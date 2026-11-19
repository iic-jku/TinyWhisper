# TinyWhisper Errata: First Silicon (SoC4219)

This sheet lists the known deviations of the first TinyWhisper silicon from its intended behaviour and its documentation, with the workaround for each. It is written before the dies arrive, from a review of the RTL, the netlists and the shipped layout. Every entry is therefore predicted, not yet measured. Update the status of each entry as bring-up confirms or clears it.

## Device identification

| Item | Value |
| --- | --- |
| Chip | TinyWhisper, IHP SG13G2 open MPW, March 2026, chip ID `SoC4219` |
| Silicon revision | 1 (release [`v.1.0.0`](../release/v.1.0.0/)) |
| Design state | Branch `IHP-TO-2026-03` |
| Shipped GDS | `ihp130/gds/SoC4219.gds.gz` on `IHP-TO-2026-03`, identical to [`release/v.1.0.0/gds/SoC4219.gds.gz`](../release/v.1.0.0/gds/) |
| MD5 of the shipped `.gz` | `1ae88675097f8dd8c7bb68c965c5a6d4` |
| MD5 of the unzipped GDS | `52c7bafd6d992a4c171a50bdc9ca3d73` |
| Package | QFN-48, 56 pads (the 12 VSS and IOVSS pads downbonded to the exposed pad) |

The design on `main` and in release `v.2.0.0` is **not** this silicon:

- The `riscv` macro views in `macros/riscv/final/` were re-hardened after tapeout.
- The `v.2.0.0` chip layout differs in routing and fill, and its origin is shifted by 25 um.

The RTL on `main` is logically equivalent to the silicon. File and line references below point to `main` (commit `ad6cbaf`).

## Severity classes

| Class | Meaning |
| --- | --- |
| **Critical** | The chip does not boot, or it transmits on the wrong frequency, unless the workaround is applied |
| **Major** | A feature does not work as specified. A workaround restores it fully or partly |
| **Minor** | A deviation that costs bring-up time or limits performance |
| **Doc** | The documentation or the reference firmware disagrees with the silicon |

## Summary

