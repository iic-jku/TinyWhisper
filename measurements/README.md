# Measurements

How SoC4219, the first TinyWhisper silicon, is brought up and characterized on the dev board, step by step, with the equipment each step needs. Nothing on this page is measured yet.

- The packaged chip is soldered onto the dev board in [`pcb/`](../pcb/). The board carries the host (a Raspberry Pi Pico), the PSRAM, the 56 MHz clock, the supplies and debug access to every chip pin. [`pcb/README.md`](../pcb/README.md) is the board contract, and the reference designators below are its own.
- The known deviations of the silicon are listed in [`ihp130/doc/errata.md`](../ihp130/doc/errata.md) and cited here as `TW-Exx` and `TW-Dxx`. Update the status of an entry when a step confirms or clears it.
- Register names and bits come from `ihp130/macros/riscv/rtl/memory.sv`, the LO divider from `lo_gen.v`.

## Equipment

| Function | Requirement | Steps |
| --- | --- | --- |
| Bench supply | Two channels, 0 to 5 V, current limit settable in 1 mA steps | 3 |
| Multimeter | Continuity and diode test, mA range, 4½ digits | 1, 2, 3 |
| Oscilloscope | 4 channels, 500 MHz or more, 5 GS/s or more, low-capacitance probes. A 0.5 % duty step of the 56 MHz clock is 0.09 ns. | 2, 5, 6 |
| Frequency reference and counter | 10 MHz reference shared by counter, spectrum analyzer and generator, 0.1 ppm resolution at 56 MHz | 6, 9 |
| Spectrum analyzer | 9 kHz to 300 MHz or more, 50 Ω input, resolution bandwidth 1 Hz or less, 10 MHz reference input | 4, 6, 7, 8, 9 |
| Function generator | Two channels. 56 MHz square wave with duty and offset control and a 3.3 V high level. Sine from 1 kHz to 2 MHz with offset and 90° between the channels. | 6, 7 |
| Logic analyzer | 8 channels or more, 200 MS/s or more or clocked from `TP301`, SPI, UART and I2C decoders | 2, 4, 5 |
| WSPR receiver | HF receiver or SDR with USB demodulation and WSJT-X, 60 dB of attenuators, 50 Ω dummy load | 9 |
| PC | Python 3 with `pyserial` and `tqdm` for `software/c_toolchain/program_sram.py`, the RISC-V toolchain of `software/c_toolchain/` | all |

## Setup

- The Pico's USB connects the board to the PC and powers it. The Pico loads the chip's program into the PSRAM, hands the PSRAM bus to the chip (`BUS_PICO` low), checks `VDD` on `GP26` and releases reset (`RST_REQ_N` high, `GP3`). The reset flip-flop `U301` then releases `rst_n` on a rising clock edge (TW-E25).
- The chip's firmware is built in `software/c_toolchain/` with the silicon constants of TW-D02 (`CLK_FREQ` 56e6, not the 12e6 of the FPGA).
- `J602` (SMA, RF OUT) carries the four joined RF outputs through the DC block `C602` (100 nF, 0.45 Ω at 3.5 MHz) and `R615` (953 Ω). With the analyzer's 50 Ω the chip sees 1003 Ω, the 1 kΩ load of the bench `iqmod_top_tb_tran` (`Rload=1k`).
- The analyzer sees 50/1003 of the RF voltage, 26.0 dB less. The power into the 1003 Ω load is the analyzer reading plus 13.0 dB (1003/50 = 20.06).
- Scope and logic analyzer reach the clock at `TP301`, reset at `TP302`, the LO and modulator monitor pads at `J503`, UART at `J302`, GPIO at `J502` and I2C at `J501`.

## Protocol

### 1. Bond diagram of the packaged parts

The parts follow either the bond plan of 2026-11-11 (`ihp130/packaging/result.md`: pin 14 `VDD`, pin 15 an `IOVSS` lead bonded to the cavity) or the older one, in which pin 14 was an `IOVSS` lead wired to an `IOVSS` pad and pin 15 a `VDD` lead (TW-D03). A board strapped for the wrong one shorts `VDD` to ground.

Ask the assembler for the bond diagram of the `SoC4219` lot. Then measure one loose, unpowered part with the multimeter, pins 14 and 15 against the exposed pad, in both polarities:

