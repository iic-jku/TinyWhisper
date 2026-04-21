# SPDX-FileCopyrightText: © 2025 Project Template Contributors
# SPDX-License-Identifier: Apache-2.0

import os
import logging
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, Edge, RisingEdge, FallingEdge, ClockCycles
from cocotb.handle import Immediate
from cocotb.types import LogicArray, Logic, Range
from cocotb_tools.runner import get_runner

sim = os.getenv("SIM", "icarus")
pdk_root = os.getenv("PDK_ROOT", Path("~/.ciel").expanduser())
pdk = os.getenv("PDK", "ihp-sg13g2")
scl = os.getenv("SCL", "sg13g2_stdcell")
gl = os.getenv("GL", False)

hdl_toplevel = "riscv_top"

CPU_CLK_FREQ = 56  # MHz

mem = {}
async def set_defaults(dut, program_path, slow_spi):
    global mem
    mem = {}

    lines = ()
    with open(program_path, "r") as f:
        lines = f.readlines()

    for i, line in enumerate(lines):
        mem[i] = LogicArray(int(line, base=16), Range(7, "downto", 0))

    if slow_spi:
        dut.input_PAD.value = 2**1 + 2**0  # uart rx set to 1 + slow_mode to 1
    else:
        dut.input_PAD.value = 2**1  # uart rx set to 1


async def enable_power(dut):
    dut.VDD.value = 1
    dut.VSS.value = 0


async def start_clock(clock, freq=20):
    """Start the clock @ freq MHz"""
    c = Clock(clock, 1 / freq * 1000, "ns")
    cocotb.start_soon(c.start())


async def reset(reset, active_low=True, time_ns=1000):
    """Reset dut"""
    cocotb.log.info("Reset asserted...")

    reset.value = not active_low
    await Timer(time_ns, "ns")
    reset.value = active_low

    cocotb.log.info("Reset deasserted.")


async def start_up(dut, program_path, slow_spi=0):
    global CPU_CLK_FREQ
    """Startup sequence"""
    await set_defaults(dut, program_path, slow_spi)
    if gl:
        await enable_power(dut)
    await start_clock(dut.clk_PAD, CPU_CLK_FREQ)
    await reset(dut.rst_n_PAD)

state = "RECV_COMMAND"
WRITE_CMD = 2
READ_CMD = 3
command_reg = LogicArray(0, Range(7, "downto", 0))
addr_reg = LogicArray(0, Range(23, "downto", 0))
datain_reg = LogicArray(0, Range(7, "downto", 0))
dataout_reg = LogicArray(0, Range(7, "downto", 0))
index = 0
mem_pattern = []
prev_sclk = 0