| ID | Title | Block | Class | Workaround |
| --- | --- | --- | --- | --- |
| TW-E01 | SRAM chip select is active high | SPI master | Critical | Inverting buffer on the board |
| TW-E02 | SRAM bus pins are always driven, also in reset | SPI master, pads | Critical | Tri-state buffers if a loader shares the bus |
| TW-E03 | Default I/Q convention transmits the lower sideband | Signal chain | Critical | Set `ds_switch` or negate `f_c` |
| TW-E04 | `FREQ_STATUS` reset value selects the external analog inputs and pad-sourced LO/DS | Memory map | Major | Write `FREQ_STATUS` first after boot |
| TW-E05 | Second-order modulator overloads at the reset amplitude | Delta-sigma modulator | Major | Amplitude at most 0.90 of full scale |
| TW-E06 | Interpolation step overflows at high baseband frequency | Delta-sigma modulator | Minor | Use OSR 32 |
| TW-E07 | UART RX samples each bit at its leading edge | UART RX | Major | Keep RX bit period 510, host sends 2 stop bits |
| TW-E08 | UART default bit period is 4.9 % slow | UART TX | Minor | Write `UART_TX_CPB` = 485 |
| TW-E09 | UART RX has no sticky data-valid flag and no overrun flag | UART RX | Major | Poll `mip[16]` |
| TW-E10 | I2C MC master sends no repeated START | I2C MC master | Major | Use I2C master 1 for reads |
| TW-E11 | I2C MC master corrupts every read | I2C MC master | Major | Use I2C master 1 for reads |
| TW-E12 | I2C MC `force_stop` deadlocks the MC master | I2C MC master | Major | Never write `I2C_MC_STOP` |
| TW-E13 | I2C MC handshake registers: level-sensitive request, no reset, endless transfer at length 0 | I2C MC master | Minor | Pulse the request, initialise all registers |
| TW-E14 | I2C SDA and SCL are push-pull, no clock stretching | I2C, pads | Major | Series resistors, non-stretching slaves |
| TW-E15 | I2C START and STOP timing below Standard-mode limits | I2C masters | Minor | Use Fast-mode capable slaves |
| TW-E16 | I2C master 1 ACK register holds stale bits | I2C master 1 | Minor | Check only the frames written |
| TW-E17 | Only `csrr`, `csrw` and `mret` are implemented | CPU CSR | Minor | Restrict firmware to these |
| TW-E18 | `mret` always enables interrupts | CPU CSR | Minor | See entry |
| TW-E19 | `mtvec` mode is ignored, interrupts are always vectored | CPU CSR | Minor | Use a vector table |
| TW-E20 | `mcause` is written outside traps | CPU CSR | Minor | Read `mcause` only in a trap |
| TW-E21 | Memory-map access-fault semantics | Memory map | Minor | See entry |
| TW-E22 | Misaligned jump reported at the target address | CPU | Minor | Return through `ra` |
| TW-E23 | Reserved load/store encodings are not trapped, x16 to x31 alias x0 to x15 | CPU | Minor | Build with `rv32e` |
| TW-E24 | External interrupt re-triggers while the pin is high | CPU CSR | Minor | Mask `mie[11]` in the handler |
| TW-E25 | Reset is synchronous only and needs a running clock | Reset | Major | Clock first, reset released in sync |
| TW-E26 | LO and modulator monitor pads cannot be switched off | Pads | Minor | Leave the pins open or add series resistors |
| TW-E27 | 10 m band image rejection limited by clock duty and LO path skew | LO generator | Minor | 50 % duty clock with 1.5 V swing |
| TW-E28 | Analog and digital core share one supply | Power | Minor | Low-noise 1.5 V supply, decoupling |
| TW-E29 | No pull-up or pull-down in any pad | Pads | Minor | Board pulls |
| TW-E30 | External analog inputs are clamped to IOVDD, not to the 1.5 V core | Analog pads | Minor | Keep inputs within 0 to 1.5 V |
| TW-E31 | Power-up order is not controlled on chip | Power | Major | IOVDD first, reset held, see entry |
| TW-D01 | Frequency resolution, default OSR and default modulator order wrongly documented | Docs | Doc | Values in entry |
| TW-D02 | Reference firmware constants are for the FPGA, not the silicon | Firmware | Doc | Values in entry |
| TW-D03 | Pinout and downbond documentation | Docs | Doc | Values in entry |

## Errata

### TW-E01: SRAM chip select is active high

- **Class:** Critical. **Status:** predicted, traced in RTL and gate-level simulation.
- **Description:** `sram_ce` (`output_PAD[6]`) is high while a transfer runs and low when idle (`macros/riscv/rtl/spi_master.sv:111,122`). The polarity follows the pico-ice FPGA board, which inverts it on the board (`spi_master.sv:11`). The APS6404L named in `pcb/README.md` has an active-low CE#.
- **Impact:** wired directly, the SRAM is selected while idle and deselected during every transfer. The CPU never fetches a valid instruction.
- **Workaround:** put an inverting buffer between `output_PAD[6]` and CE#. Use a tri-state type if a loader shares the bus (TW-E02), and put the CE# pull-up on the SRAM side of the buffer.
- **Fix in next revision:** drive an active-low chip select.

### TW-E02: SRAM bus pins are always driven, also in reset

- **Class:** Critical when a loader shares the bus, otherwise Minor. **Status:** predicted, traced in RTL and simulation.
- **Description:**
  - The CPU has no boot ROM. It fetches from the external SPI SRAM at address 0.
  - `si`, `sclk` and `sram_ce` sit on output-only pads (`sg13g2_IOPadOut30mA`). They drive even while `rst_n` is low: si=0, sclk=1, ce=0.
  - `sclk` runs at fclk/2 (28 MHz) without pause, also when no transfer is active (`spi_master.sv:52-67,103-104`).
