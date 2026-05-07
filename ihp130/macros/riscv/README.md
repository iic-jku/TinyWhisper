# ihp-sg13g2 RISC-V CPU

> [!IMPORTANT]
> This repository requires the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container with tag `2026.05` or later.

<p align="center">
  <a href="render/img/riscv_top_white.png">
    <img src="render/img/riscv_top_white.png" alt="Render of the ihp-sg13g2 RISC-V layout (700um x 1130um)" width=50%>
  </a>
  <br>
  <em>Render of the ihp-sg13g2 RISC-V layout (700um x 1130um).</em>
</p>


## Directory Structure

```text
📁 riscv/
├─ 📁 final/
│  ├─ 📁 gds/
│  │  └─ riscv_top.gds
│  ├─ 📁 lef/
│  │  └─ riscv_top.lef
│  ├─ 📁 lib/
│  │  ├─ 📁 nom_fast_1p32V_m40C/
│  │  ├─ 📁 nom_fast_1p65V_m40C/
│  │  ├─ 📁 nom_slow_1p35V_125C/
│  │  ├─ 📁 nom_typ_1p20V_25C/
│  │  └─ 📁 nom_typ_1p50V_25C/
│  ├─ 📁 nl/
│  │  └─ riscv_top.nl.v
│  ├─ 📁 pnl/
│  │  └─ riscv_top.pnl.v
│  ├─ 📁 spef/
│  │  └─ 📁 nom/
│  └─ 📁 vh/
│     └─ riscv_top.vh
├─ 📁 flow/
│  ├─ 📁 final/
│  │  ├─ 📁 def/
│  │  ├─ 📁 gds/
│  │  ├─ 📁 json_h/
│  │  ├─ 📁 klayout_gds/
│  │  ├─ 📁 lef/
│  │  ├─ 📁 lib/
│  │  ├─ 📁 mag/
│  │  ├─ 📁 mag_gds/
│  │  ├─ 📁 nl/
│  │  ├─ 📁 odb/
│  │  ├─ 📁 pnl/
│  │  ├─ 📁 render/
│  │  ├─ 📁 sdc/
│  │  ├─ 📁 sdf/
│  │  ├─ 📁 spef/
│  │  ├─ 📁 spice/
│  │  ├─ 📁 vh/
│  │  ├─ metrics.csv
│  │  └─ metrics.json
│  ├─ 📁 librelane/
│  │  ├─ config.yaml
│  │  ├─ impl.sdc
│  │  ├─ pin_order.cfg
│  │  └─ signoff.sdc
│  └─ 📁 reports/
│     ├─ hold_setup_timing.rpt
│     ├─ lvs.netgen.rpt
│     ├─ manufacturability.rpt
│     ├─ stat.rpt
│     ├─ yosys_post_dff.rpt
│     ├─ yosys_pre_techmap.rpt
│     └─ yosys_synth_check.rpt
├─ 📁 fpga/
│  ├─ Makefile
│  ├─ pico-ice.pcf
│  └─ README.md
├─ 📁 netlist/
│  ├─ 📁 nl/
│  │  └─ riscv_top.nl.v
│  ├─ 📁 pnl/
│  │  └─ riscv_top.pnl.v
│  ├─ 📁 spice/
│  │  └─ riscv_top.spice
│  └─ 📁 xspice/
│     ├─ 📁 riscv_top/
│     │  └─ riscv_top.xspice
│     ├─ reorder_xspice_pins.py
│     ├─ spi2xspice.py
│     └─ verilog2xspice.sh
├─ 📁 render/
│  ├─ 📁 blender/
│  └─ 📁 img/
│     ├─ riscv_top_black.png
│     ├─ riscv_top_librelane.png
│     └─ riscv_top_white.png
├─ 📁 rtl/
│  ├─ 📁 matlab/
│  │  ├─ dec2frac.m
│  │  ├─ getCordicScaling.m
│  │  ├─ getRotationAngles.m
│  │  ├─ iterative_cordic_main.m
│  │  ├─ sfixed_qa.m
│  │  └─ unsigned2bin.m
│  ├─ alu.sv
│  ├─ constants.sv
│  ├─ control.sv
│  ├─ cordic_iterative.v
│  ├─ cordic_slice.v
│  ├─ csr.sv
│  ├─ dsmod.v
│  ├─ freq_generator.sv
│  ├─ i2c_master.sv
│  ├─ i2c_master_mc.sv
│  ├─ imm_gen.sv
│  ├─ instructioncounter.sv
│  ├─ lo_gen.v
│  ├─ memory.sv
│  ├─ regs.sv
│  ├─ riscv_top.sv
│  ├─ spi_master.sv
│  ├─ sram_sim.sv
│  ├─ uart_rx.v
│  └─ uart_tx.v
├─ 📁 schematic/
│  ├─ riscv_top.sym
│  └─ xschemrc
├─ 📁 scripts/
│  └─ lay2img.py
├─ 📁 testbenches/
│  ├─ 📁 cocotb/
│  │  ├─ 📁 dsmod/
│  │  │  ├─ Makefile
│  │  │  └─ README.md
│  │  └─ 📁 riscv_top/
│  │     ├─ riscv_top_tb.gtkw
│  │     └─ riscv_top_tb.surf.ron
│  ├─ 📁 verilog/
│  │  ├─ 📁 dsmod/
│  │  │  ├─ dsmod_tb.v
│  │  │  ├─ dsmod_tb.gtkw
│  │  │  └─ dsmod_tb.surf.ron
│  │  └─ 📁 riscv_top/
│  │     ├─ riscv_top_tb.sv
│  │     ├─ riscv_top_tb.gtkw
│  │     └─ riscv_top_tb.surf.ron
│  └─ 📁 xschem/
│     ├─ riscv_top_tb_tran.sch
│     └─ xschemrc
├─ Makefile
└─ README.md
```


## Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```


## Linting

To lint the Verilog/SystemVerilog source files with [Verilator](https://www.veripool.org/verilator/), run:

```sh
make lint-verilog              # lint the full riscv_top design
make lint-verilog CELL=dsmod   # lint a single module
make lint-verilog-all          # lint dsmod, cordic_iterative, lo_gen, and riscv_top
```

When `CELL=riscv_top` (the default), the full `RISCV_MODULES_SIM` source list (`constants.sv` + all synthesis sources + `sram_sim.sv`) is passed to Verilator.
For a single cell, the correct extension (`.sv` or `.v`) is detected automatically, and `constants.sv` is always included first so opcode and funct constants are in scope.

The `lint-verilog-all` target runs these lint checks in sequence:

1. `make lint-verilog CELL=dsmod`
2. `make lint-verilog CELL=cordic_iterative`
3. `make lint-verilog CELL=lo_gen`
4. `make lint-verilog` (default: `riscv_top`)

This is also the lint step used by `make all`.


## Verification and Simulation

We use [cocotb](https://www.cocotb.org/), a Python-based testbench environment, and [Icarus Verilog](https://github.com/steveicarus/iverilog) for the verification of the macro.

The simulation targets are unified and accept an optional `CELL` variable (default: `riscv_top`).
The waveform viewer can be changed with `WAVEFORM_VIEWER=<gtkwave|surfer>` (default: `gtkwave`).

### RTL Verilog Simulation

Compiles the RTL with Icarus Verilog and runs the simulation.
When `CELL=riscv_top` (the default), the full `RISCV_MODULES_SIM` source list and the `.sv` testbench are selected automatically.
The waveform is written to `testbenches/verilog/<CELL>/` (e.g. `testbenches/verilog/riscv_top/riscv_top_tb.vcd`):

```sh
make sim-rtl-verilog              # run riscv_top RTL simulation
make sim-rtl-verilog CELL=dsmod   # run dsmod RTL simulation
```

To view the waveform afterwards:

```sh
make sim-view-verilog                                          # view riscv_top waveform
make sim-view-verilog CELL=dsmod                               # view dsmod waveform
make sim-view-verilog CELL=dsmod WAVEFORM_VIEWER=surfer        # use Surfer instead
```

Each simulation folder contains a pre-configured waveform layout file (`<CELL>_tb.gtkw` for GTKWave, `<CELL>_tb.surf.ron` for Surfer).
The view target loads it automatically together with the current `.vcd`, so signal formatting is preserved across runs.

### RTL / GL cocotb Simulation

The cocotb testbenches are located in `testbenches/cocotb/`.
For `CELL=dsmod`, the simulation delegates to the sub-Makefile in `testbenches/cocotb/dsmod/` (PSD, SNDR sweep, and ramp tests).
For all other cells the Python runner is invoked directly.

```sh
make sim-rtl-cocotb               # run riscv_top RTL cocotb simulation
make sim-rtl-cocotb CELL=dsmod    # run dsmod cocotb test suite
```

See `testbenches/cocotb/dsmod/README.md` for `dsmod`-specific configuration options and environment variables.

To run the gate-level (GL) cocotb simulation:

```sh
make sim-gl-cocotb                # gate-level simulation of riscv_top
```

> [!NOTE]
> Gate-level simulation requires the latest implementation in `flow/final/`.

A waveform file is generated under `testbenches/cocotb/<cell>/sim_build/<cell>.fst`.
To view it:

```sh
make sim-view-cocotb                                          # view riscv_top waveform
make sim-view-cocotb CELL=dsmod                               # view dsmod waveform
make sim-view-cocotb CELL=dsmod WAVEFORM_VIEWER=surfer        # use Surfer instead
```

Each cocotb simulation folder contains a pre-configured waveform layout file (`<CELL>_tb.gtkw` for GTKWave, `<CELL>_tb.surf.ron` for Surfer).
The view target loads it automatically together with the current `.fst`, so signal formatting is preserved across runs.

### Gate-Level Xschem Simulation

Runs the mixed-signal gate-level transient simulation testbench in `testbenches/xschem/<CELL>_tb_tran.sch`:

```sh
make sim-gl-xschem                # run riscv_top gate-level Xschem simulation
make sim-gl-xschem CELL=<cell>    # run gate-level Xschem simulation for another cell
```

> [!NOTE]
> This flow expects the generated XSPICE model in `netlist/xspice/riscv_top/`. If needed, generate it first with:
>
> ```sh
> make generate-xspice
> ```


### Run All Simulations

To run all simulation targets in sequence:

```sh
make sim-all
```

This executes the following targets in order:

1. `sim-rtl-verilog CELL=dsmod`
2. `sim-rtl-cocotb CELL=dsmod`
3. `sim-rtl-verilog` (default: `riscv_top`)
4. `sim-rtl-cocotb` (default: `riscv_top`)
5. `sim-gl-cocotb` (default: `riscv_top`)
6. `sim-gl-xschem` (default: `riscv_top`)

> [!NOTE]
> The `sim-view-verilog` and `sim-view-cocotb` targets are intentionally **not** called by `sim-all`.
> Both open a waveform viewer GUI (GTKWave or Surfer), which blocks the shell until the window is closed.
> They are designed for interactive use and must be called manually after the simulation has completed.


## LibreLane Flow

Run the LibreLane flow with:

```sh
make librelane
```

Additional targets are available for different DRC configurations:

- `make librelane-nodrc` – run LibreLane without DRC checks
- `make librelane-magicdrc` – run LibreLane with only Magic DRC checks
- `make librelane-klayoutdrc` – run LibreLane with only KLayout DRC checks

These targets are also available for the digital macros. After the LibreLane flow completes successfully, the generated views are saved under `flow/final/`.


## View the Design

After completion, you can view the design using the OpenROAD GUI:

```sh
make librelane-openroad
```

Or using KLayout:

```sh
make librelane-klayout
```


## Copy Important Reports

To copy the yosys, antenna-violation, DRC errors, hold & setup violation, timing, LVS, and manufacturability reports from the latest run into `flow/reports/`, run:

```sh
make copy-reports
```

This only works if at least one LibreLane run exists in `flow/librelane/runs/` and the latest run completed without errors.


## Copy the Final GDS

To copy the latest GDS from `flow/final/gds/` into `final/gds/`, run:

```sh
make copy-gds
```

This assumes the final GDS view exists under `flow/final/gds/`.


## Copy the Final Netlist

To copy the latest SPICE, PnL, and Netlist files from `flow/final/` into `netlist/`, run:

```sh
make copy-netlist
```

This only works if the required final views exist in `flow/final/spice/`, `flow/final/pnl/`, and `flow/final/nl/`.


## Copy the Final Render

To copy the latest LibreLane render from `flow/final/render/` into `render/img/`, run:

```sh
make copy-render
```

This only works if the final render exists in `flow/final/render/`.


## Render Top Layout

Renders the final GDS from `final/gds/` with `scripts/lay2img.py` and saves it in the `render/img/` folder:

```sh
make render-gds
```

This only works if the latest run completed without errors.


## Build FPGA

The FPGA flow targets a [pico-ice](https://pico-ice.tinyvision.ai/) board (iCE40 UP5K, sg48 package) and uses the open-source iCE40 toolchain: Yosys → nextpnr → icepack.

To run the full flow (lint → synthesis → place-and-route → bitstream), run:

```sh
make build-fpga
```

This invokes `make -C fpga all`. Individual steps can also be run from `fpga/`:

```sh
make -C fpga synthesis       # Yosys iCE40 synthesis
make -C fpga pr              # nextpnr place-and-route
make -C fpga gen_bitstream   # icepack → .bin
make -C fpga flash_bitstream # flash via dfu-util
```

> [!NOTE]
> Flashing uses `dfu-util`, not `iceprog`. Both flash iCE40 bitstreams, but they target different interfaces:
> - **`iceprog`** speaks directly over SPI via an FTDI USB bridge (iCEstick, iCEBreaker, …).
> - **`dfu-util`** uses the USB DFU standard — the pico-ice's RP2040 co-processor acts as the DFU bootloader and forwards the bitstream to the iCE40 flash. `iceprog` does not work on this board.


## Build All

To build the macro with LibreLane, copy its reports, copy GDS, copy netlists, copy the render, and render the final GDS, run:

```sh
make build-all
```


## Layout Versus Schematic (LVS) & Design Rule Check (DRC)

The LibreLane flow already includes LVS and DRC checks with Magic and KLayout, and they are saved in the flow/reports folder.


## Build and Verify All

Builds and verifies the whole macro by running linting, simulation, and build steps:

- `lint-verilog-all`
- `sim-all`
- `build-fpga`
- `build-all`

> [!NOTE]
> The LVS and DRC verification is done within the LibreLane flow.

```sh
make all
```


## Generate XSPICE File

To generate an XSPICE file of the macro for mixed-signal simulation in Xschem, run:

```sh
make generate-xspice
```

> [!NOTE]
> This command should not be run as part of `all`, since this XSPICE file is generated once with specific CPU settings for a more convenient simulation.
> This method does not work with the `.pnl.v` file in `flow/final/`. The `.nl.v` file from the LibreLane step `yosys-synthesis` must be used.
> Conversion pipeline: Copy gate-level Verilog (`.nl.v`) → Verilog with power pins (`.vp`) → SPICE (`.spice`) → XSPICE (`.xspice`) → Reorder pins in XSPICE file according to the Xschem symbol.