| Reading | Bond plan | Straps on the board |
| --- | --- | --- |
| Pin 15 a short, pin 14 a diode in one polarity and open in the other (the `VDD` clamp) | 2026-11-11 | `R101` and `R103` fitted, `R102` and `R104` open (as built) |
| Pin 14 a short (bond wires and the on-chip `IOVSS` rail), pin 15 a diode in one polarity | older | `R102` and `R104` fitted, `R101` and `R103` removed |

Handle the parts as ESD sensitive: the four RF outputs have primary protection only (TW-E30).

### 2. Board without the chip

Assemble everything except `U1` and flash the Pico with the bring-up firmware.

| Check | Measurement | Expected |
| --- | --- | --- |
| Shorts | Resistance from `+5V`, `+3V3`, `IOVDD` and `VDD` to `GND`, unpowered | No short |
| `+5V` | Pico pin 40 (`VBUS`) | 4.75 to 5.25 V (USB 2.0) |
| `+3V3` and `IOVDD` | `J201` with `JP201` fitted | 3.25 to 3.35 V (AP2112K-3.3, ±1.5 %) |
| `VDD` | `J202` with `JP202` fitted | 1.47 to 1.53 V (LP5907MFX-1.5, ±2 %) |
| Sequence | Scope on `J201` and `J202`, trigger on `IOVDD` at plug-in | `VDD` starts 120 to 350 ms after `IOVDD` passes about 2.96 V (TPS3839K33: 2.93 V threshold plus 29 mV hysteresis) |
| Clock | Counter and scope at `TP301` | 56 MHz within the stability option of `X301` (±20, ±25 or ±50 ppm), duty 45 to 55 % (SiT8008 data sheet). Record both for steps 6 and 8. |
| Reset | `TP302` against `TP301` | `RST_N` low while `GP3` is low or `SW302` is pressed. With `GP3` high it rises within 5 ns of a rising clock edge (74AUP1G74 at 3.3 V). With `GP14` (`CLK_OE`) low the clock stops and `RST_N` no longer follows `GP3`. |
| PSRAM | Pico with `BUS_PICO` high: 150 µs after power, reset enable `0x66` and reset `0x99`, then read ID `0x9F` | Known-good-die byte `0x5D` (APS6404L data sheet, table 4) |
| PSRAM data | Pico writes all 8 MB with a pseudo-random pattern and reads it back, read command `0x03` at 33 MHz or less | No error |
| Bus handover | `BUS_PICO` low, no chip | `CE#` of `U401` stays high: `R405` pulls the chip side of the inverting buffer `U404` low |

### 3. First power-up with the chip

Solder `U1` with the straps of step 1. Both chip supplies come from the current-limited bench supply for the first power-up (TW-E31).

1. Unplug the Pico's USB and the OLED. Pull `JP201` and `JP202`.
2. Channel 1 at 3.3 V with a 30 mA limit to the chip side of `JP201` and `GND` of `J201`. Channel 2 at 1.5 V with a 50 mA limit to the chip side of `JP202` and `GND` of `J202`. Both off.
3. Channel 1 on (`IOVDD`).
4. Plug in the Pico's USB. The clock starts and `U301` holds `rst_n` low. Keep steps 3 and 4 close together: until `VDD` is up the chip's outputs are undefined (TW-E31) and reach the unpowered Pico through 1 kΩ.
5. Channel 2 on (`VDD`), 350 ms or more after plug-in.
6. Read both currents with the chip in reset and the clock running. Stop if a channel reaches its limit.
7. Power down in reverse: channel 2, USB, channel 1.

`IOVDD` comes up before the board logic, so the clock, the PSRAM and the Pico never drive the pins of an unpowered IO ring, and `VDD` comes last (TW-E31).

| Rail | Condition | Expected | Source |
| --- | --- | --- | --- |
| `VDD` | Transmitting on 10 m | 29.5 mA | 19.8 mW of `riscv_top` at `nom_typ_1p50V_25C` plus 24.4 mW of the IQ modulator (schematic, 10 m) at 1.5 V, `doc/index.qmd` |
| `IOVDD` | Transmitting on 10 m | About 10 mA, estimate | C·V²·f with 10 pF per pin: `sclk` and the eight monitor pads at 28 MHz give 9 × 0.92 mA = 8.3 mA, plus the board pulls |
| Both | In reset | No prediction | Record it |