- **Impact:**
  - A host that loads the SRAM over the same wires (for example an RP2040, as on pico-ice) fights the chip's drivers and cannot program it.
  - The free-running 28 MHz clock is an aggressor 125 kHz away from the 10 m WSPR frequency.
- **Workaround:**
  - Route `si`, `sclk` and `sram_ce` through tri-state buffers or a multiplexer that the loader owns while `rst_n` is low.
  - Keep `rst_n` low for at least 150 us after the SRAM supply is valid.
  - Keep the three lines short and away from the RF output, with series resistors at the chip.
- **Fix in next revision:** release the SRAM pins in reset (bidirectional pads with the driver off until reset is released) or add a boot ROM. Stop `sclk` between transfers.

### TW-E03: Default I/Q convention transmits the lower sideband

- **Class:** Critical. **Status:** predicted, traced in RTL and confirmed in the committed post-layout simulation of the IQ modulator.
- **Description:**
  - The LO phases come in the order I, Q, Ix, Qx (`macros/riscv/rtl/lo_gen.v:52-55,111-114`), so Q lags I by 90 degrees.
  - For a positive frequency word `f_c` the CORDIC delivers I = cos and Q = sin.
  - With the four RF outputs joined, the output is I·cos(w_LO t) + Q·sin(w_LO t), which sits at f_LO minus f_IF.
  - The documentation and the reset default (`memory.sv:460`, 124.6 kHz with the 28 MHz LO) intend 28.1246 MHz. The chip transmits at 27.8754 MHz instead, with the WSPR tone order mirrored.
  - The same applies on every band. With the documented IF values the signal lands at 13.9044, 6.9614 and 3.4314 MHz, outside the amateur bands.
- **Impact:** transmission outside the intended band, and WSPR decoders cannot decode the signal.
- **Workaround:** either one of these:
  - Set `ds_switch` (`FREQ_LO_DIV` bit 7, `freq_generator.sv:107-110`). The reference firmware has no helper for this bit.
  - Program `f_c` as a negative 30-bit two's-complement number. Do not cast a negative `double` to `uint32_t` as `compute_osr_fc` does. That is undefined behaviour in C.

  Do the first RF tests into a dummy load. Joining the four RF pads with Q subtracted on the board also flips the sideband, so define the board combination before choosing the firmware setting.
- **Fix in next revision:** fix the sign convention in one place and add a sideband check to the regression.

### TW-E04: `FREQ_STATUS` reset value selects the external analog inputs and pad-sourced LO/DS

- **Class:** Major. **Status:** predicted, traced in RTL and gate-level simulation.
- **Description:**
  - The reset value is `freq_status[7:3] = 5'b11100` (`memory.sv:445-447`). The comments on those lines say the opposite of what the bits do.
  - `freq_status[6:5] = 2'b11` sets `I_ae = Q_ae = 1`, which makes the SPDT switches connect the **external analog pads** to the filters (`memory.sv:387-392`).
  - `freq_status[4:3] = 2'b00` sets the LO and delta-sigma output enables to 0. The eight bidir pads `bidir_PAD[7:0]` are then inputs, and the IQ modulator takes its LO and DS signals **from those pads** (`memory.sv:403-421`).
- **Impact:** until firmware writes `FREQ_STATUS`, floating board nets drive the mixer switches and the filter inputs.
- **Workaround:**
  - Write `FREQ_STATUS` early in the boot code. `0x9B` selects the internal path with outputs enabled and starts the chain.
  - Put weak pull-downs (about 100 kOhm) on the eight bidir pins.
  - Tie the four analog input pads to a defined level between 0 and 1.5 V.
- **Fix in next revision:** choose the intended reset state and correct the comments.

### TW-E05: Second-order modulator overloads at the reset amplitude

