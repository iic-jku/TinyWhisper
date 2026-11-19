# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Description: cocotb testbench for riscv_top. Each test loads a program into the model of the SPI SRAM, bus models drive the inputs and monitor the outputs of the CPU at every falling edge, as in the testbenches of the VLSI design course, and the test compares what they collected with the expected result.
# Environment variables: SIM selects the simulator (default icarus). GL=1 (Icarus only) simulates the netlist final/nl/riscv_top.nl.v of the macro, SDF=1 adds the delays of the SDF file of SDF_CORNER, and SDF_TRIPLE selects the min, typ or max value of each delay.
# CLK_PERIOD_NS sets the clock (default 56 MHz), and COCOTB_TEST_FILTER selects the tests (GL_TESTS of the Makefile).

import os
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge, ReadOnly, Timer
from cocotb.handle import Immediate
from cocotb.types import LogicArray, Logic, Range
from cocotb_tools.runner import get_results, get_runner

sim = os.getenv("SIM", "icarus")
pdk_root = os.getenv("PDK_ROOT", Path("~/.ciel").expanduser())
pdk = os.getenv("PDK", "ihp-sg13g2")
scl = os.getenv("SCL", "sg13g2_stdcell")
# GL=1 selects the gate-level netlist. Anything else (unset, "0", "") stays in RTL mode.
gl = os.getenv("GL", "0").strip().lower() in ("1", "true", "yes", "on")
# SDF=1 adds the delays of the SDF file of SDF_CORNER to the netlist, SDF_TRIPLE selects the min, typ or max value of each delay.
sdf        = os.getenv("SDF", "0").strip().lower() in ("1", "true", "yes", "on")
sdf_corner = os.getenv("SDF_CORNER", "nom_typ_1p50V_25C")
sdf_triple = os.getenv("SDF_TRIPLE", "typ")

hdl_toplevel = "riscv_top"

CLK_PERIOD_NS = round(float(os.getenv("CLK_PERIOD_NS", 1e3 / 56)), 4)  # 56 MHz, cocotb rejects a period that is not a whole number of fs
UART_WAIT_CYCLES = 510  # clock cycles per bit at 115200 baud


class SpiSram:
    """Model of the SPI SRAM that holds the program: answers READ and records WRITE commands."""

    READ_CMD = 3
    WRITE_CMD = 2

    def __init__(self, program_path):
        with open(program_path, encoding="utf-8") as f:
            self.mem = {i: LogicArray(int(line, base=16), Range(7, "downto", 0)) for i, line in enumerate(f)}
        self.writes = []  # (address, data) of every written byte
        self.state = "RECV_COMMAND"
        self.command_reg = LogicArray(0, Range(7, "downto", 0))
        self.addr_reg = LogicArray(0, Range(23, "downto", 0))
        self.datain_reg = LogicArray(0, Range(7, "downto", 0))
        self.dataout_reg = LogicArray(0, Range(7, "downto", 0))
        self.index = 0
        self.prev_sclk = 0

    def step(self, dut):
        sclk = dut.sclk.get()
        si = dut.si.get()
        if dut.sram_ce.get() == 0:  # cs = 0
            self.state = "RECV_COMMAND"
            self.index = 7
            self.prev_sclk = sclk
            dut.so.set(Immediate(Logic(0)))
            return

        if sclk == 1 and self.prev_sclk == 0:
            if self.state == "RECV_COMMAND":
                if dut.sram_ce.get() == 1:
                    self.command_reg[self.index] = si
                    if self.index == 0:
                        self.index = 23
                        self.state = "RECV_ADDR"
                    else:
                        self.index -= 1

            elif self.state == "RECV_ADDR":
                self.addr_reg[self.index] = si
                if self.index == 0:
                    self.index = 7
                    if self.command_reg.to_unsigned() == self.READ_CMD:
                        self.state = "SEND_DATA"
                        self.dataout_reg = self.mem[self.addr_reg[22:0].to_unsigned()]
                    elif self.command_reg.to_unsigned() == self.WRITE_CMD:
                        self.state = "RECV_DATA"
                    else:
                        cocotb.log.warning(f"unknown SPI command {self.command_reg}")
                else:
                    self.index -= 1

            elif self.state == "RECV_DATA":
                self.datain_reg[self.index] = si
                if self.index == 0:
                    self.mem[self.addr_reg.to_unsigned()] = LogicArray(self.datain_reg.to_unsigned(), Range(7, "downto", 0))
                    self.writes.append((self.addr_reg[22:0].to_unsigned(), self.datain_reg.to_unsigned()))
                    self.index = 7
                    self.addr_reg = LogicArray(self.addr_reg[22:0].to_unsigned() + 1, Range(23, "downto", 0))
                else:
                    self.index -= 1

            elif self.state == "SEND_DATA":
                if self.index == 0:
                    self.index = 7
                    self.addr_reg = LogicArray(self.addr_reg[22:0].to_unsigned() + 1, Range(23, "downto", 0))
                    self.dataout_reg = self.mem.get(self.addr_reg.to_unsigned(), LogicArray("XXXXXXXX", Range(7, "downto", 0)))
                else:
                    self.index -= 1

        elif sclk == 0 and self.prev_sclk == 1:
            if self.state == "SEND_DATA":
                dut.so.set(Immediate(self.dataout_reg[self.index]))

        self.prev_sclk = sclk


