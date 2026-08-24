# FPGA Emulation Flow

Emulates the `riscv` macro on an FPGA. The synthesis top is `riscv_top` from [`../rtl/`](../rtl/), and its ports (clock, reset, the SPI SRAM, I2C, UART and GPIO interfaces and the baseband outputs) are mapped straight onto board pins, so no board-top wrapper is needed.

The flow is driven by one shared Makefile fragment, [`fpga.mk`](fpga.mk), parameterised per architecture and per board. Adding a board is one folder: its `Makefile` and its pin constraints, see [Adding a Board](#adding-a-board).


## Supported Boards

| Board | Directory | FPGA | Toolchain | Verified here |
| --- | --- | --- | --- | --- |
| pico-ice | [`pico-ice/`](pico-ice/) | Lattice iCE40UP5K | Yosys -> nextpnr-ice40 -> icepack | Bitstream built, default board |

Pin assignment of the pico-ice, see [`pico-ice/pico-ice.pcf`](pico-ice/pico-ice.pcf) for the full list:

| Signal | Pin | Note |
| --- | --- | --- |
| `clk_i` | 35 | 12 MHz oscillator |
| `reset_i` | 10 | on-board push button |
| `sclk_o`, `sram_ce_o`, `si_o`, `so_i` | 15, 37, 14, 17 | SPI SRAM |
| `sda_io`, `scl_o` | 19, 18 | I2C |
| `tx_o`, `rx_i` | 25, 27 | UART |
| `gpio_in_i[3:0]`, `gpio_out_o[3:0]` | 31, 34, 38, 43 and 28, 32, 36, 42 | GPIO |
| `ds_I_p_o`, `ds_I_n_o`, `ds_Q_p_o`, `ds_Q_n_o` | 45, 47, 2, 4 | delta-sigma baseband outputs |
| `lo_I_o`, `lo_Q_o`, `lo_Ix_o`, `lo_Qx_o` | 44, 46, 48, 3 | LO outputs |

The `arch/` folder also carries an [`ecp5.mk`](arch/ecp5.mk) fragment (Yosys -> nextpnr-ecp5 -> ecppack), so an ECP5 board needs only its own folder, no new architecture fragment.


## Toolchain

[IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) ships the complete build chain: `verilator` and `yosys`, `nextpnr-ice40` with `icepack` for the iCE40, and `nextpnr-ecp5` with `ecppack` for the ECP5.

Programming the board happens on the host, since the container has no USB access (`openFPGALoader` and `dfu-util` are not installed, and `iceprog`, which is, cannot reach a board): build the bitstream inside and run `load_bitstream`/`flash_bitstream` from a host installation of the board's programmer. The `visualize` and `visualize_generic` targets additionally need `netlistsvg`, `svgo` and `rsvg-convert`, which are not in the container either.


## Picking a Board

[`Makefile`](Makefile) in this folder is a dispatcher: it forwards every target it does not handle itself to `<BOARD>/Makefile`, defaulting to `BOARD ?= pico-ice`. Running the default board, another board, or the board directory directly are all equivalent:

```sh
make all                     # pico-ice, the default
make BOARD=pico-ice all
make -C pico-ice all
```

`BOARD` is validated against the folders that hold a `Makefile`, so a typo gives a list of what is available instead of a confusing error:

```console
$ make BOARD=nosuchboard synthesis
Unknown BOARD 'nosuchboard'. Available: pico-ice.
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

PCF_FILE := pico-ice.pcf

ARCH         := ice40
ICE40_DEVICE := --up5k --package sg48

# DFU alt 0 is the SPI flash, alt 1 the FPGA's volatile configuration memory.
# Must be `=`, not `:=`, since BITSTREAM is only defined later, by fpga.mk.
LOAD_CMD  = dfu-util --alt 1 --download $(BITSTREAM)
FLASH_CMD = dfu-util --alt 0 --download $(BITSTREAM) --reset

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
make -C pico-ice clean   # only this board
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
make BOARD=pico-ice synthesis
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
> The RISC-V macro fills the iCE40UP5K almost completely, so the place-and-route takes long and can fail on a marginal seed. Run `make clean` and try again in that case.


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
> The pico-ice is programmed with `dfu-util`, not `iceprog`. Both flash iCE40 bitstreams, but they target different interfaces: `iceprog` speaks directly over SPI via an FTDI USB bridge (iCEstick, iCEBreaker, and so on), while `dfu-util` uses the USB DFU standard. On the pico-ice the RP2040 co-processor is the DFU bootloader and forwards the bitstream to the iCE40 flash (DFU alt 0) or to the FPGA's configuration memory (alt 1), which is why `iceprog` does not work on that board.


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