- **Class:** Major. **Status:** predicted, RTL simulation.
- **Description:**
  - The reset value of `cordic_I` (`memory.sv:452`) gives 0.999995 of full scale after the CORDIC gain.
  - The integrators of the second-order modulator do not saturate (`dsmod.v:105-108`).
  - A DC input wraps between 0.955 and 0.965 of full scale.

  | Input (124.6 kHz, OSR 32) | Order | SNDR |
  | --- | --- | --- |
  | 0.90 FS | 2nd | 57.4 dB |
  | 1.0 FS | 2nd | 2.8 dB |
  | 1.0 FS | 1st (reset default) | 52.5 dB |

- **Impact:** switching to second order at the reset amplitude gives a broken output spectrum.
- **Workaround:** before setting `ds_mode` (`FREQ_LO_DIV` bit 5), write `cordic_I` at most 293414793 (0.90 FS). For any I/Q pair keep sqrt(I² + Q²) x 1.64676 at most 0.93 FS.
- **Fix in next revision:** saturate the integrators or add an overload reset.

### TW-E06: Interpolation step overflows at high baseband frequency

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:**
  - The difference between two consecutive CORDIC samples is computed in 38 bits (`dsmod.v:132-135`). It wraps when 2A·sin(pi·f/fs) reaches 1.
  - Examples: OSR 128 at 124.6 kHz limits the amplitude to 0.641, and OSR 256 at 95.6 kHz to 0.510.
  - At OSR 128 the interpolation image (fs minus f) also falls inside the 400 kHz filter passband.
- **Workaround:** use OSR 32 on every band. All four WSPR settings fit at OSR 32.
- **Fix in next revision:** compute the difference in 39 bits.

### TW-E07: UART RX samples each bit at its leading edge

- **Class:** Major. **Status:** predicted, RTL simulation.
- **Description:**
  - The sample point compares the bit counter with `{1'b0, CYCLES_PER_BIT[14:0]}`, which equals the full bit period, not half of it (`uart_rx.v:110-112,169`).
  - Each bit is taken at its leading boundary, and the stop state lasts a full bit.
  - The receiver works only when it is slower than the sender. Back-to-back bytes with 1 stop bit slip after a few bytes.
- **Workaround:**
  - Leave `UART_RX_CPB` at its reset value 510.
  - Configure the host for 2 stop bits, or leave at least one bit time between bytes.
  - With 2 stop bits the working range is CPB 486 to 533. Do not write the computed 485 or 486 (`uart_compute_cpb`) to `UART_RX_CPB`.
- **Fix in next revision:** sample at `CYCLES_PER_BIT[15:1]`.

### TW-E08: UART default bit period is 4.9 % slow

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:** the default is computed with the clock period truncated to 17 ns (`memory.sv:303-305`). The transmitter adds one cycle (`uart_tx.v:96`). The bit lasts 511 clocks, 109589 baud instead of 115200.
- **Workaround:** write `UART_TX_CPB` = 485 (486 clocks, 115226 baud) before the first character.
- **Fix in next revision:** compute the default with rounding and the minus-one offset.

### TW-E09: UART RX has no sticky data-valid flag and no overrun flag

- **Class:** Major. **Status:** predicted, RTL simulation.
- **Description:**
  - The data-valid bit in the RX status register is a one-clock pulse (`uart_rx.v:96`, `memory.sv:330`). Polling it almost never sees it.
  - A new byte overwrites the data register without an overrun indication.
  - The UART interrupt pending bit `mip[16]` is set by hardware and never cleared by it (`csr.sv:60`).
- **Workaround:**
  - Poll `mip[16]` (it works with interrupts disabled) or use the interrupt.
  - Clear `mip[16]` with a read-modify-write that keeps the other bits.
  - Avoid long blocking I2C transfers while bytes are expected.
- **Fix in next revision:** a sticky valid flag cleared on read, an overrun flag, and hardware clearing of the pending bit.