class UartReceiver:
    """Monitor of tx: collects the characters that the CPU sends."""

    def __init__(self):
        self.chars = []
        self.state = "IDLE"
        self.clk_counter = 0
        self.bit_counter = 0
        self.data = LogicArray(0, Range(7, "downto", 0))

    def step(self, dut):
        tx = dut.tx.get()
        if self.state == "IDLE":
            if tx == 1:  # no start bit
                return
            self.state = "RECV"
            self.clk_counter = 1.5 * UART_WAIT_CYCLES  # sample in the middle of each bit
            self.bit_counter = 0
            self.data = LogicArray(0, Range(7, "downto", 0))
        else:
            self.clk_counter -= 1
            if self.clk_counter != 0:
                return
            self.clk_counter = UART_WAIT_CYCLES
            if self.bit_counter <= 7:
                self.data[self.bit_counter] = tx
                self.bit_counter += 1
            elif tx == 0:
                cocotb.log.warning("expected the UART stop bit on tx")
            else:
                self.state = "IDLE"
                self.chars.append(chr(self.data.to_unsigned()))


class UartTransmitter:
    """Driver of rx: sends one character after send() was called."""

    def __init__(self):
        self.enable = False
        self.state = "IDLE"
        self.clk_counter = 0
        self.bit_counter = 0
        self.data = LogicArray(0, Range(7, "downto", 0))

    def send(self, char):
        self.data = LogicArray(ord(char), Range(7, "downto", 0))
        self.enable = True

    def step(self, dut):
        if not self.enable:
            return
        rx = 1
        if self.state == "IDLE":
            rx = 0  # start bit
            self.state = "TX"
            self.clk_counter = UART_WAIT_CYCLES
            self.bit_counter = 0
        else:
            self.clk_counter -= 1
            if self.clk_counter != 0:
                return
            self.clk_counter = UART_WAIT_CYCLES
            if self.bit_counter <= 7:
                rx = self.data[self.bit_counter]
                self.bit_counter += 1
            else:  # stop bit
                self.state = "IDLE"
                self.enable = False
        dut.rx.set(Immediate(rx))


