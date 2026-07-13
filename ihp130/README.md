# ihp-sg13g2 TinyWhisper

> [!IMPORTANT]
> This repository requires the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container with tag `2026.05` or later.

<p align="center">
  <a href="render/img/tinywhisper_top_black.png">
    <img src="render/img/tinywhisper_top_black.png" alt="Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm)" width=70%>
  </a>
  <br>
  <em>Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm).</em>
</p>


## Directory Structure

```text
📁 ihp130/
├─ 📁 doc/
│  ├─ 📁 AMS/
│  │  ├─ AMS_simulation.pdf
│  │  ├─ Verilog-CoSim_Ngspice.pdf
│  │  └─ Verilog-CoSim_Xschem.pdf
│  ├─ 📁 IHP-PDK/
│  │  └─ SG13G2_os_layout_cheatsheet.xlsx
│  ├─ 📁 klayout/
│  │  └─ klayout_cheatsheet.md
│  ├─ 📁 librelane/
│  │  └─ librelane_cheatsheet.md
│  ├─ 📁 naming/
│  │  ├─ files_naming_convention.txt
│  │  └─ vhdl_naming_convention.txt
│  ├─ 📁 sizing/
│  │  ├─ techsweep_sg13g2_hv_nmos_plots_overview.pdf
│  │  ├─ techsweep_sg13g2_hv_pmos_plots_overview.pdf
│  │  ├─ techsweep_sg13g2_lv_nmos_plots_overview.pdf
│  │  └─ techsweep_sg13g2_lv_pmos_plots_overview.pdf
│  ├─ pinout.md
│  └─ pinout.pdf
├─ 📁 flow/
│  ├─ 📁 artistic/
│  ├─ 📁 librelane/
│  │  ├─ config.yaml
│  │  ├─ pdn_cfg.tcl
│  │  └─ tinywhisper_top.sdc
│  ├─ 📁 logo/
│  │  └─ tinywhisper_logo_mono.png
│  └─ 📁 reports/
│     ├─ antenna_summary.rpt
│     ├─ antenna_violations.rpt
│     ├─ hold_setup_timing.rpt
│     ├─ lvs.netgen.rpt
│     ├─ manufacturability.rpt
│     ├─ stat.rpt
│     ├─ yosys_post_dff.rpt
│     ├─ yosys_pre_techmap.rpt
│     └─ yosys_synth_check.rpt
├─ 📁 ip/
│  ├─ 📁 sg13g2_io_custom/
│  ├─ 📁 sg13g2_ip__bondpad_70x70/
│  │  ├─ 📁 final/
│  │  ├─ 📁 script/
│  │  ├─ 📁 verification/
│  │  ├─ Makefile
│  │  └─ README.md
│  ├─ 📁 sg13g2_ip__ce/
│  │  ├─ 📁 final/
│  │  ├─ 📁 logo/
│  │  ├─ 📁 script/
│  │  ├─ 📁 verification/
│  │  ├─ Makefile
│  │  └─ README.md
│  ├─ 📁 sg13g2_ip__ce_names/
│  │  ├─ 📁 final/
│  │  ├─ 📁 logo/
│  │  ├─ 📁 script/
│  │  ├─ 📁 verification/
│  │  ├─ Makefile
│  │  └─ README.md
│  ├─ 📁 sg13g2_ip__jku/
│  │  ├─ 📁 final/
│  │  ├─ 📁 logo/
│  │  ├─ 📁 script/
│  │  ├─ 📁 verification/
│  │  ├─ Makefile
│  │  └─ README.md
│  └─ 📁 sg13g2_ip__jku_names/
│     ├─ 📁 final/
│     ├─ 📁 logo/
│     ├─ 📁 script/
│     ├─ 📁 verification/
│     ├─ Makefile
│     └─ README.md
├─ 📁 layout/
│  ├─ tinywhisper_top.gds.gz
│  └─ tinywhisper_top_logo_fill.gds.gz
├─ 📁 macros/
│  ├─ 📁 coupled_resonator_lc_bpf/
│  │  ├─ 📁 schematic/
│  │  ├─ 📁 scripts/
│  │  └─ 📁 testbenches/
│  ├─ 📁 iqmod/
│  │  ├─ 📁 final/
│  │  ├─ 📁 layout/
│  │  ├─ 📁 netlist/
│  │  ├─ 📁 render/
│  │  ├─ 📁 schematic/
│  │  ├─ 📁 scripts/
│  │  ├─ 📁 testbenches/
│  │  ├─ 📁 verification/
│  │  ├─ Makefile
│  │  └─ README.md
│  └─ 📁 riscv/
│     ├─ 📁 final/
│     ├─ 📁 flow/
│     ├─ 📁 fpga/
│     ├─ 📁 netlist/
│     ├─ 📁 render/
│     ├─ 📁 rtl/
│     ├─ 📁 schematic/
│     ├─ 📁 scripts/
│     ├─ 📁 testbenches/
│     ├─ Makefile
│     └─ README.md
├─ 📁 netlist/
│  ├─ 📁 layout/
│  │  └─ tinywhisper_top.spice
│  ├─ 📁 nl/
│  │  └─ tinywhisper_top.nl.v
│  ├─ 📁 pex/
│  │  ├─ reorder_spice_pins.py
│  │  ├─ tinywhisper_top_klayout_pex_*.spice
│  │  └─ tinywhisper_top_magic_pex_*.spice
│  ├─ 📁 pnl/
│  │  └─ tinywhisper_top.pnl.v
│  └─ 📁 spice/
│     └─ tinywhisper_top.spice
├─ 📁 packaging/
│  ├─ 📁 layout/
│  │  ├─ EP_PACKAGES_08022018.gds
│  │  ├─ OP_QFN48_A4_FIT.gds
│  │  ├─ tinywhisper_bondplan.gds
│  │  └─ tinywhisper_top_logo_TM2.gds.gz
│  ├─ 📁 render/
│  │  └─ tinywhisper_bondplan_{white,black}.{png,svg}
│  ├─ 📁 scripts/
│  │  └─ run_bondplan.py
│  ├─ config.yaml
│  ├─ README.md
│  └─ result.md
├─ 📁 release/
│  ├─ 📁 v.1.0.0/
│  │  ├─ 📁 doc/
│  │  ├─ 📁 gds/
│  │  └─ ReleaseNote.md
│  └─ 📁 v.2.0.0/
│     ├─ 📁 gds/
│     └─ 📁 netlist/
├─ 📁 render/
│  ├─ 📁 blender/
│  └─ 📁 img/
│     ├─ tinywhisper_top_black.png
│     ├─ tinywhisper_top_librelane.png
│     └─ tinywhisper_top_white.png
├─ 📁 rtl/
│  ├─ tinywhisper_core.sv
│  └─ tinywhisper_top.sv
├─ 📁 schematic/
│  ├─ tinywhisper.sch
│  ├─ tinywhisper.sym
│  ├─ tinywhisper_top.sch
│  ├─ tinywhisper_top.sym
│  ├─ tinywhisper_top_pex.sym
│  └─ xschemrc
├─ 📁 scripts/
│  ├─ add_logo_fill.sh
│  ├─ add_rectangle.py
│  ├─ gds_xor.py
│  └─ lay2img.py
├─ 📁 testbenches/
│  ├─ 📁 cocotb/
│  │  ├─ tinywhisper_top_tb.gtkw
│  │  ├─ tinywhisper_top_tb.surf.ron
│  │  └─ tinywhisper_top_tb.py
│  └─ 📁 xschem/
│     ├─ tinywhisper_tb_tran.sch
│     ├─ tinywhisper_top_tb_tran.sch
│     └─ xschemrc
├─ 📁 verification/
│  ├─ 📁 drc/
│  │  ├─ tinywhisper_top.magic.drc.rpt
│  │  └─ tinywhisper_top_logo_fill.magic.drc.rpt
│  └─ 📁 lvs/
│     └─ tinywhisper_top.lvs.out
├─ Makefile
└─ README.md
```


## Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```


## Initialize Git Submodules

Initializes and updates the repository submodules (for example `ihp130/artistic`):

```sh
make init-submodules
```

Run this after cloning the repository, or whenever submodule pointers are updated.


## Simulation

We use [cocotb](https://www.cocotb.org/), a Python-based testbench environment, for the verification of the chip.
The underlying simulator is [Icarus Verilog](https://github.com/steveicarus/iverilog).

The simulation targets accept an optional `CELL` variable (default: `tinywhisper_top`).
The testbench is located in `testbenches/cocotb/tinywhisper_top_tb.py`. To run the RTL simulation, use:

```sh
make sim-rtl-cocotb
```

To run the gate-level (GL) simulation with cocotb, use:

```sh
make sim-gl-cocotb
```

To run the gate-level simulation with Xschem, use:

```sh
make sim-gl-xschem
```

The cocotb simulations generate a waveform file under `testbenches/cocotb/sim_build/tinywhisper_top.fst`.
You can view it with a waveform viewer such as [GTKWave](https://gtkwave.github.io/gtkwave/) or [Surfer](https://surfer-project.org/).
The waveform viewer can be changed with `WAVEFORM_VIEWER=<gtkwave|surfer>` (default: `gtkwave`).

```sh
make sim-view-cocotb                                          # view tinywhisper_top waveform with GTKWave (default)
make sim-view-cocotb WAVEFORM_VIEWER=surfer                   # use Surfer instead
```

Each cocotb simulation folder contains a pre-configured waveform layout file (`<CELL>_tb.gtkw` for GTKWave, `<CELL>_tb.surf.ron` for Surfer).
The view target loads it automatically together with the current `.fst`, so signal formatting is preserved across runs.

To run all non-interactive simulation targets in sequence (RTL cocotb, GL cocotb, and GL Xschem), use:

```sh
make sim-all
```

> [!NOTE]
> `sim-view-cocotb` is intentionally **not** called by `sim-all`.
> It opens a waveform viewer GUI (GTKWave or Surfer), which blocks the shell until the window is closed.
> It is designed for interactive use and must be called manually after the simulation has completed.


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

These commands are also available for the digital macros.


## Copy Important Reports

To copy the yosys, antenna-violation, DRC errors, hold & setup violation, timing, LVS, and manufacturability reports from the latest run into `flow/reports/`, run:

```sh
make copy-reports
```

This only works if the latest run completed without errors. This command is also available for the digital macros.


## Copy the Final GDS

To copy and compress the latest GDS from `flow/final/gds/` into `layout/`, run:

```sh
make copy-gds
```


## Copy the Final Netlist

To copy the latest SPICE, PnL, and NL netlists from `flow/final/spice/` into `netlist/spice/`, from `flow/final/pnl/` into `netlist/pnl/`, and from `flow/final/nl/` into `netlist/nl/`, run:

```sh
make copy-netlist
```

This only works if the latest run completed without errors.


## Copy the Final Render

To copy the latest LibreLane chip render from `flow/final/render/` into `render/img/`, run:

```sh
make copy-render
```

This creates `render/img/tinywhisper_top_librelane.png`. This only works if the latest run completed without errors.


## Render Top Layout

Renders the top-level GDS from `layout/` and saves it in the `render/img/` folder:

```sh
make render-gds
```

This only works if the latest run completed without errors. This command is also available for the digital macros.


## Build Bondpad

To build the bondpad in the `ip` folder, run the following command:

```sh
make build-bondpad
```


## Build Logos

To build the logos in the `ip` folder, run the following command:

```sh
make build-logos
```


## Build Macros

To build a specific macro, run the corresponding target from the `Makefile`. To build all currently enabled macros, run:

```sh
make build-macros
```

### Build Digital Macros

The following command builds the `riscv` digital macro:

```sh
make build-riscv
```

For each digital macro the following commands are executed: `make librelane`, `make copy-reports`, and `make render-gds`.

> [!TIP]
> Each macro has its own `Makefile` and `README.md` with additional targets, such as linting, simulation, and verification.
> For example, to lint the RISC-V CPU or run its simulation, refer to [ihp130/macros/riscv/README.md](macros/riscv/README.md).

### Build Analog Macros

Each analog macro has its own `klayout-verify` and `magic-verify` targets that runs LVS, DRC, and PEX for the top level cell.

To build the IQ modulator macro:

```sh
make build-iqmod
```

All analog macros are included in `build-macros` alongside the digital macros.


## Build All

To build the bondpad, logos and macros, run LibreLane for the top-level chip, copy the reports, GDS, netlist, and LibreLane render, add the logo and fill structures, render the final GDS, and open it in the OpenROAD GUI, run:

```sh
make build-all
```

> [!NOTE]
> The `make build-all` target does **not** currently build the digital macros (e.g., RISC-V CPU, IQ modulator).
> To build specific macros, use `make build-riscv`, `make build-iqmod`, or `make build-macros` to build all enabled macros separately.

This is useful if you want to rebuild the chip from scratch. Clone the repository, enter the IIC-OSIC-TOOLS environment, and run `make build-all`.


## Export Schematic Netlist for LVS

Exports the schematic netlist for LVS from Xschem and places it in `netlist/schematic/`.

The `EV_PRECISION` parameter sets the number of significant digits used by Xschem's `ev` function when calculating device properties (default: 5). Increase this to avoid LVS mismatches caused by floating-point rounding differences between Xschem and KLayout (see [xschem#465](https://github.com/StefanSchippers/xschem/issues/465)).

Currently, KLayout LVS extracts `ntap` and `ptap` devices, so the schematic netlist must include them as well. In contrast, Magic + Netgen LVS does not extract `ntap` and `ptap`. Therefore, the schematic uses `lvs_ignore = short` for these devices and conditional net labels (see [xschem#474](https://github.com/StefanSchippers/xschem/issues/474)). To make this effective during schematic netlist export, `set lvs_ignore 1` must be set in the `magic-lvs-netlist` target.

KLayout uses CDL netlists, while Magic uses SPICE netlists. Accordingly, `klayout-lvs-netlist` uses the Xschem commands `set spiceprefix 1`, `set lvs_netlist 1`, `set top_is_subckt 1`, and `set lvs_ignore 0`. In contrast, `magic-lvs-netlist` uses `set spiceprefix 1`, `set lvs_netlist 0`, `set top_is_subckt 1`, and `set lvs_ignore 1`.

To extract a CDL schematic netlist for KLayout LVS, use:
```sh
make klayout-lvs-netlist
make klayout-lvs-netlist CELL=tinywhisper_top
make klayout-lvs-netlist EV_PRECISION=5
```

To extract a SPICE schematic netlist for Magic + Netgen LVS, use:
```sh
make magic-lvs-netlist
make magic-lvs-netlist CELL=tinywhisper_top
make magic-lvs-netlist EV_PRECISION=5
```


## Layout Versus Schematic (LVS)

Exports the schematic netlist from Xschem, then runs LVS. Compares the GDS layout in `layout/` against the schematic netlist in `netlist/schematic/`. Reports are saved to `verification/lvs/`. The extracted layout netlist is moved to `netlist/layout/`.

**KLayout LVS** uses `run_lvs.py` from the IHP Open-PDK:

```sh
make klayout-lvs
make klayout-lvs CELL=tinywhisper_top
```

**Magic + Netgen LVS** uses `sak-lvs.sh`:

```sh
make magic-lvs
make magic-lvs CELL=tinywhisper_top
```


## Design Rule Check (DRC)

Runs DRC on the GDS layout in `layout/`. Reports are saved to `verification/drc/`.

**KLayout DRC (minimum)** runs a pre-check KLayout DRC on the final top-level layout with logo and fill structures:

```sh
make klayout-drc-minimum
```

**KLayout DRC (regular)** runs a regular KLayout DRC on the final top-level layout with logo and fill structures:

```sh
make klayout-drc-regular
```

**KLayout DRC** uses `run_drc.py` from the IHP Open-PDK with relaxed rules (FEOL, density checks, and extra rules disabled):

```sh
make klayout-drc
make klayout-drc CELL=tinywhisper_top
```

**Magic DRC** uses `sak-drc.sh`:

```sh
make magic-drc
make magic-drc CELL=tinywhisper_top
```


## Parasitic Extraction (PEX)

Runs parasitic extraction on the GDS layout in `layout/`. The extracted SPICE netlist is written to `netlist/pex/`.

The extracted SPICE filenames include the selected extraction mode:
- `klayout-pex` writes `netlist/pex/<CELL>_klayout_pex_<EXT_MODE>.spice`
- `magic-pex` writes `netlist/pex/<CELL>_magic_pex_<EXT_MODE>.spice`

The `EXT_MODE` parameter selects the extraction mode:
- `1` = C-decoupled
- `2` = C-coupled
- `3` = full-RC (default)

> **Note:** For `klayout-pex`, `EXT_MODE=1` (C-decoupled) is not yet supported by kpex and automatically falls back to `EXT_MODE=2` (CC) with a warning.

The `.subckt` name in the extracted SPICE file is automatically renamed from `<CELL>_flat` (kpex) or `<CELL>` (Magic) to `<CELL>_pex`.

If a matching Xschem symbol (`schematic/<CELL>_pex.sym`) exists, the `.subckt` pin order in the extracted SPICE file is automatically reordered to match the symbol's pin positions. This ensures the PEX netlist can be used directly with the corresponding Xschem symbol for simulation regardless of the selected `EXT_MODE`.

**KLayout PEX** uses `kpex` with the Magic extraction engine currently (2.5D engine is work in progress):

```sh
make klayout-pex
make klayout-pex CELL=tinywhisper_top
make klayout-pex CELL=tinywhisper_top EXT_MODE=3
```

**Magic PEX** uses `sak-pex.sh`:

```sh
make magic-pex
make magic-pex CELL=tinywhisper_top
make magic-pex CELL=tinywhisper_top EXT_MODE=3
```


## Verify a Specific Cell

Runs LVS, DRC, and PEX for a specific cell (e.g. `tinywhisper_top`):

```sh
make klayout-verify CELL=tinywhisper_top
make magic-verify CELL=tinywhisper_top
```


## Verify Top Cell

Runs LVS, DRC, and PEX for the top cell:

```sh
make klayout-verify
make magic-verify
```


## Packaging (Bondplan Generation)

Generates the bondplan fully automatically: the die placed in the package cavity, all bondwires, a pin table, and the filled EUROPRACTICE title block. Inputs are the final chip GDS (`layout/tinywhisper_top_logo_fill.gds.gz`) and the EUROPRACTICE package library, from which the QFN48 drawing sheet is extracted:

```sh
make bondplan
```

The flow ([packaging/scripts/run_bondplan.py](packaging/scripts/run_bondplan.py)) is driven by [packaging/config.yaml](packaging/config.yaml), which holds the full package-pin-to-die-pad `PINOUT` in a LibreLane-style config format. It detects the die bondpads (`Passiv` openings and `TopMetal2.text` labels), places the die in the package cavity, draws the bondwires, and checks wire lengths, crossings, spacing, lead skew and RF guard clearances. Outputs:

- `packaging/layout/tinywhisper_bondplan.gds`: the bondplan GDS
- [packaging/result.md](packaging/result.md): bond report with summary and bond table
- `packaging/render/tinywhisper_bondplan_{white,black}.{png,svg}`: bonding diagram images

See [packaging/README.md](packaging/README.md) for the full flow documentation and configuration reference.

<p align="center">
  <a href="packaging/render/tinywhisper_bondplan_white.png">
    <img src="packaging/render/tinywhisper_bondplan_white.png" alt="Bonding diagram of the TinyWhisper ASIC in a QFN48 package" width=70%>
  </a>
  <br>
  <em>Bonding diagram of the TinyWhisper ASIC in a QFN48 package.</em>
</p>


## Build and Verify All

Runs full simulation (`sim-all`), then `build-all`, followed by Magic DRC for both `tinywhisper_top` and `tinywhisper_top_logo_fill`, and finally generates the bondplan (`bondplan`):

```sh
make all
```


## Release

Copies the final top-level GDS with logo and fill structures from `layout/` to `release/v.<VERSION>/gds/`, copies the generated netlists into `release/v.<VERSION>/netlist/`, and copies the chip renders into `release/v.<VERSION>/img/`.

The following netlist folders are exported:

- `netlist/layout` -> `release/v.<VERSION>/netlist/layout`
- `netlist/pnl` -> `release/v.<VERSION>/netlist/pnl`
- `netlist/spice` -> `release/v.<VERSION>/netlist/spice`

The following chip renders are exported:

- `render/img/tinywhisper_top_black.png` -> `release/v.<VERSION>/img/tinywhisper_top_black.png`
- `render/img/tinywhisper_top_white.png` -> `release/v.<VERSION>/img/tinywhisper_top_white.png`
- `render/img/tinywhisper_top_librelane.png` -> `release/v.<VERSION>/img/tinywhisper_top_librelane.png`

> [!NOTE]
> `netlist/schematic` and `netlist/pex` are currently not copied by the `release` target.

Run with default version (`2.0.0`):

```sh
make release
```

Run with a custom version:

```sh
make release VERSION=2.1.0
```