### TW-E10: I2C MC master sends no repeated START

- **Class:** Major. **Status:** predicted, RTL simulation.
- **Description:** the RESTART state changes the SDA data but never enables the SDA driver (`i2c_master_mc.sv:222-239`). No repeated START appears, so register reads with a sub-address fail on every device.
- **Workaround:** use I2C master 1 for reads. Write the register pointer in a separate transaction if a device needs it.
- **Fix in next revision:** enable the driver in RESTART.

### TW-E11: I2C MC master corrupts every read

- **Class:** Major. **Status:** predicted, RTL simulation.
- **Description:**
  - After each read byte the master enables its SDA driver while SCL is high and the data register is 0 (`i2c_master_mc.sv:449`). After a byte whose bit 0 is 1 this is a START condition.
  - No STOP follows a read (`:475`).
  - Single-byte reads are affected too.
- **Workaround:** use I2C master 1 for all reads. The MC master is usable for writes.
- **Fix in next revision:** enable the ACK driver only after the SCL falling edge, and generate STOP for reads.

### TW-E12: I2C MC `force_stop` deadlocks the MC master

- **Class:** Major. **Status:** predicted, RTL simulation.
- **Description:** writing `I2C_MC_STOP` forces the STOP state from any state, including idle (`i2c_master_mc.sv:515-518`). STOP is left only through a write-mode SCL edge. Only a chip reset recovers.
- **Workaround:** never write `I2C_MC_STOP`. If the MC master hangs, set `I2C_MC_ENABLED` = 0 and use master 1.

### TW-E13: I2C MC handshake registers

- **Class:** Minor. **Status:** predicted, traced in RTL.
- **Description:**
  - `I2C_MC_REQ` is level-sensitive and repeats the transfer while it stays 1.
  - `I2C_MC_WRITE` has no reset value (`memory.sv:258`). It is the R/W bit, so 1 means read.
  - `I2C_MC_SUBADDR` is ignored unless `I2C_MC_SUBLEN[0]` is set.
  - `I2C_MC_BYTELEN` = 0 gives an endless transfer.
- **Workaround:** write every MC register before first use, write REQ as 1 then 0, and never use length 0.

### TW-E14: I2C SDA and SCL are push-pull, no clock stretching

- **Class:** Major (electrical). **Status:** predicted, RTL simulation.
- **Description:**
  - Both masters drive SDA high actively (`i2c_master.sv:244-246`, `i2c_master_mc.sv:164-165`).
  - SCL is on an output-only pad (`tinywhisper_core.sv:144`).
  - At slave ACKs the master and the slave drive against each other for up to 2.5 us at 100 kHz.
- **Impact:** contention current on every affected ACK. No clock stretching and no second master on the bus.
- **Workaround:** pull-ups plus 100 to 330 Ohm series resistors in SDA and SCL. Use slaves that do not stretch the clock.
- **Fix in next revision:** open-drain emulation and a bidirectional SCL pad.

### TW-E15: I2C START and STOP timing below Standard-mode limits

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:**
  - Master 1: tHD:STA and tSU:STO are 2.5 us. Standard mode requires 4.0 us.
  - MC master: tSU:STO is 286 ns. Fast mode requires 0.6 us. The constants were sized for a 100 MHz clock (`i2c_master_mc.sv:9,117`).
- **Workaround:** use Fast-mode capable slaves. Lowering `SCL_RATIO` does not change these times.

### TW-E16: I2C master 1 ACK register holds stale bits

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:** the code that clears the ACK bits at START never runs (`i2c_master.sv:181-184`). Reads never update them.
- **Workaround:** evaluate only the address ACK and the ACK bits of frames written in the current transaction.

### TW-E17: Only `csrr`, `csrw` and `mret` are implemented

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:**
  - Only the CSR read and write forms are decoded (`control.sv:175`, `alu.sv:91-98`).
  - `csrs` and `csrc` with a register are silently ignored.
  - The immediate forms, `ecall`, `ebreak`, `wfi` and `fence` raise an illegal-instruction exception (cause 2).
  - `csrrw` with rd other than x0 does not write rd.