class I2cTarget:
    """Model of an I2C target: collects the bytes that the CPU writes and answers reads with fixed bytes."""

    SEND = [LogicArray(v, Range(7, "downto", 0)) for v in (37, 29, 204, 103)]

    def __init__(self):
        self.received = []
        self.state = "IDLE"
        self.prev_scl = 1
        self.prev_sda = 1
        self.addr = LogicArray(0, Range(6, "downto", 0))
        self.cmd = 0
        self.counter = 0
        self.index = 3
        self.data = LogicArray(0, Range(7, "downto", 0))

    def step(self, dut):
        sda = dut.sda_o.get()
        scl = dut.scl.get()

        if scl == 1 and self.prev_scl == 1 and sda != self.prev_sda:  # start or stop condition
            self.state = "IDLE"
        elif self.state == "IDLE":
            if sda == 0:
                self.state = "START"
                self.index = 3
        elif self.state == "START":
            if sda == 0 and scl == 0 and self.prev_scl == 1:
                self.state = "R_ADDR"
                self.addr = LogicArray(0, Range(6, "downto", 0))
                self.counter = 6
        elif self.prev_scl == 0 and scl == 1:  # rising edge of scl
            if self.state == "R_ADDR":
                self.addr[self.counter] = sda
            elif self.state == "R_CMD":
                self.cmd = sda
            elif self.state == "WRITE":
                self.data[self.counter] = sda
        elif self.prev_scl == 1 and scl == 0:  # falling edge of scl
            if self.state == "R_ADDR":
                if self.counter > 0:
                    self.counter -= 1
                else:
                    self.state = "R_CMD"
            elif self.state == "R_CMD":
                self.counter = 0
                self.state = "T_ACK"
            elif self.state == "T_ACK":
                self.counter = 7
                self.index = 3
                self.state = "READ" if self.cmd == 1 else "WRITE"
            elif self.state == "WRITE":
                if self.counter > 0:
                    self.counter -= 1
                else:
                    self.received.append(self.data.to_unsigned())
                    self.index -= 1
                    self.counter = 7
                    self.state = "WRITE_ACK"
            elif self.state == "WRITE_ACK":
                self.state = "WRITE"
            elif self.state == "READ":
                if self.counter > 0:
                    self.counter -= 1
                else:
                    self.index = max(self.index - 1, 0)
                    self.counter = 7
                    self.state = "READ_ACK"
            elif self.state == "READ_ACK":
                self.state = "READ"

        self.prev_scl = scl
        self.prev_sda = sda

        if self.state in ("T_ACK", "WRITE_ACK"):
            dut.sda_i.set(Immediate(Logic(0)))
        elif self.state == "READ":
            dut.sda_i.set(Immediate(self.SEND[3 - self.index][self.counter]))


async def bus_models(dut, models, stimulus=None):
    """Step the bus models at every falling edge, so that the inputs they drive cannot race the clock tree of the timed netlist.
    stimulus(cycle, dut) runs first in each cycle and changes the inputs that a test drives itself."""
    cycle = 0
    while True:
        await FallingEdge(dut.clk)
        if stimulus:
            stimulus(cycle, dut)
        for model in models:
            model.step(dut)
        cycle += 1


async def start_up(dut, program_path, *models, stimulus=None):
    """Load the program, start the clock, reset the CPU, and start the SRAM model, the given bus models and the stimulus."""
    sram = SpiSram(program_path)
    # Drive every input to its idle level: an undriven input is X in the netlist, while the RTL takes an X
    # condition as false (gpio_in[0] is the external interrupt, so X there took a trap on the netlist)
    dut.gpio_in.value = 0
    dut.rx.value = 1
    dut.sda_i.value = 1
    dut.so.value = 0
    for name in ("lo_I_i", "lo_Ix_i", "lo_Q_i", "lo_Qx_i", "ds_I_n_i", "ds_I_p_i", "ds_Q_n_i", "ds_Q_p_i"):
        getattr(dut, name).value = 0
    cocotb.start_soon(Clock(dut.clk, CLK_PERIOD_NS, "ns").start())
    dut.reset.value = 0  # active low
    await Timer(1000, "ns")
    await FallingEdge(dut.clk)
    dut.reset.value = 1
    cocotb.start_soon(bus_models(dut, [sram, *models], stimulus))
    return sram


async def run_cycles(dut, cycles):
    """Wait for the given number of cycles, then until the bus models have taken the last falling edge."""
    await ClockCycles(dut.clk, cycles, rising=False)
    await ReadOnly()


def fibonacci_writes():
    """Reference model of fib.txt: it stores the Fibonacci numbers from 2 to 89 as 32-bit words from address 160."""
    a, b, writes = 1, 2, []
    for k in range(9):
        writes += [(160 + 4 * k + i, (b >> (8 * i)) & 0xFF) for i in range(4)]
        a, b = b, a + b
    return writes