async def do_spi(dut):
    global state
    global mem
    global WRITE_CMD
    global READ_CMD
    global command_reg
    global addr_reg
    global datain_reg
    global dataout_reg
    global index
    global mem_pattern
    global prev_sclk

    sclk = dut.bidir_PAD.get()[20]
    si = dut.bidir_PAD.get()[21]
    if dut.bidir_PAD.get()[19] == 0:  # cs = 0
        state = "RECV_COMMAND"
        index = 7
        prev_sclk = sclk
        tmp = dut.input_PAD.get()
        tmp[2] = Logic(0)
        dut.input_PAD.set(Immediate(tmp))

        return

    if sclk == 1 and prev_sclk == 0:
        if state == "RECV_COMMAND":
            if dut.bidir_PAD.get()[19] == 1:
                command_reg[index] = si
                if index == 0:
                    index = 23
                    state = "RECV_ADDR"
                else:
                    index = index - 1

        elif state == "RECV_ADDR":
            addr_reg[index] = si
            if index == 0:
                index = 7

                if command_reg.to_unsigned() == READ_CMD:
                    state = "SEND_DATA"
                    addr_tmp = addr_reg[22:0].to_unsigned()
                    dataout_reg = mem[addr_tmp]

                elif command_reg.to_unsigned() == WRITE_CMD:
                    state = "RECV_DATA"
                    index = 7
                else:
                    print("GOT UNKNOWN SPI COMMAND!!!!!")
            else:
                index = index - 1

        elif state == "WAITING":
            state = "SEND_DATA"

        elif state == "RECV_DATA":
            datain_reg[index] = si
            if index == 0:
                mem[addr_reg.to_unsigned()] = LogicArray(datain_reg.to_unsigned(), Range(7, "downto", 0))

                mem_pattern.append((addr_reg[22:0].to_unsigned(), datain_reg.to_unsigned()))
                index = 7
                addr_reg = LogicArray(addr_reg[22:0].to_unsigned() + 1, Range(23, "downto", 0))
            else:
                index = index - 1

        elif state == "SEND_DATA":
            if index == 0:
                index = 7
                addr_reg = LogicArray(addr_reg[22:0].to_unsigned() + 1, Range(23, "downto", 0))
                addr_tmp = addr_reg.to_unsigned()
                if addr_tmp in mem:
                    dataout_reg = mem[addr_reg.to_unsigned()]
                else:
                    dataout_reg = LogicArray("XXXXXXXX", Range(7, "downto", 0))
            else:
                index = index - 1

    elif sclk == 0 and prev_sclk == 1:
        if state == "SEND_DATA":
            tmp = dut.input_PAD.get()
            tmp[2] = dataout_reg[index]
            dut.input_PAD.set(Immediate(tmp))

    prev_sclk = sclk


uart_rx_bytes = list()  # List of bytes sent by the CPU to the tb
UART_RX_BAUD = 115200
# UART_RX_WAIT_CYCLES = (1e9 * (1.0 / UART_RX_BAUD)) / (1e3 * (1.0 / CPU_CLK_FREQ))
UART_RX_WAIT_CYCLES = 104
uart_rx_clk_counter = 0
uart_rx_bit_counter = 0
uart_rx_state = "IDLE"  # IDLE, WAIITNG, RECV
uart_rx_current_data = 0


async def do_uart_rx(dut):
    global uart_rx_bytes
    global UART_RX_WAIT_CYCLES
    global uart_rx_clk_counter
    global uart_rx_bit_counter
    global uart_rx_state
    global uart_rx_current_data

    cpu_tx = dut.bidir_PAD.get()[18]

    if uart_rx_state == "IDLE":
        if cpu_tx == 1:
            # No start condition. Doing nothing
            return

        uart_rx_state = "RECV"
        uart_rx_clk_counter = 1.5 * UART_RX_WAIT_CYCLES
        uart_rx_bit_counter = 0
        uart_rx_current_data = LogicArray(0, Range(7, "downto", 0))

    elif uart_rx_state == "RECV":
        uart_rx_clk_counter -= 1

        if uart_rx_clk_counter != 0:
            return

        uart_rx_clk_counter = UART_RX_WAIT_CYCLES
        if uart_rx_bit_counter <= 7:
            uart_rx_current_data[uart_rx_bit_counter] = cpu_tx
            uart_rx_bit_counter += 1
        else:
            if cpu_tx == 0:
                print("Expected to see UART stop condition on rx!")
            else:
                uart_rx_state = "IDLE"
                uart_rx_bytes.append(chr(uart_rx_current_data.to_unsigned()))


UART_TX_BAUD = 115200
# UART_TX_WAIT_CYCLES = (1e9 * (1.0 / UART_RX_BAUD)) / (1e3 * (1.0 / CPU_CLK_FREQ))
UART_TX_WAIT_CYCLES = 104
uart_tx_clk_counter = 0
uart_tx_bit_counter = 0
uart_tx_state = "IDLE"  # IDLE, TX, END
uart_tx_current_data = 0
uart_tx_enable = 0