- **Workaround:** use only `csrr`, `csrw` and `mret`. The current firmware does so.

### TW-E18: `mret` always enables interrupts

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:** `mret` sets `mstatus.MIE` to 1 regardless of the previous state (`csr.sv:68-70`). There is no MPIE.
- **Workaround:** an exception handler that returns into code running with interrupts disabled must disable them again afterwards.

### TW-E19: `mtvec` mode is ignored, interrupts are always vectored

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:**
  - Interrupts jump to `mtvec` base + 4 x cause, regardless of the mode bits (`csr.sv:107`).
  - The reset value of `mtvec` is 1 (base 0). An exception before `mtvec` is set re-enters `_start` without resetting the peripherals.
- **Workaround:** set `mtvec` early and place a vector table at its base.

### TW-E20: `mcause` is written outside traps

- **Class:** Minor. **Status:** predicted, RTL simulation and trace.
- **Description:**
  - `mcause` follows the current cause conditions every cycle (`csr.sv:85-90`). After reset it reads 2.
  - If an enabled interrupt becomes pending while an exception is taken, the trap goes to the exception handler with an interrupt cause.
- **Workaround:** read `mcause` only inside a trap. Do not rely on it to tell exceptions from interrupts in that corner case.

### TW-E21: Memory-map access-fault semantics

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:**
  - A store to an unmapped address raises a load access fault (cause 5). Store access fault (cause 7) is never produced.
  - Reading `GPIO_OUT` faults.
  - Reads of unused addresses inside the peripheral window return stale data instead of faulting.
  - Peripheral reads ignore the access width, so `lb` from a peripheral register is not sign-extended.
- **Workaround:** keep a shadow copy of `GPIO_OUT`, and use word accesses to peripherals.

### TW-E22: Misaligned jump reported at the target address

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:** a jump to a misaligned target traps with `mepc` set to the target, not to the jump (`instructioncounter.sv:38`, `control.sv:107`).
- **Workaround:** a handler that returns must use the return address in `ra`, not `mepc` + 4.

### TW-E23: Reserved load/store encodings are not trapped, x16 to x31 alias x0 to x15

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:**
  - Loads with funct3 3, 6 or 7 read SRAM address 0, and stores with funct3 4 or 5 execute (`alu.sv:123-127`).
  - Misaligned SRAM accesses execute without a trap.
  - Register fields are 4 bits wide, so x16 to x31 address x0 to x15.
- **Workaround:** build with `-march=rv32e_zicsr -mabi=ilp32e`, as `software/c_toolchain` does, and keep hand-written assembly within x0 to x15.

### TW-E24: External interrupt re-triggers while the pin is high

- **Class:** Minor. **Status:** predicted, RTL simulation.
- **Description:** `gpio_in[0]` sets the external pending bit on every cycle it is high, and only entering the handler clears it (`csr.sv:59,65`). A held level re-enters the handler after every `mret`.
- **Workaround:** in the handler, clear `mie[11]` until the pin is low again, and use a pull-down on `gpio_in[0]`.

### TW-E25: Reset is synchronous only and needs a running clock

- **Class:** Major. **Status:** predicted, traced in RTL and netlist.
- **Description:**
  - `rst_n` acts only on clock edges (`riscv_top.sv:95-99`). All flip-flops have their asynchronous reset tied off.
  - There is no reset synchronizer.
  - The clock and reset pads have no hysteresis.
- **Impact:**
  - Without a clock, reset does nothing, so pad output enables and `analog_en` are random from power-up until the first clocked reset.
  - A reset release asynchronous to the clock can reach different flip-flops in different cycles.