@cocotb.test()
async def test_cpu_fibonacci_fast(dut):
    """The program writes the Fibonacci numbers to the SRAM."""
    sram = await start_up(dut, "../fib.txt")
    await run_cycles(dut, 18000)
    assert sram.writes == fibonacci_writes()


@cocotb.test()
async def test_cpu_analog_enables(dut):
    """The analog inputs reach the outputs while the CPU does not drive the pads (check the waveform)."""
    names = ("lo_Qx_i", "lo_Q_i", "ds_Q_n_i", "ds_Q_p_i", "lo_Ix_i", "lo_I_i", "ds_I_n_i", "ds_I_p_i")

    def stimulus(cycle, dut):
        # Toggle the inputs of the bidirectional pads first, then release them to Z, since the CPU starts to drive
        # the pads at some point and the inputs would turn X
        for name in names:
            pin = getattr(dut, name)
            pin.set(Immediate(not pin.get() if cycle < 10000 else Logic("Z")))

    await start_up(dut, "../analog_enables.txt", stimulus=stimulus)
    for name, value in zip(names, (1, 0, 1, 0, 1, 0, 1, 0)):
        getattr(dut, name).set(Immediate(Logic(value)))
    await run_cycles(dut, 100000)


@cocotb.test()
async def test_cpu_uart_tx(dut):
    """The program sends "Hallo!" over the UART."""
    uart_rx = UartReceiver()
    await start_up(dut, "../uart_tx_test.txt", uart_rx)
    await run_cycles(dut, 100000)
    assert uart_rx.chars == list("Hallo!")


@cocotb.test()
async def test_cpu_uart_rx(dut):
    """The program echoes the characters that it receives over the UART."""
    uart_rx, uart_tx = UartReceiver(), UartTransmitter()
    send_at = {6000 + 40000 * k: char for k, char in enumerate("Linz")}

    def stimulus(cycle, dut):
        if cycle in send_at:
            uart_tx.send(send_at[cycle])

    await start_up(dut, "../uart_rx_test.txt", uart_rx, uart_tx, stimulus=stimulus)
    await run_cycles(dut, 200000)
    assert uart_rx.chars == list("Linz")


@cocotb.test()
async def test_cpu_i2c_rw(dut):
    """The program writes to and reads from an I2C target."""
    i2c = I2cTarget()
    await start_up(dut, "../i2c_rw_test.txt", UartReceiver(), UartTransmitter(), i2c)
    await run_cycles(dut, 250000)
    assert i2c.received == [0x78, 37, 37, 37, 29, 37, 29, 37, 29, 204, 103]


@cocotb.test()
async def test_cpu_i2c_mc(dut):
    """The program writes to an I2C target with the multi-cycle I2C master."""
    i2c = I2cTarget()
    await start_up(dut, "../i2c_mc_test.txt", UartReceiver(), UartTransmitter(), i2c)
    await run_cycles(dut, 100000)
    assert i2c.received == [32]


@cocotb.test()
async def test_cpu_gpio(dut):
    """The program adds one to gpio_in and writes the sum to gpio_out."""
    await start_up(dut, "../gpio_test.txt")
    assert dut.gpio_out.get() == 0, f"gpio_out = {dut.gpio_out.get()} after the reset"
    for gpio_in, expected in ((0b0111, 0b1000), (0b1010, 0b1011)):
        dut.gpio_in.set(Immediate(gpio_in))
        await ClockCycles(dut.clk, 5000, rising=False)
        assert dut.gpio_out.get() == expected, f"gpio_out = {dut.gpio_out.get()}, expected {expected:04b}"


@cocotb.test()
async def test_cpu_wspr(dut):
    """The program sends a WSPR message after gpio_in[0] rises (check the waveform)."""

    def stimulus(cycle, dut):
        if cycle == 19000:
            dut.gpio_in.set(Immediate(0b0001))

    await start_up(dut, "../wspr_test.txt", stimulus=stimulus)
    await run_cycles(dut, 300000)