The limits sit at 1.7 times (`VDD`) and 3 times (`IOVDD`) the expected values. Once the currents are recorded, refit the jumpers and use the board's regulators for the steps below. For a later current reading replace a jumper by an ammeter.

### 4. Boot and digital interfaces

The Pico loads the program with `BUS_PICO` high and the chip in reset, checks `VDD` (1.47 V or more on `GP26`), sets `BUS_PICO` low and then `RST_REQ_N` high. TW-E02 asks for 150 µs or more of reset after the PSRAM supply is valid, which this order exceeds.

| Test | Firmware | Measurement | Pass |
| --- | --- | --- | --- |
| Signal path | `FREQ_STATUS` = `0x9B` as the first store (TW-E04) | `J503` and the spectrum at `J602` | The monitor pads start to toggle. A tone appears at 27.8754 MHz, the lower sideband of the reset settings (28 MHz LO, 124.6 kHz IF, TW-E03), outside the amateur band, so into the analyzer only. Before the write the monitor pads are inputs held low by the board's 100 kΩ pull-downs and the analog inputs sit at `VCM` (0.75 V). |
| GPIO out | Walking one on `GPIO_OUT` (`0x00800000`) | LEDs `D501` to `D504`, Pico `GP10` to `GP13` | Every bit high and low |
| GPIO in | Read `GPIO_IN` (`0x00800001`) | Pico drives `GP6` to `GP9`, then the buttons `SW501` to `SW504` | Every bit high and low |
| UART TX | Write `UART_TX_CPB` = 485 before the first character (TW-E08) | Bit time of `UART_TX` at `J302` | 8.68 µs (486 clocks) after the write, 9.13 µs (511 clocks) before it. 1000 bytes at 115200 baud without error. |
| UART RX | Leave `UART_RX_CPB` at 510 (TW-E07), poll `mip[16]` (TW-E09) | Host sends 8 data bits and 2 stop bits, the chip echoes | 1000 bytes echoed without error |
| I2C write | Default `SCL_RATIO` 280 (100 kHz) | OLED on `J501`, a Fast-mode slave that does not stretch the clock (TW-E14, TW-E15) | The display shows the text |
| I2C read | Master 1 only (TW-E10, TW-E11), never write `I2C_MC_STOP` (TW-E12) | A target on `J501` that answers reads, logic analyzer on `SDA` and `SCL` | Data correct. Evaluate only the ACK bits of frames written (TW-E16). |
| Interrupt | External interrupt on `gpio_in[0]` (pin 45, driven by `GP6`). The handler clears `mie[11]` until the pin is low (TW-E24). | Count handler entries for a 10 ms high pulse | One entry per pulse |

### 5. LO and modulator monitor pads

With `FREQ_STATUS` = `0x9B` the eight pads on `J503` show the internal LO phases and the delta-sigma streams, driven by 30 mA pads that cannot be switched off (TW-E26). `FREQ_LO_DIV[1:0]` selects the band:

| `FREQ_LO_DIV[1:0]` | LO | Band | Clocks per LO period |
| --- | --- | --- | --- |
| `00` (reset) | 28 MHz | 10 m | 2 |
| `01` | 14 MHz | 20 m | 4 |
| `10` | 7 MHz | 40 m | 8 |
| `11` | 3.5 MHz | 80 m | 16 |

Per band, measure:

- Frequency of `lo_I`, `lo_Q`, `lo_Ix` and `lo_Qx`. Each phase is a 25 % pulse, in the order I, Q, Ix, Qx, so Q lags I by 90° and no two phases overlap.
- On 10 m the I and Ix pulses last the clock high time and the Q and Qx pulses the low time (TW-E27): 8.93 ns each at 50 % duty. Their difference is the clock duty at the chip pin. `lo_I` may arrive 0.16 to 0.25 ns late (TW-E27).
- `ds_I_p` against `ds_I_n` and `ds_Q_p` against `ds_Q_n`: complementary 1-bit streams.

The 100 Ω series resistors and the probe slow the edges, so compare pulse widths only between pads with the same probe.
For external LO or modulator signals, `FREQ_STATUS` bit 3 = 0 (`0x93`) turns the LO pads into inputs and bit 4 = 0 (`0x8B`) the delta-sigma pads, and the IQ modulator then takes its signals from `J503` (`memory.sv`, `software/c_toolchain/hardware_test.c`).

### 6. Clock frequency and duty