async def do_uart_tx(dut):
    global UART_TX_WAIT_CYCLES
    global uart_tx_clk_counter
    global uart_tx_bit_counter
    global uart_tx_state
    global uart_tx_current_data
    global uart_tx_enable

    if uart_tx_enable == 0:
        return

    cpu_rx_in = 1

    if uart_tx_state == "IDLE":
        cpu_rx_in = 0

        uart_tx_state = "TX"
        uart_tx_clk_counter = 1 * UART_TX_WAIT_CYCLES
        uart_tx_bit_counter = 0

    elif uart_tx_state == "TX":
        uart_tx_clk_counter -= 1

        if uart_tx_clk_counter != 0:
            return

        uart_tx_clk_counter = UART_TX_WAIT_CYCLES
        if uart_tx_bit_counter <= 7:
            cpu_rx_in = uart_tx_current_data[uart_tx_bit_counter]
            uart_tx_bit_counter += 1
        else:
            uart_tx_state = "IDLE"
            cpu_rx_in = 1
            uart_tx_enable = 0

    # Set CPU rx input to the computed value
    tmp = dut.input_PAD.get()
    tmp[1] = cpu_rx_in
    dut.input_PAD.set(Immediate(tmp))


i2c_state = "IDLE"
prev_scl = 1
prev_sda = 1
i2c_addr = 0
i2c_cmd = 0
i2c_counter = 0
i2c_index = 3
i2c_recv = []
i2c_current_recv = LogicArray(0, Range(7, "downto", 0))
async def do_i2c_slave(dut):
    global i2c_state
    global prev_scl
    global i2c_addr
    global i2c_cmd
    global i2c_counter
    global i2c_index
    global i2c_recv
    global i2c_current_recv
    global prev_sda

    # Some random values
    i2c_send = [
        LogicArray(37, Range(7, "downto", 0)),
        LogicArray(29, Range(7, "downto", 0)),
        LogicArray(204, Range(7, "downto", 0)),
        LogicArray(103, Range(7, "downto", 0))
    ]

    sda_in = dut.bidir_PAD.get()[17]
    scl = dut.bidir_PAD.get()[16]

    # if scl == 1 and prev_scl == 1 and sda_in == 1 and prev_sda == 0:
    if scl == 1 and prev_scl == 1 and sda_in != prev_sda:
        i2c_state = "IDLE"

    elif i2c_state == "IDLE":
        # I2C start condition
        if sda_in == 0:
            i2c_state = "START"
            i2c_index = 3

    elif i2c_state == "START":
        if sda_in == 0 and scl == 0 and prev_scl == 1:
            i2c_state = "R_ADDR"
            i2c_addr = LogicArray(0, Range(6, "downto", 0))
            i2c_counter = 6

    elif prev_scl == 0 and scl == 1:
        if i2c_state == "R_ADDR":
            # Posedge of scl
            i2c_addr[i2c_counter] = sda_in

        elif i2c_state == "R_CMD":
            i2c_cmd = sda_in

        elif i2c_state == "WRITE":
            i2c_current_recv[i2c_counter] = sda_in

    elif prev_scl == 1 and scl == 0:
        if i2c_state == "R_ADDR":
            if i2c_counter > 0:
                i2c_counter -= 1
            else:
                i2c_state = "R_CMD"

        elif i2c_state == "R_CMD":
            i2c_counter = 0
            i2c_state = "T_ACK"

        elif i2c_state == "T_ACK":
            i2c_counter = 7
            i2c_index = 3
            if i2c_cmd == 1:
                i2c_state = "READ"
            else:
                i2c_state = "WRITE"

        elif i2c_state == "WRITE":
            if i2c_counter > 0:
                i2c_counter -= 1
            else:
                i2c_recv.append(i2c_current_recv.to_unsigned())
                i2c_index -= 1
                i2c_counter = 7
                i2c_state = "WRITE_ACK"

        elif i2c_state == "WRITE_ACK":
            i2c_state = "WRITE"

        elif i2c_state == "READ":
            if i2c_counter > 0:
                i2c_counter -= 1
            else:
                i2c_index -= 1

                if i2c_index < 0:
                    i2c_index = 0

                i2c_counter = 7
                i2c_state = "READ_ACK"

        elif i2c_state == "READ_ACK":
            i2c_state = "READ"

    prev_scl = scl
    prev_sda = sda_in

    tmp = dut.bidir_PAD.get()
    for i in range(len(tmp)):
        tmp[i] = Logic("Z")

    if i2c_state in ["T_ACK", "WRITE_ACK"]:
        tmp[17] = Logic(1)
    elif i2c_state == "READ":
        tmp[17] = i2c_send[3-i2c_index][i2c_counter]

    dut.bidir_PAD.set(Immediate(tmp))