def riscv_top_runner():

    proj_path = Path(__file__).resolve().parent

    sources = []
    # defines = {f"SLOT_{slot.upper()}": True}
    defines = {}
    includes = [proj_path / "../src/"]

    if gl:
        # SCL models
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v")
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"sg13g2_udp.v")
        # sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / "sg13g2_stdcell.v")

        # We use the unpowered netlist
        # sources.append(proj_path / f"../final/nl/{hdl_toplevel}.nl.v")
        sources.append(proj_path / f"../../../final/nl/riscv_top.nl.v")

        # Unpowered netlist: USE_POWER_PINS must NOT be defined at all
        # (passing USE_POWER_PINS=False would still define the macro).
    else:
        sources.append(proj_path / "../../../rtl/constants.sv")
        sources.append(proj_path / "../../../rtl/riscv_top.sv")
        sources.append(proj_path / "../../../rtl/alu.sv")
        sources.append(proj_path / "../../../rtl/lo_gen.v")
        sources.append(proj_path / "../../../rtl/csr.sv")
        sources.append(proj_path / "../../../rtl/memory.sv")
        sources.append(proj_path / "../../../rtl/dsmod.v")
        sources.append(proj_path / "../../../rtl/regs.sv")
        sources.append(proj_path / "../../../rtl/freq_generator.sv")
        sources.append(proj_path / "../../../rtl/spi_master.sv")
        sources.append(proj_path / "../../../rtl/control.sv")
        sources.append(proj_path / "../../../rtl/i2c_master.sv")
        sources.append(proj_path / "../../../rtl/i2c_master_mc.sv")
        sources.append(proj_path / "../../../rtl/cordic_iterative.v")
        sources.append(proj_path / "../../../rtl/imm_gen.sv")
        sources.append(proj_path / "../../../rtl/uart_tx.v")
        sources.append(proj_path / "../../../rtl/uart_rx.v")
        sources.append(proj_path / "../../../rtl/cordic_slice.v")
        sources.append(proj_path / "../../../rtl/instructioncounter.sv")

    toplevel   = hdl_toplevel
    build_args = []
    plusargs   = []

    if sim == "icarus":
        # For debugging
        # build_args = ["-Winfloop", "-pfileline=1"]
        build_args = ["-DSIM"]
        pass

    if gl and sdf:
        if sim != "icarus":
            raise SystemExit("The timed gate-level simulation (SDF=1) needs SIM=icarus.")
        sdf_file = proj_path / f"../../../final/sdf/{sdf_corner}/{hdl_toplevel}__{sdf_corner}.sdf"
        if not sdf_file.is_file():
            raise SystemExit(f"No SDF file {sdf_file} found. Run 'make build-top' (or 'make copy-final') first.")
        # The wrapper instantiates the netlist and annotates the SDF file.
        # -gspecify keeps the delays of the cell models, -ginterconnect the wire delays of the layout, and -T selects the value of each min:typ:max delay.
        toplevel   = f"{hdl_toplevel}_sdf"
        sources   += [proj_path / f"{toplevel}.sv"]
        build_args = ["-DSIM", "-gspecify", "-ginterconnect", f"-T{sdf_triple}"]
        plusargs   = [f"+SDF={sdf_file.resolve()}"]

    if sim == "verilator":
        build_args = ["--timing", "--trace", "--trace-fst", "--trace-structs"]

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=toplevel,
        defines=defines,
        always=True,
        includes=includes,
        build_args=build_args,
        waves=True,
        timescale=("1ns", "1fs")
    )

    results_xml = runner.test(
        hdl_toplevel=toplevel,
        test_module="riscv_top_tb,",
        plusargs=plusargs,
        waves=True,
    )

    # Outside pytest a failing test leaves the exit status at 0, so check the results
    num_tests, num_failed = get_results(results_xml)
    if num_failed:
        raise SystemExit(f"FAIL: {num_failed} of {num_tests} tests failed")


if __name__ == "__main__":
    riscv_top_runner()