- **Frequency.** The RF frequency is f_LO + f_IF, and both are derived from the clock, so a clock error of x ppm moves the RF by x ppm. 20 ppm is 563 Hz at 28.1261 MHz, while WSPR needs the signal within ±100 Hz (3.6 ppm) of the dial frequency plus 1500 Hz. Count `TP301` against the 10 MHz reference and compute the frequency word from the measured clock: `f_c` = (f_target − f_clk/D) × 2^30 × OSR / f_clk, with D = 2, 4, 8 or 16 per band and f_target = dial + 1500 Hz + tone offset (TW-D02). Set `ds_switch` (`FREQ_LO_DIV` bit 7) for the upper sideband (TW-E03). Check of the formula: the reset value 76450417 is 124.6 kHz at OSR 32 and 56 MHz (`memory.sv`).
- **Duty.** Record the duty at `TP301` and the pulse widths of step 5. `X301` may deliver 45 to 55 %, and TW-E27 predicts about 22 dB image rejection on 10 m at 45 %, about 30 dB at 48 %, and 34 to 41 dB from the LO path skew alone.
- **Trim.** Remove `R304`, fit `R305` and feed `J301` from the generator: 56 MHz square wave from 0 V to 3.3 V, duty swept from 45 to 55 % in 0.5 % steps, while step 8 reads the image rejection on 10 m. `U301` needs 2 V or more at its clock input (74AUP1G74 data sheet), so the 1.5 V swing that TW-E27 suggests does not fit this board. `R303` (49.9 Ω, not fitted) terminates a generator that needs a 50 Ω load. Report the image rejection against duty, its maximum and the duty where it occurs.

### 7. MFB filter through the external analog inputs

- **Path.** `FREQ_STATUS` = `0xFB`: bits 6 and 5 (`I_ae`, `Q_ae`) connect the analog pads to the filter inputs instead of the delta-sigma streams, bit 3 keeps the internal LO, bits 1 and 0 run the generator that enables the LO (`memory.sv`, the same value as `hardware_test.c`). Measure on 10 m (`FREQ_LO_DIV[1:0]` = `00`), where products up to 2 MHz from the LO stay clear of the other LO and counter lines.
- **Drive.** The generator feeds `J601`. Each input passes 1 kΩ on the board and about 590 Ω in the pad (TW-E30) and is biased to `VCM` (0.75 V) through 100 kΩ. Keep every input between 0 and 1.5 V (TW-E30): a full-scale delta-sigma stream switches between 0 and 1.5 V, so its baseband reaches at most 0.75 V peak around 0.75 V. Switch the generator on only after `IOVDD` and `VDD` are up.
- **Why f_LO ± f_BB.** The passive mixer multiplies the filter output by the LO. A tone f_BB on the I inputs alone gives two products of equal level, at f_LO − f_BB and f_LO + f_BB. The mixer gain does not depend on f_BB while f_BB is far below f_LO, so either product against f_BB, normalized to its level at 1 kHz, is the filter response.
- **Transfer function.** Sweep f_BB from 1 kHz to 2 MHz on `vinp_I` with `vinn_I` left at `VCM`, then on the Q inputs. Expected: 3 dB down at 401 kHz post-layout, 358 to 519 kHz over 200 Monte Carlo samples (`doc/index.qmd`), and 18.1 dB down at twice the corner for a third-order Butterworth response (10·log10(1 + 2^6)). The board's 1 kΩ and the pad's 590 Ω divide against the filter's input resistance, so only the relative response is measured.
- **THD.** f_BB = 50 kHz, so that the harmonics up to the fifth stay below the corner, at 0.1, 0.3 and 0.6 V peak. Read the products at f_LO ± k·f_BB for k = 2 to 5 relative to the wanted product. The mixer adds its own distortion, so the result is an upper bound of the filter's THD. No simulated THD is committed to compare with.

### 8. RF output per band

Settings per band: `FREQ_LO_DIV[1:0]` from step 5, the IF from the band table of the top-level `README.md` (124.6, 95.6, 38.6 and 68.6 kHz for 10, 20, 40 and 80 m), `f_c` from step 6, `ds_switch` set, OSR 32 (TW-E06), and either the first-order modulator or a CORDIC amplitude of 0.90 of full scale or less for the second order (TW-E05).