@cocotb.test()
async def test_cpu_fibonacci_slow(dut):
    global mem_pattern
    mem_pattern = []
    mem_pattern_correct = [
        (160, 2), (161, 0), (162, 0), (163, 0),
        (164, 3), (165, 0), (166, 0), (167, 0),
        (168, 5), (169, 0), (170, 0), (171, 0),
        (172, 8), (173, 0), (174, 0), (175, 0),
        (176, 13), (177, 0), (178, 0), (179, 0),
        (180, 21), (181, 0), (182, 0), (183, 0),
        (184, 34), (185, 0), (186, 0), (187, 0),
        (188, 55), (189, 0), (190, 0), (191, 0),
        (192, 89), (193, 0), (194, 0), (195, 0),
    ]

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt", slow_spi=1)
    logger.info("Testing basic fibonacci program")

    # Wait for a number of clock cycles
    for i in range(20000):
        await ClockCycles(dut.clk_PAD, 1)

        await do_spi(dut)

    # Check the end result of the counter
    print(mem_pattern)
    assert mem_pattern == mem_pattern_correct
    logger.info("Done!")


@cocotb.test()
async def test_cpu_fibonacci_fast(dut):
    global mem_pattern
    mem_pattern = []
    mem_pattern_correct = [
        (160, 2), (161, 0), (162, 0), (163, 0),
        (164, 3), (165, 0), (166, 0), (167, 0),
        (168, 5), (169, 0), (170, 0), (171, 0),
        (172, 8), (173, 0), (174, 0), (175, 0),
        (176, 13), (177, 0), (178, 0), (179, 0),
        (180, 21), (181, 0), (182, 0), (183, 0),
        (184, 34), (185, 0), (186, 0), (187, 0),
        (188, 55), (189, 0), (190, 0), (191, 0),
        (192, 89), (193, 0), (194, 0), (195, 0),
    ]

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing basic fibonacci program")

    # Wait for a number of clock cycles
    for i in range(18000):
        await ClockCycles(dut.clk_PAD, 1)

        await do_spi(dut)

    # Check the end result of the counter
    print(mem_pattern)
    assert mem_pattern == mem_pattern_correct
    logger.info("Done!")


@cocotb.test()
async def test_cpu_uart_tx(dut):
    global uart_rx_bytes

    uart_rx_bytes = list()  # List of bytes sent by the CPU to the tb

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../uart_tx_test.txt")
    logger.info("Testing UART transmission")

    # Wait for a number of clock cycles
    # for i in range(150000):
    for i in range(50000):
        await ClockCycles(dut.clk_PAD, 1)

        await do_spi(dut)
        await do_uart_rx(dut)

    # Check the end result of the counter
    print(uart_rx_bytes)
    assert uart_rx_bytes == ["H", "a", "l", "l", "o", "!"]
    # assert mem_pattern == mem_pattern_correct

    logger.info("Done!")


