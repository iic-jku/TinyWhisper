# FPGA Emulation Flow

Emulates the `riscv` macro on an FPGA. The synthesis top is `riscv_top` from [`../rtl/`](../rtl/), and its ports (clock, reset, the SPI SRAM, I2C, UART and GPIO interfaces and the baseband outputs) are mapped straight onto board pins, so no board-top wrapper is needed.

The flow is driven by one shared Makefile fragment, [`fpga.mk`](fpga.mk), parameterised per architecture and per board. Adding a board is one folder: its `Makefile` and its pin constraints, see [Adding a Board](#adding-a-board).


## Supported Boards

| Board | Directory | FPGA | Toolchain | Programmer | Verified here |
| --- | --- | --- | --- | --- | --- |
| ULX3S | [`ulx3s/`](ulx3s/) | Lattice ECP5-85F, CABGA381 | Yosys -> nextpnr-ecp5 -> ecppack | `openFPGALoader` | Default board, bitstream builds |
| pico-ice | [`pico-ice/`](pico-ice/) | Lattice iCE40UP5K, SG48 | Yosys -> nextpnr-ice40 -> icepack | `dfu-util` | Place-and-route overflows, see below |
| iCEBreaker | [`icebreaker/`](icebreaker/) | Lattice iCE40UP5K, SG48 | Yosys -> nextpnr-ice40 -> icepack | `iceprog` | Place-and-route overflows, see below |

The ULX3S is the default board, because the macro no longer fits an iCE40UP5K. Both iCE40 boards currently synthesize to 6132 ICESTORM_LCs against the 5280 the UP5K has, 116%, and nextpnr stops with `Failed to expand region`. The numbers are identical on the two boards, the overflow is in the RTL and not in a pin map. The same design takes 5751 of the 83640 TRELLIS_COMBs of the ECP5-85F, 6.9%, and closes timing at 51.0 MHz against the 25 MHz oscillator.

So the iCE40 boards stay useful once the macro shrinks below 5280 LCs again, and until then `make all` in the macro builds the ULX3S bitstream.

The ASIC-only ports of `riscv_top` (`ds_*_i`, `lo_*_i`, `lo_I_oe`, `lo_Q_oe`) stay unconstrained in every pin file. They only matter for the pad ring, and `--pcf-allow-unconstrained` / `--lpf-allow-unconstrained` let nextpnr put them on free pins.

Pin assignment of the ULX3S, see [`ulx3s/ulx3s.lpf`](ulx3s/ulx3s.lpf) for the full list:

| Signal | Site | Note |
| --- | --- | --- |
| `clk` | G2 | 25 MHz oscillator |
| `reset` | D6 | BTN_PWRn, already inverted and therefore active low |
| `sclk`, `sram_ce`, `si`, `so` | B11, C11, A10, A11 | SPI SRAM on J1, `gp/gn[0]` and `gp/gn[1]` |
| `scl`, `sda` | A9, B10 | I2C on J1, `gp/gn[2]` |
| `tx`, `rx` | L4, M1 | UART on the on-board FTDI |
| `gpio_in[3:0]` | B9, C10, A7, A8 | J1, `gp/gn[3]` and `gp/gn[4]`, pulled down |
| `gpio_out[3:0]` | B2, C2, C1, D2 | the four left-most on-board LEDs |
| `ds_I_p_o`, `ds_I_n_o`, `ds_Q_p_o`, `ds_Q_n_o` | A4, A5, A2, B1 | delta-sigma baseband outputs on J2, `gp/gn[8]` and `gp/gn[9]` |
| `lo_I_o`, `lo_Ix_o`, `lo_Q_o`, `lo_Qx_o` | C4, B4, A6, B6 | LO outputs on J2, `gp/gn[10]` and `gp/gn[7]` |

Every complementary output pair sits on one `gp`/`gn` pin pair. The two delta-sigma pairs and `lo_I`/`lo_Ix` take the LVDS-capable pairs `gp/gn[8..10]`, so switching them to `LVCMOS33D` later moves no pin. `gp/gn[11..13]` are avoided because they are shared with the ESP32.

Pin assignment of the pico-ice, see [`pico-ice/pico-ice.pcf`](pico-ice/pico-ice.pcf) for the full list:

| Signal | Pin | Note |
| --- | --- | --- |
| `clk` | 35 | 12 MHz oscillator |
| `reset` | 10 | on-board push button, active low |
| `sclk`, `sram_ce`, `si`, `so` | 15, 37, 14, 17 | SPI SRAM |
| `sda`, `scl` | 19, 18 | I2C |
| `tx`, `rx` | 25, 27 | UART |
| `gpio_in[3:0]`, `gpio_out[3:0]` | 31, 34, 38, 43 and 28, 32, 36, 42 | GPIO |
| `ds_I_p_o`, `ds_I_n_o`, `ds_Q_p_o`, `ds_Q_n_o` | 45, 47, 2, 4 | delta-sigma baseband outputs |
| `lo_I_o`, `lo_Q_o`, `lo_Ix_o`, `lo_Qx_o` | 44, 46, 48, 3 | LO outputs |

Pin assignment of the iCEBreaker, see [`icebreaker/icebreaker.pcf`](icebreaker/icebreaker.pcf) for the full list:

| Signal | Pin | Note |
| --- | --- | --- |
| `clk` | 35 | 12 MHz oscillator |
| `reset` | 10 | S1 button, active low |
| `sram_ce`, `si`, `so`, `sclk` | 4, 2, 47, 45 | SPI SRAM on PMOD 1A, top row, in the Digilent SPI pin order |
| `scl`, `sda` | 46, 44 | I2C on PMOD 1A, bottom row |
| `rx`, `tx` | 6, 9 | UART on the FT2232H channel B |
| `gpio_in[3:0]`, `gpio_out[3:0]` | 43, 38, 34, 31 and 42, 36, 32, 28 | GPIO on PMOD 1B |
| `ds_I_p_o`, `ds_I_n_o`, `ds_Q_p_o`, `ds_Q_n_o` | 27, 25, 21, 19 | delta-sigma baseband outputs on PMOD 2, top row |
| `lo_I_o`, `lo_Q_o`, `lo_Ix_o`, `lo_Qx_o` | 26, 23, 20, 18 | LO outputs on PMOD 2, bottom row |

`P1A7` (pin 3), `P1A8` (pin 48) and both on-board LEDs stay free on the iCEBreaker.

> [!NOTE]
> `riscv_top` derives the UART baud rate and the I2C clock divider from its `CLK_FREQ` parameter, which defaults to 56 MHz, and no board clocks the design at 56 MHz. The real rates therefore scale by `f_osc / 56 MHz`: 115200 baud becomes about 51.4 kBaud on the ULX3S at 25 MHz and about 24.7 kBaud on the two iCE40 boards at 12 MHz. Set the host terminal to the scaled rate, or override `CLK_FREQ` at synthesis time. This is not new with the ECP5 board, the pico-ice build has always run this way.


## Toolchain

[IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) ships the complete build chain: `verilator` and `yosys`, `nextpnr-ice40` with `icepack` for the iCE40, and `nextpnr-ecp5` with `ecppack` for the ECP5.

Programming the board happens on the host, since the container has no USB access (`openFPGALoader` and `dfu-util` are not installed, and `iceprog`, which is, cannot reach a board): build the bitstream inside and run `load_bitstream`/`flash_bitstream` from a host installation of the board's programmer, which differs per board, see the table above. The `visualize` and `visualize_generic` targets additionally need `netlistsvg`, `svgo` and `rsvg-convert`, which are not in the container either.


## Picking a Board

[`Makefile`](Makefile) in this folder is a dispatcher: it forwards every target it does not handle itself to `<BOARD>/Makefile`, defaulting to `BOARD ?= ulx3s`. Running the default board, another board, or the board directory directly are all equivalent:

```sh
make all                     # ulx3s, the default
make BOARD=pico-ice all
make -C icebreaker all
```

`BOARD` is validated against the folders that hold a `Makefile`, so a typo gives a list of what is available instead of a confusing error:

```console
$ make BOARD=nosuchboard synthesis
Unknown BOARD 'nosuchboard'. Available: icebreaker pico-ice ulx3s.
```

`help`, `open` and `clean` are handled by the dispatcher itself. `clean` deliberately cleans **every** board, not just `$(BOARD)`, so that `make clean` in the macro removes all FPGA outputs in one go.


## How the Flow Is Put Together

The flow is split across four layers, so that a new board touches as little as possible:

| File | One per | Holds |
| --- | --- | --- |
| [`fpga.mk`](fpga.mk) | flow | The targets themselves and the defaults common to all boards |
| [`arch/<arch>.mk`](arch/) | FPGA architecture | The synthesis, place-and-route and packing toolchain (`ice40`, `ecp5`) |
| `<board>/Makefile` | board | Everything about one board: top module, pin file, device, package, how to load and flash it |
| [`dut.mk`](dut.mk) | design under test | The RTL sources, shared by every board |

A board directory's `Makefile` holds all of its board's configuration in one place. It includes `dut.mk` for the sources, names the top module and the pin file, sets the device and programmer variables, then includes `fpga.mk` last, which pulls in the `arch/` fragment named by the board's `ARCH`:

```make
TOP := riscv_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := ulx3s.lpf

ARCH        := ecp5
ECP5_DEVICE := --85k --package CABGA381

OPENFPGALOADER_BOARD := ulx3s
OPENFPGALOADER_FLAGS := --unprotect-flash

include $(TOP_FPGA_DIR)/fpga.mk
```

### Set by `dut.mk`

| Variable | | Description |
| --- | --- | --- |
| `SRC_DIR` | mandatory | RTL source directory |
| `DUT_SRCS` | mandatory | Ordered source file list of the design under test, `constants.sv` first and `riscv_top.sv` last |
| `TOP_FPGA_DIR` | mandatory | Path from a board folder back to this one |

### Set by the board `Makefile`

| Variable | | Description |
| --- | --- | --- |
| `TOP` | mandatory | Synthesis top module and instance name |
| `MODULES_SYNTH` | mandatory | Ordered source file list for `TOP`, here just `$(DUT_SRCS)` |
| `PCF_FILE` | mandatory | Board pin constraint file |
| `ARCH` | mandatory | Selects the `arch/<arch>.mk` fragment |
| `ICE40_DEVICE`, `ECP5_DEVICE` | mandatory | Device and package, whichever the board's architecture uses |
| `OPENFPGALOADER_BOARD` | mandatory | openFPGALoader board profile, unless `LOAD_CMD`/`FLASH_CMD` are set instead |
| `OPENFPGALOADER_FLAGS` | optional | Extra openFPGALoader flags |
| `LOAD_CMD`, `FLASH_CMD` | optional | Complete load and flash commands, replacing the openFPGALoader default, for boards it has no profile for |

### Set by `arch/<arch>.mk`

| Variable | | Description |
| --- | --- | --- |
| `TARGET`, `SYNTH_OPTS` | mandatory | Yosys synth pass and its options (`-dsp -spram` for the iCE40, so the CPU memories map onto the SPRAM blocks) |
| `SYNTH_CMD` | optional | Complete synthesis command, replacing `TARGET`/`SYNTH_OPTS`, for a synth pass that does not fit the `$(TARGET) $(SYNTH_OPTS) -top $(TOP)` shape |
| `PNR_CMD`, `PNR_OUT` | mandatory | Place-and-route command and its output file |
| `PNR_ARGS`, `PNR_DEPS` | optional | Place-and-route flags, and extra prerequisites |
| `PNR_GUI_CMD` | optional | Interactive place-and-route command. Left empty where there is none, `pr-gui` then says so and stops |
| `PACK_CMD`, `BITSTREAM` | mandatory | Bitstream packing command and output file |

`fpga.mk` and the `arch/` fragments assign with `?=`, so a board `Makefile` can still override anything it needs to. `fpga.mk` also checks that the mandatory variables are set and errors immediately when its include comes too early or a variable is missing.

### Adding a Board

1. Create `<board>/` with a `Makefile` like the one shown above, setting `ARCH` and the device, package and flash variables, and the pin constraint file it names, mapping the `riscv_top` ports onto board pins.
2. If the FPGA family is new, also create `arch/<arch>.mk` with that family's synthesis, place-and-route and packing commands, and check the container carries its toolchain.

Neither `fpga.mk` nor the dispatcher changes, and the new board shows up in `make help` and in `make clean` on its own, because both derive the board list from the folders that hold a `Makefile`.


## Makefile Targets

### Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions. Run it in a board folder to see that board's architecture, top cell and constraint file:

```sh
make
make help
make -C pico-ice help
```


### Open the Design Files

Opens a file browser for this folder with `sak-open.py` from the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS), one button per file:

