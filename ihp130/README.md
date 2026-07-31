# ihp-sg13g2 TinyWhisper

<p align="center">
  <a href="render/img/tinywhisper_top_black.png">
    <img src="render/img/tinywhisper_top_black.png" alt="Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm)" width=70%>
  </a>
  <br>
  <em>Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm).</em>
</p>


> [!WARNING]
> `make add-logo-fill` currently fails in the IIC-OSIC-TOOLS `2026.07` release. A PDK issue corrupts the
> seal ring, which makes the KLayout filler abort with an internal error in `Region::holes`. The target is
> therefore commented out in `Makefile :: build-top`. This will be fixed with the `2026.08` release of
> IIC-OSIC-TOOLS.

## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 ihp130/
├─ 📁 doc/
│  ├─ 📁 AMS/
│  │  ├─ AMS_simulation.pdf
│  │  ├─ Verilog-CoSim_Ngspice.pdf
│  │  └─ Verilog-CoSim_Xschem.pdf
│  ├─ 📁 ihp-sg13g2-Open-PDK/
│  │  └─ sg13g2_os_layout_cheatsheet.xlsx
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
│  ├─ floorplan.md
│  ├─ pinout.md
│  ├─ pinout.pdf
│  └─ specifications.md
├─ 📁 flow/
│  ├─ 📁 artistic/
│  ├─ 📁 librelane/
│  │  ├─ config.yaml
│  │  ├─ pdn_cfg.tcl
│  │  └─ tinywhisper_top.sdc
│  └─ 📁 logo/
│     └─ tinywhisper_logo_mono.png
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
│  │  ├─ 📁 testbenches/
│  │  ├─ Makefile
│  │  └─ README.md
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
│     ├─ 📁 verification/
│     ├─ Makefile
│     └─ README.md
├─ 📁 netlist/
│  ├─ 📁 layout/
│  │  └─ tinywhisper_top.spice
│  ├─ 📁 nl/
│  │  └─ tinywhisper_top.nl.v
│  ├─ 📁 pex/
│  │  ├─ tinywhisper_top_klayout_pex_*.spice
│  │  └─ tinywhisper_top_magic_pex_*.spice
│  ├─ 📁 pnl/
│  │  └─ tinywhisper_top.pnl.v
│  ├─ 📁 schematic/
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
│  └─ 📁 xschem/
│     ├─ tinywhisper.sch
│     ├─ tinywhisper.sym
│     ├─ tinywhisper_top.sch
│     ├─ tinywhisper_top.sym
│     ├─ tinywhisper_top_pex.sym
│     └─ xschemrc
├─ 📁 scripts/
│  ├─ add_logo_fill.sh
│  ├─ add_rectangle.py
│  ├─ check_pex_ports.py
│  └─ lay2img.py
├─ 📁 testbenches/
│  ├─ 📁 cocotb/
│  │  ├─ tinywhisper_top_tb.gtkw
│  │  ├─ tinywhisper_top_tb.surf.ron
│  │  └─ tinywhisper_top_tb.py
│  └─ 📁 xschem/
│     ├─ 📁 plot_simulations/
│     │  ├─ 📁 data/
│     │  └─ ngspice2python.py
│     ├─ tinywhisper_tb_tran.sch
│     ├─ tinywhisper_top_tb_tran.sch
│     └─ xschemrc
├─ 📁 verification/
│  ├─ 📁 drc/
│  │  ├─ 📁 tinywhisper_top.magic.drc/
│  │  └─ 📁 tinywhisper_top_logo_fill.magic.drc/
│  ├─ 📁 lvs/
│  │  └─ 📁 tinywhisper_top.magic.lvs/
│  └─ 📁 reports/
├─ Makefile
└─ README.md
```

</details>


## Makefile Structure

The whole flow is driven by Makefiles. The top-level `Makefile` builds the chip, and every component under [`macros/`](macros/) and [`ip/`](ip/) has its own `Makefile` and `README.md` following the same conventions (`make help`, `make all`, and so on). You can run each component from the top level or directly from inside its own folder.

At the top level, `make all` runs four steps in this order:

1. `build-all` initializes the submodules and builds every component by calling its own `all` target: bondpad, logos, macros, and finally the chip assembly with `build-top` (LibreLane, copy-back of all artifacts, logo and fill insertion, final GDS render).
2. `magic-drc` runs the DRC of the final `tinywhisper_top` and `tinywhisper_top_logo_fill` GDS.
3. `sim-all` runs the chip-level RTL and gate-level simulations on the netlists produced by this build.
4. `bondplan` generates the bonding diagram, the bondwires, and the pin table.

Every component follows the same principle. The simulations always run last, so they use the artifacts that the same invocation has just produced.

| Makefile | `all` flow |
| --- | --- |
| [`macros/riscv/`](macros/riscv/) (digital) | lint -> build (FPGA and LibreLane, including the XSPICE model) -> simulate. DRC and LVS run inside the LibreLane flow. |
| [`macros/iqmod/`](macros/iqmod/) (analog) | verify (DRC, LVS, PEX) -> build (LEF, LIB, Verilog stub, GDS, render) -> simulate |
| [`macros/coupled_resonator_lc_bpf/`](macros/coupled_resonator_lc_bpf/) (schematic-only) | simulate |
| [`ip/*`](ip/) (bondpad, logos) | build -> verify (DRC) |
| top level | build -> verify (DRC) -> simulate -> package |

The following sections describe the top-level targets in detail. The macro and IP targets are documented in the `README.md` of the respective subfolder.


## Makefile Targets

### Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```


### Initialize Git Submodules

Initializes and updates the repository submodules (for example `ihp130/artistic`):

```sh
make init-submodules
```

Run this after cloning the repository, or whenever submodule pointers are updated.


### Simulation

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
make sim-gl-xschem TB=<testbenchname>
```

The testbench is selected with the `TB` variable, given without the `.sch` extension (default: `<CELL>_tb_tran`). All testbench schematics are located in `testbenches/xschem/`, and the generated netlists are written to `testbenches/xschem/simulations/`.

The simulation runs in **batch mode**: the target netlists the testbench with `xschem netlist` and then invokes `ngspice -b` directly instead of using `xschem simulate`. `xschem simulate` would spawn an interactive ngspice in a terminal detached from `make`: the target would return immediately, the result would never be checked, and the process (with its X server) would leak. Running the simulator directly makes `make` block until the run finishes and see its exit status.

Because the run is headless, the `plot` commands in a testbench's `.control` block are a no-op and no plot windows appear. Every testbench instead exports its results with `wrdata` to `testbenches/xschem/plot_simulations/data/`, from where they are plotted with `sim-view-xschem`.

> [!NOTE]
> `sim-gl-xschem` is part of `sim-all`, but it may take a long time depending on the hardware used.

To plot the Xschem simulation results, use `sim-view-xschem`. It runs a plotting script from `testbenches/xschem/plot_simulations/` (`SIM_PLOT_DIR`), selected with the `SCRIPT` variable (given without the `.py` extension), and reproduces the plots of the testbench's `.control` block with matplotlib from the exported data in `plot_simulations/data/`:

```sh
make sim-view-xschem SCRIPT=<scriptname>
```

The target runs `SHOW_PLOTS=1 python3 testbenches/xschem/plot_simulations/$(SCRIPT).py`. Every script writes its figures to `testbenches/xschem/plot_simulations/figures/`. Run through `sim-view-xschem`, the plot windows additionally open when a display is available (i.e. the container's X/VNC session). Headless, only the figures are written.

> [!NOTE]
> `sim-view-xschem` is intentionally **not** called by `sim-all`.

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


### LibreLane Flow

Run the LibreLane flow with:

```sh
make librelane
```

Additional targets are available for different DRC configurations:

- `make librelane-nodrc` – run LibreLane without DRC checks
- `make librelane-magicdrc` – run LibreLane with only Magic DRC checks
- `make librelane-klayoutdrc` – run LibreLane with only KLayout DRC checks

These targets are also available for the digital macros. After the LibreLane flow completes successfully, the generated views are saved under `flow/final/`.


### View the Design

After completion, you can view the design using the OpenROAD GUI:

```sh
make librelane-openroad
```

Or using KLayout:

```sh
make librelane-klayout
```

These commands are also available for the digital macros.


### Copy Important Reports

To copy the Yosys synthesis checks, antenna reports, post-PnR timing summary, per-corner power reports, IR-drop report, LVS report, and manufacturability report from the latest LibreLane run into `verification/reports/`, run:

```sh
make copy-reports
```

This only works if the latest run completed without errors. This command is also available for the digital macros.


### Copy the Final GDS

To copy and compress the latest GDS from `flow/final/gds/` into `layout/`, run:

```sh
make copy-gds
```


### Copy the Final Netlist

To copy the latest SPICE, PnL, and NL netlists from `flow/final/spice/` into `netlist/spice/`, from `flow/final/pnl/` into `netlist/pnl/`, and from `flow/final/nl/` into `netlist/nl/`, run:

```sh
make copy-netlist
```

This only works if the latest run completed without errors.


### Copy the Final Render

To copy the latest LibreLane chip render from `flow/final/render/` into `render/img/`, run:

```sh
make copy-render
```

This creates `render/img/tinywhisper_top_librelane.png`. This only works if the latest run completed without errors.


### Render Top Layout

Renders the top-level GDS from `layout/` with `scripts/lay2img.py` and saves the two images `tinywhisper_top_black.png` and `tinywhisper_top_white.png` in the `render/img/` folder:

```sh
make render-gds
```

This only works if the latest run completed without errors. This command is also available for the digital macros.


### Build Bondpad

To build the bondpad in the `ip` folder, run the following command:

```sh
make build-bondpad
```


### Build Logos

To build the logos in the `ip` folder, run the following command:

```sh
make build-logos
```


### Build Macros

To build a specific macro, run the corresponding target from the `Makefile`. To build all currently enabled macros, run:

```sh
make build-macros
```

#### Build Digital Macros

The following command builds the `riscv` digital macro:

```sh
make build-riscv
```

For each digital macro this dispatches to its in-tree `make all`, which runs the macro's full flow: lint, build (FPGA and LibreLane, including netlists and the XSPICE model), verify (DRC and LVS within the LibreLane flow) and simulate. The simulations run after the build, so the gate-level simulations run on the netlists produced by this build.

> [!TIP]
> Each macro has its own `Makefile` and `README.md` with additional targets, such as linting, simulation, and verification.
> For example, to lint the RISC-V CPU or run its simulation, refer to [ihp130/macros/riscv/README.md](macros/riscv/README.md).

#### Build Analog Macros

Each analog macro has its own `klayout-verify` and `magic-verify` targets that run DRC, LVS, and PEX for the top-level cell.

To build the IQ modulator macro:

```sh
make build-iqmod
```

For each analog macro this dispatches to its in-tree `make all`, which runs the macro's full flow: verify (DRC, LVS, PEX), build, and simulate. The simulations run after the verification, so the top-level testbench includes the PEX netlist produced by this run.

All analog macros are included in `build-macros` alongside the digital macros.


### Build Top

To run LibreLane for the top-level chip and copy the resulting reports, GDS, netlist, and chip render back into the source tree, then add the logo + fill structures and render the final GDS, run:

```sh
make build-top
```

Internally this executes (in order): `librelane-nodrc` → `copy-reports` → `copy-gds` → `copy-netlist` → `copy-render` → `add-logo-fill` → `render-gds`.

> [!NOTE]
> `build-top` runs `librelane-nodrc` instead of `librelane` for the same reason the DRC reports are not copied: IHP's `metal1_pin_offgrid` rule trips on the pad ring (see [IHP-Open-PDK#683](https://github.com/IHP-GmbH/IHP-Open-PDK/issues/683#issuecomment-4065791975)).
> Once it is fixed upstream, `Makefile :: build-top` switches back to `librelane`.

> [!NOTE]
> `add-logo-fill` is currently commented out in `build-top` because the corrupted seal ring makes the KLayout filler abort (see the WARNING at the top of this README).


### Build All

To initialise submodules, build the bondpad, build the logos, build the macros, and run the full `build-top` flow, run:

```sh
make build-all
```

> [!NOTE]
> The `make build-all` target does **not** currently call `make build-macros`: the RISC-V CPU is built with nix-shell and the top-level with the `next` IIC-OSIC-TOOLS release (see the TODO in the [Makefile](Makefile)).
> To build specific macros, use `make build-riscv`, `make build-iqmod`, or `make build-macros` to build all enabled macros separately.

This is useful if you want to rebuild the chip from scratch. Clone the repository, enter the IIC-OSIC-TOOLS environment, and run `make build-all`.


### Design Rule Check (DRC)

Runs DRC on the GDS layout in `layout/`. Both flows use `sak-drc.sh` and write their reports into per-cell run folders: `verification/drc/<CELL>.magic.drc/` (Magic) and `verification/drc/<CELL>.klayout.drc/` (KLayout, `.lyrdb`). The run folders are wiped at the start of each run, so they always reflect the latest run only.

The `DRC_LEVEL` parameter selects the KLayout DRC level (`sak-drc.sh -l`). It is ignored by `magic-drc`, since Magic has no selectable rule decks and always runs the full rule set compiled into the PDK's Magic tech file:

- `precheck` = core FEOL + BEOL manufacturing rules only (fast iteration)
- `macro` = block-in-isolation sign-off: `precheck` plus off-grid, zero-area, and pin/label checks (default)
- `regular` = full-chip sign-off: all checks, including density and antenna

| Check | `precheck` | `macro` _(default)_ | `regular` |
| --- | :---: | :---: | :---: |
| FEOL + BEOL core rules | ✓ | ✓ | ✓ |
| Off-grid / angle | – | ✓ | ✓ |
| Zero-area / geometry | – | ✓ | ✓ |
| Pin / label | – | ✓ | ✓ |
| Recommended / extra rules | – | – | ✓ |
| Density (chip-level fill) | – | – | ✓ |
| Antenna | – | – | ✓ |

**KLayout DRC (minimum)** runs a pre-check (`precheck`) KLayout DRC on the final top-level layout with logo and fill structures:

```sh
make klayout-drc-minimum
```

**KLayout DRC (regular)** runs a full (`regular`) KLayout DRC on the final top-level layout with logo and fill structures:

```sh
make klayout-drc-regular
```

**KLayout DRC** runs a KLayout DRC at the selected `DRC_LEVEL`:

```sh
make klayout-drc
make klayout-drc CELL=tinywhisper_top
make klayout-drc CELL=tinywhisper_top DRC_LEVEL=regular
```

**Magic DRC** runs a Magic DRC with all subcells flattened (`sak-drc.sh -f "*"`):

```sh
make magic-drc
make magic-drc CELL=tinywhisper_top
```


### Export Schematic Netlist for LVS

Exports the schematic netlist for LVS from Xschem and places it in `netlist/schematic/`.

The `EV_PRECISION` parameter sets the number of significant digits used by Xschem's `ev` function when calculating device properties (default: 5). Increase this to avoid LVS mismatches caused by floating-point rounding differences between Xschem and KLayout (see [xschem#465](https://github.com/StefanSchippers/xschem/issues/465)).

The `ntap` and `ptap` substrate contacts are ignored during LVS in both flows. `sak-lvs.sh` runs KLayout LVS with the `--disable_tap_extraction` option so it does not extract `ntap` and `ptap` devices from the layout (matching Magic + Netgen LVS). The schematic uses `lvs_ignore = short` for these devices and conditional net labels (see [xschem#474](https://github.com/StefanSchippers/xschem/issues/474)), which takes effect during schematic netlist export via `set lvs_ignore 1`.

KLayout uses CDL netlists, while Magic uses SPICE netlists. Accordingly, `klayout-lvs-netlist` uses the Xschem commands `set spiceprefix 1`, `set lvs_netlist 1`, `set top_is_subckt 1`, and `set lvs_ignore 1`, while `magic-lvs-netlist` uses `set spiceprefix 1`, `set lvs_netlist 0`, `set top_is_subckt 1`, and `set lvs_ignore 1`. Hence, switching between CDL and SPICE netlists can be done with `lvs_netlist`.

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


### Layout Versus Schematic (LVS)

Exports the schematic netlist from Xschem, then runs LVS. Compares the GDS layout in `layout/` against the schematic netlist in `netlist/schematic/`. Both flows use `sak-lvs.sh` and write their reports into per-cell run folders: `verification/lvs/<CELL>.magic.lvs/` (Magic + Netgen) and `verification/lvs/<CELL>.klayout.lvs/` (KLayout, `.lvsdb`). The run folders are wiped at the start of each run, so they always reflect the latest run only. The extracted layout netlist is moved to `netlist/layout/`.

**KLayout LVS** uses `sak-lvs.sh` (KLayout mode `-k`), which wraps `run_lvs.py` from the IHP Open-PDK:

```sh
make klayout-lvs
make klayout-lvs CELL=tinywhisper_top
```

**Magic + Netgen LVS** uses `sak-lvs.sh` (Magic + Netgen mode `-m`, the default), which extracts the layout netlist with Magic and compares it against the schematic netlist with Netgen, using the Netgen setup from the IHP Open-PDK:

```sh
make magic-lvs
make magic-lvs CELL=tinywhisper_top
```


### Parasitic Extraction (PEX)

Runs parasitic extraction on the GDS layout in `layout/`. The extracted SPICE netlist is written to `netlist/pex/`.

The extracted SPICE filenames include the selected extraction mode:
- `klayout-pex` writes `netlist/pex/<CELL>_klayout_pex_<EXT_MODE>.spice`
- `magic-pex` writes `netlist/pex/<CELL>_magic_pex_<EXT_MODE>.spice`

The `EXT_MODE` parameter selects the extraction mode:
- `1` = C-decoupled
- `2` = C-coupled
- `3` = full-RC (default)

> **Note:** For `klayout-pex`, `EXT_MODE=1` (C-decoupled) is not yet supported by kpex and automatically falls back to `EXT_MODE=2` (CC) with a warning.

The `.subckt` name in the extracted SPICE file is `<CELL>_pex`: `magic-pex` sets it directly via the `sak-pex.sh` option `-n <CELL>_pex`, while for `klayout-pex` it is automatically renamed from `<CELL>` (kpex).

If a matching Xschem symbol (`schematic/xschem/<CELL>_pex.sym`) exists, the `.subckt` pin order in the extracted SPICE file is automatically reordered with `sak-pin-reorder.py` (installed in the IIC-OSIC-TOOLS container) to match the symbol's pin positions. This ensures the PEX netlist can be used directly with the corresponding Xschem symbol for simulation regardless of the selected `EXT_MODE`.

Both targets finish by running [`scripts/check_pex_ports.py`](scripts/check_pex_ports.py) on the netlist they just wrote. It verifies that every pin of the `.subckt` really reaches the circuit, and fails the target otherwise. Two cases are caught:

- A port that is declared in the `.subckt` line but referenced by no element at all. Whatever is wired to that pin from outside is then left floating.
- A port whose net was split into `<port>.t<n>` and `<port>.n<n>` fragments by `extresist` (`EXT_MODE=3`), where none of the fragments is connected back to the port. The pin is then dangling even though the fragments themselves are wired up.

Both produce a netlist that ngspice reads without a single warning while the cell behaves completely differently in simulation, so the check is worth the two seconds it costs. It can also be run by hand on any SPICE netlist:

```sh
python3 scripts/check_pex_ports.py netlist/pex/tinywhisper_top_magic_pex_3.spice
python3 scripts/check_pex_ports.py -v netlist/pex/*.spice     # -v also prints the size of each subcircuit
```

**KLayout PEX** uses `kpex` with the Magic extraction engine currently (2.5D engine is work in progress):

```sh
make klayout-pex
make klayout-pex CELL=tinywhisper_top
make klayout-pex CELL=tinywhisper_top EXT_MODE=3
```

**Magic PEX** uses `sak-pex.sh`, which extracts the parasitics with Magic (C-decoupled, C-coupled, or full-RC):

```sh
make magic-pex
make magic-pex CELL=tinywhisper_top
make magic-pex CELL=tinywhisper_top EXT_MODE=3
```

For full-RC extraction (`EXT_MODE=3`), `magic-pex` additionally exposes the three `extresist` tuning parameters of `sak-pex.sh`. They are ignored in `EXT_MODE=1`/`2`.

A full-RC extraction of a whole chip would produce a resistor network far too large to simulate, and most of it would be wires so short that their resistance does not matter. The three parameters are the filters Magic applies to keep only the part of the network that is worth having. They run in this order:

1. **`THRESHOLD`** (`-t`, in mOhm, default `10000` = 10 Ohm) decides **which nets are extracted at all**. Before doing any real work, Magic makes a quick end-to-end resistance guess for every net. The guess is deliberately pessimistic, it is an absolute worst case. Nets that stay below `THRESHOLD` even in that worst case cannot matter, so they are treated as ideal wires and skipped. This is the cheap first pass that removes the many short, low-resistance nets.
2. **`MINDELAY`** (`-y`, in ps, default `1`) decides **which of the extracted nets are kept**. Because the guess above overestimates, Magic re-checks each net once it has been properly extracted and discards its resistor network again if the RC delay it adds stays below `MINDELAY`. Setting `MINDELAY=0` switches the delay criterion off and applies `THRESHOLD` a second time instead, now against the accurately extracted resistance rather than the initial guess.
3. **`MINRES`** (`-r`, in mOhm, default `1000` = 1 Ohm) decides **how detailed the kept networks are**. Inside a net, neighbouring resistors below `MINRES` are merged as far as possible, which shrinks the network without changing its overall resistance much.

In short: `THRESHOLD` and `MINDELAY` control *how many* nets carry parasitic resistance, `MINRES` controls *how finely* each of them is modelled. Raising all three gives a smaller netlist that simulates faster with less detail, lowering them gives a more accurate but considerably larger one.

```sh
make magic-pex CELL=tinywhisper_top EXT_MODE=3 THRESHOLD=5000 MINRES=500 MINDELAY=2
```


### Verify a Specific Cell

Runs DRC, LVS, and PEX for a specific cell (e.g. `tinywhisper_top`):

```sh
make klayout-verify CELL=tinywhisper_top
make magic-verify CELL=tinywhisper_top
```


### Verify Top Cell

Runs DRC, LVS, and PEX for the top cell:

```sh
make klayout-verify
make magic-verify
```


### Packaging (Bondplan Generation)

Generates the bondplan fully automatically: the die placed in the package cavity, all bondwires, a pin table, and the filled EUROPRACTICE title block. Inputs are the final chip GDS (`layout/tinywhisper_top_logo_fill.gds.gz`) and the EUROPRACTICE package library, from which the QFN48 drawing sheet is extracted:

```sh
make bondplan                        # uses the default VERSION (2.0.0)
make bondplan VERSION=2.1.0          # stamp another version on the sheet
```

The `VERSION` variable is passed to the flow and printed in the title block (`DIE: TINYWHISPER - V.2.0.0`), so the version number is maintained in the Makefile only.

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


### Build, Verify and Simulate All

Runs `build-all` first, followed by Magic DRC for both `tinywhisper_top` and `tinywhisper_top_logo_fill`, then the chip simulations (`sim-all`) and finally generates the bondplan (`bondplan`) once all checks have passed:

```sh
make all
```


### Release

Copies the final top-level GDS with logo and fill structures from `layout/` to `release/v.<VERSION>/gds/`, copies the generated netlists into `release/v.<VERSION>/netlist/`, and copies the chip renders and the bonding diagram into `release/v.<VERSION>/img/`.

The following netlist folders are exported:

- `netlist/schematic` -> `release/v.<VERSION>/netlist/schematic`
- `netlist/layout` -> `release/v.<VERSION>/netlist/layout`
- `netlist/pnl` -> `release/v.<VERSION>/netlist/pnl`
- `netlist/spice` -> `release/v.<VERSION>/netlist/spice`

The following chip renders are exported:

- `render/img/tinywhisper_top_black.png` -> `release/v.<VERSION>/img/tinywhisper_top_black.png`
- `render/img/tinywhisper_top_white.png` -> `release/v.<VERSION>/img/tinywhisper_top_white.png`
- `render/img/tinywhisper_top_librelane.png` -> `release/v.<VERSION>/img/tinywhisper_top_librelane.png`

The bonding diagram is exported as well (see `make bondplan`):

- `packaging/render/tinywhisper_bondplan_black.png` -> `release/v.<VERSION>/img/tinywhisper_bondplan_black.png`
- `packaging/render/tinywhisper_bondplan_white.png` -> `release/v.<VERSION>/img/tinywhisper_bondplan_white.png`

> [!NOTE]
> `netlist/pex` is **not** copied by the `release` target: the extracted top-level PEX netlists are far too large to commit into every released version. They stay available in `netlist/pex/`.

Run with default version (`2.0.0`):

```sh
make release
```

Run with a custom version:

```sh
make release VERSION=2.1.0
```


### Regression

The `regression` target is the project's end-to-end smoke test for the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) environment (IIC-OSIC-TOOLS regression test **28**). Its goal is to exercise **every tool and flow** in the project at least once with the **shortest possible runtime**. It is a tool/flow regression, not a design sign-off. It comes in two variants: the default `regression` reuses the committed riscv macro views for speed, while `regression-nightly` additionally re-hardens the riscv macro and runs its gate-level flows (it runs `regression` with `NIGHTLY_REGRESSION=1`).

```sh
make regression          # fast variant, committed riscv views reused
make regression-nightly  # full variant, riscv hardening + gate-level flows included
```

This target also runs automatically in continuous integration: the [`regression`](../.github/workflows/regression.yml) GitHub Actions workflow runs `make regression-nightly` inside the `IIC-OSIC-TOOLS` container nightly (and on manual dispatch), and its status is shown by the *Regression* badge at the top of the [repository README](../README.md). The scheduled run is gated so it only executes when there have been changes since the previous night.

To keep the runtime low while still covering the full toolchain, the regression makes the following trade-offs:

- The chip top-level runs `librelane-nodrc`. All DRC checks are skipped to save runtime on the large top-level assembly. The macros and IP blocks are DRC-checked individually beforehand, so this only leaves the top-level routing/fill unchecked.
- KLayout DRC (`sak-drc.sh`) is skipped inside the LibreLane runs, but is still exercised in the bondpad and logo IP builds, and in the iqmod `klayout-verify`.
- Only **one** logo (`sg13g2_ip__jku`) is regenerated. It is the only step that exercises the PNG to GDS flow. The other logos (`sg13g2_ip__jku_names`, `sg13g2_ip__ce`, `sg13g2_ip__ce_names`) use an identical toolchain and reuse their committed views.
- Exactly **one** Xschem testbench (`iqmod_mfb_lpf_tb_ac_cl`) and **one** CACE parameter set (the AC VDD sweep `ac_params` of `iqmod_mfb_lpf.yaml`, no Monte-Carlo) are run. Swap `ac_params` for `ac_mc_params` / `ac_mm_params` in the target to also exercise the Monte-Carlo flow.
- In the default `regression` the riscv macro is **not re-hardened**: `librelane-magicdrc` (the full RTL-to-GDS of the CPU, ≈2 h wall clock) and the flows that depend on its fresh outputs — `copy-final`, the gate-level cocotb simulation (`sim-gl-cocotb`, ≈12 min for the full suite), `generate-xspice` and the gate-level Xschem simulation (`sim-gl-xschem`) — as well as the Icarus RTL testbench (`sim-rtl-verilog`) only run in `regression-nightly` (`NIGHTLY_REGRESSION=1`). In the default variant the riscv macro is covered at RTL (lint + cocotb, which also exercises Icarus as its simulator), and the LibreLane flow itself is still exercised by the chip top-level `librelane-nodrc` run. A fast gate-level smoke run of a single test (≈20 s) is available via `COCOTB_TEST_FILTER=test_cpu_fibonacci_fast make sim-gl-cocotb`.

The regression runs bottom-up: first the iqmod and riscv macros, then the top-level assembly (submodules, bondpad, logo) and finally the chip top-level LibreLane run that integrates the macros and IP. In `regression-nightly`, `copy-final` copies the freshly hardened `flow/final/` views into `macros/riscv/final/`, so the gate-level flows and the chip top-level use the freshly built outputs; in the default `regression` the chip top-level integrates the committed views in `macros/riscv/final/` instead.

The following tools and flows are checked by both variants:

| Tool / flow | Where it is exercised |
| --- | --- |
| git submodules | `init-submodules` |
| KLayout scripting (bondpad generator), KLayout DRC, Magic DRC | `build-bondpad` |
| PNG to GDS logo generation, KLayout DRC, Magic DRC | `sg13g2_ip__jku all` (single logo) |
| Xschem + ngspice (analog simulation) | iqmod `sim-xschem` (`iqmod_mfb_lpf_tb_ac_cl`) |
| CACE (+ ngspice) | iqmod CACE, single parameter set (`ac_params`) |
| KLayout DRC (`sak-drc.sh`) + KLayout LVS (`sak-lvs.sh`) + KLayout PEX (`kpex`) | iqmod `klayout-verify CELL=iqmod_top` |
| Magic DRC (`sak-drc.sh`) + Magic extract + Netgen LVS (`sak-lvs.sh`) + Magic PEX (`sak-pex.sh`) | iqmod `magic-verify CELL=iqmod_top` |
| Magic LEF export + LIB + Verilog stub + `lay2img` render | iqmod `build-top` |
| Verilator lint | riscv `lint-verilog-all` |
| cocotb (RTL, Icarus as simulator) | riscv `sim-rtl-cocotb` |
| LibreLane (OpenROAD / yosys / KLayout streamout / Netgen LVS) | chip `librelane-nodrc` |

The following flows are only covered by `regression-nightly`:

| Tool / flow | Target (in `macros/riscv/`) |
| --- | --- |
| Icarus Verilog with the plain SystemVerilog testbench | `sim-rtl-verilog` |
| LibreLane macro hardening + Magic sign-off DRC (≈2 h) | `librelane-magicdrc` + `copy-final` |
| cocotb gate-level | `sim-gl-cocotb` (manual smoke run: `COCOTB_TEST_FILTER=test_cpu_fibonacci_fast make sim-gl-cocotb`) |
| `spi2xspice.py` + `sak-pin-reorder.py` (XSPICE model) | `generate-xspice` |
| Xschem gate-level (ngspice + xspice) | `sim-gl-xschem` |

The FPGA flow (yosys + nextpnr-ice40 + icepack, riscv `build-fpga`) is not part of either regression variant and must be run manually.