@cocotb.test()
async def test_cpu_uart_rx(dut):
    global uart_tx_enable
    global uart_tx_current_data
    global uart_rx_bytes

    uart_rx_bytes = list()  # List of bytes sent by the CPU to the tb
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../uart_rx_test.txt")
    logger.info("Testing UART receiving")

    to_send = ["L", "i", "n", "z"]
    counter = -1  # HACK
    next_i = 8000
    increment = 40000

    # Wait for a number of clock cycles
    for i in range(180000):
        await ClockCycles(dut.clk_PAD, 1)

        if i >= next_i:
            if uart_tx_enable == 0 and counter < len(to_send) - 1:
                counter += 1
                uart_tx_enable = 1
                uart_tx_current_data = LogicArray(ord(to_send[counter]), Range(7, "downto", 0))
                next_i = i + increment

        await do_spi(dut)
        await do_uart_rx(dut)
        await do_uart_tx(dut)

    # Check the end result of the counter
    print(uart_rx_bytes)
    assert uart_rx_bytes == to_send
    logger.info("Done!")


@cocotb.test()
async def test_cpu_i2c_rw(dut):
    global uart_tx_enable
    global uart_tx_current_data
    global uart_rx_bytes
    global i2c_recv

    uart_rx_bytes = list()  # List of bytes sent by the CPU to the tb
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../i2c_rw_test.txt")
    logger.info("Testing I2C")

    # Wait for a number of clock cycles
    for i in range(50000):
        await ClockCycles(dut.clk_PAD, 1)

        await do_spi(dut)
        await do_uart_rx(dut)
        await do_uart_tx(dut)
        await do_i2c_slave(dut)

    # Check the end result of the counter
    print(i2c_recv)
    assert i2c_recv == [0x78, 37, 37, 37, 29, 37, 29, 37, 29, 204, 103]
    logger.info("Done!")