```sh
make open
```

Clicking a button launches the matching tool in the file's own directory: gvim for the `Makefile`, the `.mk` fragments and the `README.md`, and the desktop's handler for a generated `.pdf` visualization. Only the file types listed in [the top-level README](../../../README.md#open-the-design-files) get a button, so the pin constraint files are not shown, and the RTL lives one level up in [`../rtl/`](../rtl/). Pass extra options with `OPEN_ARGS`, for example `make open OPEN_ARGS=--all` to include the build outputs.

> [!NOTE]
> This target needs a display. Run it inside the container's VNC/noVNC desktop or over X11 forwarding. The `.pdf` buttons hand the file to the desktop's registered handler, so they need the full VNC/noVNC session and do not work over a bare X forward.


### Clean

Remove the generated files of every board, that is each `<board>/build/`:

```sh
make clean
make -C ulx3s clean   # only this board
```


### Lint

Run Verilator lint checks:

```sh
make lint-verilog
make lint-verilog CELL=dsmod
make lint-verilog-all
```

`make lint-verilog` defaults to `CELL=riscv_top` and checks the full `DUT_SRCS` list. `make lint-verilog CELL=<cellname>` checks `constants.sv` together with `../rtl/<cellname>.sv` or `../rtl/<cellname>.v`. `make lint-verilog-all` runs the checks for `dsmod`, `cordic_iterative`, `lo_gen` and `riscv_top` in sequence.


### Synthesis

Run technology-mapped synthesis for the board's FPGA architecture. The Yosys `synth_*` pass comes from its `arch/<arch>.mk`:

```sh
make synthesis
make BOARD=icebreaker synthesis
```

Generate a generic synthesis netlist and Yosys graph:

```sh
make synthesis_generic
```


### Netlist Visualization

Generate a PDF from the technology-mapped netlist, or from the generic one:

```sh
make visualize
make visualize_generic
```

Both need `netlistsvg`, `svgo` and `rsvg-convert`, which are not part of IIC-OSIC-TOOLS.


### Place-and-Route

Run place-and-route:

```sh
make pr
```

Run it in the nextpnr GUI:

```sh
make pr-gui
```

> [!NOTE]
> The RISC-V macro currently overflows the iCE40UP5K, so `pr` fails on the pico-ice and on the iCEBreaker, see [Supported Boards](#supported-boards). Even when it fits, the UP5K place-and-route runs at over 99% utilisation, takes long and can fail on a marginal seed, in which case `make clean` and a retry help. The ECP5-85F of the ULX3S is nowhere near that tight.


### Bitstream Generation and Flash

Generate a bitstream:

```sh
make gen_bitstream
```

Load or flash it:

```sh
make load_bitstream    # into SRAM, lost on power cycle
make flash_bitstream   # into the board's flash, survives a power cycle
```

> [!NOTE]
> Neither target is part of `make all`, by design. Use them explicitly when you want to program the FPGA.
> The pico-ice is programmed with `dfu-util`, not `iceprog`, unlike the iCEBreaker. Both flash iCE40 bitstreams, but they target different interfaces: `iceprog` speaks directly over SPI via an FTDI USB bridge (iCEstick, iCEBreaker, and so on), while `dfu-util` uses the USB DFU standard. On the pico-ice the RP2040 co-processor is the DFU bootloader and forwards the bitstream to the iCE40 flash (DFU alt 0) or to the FPGA's configuration memory (alt 1), which is why `iceprog` does not work on that board.


### Convert to Verilog

Convert the SystemVerilog top module to Verilog:

```sh
make convert
```


### Build All

Run the full FPGA flow:

```sh
make all
```

The `all` recipe executes these steps in order:

1. `make clean`
2. `make lint-verilog-all`
3. `make synthesis`
4. `make pr`
5. `make gen_bitstream`

Cleaning first means stale artifacts from a previous run cannot survive into the build.

> [!NOTE]
> `make all` intentionally stops after bitstream generation and does not call `load_bitstream` or `flash_bitstream`.

All outputs land in `<board>/build/`, which is git-ignored, so several boards can be built side by side without overwriting each other.