- **Level.** Analyzer reading at f_LO + f_IF plus 13.0 dB is the power into the 1003 Ω load. The simulation gives −11.9 dBm post-layout on 10 m into the band-pass model and its 1 kΩ load (`doc/index.qmd`), which would read about −25 dBm on the analyzer if it holds for the resistive load.
- **Sideband (TW-E03).** With `ds_switch` = 0 the tone sits at f_LO − f_IF, with `ds_switch` = 1 at f_LO + f_IF. The level difference between the two products is the image rejection: 22 to 41 dB expected on 10 m (TW-E27). The lower bands use registered counter states and do not depend on the clock duty (TW-E27).
- **Spectrum.** Read each product in dBc relative to the wanted one:

| Product | Frequency, 10 m example | Origin |
| --- | --- | --- |
| Wanted | f_LO + f_IF, 28.1246 MHz | |
| Opposite sideband | f_LO − f_IF, 27.8754 MHz | I/Q imbalance (TW-E27) |
| LO feedthrough | f_LO, 28 MHz | Carrier leakage, plus `sclk` at 28 MHz (TW-E02) |
| Counter lines | 3.5, 7, 14 and 28 MHz on every band | The LO counter in `lo_gen.v` counts on every clock |
| LO harmonics | 2 to 5 times f_LO, ± f_IF | Switching mixer |
| Clock | 56 MHz and its harmonics | Clock and monitor pads (TW-E26) |
| Delta-sigma noise | More than 400 kHz from the wanted tone | Above the filter corner |

- **CPU activity (TW-E28).** Repeat the spectrum with the CPU running and with it halted in a tight loop, and compare the spur levels.
- **One output alone.** Remove three of the links `R611` to `R614` to see a single RF output on `J602`.

### 9. WSPR

The firmware uses `software/c_toolchain/wspr.c` with the fixes of TW-D02, among them the tone spacing of 12000/8192 = 1.4648 Hz and the frequency word for IF + 1500 Hz + tone offset. A transmission is 162 symbols of 8192/12000 s = 0.683 s, 110.6 s in total, and starts one second into an even UTC minute (WSPR convention).

1. **Analyzer.** Four tones 1.4648 Hz apart at the dial frequency plus 1500 Hz, resolution bandwidth 1 Hz or less.
2. **Local decode.** From `J602` through 60 dB of attenuation into the receiver, USB at the dial frequency, WSJT-X in WSPR mode. Pass: callsign, locator and power decoded, frequency within 1400 to 1600 Hz above the dial frequency.
3. **On air.** Only by a licensed operator under their own callsign, with a low-pass filter for the band between `J602` and the antenna, because this board has no filter and the switching mixer puts out odd LO harmonics. With `R615` the output is about −25 dBm (3 µW) into 50 Ω if the simulated level holds. Spots appear on the [WSPRnet map](https://www.wsprnet.org/drupal/wsprnet/map).

## Data

- One folder per packaged part, `measurements/<part>/`, with the parts numbered `TW01`, `TW02` and so on and the number written on the board's write-on field.
- One Markdown file per step (`01_bond.md` to `09_wspr.md`) with date, board revision, firmware commit, instrument settings and the result against the expected value of this page. Raw data (CSV, scope and analyzer screenshots) goes beside it.
- `REUSE.toml` covers `measurements/**`, so data files need no license header.

## Open points

- The Pico bring-up firmware does not exist yet: PSRAM load, bus handover, reset release, `VDD` check, UART bridge, and the time for WSPR. Reusing the serial protocol of `program_sram.py` keeps that script.
- The chip firmware needs the constant fixes of TW-D02 before steps 4 and 9.
- The bond diagram of the `SoC4219` lot (TW-D03).
- No committed simulation gives the absolute RF level into a resistive 1 kΩ load or the THD of the filter, so steps 7 and 8 give the first values.

## Other TinyWhisper chips

Not part of this protocol.

- sky130A, Tiny Tapeout `TTSKY25b`: the digital core [`tt_um_cejmu_wspr`](https://tinytapeout.com/chips/ttsky25b/tt_um_cejmu_wspr) and the analog front end [`tt_um_TinyWhisper`](https://tinytapeout.com/chips/ttsky25b/tt_um_TinyWhisper).
- gf180mcuD, wafer.space run: [`iic-jku/gf180mcu-jku-projects`](https://github.com/iic-jku/gf180mcu-jku-projects).