@cocotb.test()
async def test_cpu_gpio(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../gpio_test.txt")
    logger.info("Testing GPIO")

    # Test 0111 + 1 = 1000
    tmp = dut.input_PAD.get()
    tmp[6] = 0
    tmp[5] = 1
    tmp[4] = 1
    tmp[3] = 1
    dut.input_PAD.set(Immediate(tmp))
    # Wait for a number of clock cycles

    print(dut.bidir_PAD.get()[25:22])
    assert dut.bidir_PAD.get()[25:22] == 0b0000
    for i in range(5000):
        await ClockCycles(dut.clk_PAD, 1)
        await do_spi(dut)

    # Check the end result of the counter
    print(dut.bidir_PAD.get()[25:22])
    assert dut.bidir_PAD.get()[25:22] == 0b1000

    # Test 1010 + 1 = 1011
    tmp = dut.input_PAD.get()
    tmp[6] = 1
    tmp[5] = 0
    tmp[4] = 1
    tmp[3] = 0
    dut.input_PAD.set(Immediate(tmp))
    # Wait for a number of clock cycles

    for i in range(5000):
        await ClockCycles(dut.clk_PAD, 1)
        await do_spi(dut)

    # Check the end result of the counter
    print(dut.bidir_PAD.get()[25:22])
    assert dut.bidir_PAD.get()[25:22] == 0b1011
    logger.info("Done!")


@cocotb.test()
async def test_cpu_wspr(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../wspr_test.txt")
    logger.info("Testing WSPR")

    for i in range(300000):
        await ClockCycles(dut.clk_PAD, 1)
        await do_spi(dut)

        if i == 12000:
            tmp = dut.input_PAD.get()
            tmp[3] = 1
            dut.input_PAD.set(Immediate(tmp))

    print("WSPR TEST DONE. CHECK WAVEFORM!")
    logger.info("Done!")

# =============================================================
# Other projects (just generating clock and reset)


@cocotb.test()
async def test_mux_tiny_bf(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 000")

    tmp = dut.input_PAD.get()
    tmp[14] = 0
    tmp[13] = 0
    tmp[12] = 0
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


@cocotb.test()
async def test_mux_sar_adc(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 001")

    tmp = dut.input_PAD.get()
    tmp[14] = 0
    tmp[13] = 0
    tmp[12] = 1
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


@cocotb.test()
async def test_mux_led_spinner(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 010")

    tmp = dut.input_PAD.get()
    tmp[14] = 0
    tmp[13] = 1
    tmp[12] = 0
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


@cocotb.test()
async def test_mux_tiny_stack(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 011")

    tmp = dut.input_PAD.get()
    tmp[14] = 0
    tmp[13] = 1
    tmp[12] = 1
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


@cocotb.test()
async def test_mux_tiny_tonegen_digital_filter(dut):
    global CPU_CLK_FREQ
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Dirty hack to set the testbench frequency :/
    old_freq = CPU_CLK_FREQ
    CPU_CLK_FREQ = 40
    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 100")

    tmp = dut.input_PAD.get()
    tmp[14] = 1
    tmp[13] = 0
    tmp[12] = 0
    tmp[11] = 1 # ena = 1
    dut.input_PAD.set(Immediate(tmp))

    for i in range(100000):
        await ClockCycles(dut.clk_PAD, 1)

        if i == 50: # Addr = 000, data = 00110
            tmp = dut.input_PAD.get()
            tmp[10] = 0
            tmp[9] = 0
            tmp[8] = 0
            tmp[6] = 0
            tmp[5] = 0
            tmp[4] = 1
            tmp[3] = 1
            tmp[2] = 0
            dut.input_PAD.set(Immediate(tmp))

        if i == 51: # write_strb = 1
            tmp = dut.input_PAD.get()
            tmp[7] = 1
            dut.input_PAD.set(Immediate(tmp))

        if i == 5051:
            tmp = dut.input_PAD.get()
            tmp[7] = 0
            dut.input_PAD.set(Immediate(tmp))

        if i == 12000: # Addr = 010, data = 01011
            tmp = dut.input_PAD.get()
            tmp[10] = 0
            tmp[9] = 1
            tmp[8] = 0
            tmp[6] = 0
            tmp[5] = 1
            tmp[4] = 0
            tmp[3] = 1
            tmp[2] = 1
            dut.input_PAD.set(Immediate(tmp))

        if i == 12001: # write_strb = 1
            tmp = dut.input_PAD.get()
            tmp[7] = 1
            dut.input_PAD.set(Immediate(tmp))

        if i == 17001:
            tmp = dut.input_PAD.get()
            tmp[7] = 0
            dut.input_PAD.set(Immediate(tmp))

    logger.info("Done!")
    CPU_CLK_FREQ = old_freq


@cocotb.test()
async def test_mux_traffic_light(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 101")

    tmp = dut.input_PAD.get()
    tmp[14] = 1
    tmp[13] = 0
    tmp[12] = 1
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


@cocotb.test()
async def test_mux_tetris(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 110")

    tmp = dut.input_PAD.get()
    tmp[14] = 1
    tmp[13] = 1
    tmp[12] = 0
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


@cocotb.test()
async def test_mux_classic_vga_clock(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut, "../fib.txt")
    logger.info("Testing MUX 111")

    tmp = dut.input_PAD.get()
    tmp[14] = 1
    tmp[13] = 1
    tmp[12] = 1
    dut.input_PAD.set(Immediate(tmp))

    for i in range(6000):
        await ClockCycles(dut.clk_PAD, 1)

    logger.info("Done!")


def riscv_runner():

    proj_path = Path(__file__).resolve().parent

    sources = []
    # defines = {f"SLOT_{slot.upper()}": True}
    includes = [proj_path / "../src/"]

    if gl:
        # SCL models
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v")
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"sg13g2_udp.v")
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / "primitives.v")

        # We use the powered netlist
        sources.append(proj_path / f"../final/pnl/{hdl_toplevel}.pnl.v")
        sources.append(proj_path / f"../macros/adc_sar_controller/final/pnl/sar_adc_spi_oversampling.pnl.v")
        sources.append(proj_path / f"../macros/classic_vga_clock/final/pnl/classic_vga_clock.pnl.v")
        sources.append(proj_path / f"../macros/decimation_filter_256_ser/final/pnl/decimator_ser_top.pnl.v")
        sources.append(proj_path / f"../macros/digital_filter/final/pnl/df_digital_filter.pnl.v")
        sources.append(proj_path / f"../macros/led_spinner/final/pnl/led_spinner.pnl.v")
        sources.append(proj_path / f"../macros/multiplexer/final/pnl/multiplexer.pnl.v")
        sources.append(proj_path / f"../macros/octowave/final/pnl/octowave.pnl.v")
        sources.append(proj_path / f"../macros/tetris/final/pnl/tetris.pnl.v")
        sources.append(proj_path / f"../macros/tiny_bf/final/pnl/rh_bf_top.pnl.v")
        sources.append(proj_path / f"../macros/tiny_tone/final/pnl/tiny_tone.pnl.v")
        sources.append(proj_path / f"../macros/tiny_tonegen/final/pnl/tiny_tonegen.pnl.v")
        sources.append(proj_path / f"../macros/riscv_top/final/pnl/riscv_top.pnl.v")
        sources.append(proj_path / f"../macros/traffic_light_controller/final/pnl/traffic_light.pnl.v")
        sources.append(proj_path / f"../macros/tiny_stack/final/pnl/tiny_stack.pnl.v")

        defines = {"FUNCTIONAL": True, "USE_POWER_PINS": True}
    else:
        # Toplevel
        sources.append(proj_path / "../src/tinywhisper_top.sv")
        sources.append(proj_path / "../src/tinywhisper_core.sv")
        sources.append(proj_path / "../src/slot_defines.svh")

        # TinyWhisper
        sources.append(proj_path / "../macros/riscv_top/verilog/constants.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/riscv_top.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/alu.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/lo_gen.v")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/csr.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/memory.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/dsmod.v")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/regs.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/freq_generator.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/spi_master.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/control.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/i2c_master.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/cordic_iterative.v")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/imm_gen.sv")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/uart_tx.v")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/uart_rx.v")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/cordic_slice.v")
        sources.append(proj_path / "../macros/riscv_top/verilog/src/instructioncounter.sv")

        # Tetris
        sources.append(proj_path / "../macros/tetris/verilog/src/tetris.v")

        # tiny_bf
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/rh_bf_top.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/bf_top.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/control_unit.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/program_memory.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/tape_memory.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/uart_tx_bf.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/uart_rx_bf.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/baud_gen.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/programmer.v")
        sources.append(proj_path / "../macros/tiny_bf/verilog/src/reset_sync.v")

        # Octowave
        sources.append(proj_path / "../macros/octowave/verilog/src/octowave.v")

        # tiny_tone
        sources.append(proj_path / "../macros/tiny_tone/verilog/src/tiny_tone.v")
        sources.append(proj_path / "../macros/tiny_tone/verilog/src/StrobeGenerator.v")
        sources.append(proj_path / "../macros/tiny_tone/verilog/src/NotesRom.v")
        sources.append(proj_path / "../macros/tiny_tone/verilog/src/SequenceCounter.v")
        sources.append(proj_path / "../macros/tiny_tone/verilog/src/PwmModulator.v")

        # led_spinner
        sources.append(proj_path / "../macros/led_spinner/verilog/src/led_spinner.v")
        sources.append(proj_path / "../macros/led_spinner/verilog/src/prescaler.v")
        sources.append(proj_path / "../macros/led_spinner/verilog/src/rng.v")
        sources.append(proj_path / "../macros/led_spinner/verilog/src/wheel.v")
        sources.append(proj_path / "../macros/led_spinner/verilog/src/seg_driver.v")
        sources.append(proj_path / "../macros/led_spinner/verilog/src/guess_eval.v")

        # multiplexer
        sources.append(proj_path / "../macros/multiplexer/verilog/src/multiplexer.v")

        # tiny_tonegen
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/tiny_tonegen.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/signal_gen.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/clock_scaler.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/mult4x4.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/adsr.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/lfsr.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/mixer.v")
        sources.append(proj_path / "../macros/tiny_tonegen/verilog/src/pwm8.v")

        # digital filter
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_digital_filter.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_multiplier_c1.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_multiplier_c2.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_multiplier_c3.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_multiplier_c4.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_halfadder.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_fulladder.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_opt_2comp.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_adder_subtractor.v")
        sources.append(proj_path / "../macros/digital_filter/verilog/src/df_adder_noovfl.v")

        # vga clock
        sources.append(proj_path / "../macros/classic_vga_clock/verilog/src/classic_vga_clock.v")
        sources.append(proj_path / "../macros/classic_vga_clock/verilog/src/button_debounce.v")
        sources.append(proj_path / "../macros/classic_vga_clock/verilog/src/clockRenderer.v")
        sources.append(proj_path / "../macros/classic_vga_clock/verilog/src/display_vga.v")
        sources.append(proj_path / "../macros/classic_vga_clock/verilog/src/cordic_sin_cos.v")

        # adc_sar_controller
        sources.append(proj_path / "../macros/adc_sar_controller/verilog/src/sar_adc_8bit_ea.v")

        # traffic_light
        sources.append(proj_path / "../macros/traffic_light_controller/verilog/src/traffic_light.v")
        sources.append(proj_path / "../macros/traffic_light_controller/verilog/src/clk_enable.v")
        sources.append(proj_path / "../macros/traffic_light_controller/verilog/src/max7219_driver.v")
        sources.append(proj_path / "../macros/traffic_light_controller/verilog/src/spi_master_traffic.v")

        # decimation_filter
        sources.append(proj_path / "../macros/decimation_filter_256_ser/verilog/src/decimator_ser_top.v")
        sources.append(proj_path / "../macros/decimation_filter_256_ser/verilog/src/synchronizer.v")
        sources.append(proj_path / "../macros/decimation_filter_256_ser/verilog/src/dec_top.v")
        sources.append(proj_path / "../macros/decimation_filter_256_ser/verilog/src/dec_serializer_22b.v")

        # tiny_stack
        sources.append(proj_path / "../macros/tiny_stack/verilog/src/cells.v")
        sources.append(proj_path / "../macros/tiny_stack/verilog/src/tiny_stack.v")

    sources += [
        # IO pad models
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_io/verilog/gf180mcu_fd_io.v",
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_io/verilog/gf180mcu_ws_io.v",

        # SRAM macros
        # Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram64x8m8wm1.v",

        # Custom IP
        proj_path / "../ip/gf180mcu_ws_ip__id/vh/gf180mcu_ws_ip__id.v",
        proj_path / "../ip/gf180mcu_ws_ip__logo/vh/gf180mcu_ws_ip__logo.v",
        proj_path / "../ip/gf180mcu_ws_ip__ce/vh/gf180mcu_ws_ip__ce.v",
        proj_path / "../ip/gf180mcu_ws_ip__jku/vh/gf180mcu_ws_ip__jku.v",
    ]

    build_args = []

    if sim == "icarus":
        # For debugging
        # build_args = ["-Winfloop", "-pfileline=1"]
        build_args = ["-DSIM"]
        pass

    if sim == "verilator":
        build_args = ["--timing", "--trace", "--trace-fst", "--trace-structs"]

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=hdl_toplevel,
        # defines=defines,
        always=True,
        includes=includes,
        build_args=build_args,
        waves=True,
    )

    plusargs = []

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module="riscv_tb,",
        plusargs=plusargs,
        waves=True,
    )


if __name__ == "__main__":
    riscv_runner()