- **Workaround:**
  - Start the 56 MHz clock before releasing reset, and hold reset for many clock cycles.
  - Release `rst_n` through a flip-flop clocked by the same oscillator, with fast edges.
- **Fix in next revision:** asynchronous assert, synchronous release.

### TW-E26: LO and modulator monitor pads cannot be switched off

- **Class:** Minor. **Status:** predicted, traced in RTL.
- **Description:**
  - The output enable of the eight bidir pads doubles as the source select of the IQ modulator (`memory.sv:403-421`). Using the internal LO and modulator therefore drives all eight pads with the strongest output driver (30 mA).
  - On the 10 m band the LO pads toggle at 28.000 MHz, 124.6 kHz from the wanted signal.
- **Workaround:** leave `bidir_PAD[7:0]` unconnected, or route them to test points through 100 to 330 Ohm series resistors at the chip. Keep them away from the RF output.
- **Fix in next revision:** separate the pad enable from the source select, and use weaker drivers for monitor pins.

### TW-E27: 10 m band image rejection limited by clock duty and LO path skew

- **Class:** Minor. **Status:** predicted, derived from RTL and the timing data of the hardened macro.
- **Description:**
  - With the LO at fclk/2 (`lo_div_sel` = 0, 10 m band), the I and Ix pulses last the clock high time and the Q and Qx pulses the clock low time (`lo_gen.v:87-114`). Clock duty error becomes an I/Q gain imbalance.
  - In addition, the `lo_I_o` output path of the CPU macro is 0.16 to 0.25 ns slower than the other three phases, a phase error of 1.0 to 2.2 degrees across corners.

  | Cause | Value | Image rejection |
  | --- | --- | --- |
  | Clock duty | 45 % | about 22 dB |
  | Clock duty | 48 % | about 30 dB |
  | Path skew alone (perfect clock) | 1.0 to 2.2 degrees | about 34 to 41 dB |

  The two effects add. Other bands use registered counter states and do not depend on duty.
- **Workaround:**
  - Drive the clock with 50 % duty and a 1.5 V swing. The clock receiver switches near half the core supply, so a 3.3 V swing with slow edges distorts the duty.
  - For trimming, AC-couple the clock and adjust its DC bias while watching the image.
  - Measure the duty on the LO monitor pins.
- **Fix in next revision:** generate the four phases from a 2x or 4x clock with registered outputs, and constrain the skew of the four LO paths.

### TW-E28: Analog and digital core share one supply

- **Class:** Minor. **Status:** by design, traced in RTL and layout.
- **Description:** the CPU and the IQ modulator share VDD and VSS (`tinywhisper_core.sv:58-59,111-112`). The IO ring has no supply split.
- **Impact:** CPU activity and the free-running SPI clock can modulate the filter and mixer supply, which shows up as spurs.
- **Workaround:**
  - Use a low-noise 1.5 V supply and decouple every VDD pin at the package. A separate analog regulator does not help, because the rails are joined on the die.
  - Compare spectra with the CPU running and with it halted in a tight loop.
- **Fix in next revision:** separate analog supply pads and a split IO ring.

### TW-E29: No pull-up or pull-down in any pad

- **Class:** Minor. **Status:** by design, traced in the IO cell netlist.
- **Description:** none of the IO cells has a pull.
- **Workaround:**

  | Pins | Board pull |
  | --- | --- |
  | `rx` (`input_PAD[4]`) | Pull-up (UART idles high) |
  | `so` (`input_PAD[5]`) | Pull-up |
  | `gpio_in[3:0]` (`input_PAD[3:0]`) | Pull-down. `gpio_in[0]` is the external interrupt and must not float |
  | `bidir_PAD[7:0]` | Pull-down (TW-E04) |

  A pull-down on `rx` would read as a permanent start bit and flood the receiver with 0x00 bytes.

### TW-E30: External analog inputs are clamped to IOVDD, not to the 1.5 V core

- **Class:** Minor. **Status:** traced in the IO cell netlist.
- **Description:**
  - The analog input pads (`analog_PAD[1:0]` and `[7:6]`) reach thin-oxide 1.5 V switches through about 590 Ohm. Their protection diodes clamp to IOVDD (3.3 V).
  - The RF outputs (`analog_PAD[5:2]`) use the bare pad with primary protection only.
- **Workaround:**
  - Keep external analog signals within 0 to 1.5 V and add series resistance. Never drive these pins while the chip is unpowered.
  - AC-couple the RF outputs. Their DC level is about 0.75 V, and a DC path to ground loads the filter amplifiers.
  - Handle the RF pins with ESD care.

### TW-E31: Power-up order is not controlled on chip

- **Class:** Major. **Status:** predicted, traced in the IO cell netlist, not simulated for this chip.
- **Description:**
  - The chip has no power-on reset. `rst_n` enters through an IO input pad, whose level shifter needs both supplies to deliver a defined level to the core.
  - With the core supply (VDD) off, the output level shifters on IOVDD have no defined input, so the outputs can drive either level.
- **Workaround:**
  - Bring up IOVDD (3.3 V) first, then VDD (1.5 V). For example, let a supervisor on IOVDD enable the 1.5 V regulator, and use a regulator with output discharge so that power-down runs in reverse.
  - Hold `rst_n` low from an external supervisor until both rails are valid and the clock runs.
  - The SRAM chip select stays inactive during power-up through the disabled buffer and the SRAM-side pull-up (TW-E01, TW-E02).
  - Limit the current of both supplies on the first power-up.

## Documentation and firmware errata

### TW-D01: Frequency resolution, default OSR and default modulator order

| Topic | Documentation | Silicon |
| --- | --- | --- |
| Frequency step | about 0.05 Hz (`README.md`, `doc/index.qmd`) | fs/2^30 with fs = fclk/OSR: 1.63 mHz at OSR 32, 0.20 mHz at OSR 256 |
| Default OSR | 64 (`doc/index.qmd`) | 32 (`memory.sv:460`) |
| Default modulator order | second order | first order (`ds_mode` = 0 at reset) |
| Reset type of `dsmod` and `lo_gen` | "async. reset" in the file headers | synchronous |
| Delta-sigma SNDR | 85.2 dB (`doc/index.qmd`) | 68.7 dB peak in the committed bench results |

### TW-D02: Reference firmware constants are for the FPGA

| Item | Firmware | Required for the silicon |
| --- | --- | --- |
| `CLK_FREQ` in `demo.c` and `hardware_test.c` | 12e6 | 56e6 |
| WSPR tone spacing in `demo.c` | 1.5 Hz | 12000/8192 = 1.4648 Hz |
| Frequency word | tone only | IF + 1500 Hz + tone offset, with the sideband per TW-E03 |
| `freq_lo_div_set` mask | 3 bits | 2 bits (`lo_gen.v:44`) |
| `OSR << 30` | signed int, overflows | unsigned |
| `uart_rx_set_cpb(uart_compute_cpb(...))` | writes 486 | keep 510 (TW-E07) |
| `start.s` | does not clear `.bss` | clear `.bss` |
| `mtime_get` | reads high then low once | retry on a low-word wrap |
| Default interrupt handlers | do not clear their sources | clear the pending source |

### TW-D03: Pinout and downbond documentation

- [`pinout.md`](pinout.md) is still a placeholder. The pad-to-QFN mapping is in [`../packaging/result.md`](../packaging/result.md). That report was generated for `v.2.0.0`, and the pad order is the same as on `SoC4219`. Confirm the QFN pin numbers against the bonding diagram used for the `SoC4219` assembly before the first PCB is drawn.
- VSS and IOVSS have no pad-to-lead wire: all 9 VSS and 3 IOVSS pads are downbonded to the exposed pad, and the leads 15 (IOVSS), 27, 34 and 46 (VSS) are bonded to it (`../packaging/config.yaml`).
