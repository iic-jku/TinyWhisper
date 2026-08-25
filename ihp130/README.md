# ihp-sg13g2 TinyWhisper

<p align="center">
  <a href="render/img/tinywhisper_top_black.png">
    <img src="render/img/tinywhisper_top_black.png" alt="Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm)" width=70%>
  </a>
  <br>
  <em>Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm).</em>
</p>


## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 ihp130/
├─ 📁 doc/
│  ├─ 📁 ihp-sg13g2-Open-PDK/
│  │  ├─ sg13g2_ngspice_mc_mm_guide.md
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
│  ├─ README.md
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
│     ├─ tinywhisper_top_black_TM2.png
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
│  └─ check_pex_ports.py
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
│  │  ├─ run_lvs.sh
│  │  ├─ gds2spice.sh
│  │  ├─ merge_spice.py
│  │  ├─ lvs.out
│  │  └─ README.md
│  └─ 📁 reports/
├─ Makefile
└─ README.md
```

</details>


## Xschem Configuration

Xschem reads exactly one `xschemrc` at start-up, and that file decides which symbol libraries are visible and where netlists and simulation output are written. This project ships one per folder that holds schematics:

| `xschemrc` | Belongs to |
| --- | --- |
| [`schematic/xschem/xschemrc`](schematic/xschem/xschemrc) | chip top-level schematics |
| [`testbenches/xschem/xschemrc`](testbenches/xschem/xschemrc) | chip top-level testbenches |
| [`macros/iqmod/schematic/xschem/xschemrc`](macros/iqmod/schematic/xschem/xschemrc) | iqmod schematics |
| [`macros/iqmod/testbenches/xschem/xschemrc`](macros/iqmod/testbenches/xschem/xschemrc) | iqmod testbenches |
| [`macros/iqmod/verification/cace/templates/xschemrc`](macros/iqmod/verification/cace/templates/xschemrc) | CACE testbench templates |
| [`macros/riscv/schematic/xschem/xschemrc`](macros/riscv/schematic/xschem/xschemrc) | riscv schematics |
| [`macros/riscv/testbenches/xschem/xschemrc`](macros/riscv/testbenches/xschem/xschemrc) | riscv testbenches |
| [`macros/coupled_resonator_lc_bpf/schematic/xschem/xschemrc`](macros/coupled_resonator_lc_bpf/schematic/xschem/xschemrc) | coupled_resonator_lc_bpf schematics |
| [`macros/coupled_resonator_lc_bpf/testbenches/xschem/xschemrc`](macros/coupled_resonator_lc_bpf/testbenches/xschem/xschemrc) | coupled_resonator_lc_bpf testbenches |


### What Every File Does

All of them run the same four steps, in this order:

1. **Pick the PDK.** `PDK_ROOT` is probed in the usual install locations if the environment does not set it, and `PDK` falls back to `ihp-sg13g2`. The container already exports `PDK_ROOT`, and [`.designinit`](../.designinit) exports `PDK`, so this step is only a safety net for an Xschem started outside that environment.
2. **Source the PDK `xschemrc`.** `$PDK_ROOT/$PDK/libs.tech/xschem/xschemrc` brings in the IHP device symbols, the ngspice model paths and the IHP menu. It is guarded by `[info exists PDK]` so it is read once even when several project files are chained.
3. **Add the project library paths.** `append_xschem_library_path_unique` appends a folder to `XSCHEM_LIBRARY_PATH` only if it is not already there, so the same folder never appears twice no matter how the files are chained. [`testbenches/xschem/xschemrc`](testbenches/xschem/xschemrc) adds none of its own and gets its paths from the file it sources.
4. **Pin the netlist directory.** `pin_netlist_dir` decides where `xschem netlist` and the simulators write.

Both helper procedures are defined behind an `[info commands ...]` guard, so sourcing one file from another is harmless and the order does not matter.


### How the Files Are Chained

The chip top-level pulls in everything below it:

```text
testbenches/xschem/xschemrc
└─ source schematic/xschem/xschemrc
   ├─ source macros/coupled_resonator_lc_bpf/schematic/xschem/xschemrc
   ├─ source macros/iqmod/schematic/xschem/xschemrc
   │  ├─ source macros/coupled_resonator_lc_bpf/schematic/xschem/xschemrc
   │  └─ source macros/riscv/schematic/xschem/xschemrc
   └─ source macros/riscv/schematic/xschem/xschemrc

macros/iqmod/testbenches/xschem/xschemrc
├─ source macros/coupled_resonator_lc_bpf/schematic/xschem/xschemrc
└─ source macros/riscv/schematic/xschem/xschemrc

macros/iqmod/verification/cace/templates/xschemrc
└─ source macros/iqmod/schematic/xschem/xschemrc
```

Each schematic folder puts itself and its sibling testbenches folder on the library path, and each testbenches folder does the reverse. The chip top-level therefore sees all eight schematic and testbench folders, which is what lets `tinywhisper_top.sch` instantiate `iqmod_top.sym` and `riscv_top.sym`, and what lets you open a macro testbench from a chip top-level session. The riscv and coupled_resonator_lc_bpf files do not source any other macro, so both can be opened and simulated on their own without the top level being present. The iqmod files pull in those two, because the iqmod system-level testbenches (for example `iqmod_mfb_lpf_riscv_tb_tran.sch`) drive the filter from the riscv XSPICE model and load it with the LC band-pass filter.


### Where Netlists and Simulation Output Go

`pin_netlist_dir` maps the folder of the schematic being netlisted to a `simulations/` folder:

| Schematic lives in | `netlist_dir` |
| --- | --- |
| `<x>/testbenches/xschem` | `<x>/testbenches/xschem/simulations` |
| `<x>/schematic/xschem` | `<x>/testbenches/xschem/simulations` |
| `.../cace/templates` | `.../cace/templates/simulations` |
| anywhere else (a PDK example) | left at the value the `xschemrc` pinned |

It runs twice: once while the `xschemrc` is read, using that file's own folder, and again through Xschem's `load_file_postprocess` hook for every schematic that is opened afterwards. The second call is the important one. Because the chip top-level puts the macro folders on the library path, a macro testbench can be opened from a chip top-level session, and without the hook its netlist would land in `testbenches/xschem/simulations/`. Its relative includes such as `.include ../../../netlist/pex/iqmod_top_pex.spice` are resolved by ngspice relative to the netlist file, so they would then point at the wrong tree and the simulation would abort. With the hook, the netlist always lands next to its own schematic and the includes resolve.

A `set netlist_dir` passed on the Xschem command line still wins, because `--command` runs after the file is loaded. The LVS netlist targets rely on this to write into `netlist/schematic/` instead.

All `simulations/` folders are generated and git-ignored.


### Which File Is Used

- The Makefile targets always name one explicitly with `--rcfile`, so a target behaves the same from any working directory.
- Inside the container, [`.designinit`](../.designinit) only exports the PDK variables. It does not wrap `xschem`, so a plain `xschem <file>` uses whatever the current directory provides.
- Starting Xschem from within one of the nine folders picks up that folder's file, which is the normal interactive case.


## Makefile Structure

The whole flow is driven by Makefiles. The top-level `Makefile` builds the chip, and every component under [`macros/`](macros/) and [`ip/`](ip/) has its own `Makefile` and `README.md` following the same conventions (`make help`, `make all`, and so on). You can run each component from the top level or directly from inside its own folder.

At the top level, `make all` runs four steps in this order:

1. `build-all` initialises the submodules and builds every component by calling its own `all` target: bondpad, logos, macros, and finally the chip assembly with `build-top` (LibreLane, copy-back of all artifacts, logo and fill insertion, final GDS render).
2. `magic-drc` runs the DRC of the final `tinywhisper_top` and `tinywhisper_top_logo_fill` GDS. The KLayout DRC is not part of `make all` to shorten the runtime. Run it separately with `klayout-drc-minimum` or `klayout-drc-regular`.
3. `sim-all` runs the top-level RTL and gate-level simulations on the netlists produced by this build.
4. `bondplan` generates the bonding diagram, the bondwires, and the pin table.

Every component follows the same principle. The simulations always run last, so they use the artifacts that the same invocation has just produced.

| Makefile | `all` flow |
| --- | --- |
| [`macros/riscv/`](macros/riscv/) (digital) | lint -> build (FPGA and LibreLane) -> simulate. DRC and LVS run inside the LibreLane flow. The XSPICE model is a committed source file and is not rebuilt. |
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


### Open the Design Files

Opens a file browser for this folder with `sak-open.py` from the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS), one button per design file, grouped by directory:

```sh
make open
```

Clicking a button launches the matching tool in the file's own directory, so Xschem finds its `simulations/` folder and KLayout its run outputs where they belong:

| File type | Tool |
| --- | --- |
| `.sch`, `.sym` | Xschem |
| `.gds`, `.gds.gz`, `.oas`, `.oas.gz` | KLayout in edit mode |
| `.mag` | Magic |
| `.vcd`, `.fst`, `.gtkw` | GTKWave |
| `.raw` | gaw (ngspice rawfile) |
| `.png`, `.pdf` | the desktop's handler (`xdg-open`) |
| `.sv`, `.svh`, `.v`, `.vh`, `.vhd`, `.vhdl`, `.spice`, `.cir`, `.sp`, `.cdl`, `.sdc`, `.lef`, `.lib`, `.tcl`, `.mk`, `.yaml`, `.json`, `.py`, `.qmd`, `.tex`, `.md` and `Makefile` | gvim |

Only these types get a button. Files with any other extension (`.sh`, `.svg`, `.pcf`, `.save`, `.rpt`, `.txt`, `.csv` and so on) are not listed.

Schematics and symbols that belong to one design unit share a single tabbed Xschem instance instead of one process per click. The unit is the nearest ancestor holding a `Makefile`, so each macro and the top level get their own instance. Every tab then writes its netlists to the folder that macro's `xschemrc` pins, see [Xschem Configuration](#xschem-configuration).

The tree is rescanned every 15 s, so files a running flow produces appear on their own and are highlighted for a minute. Generated directories are skipped by default: `runs/`, `sim_build/`, `obj_dir/`, `simulations/`, `__pycache__/`, `_freeze/` and `.git/`. The Xschem `simulations/` folder is one of them, so the `.raw` files show up only with `--all`. Pass extra options with `OPEN_ARGS`:

```sh
make open OPEN_ARGS=--all              # include the build outputs
make open OPEN_ARGS="--prune backups"  # skip one more directory name
```

At most 400 buttons are drawn at once, because each one is an X window, and what is left out is stated at the end of the list. That cap is easy to hit with `--all`: at the top level it pulls in the LibreLane run directories, the riscv views and every simulation output, tens of thousands of files. Use `--all` from the folder you actually care about, or narrow it with `--prune`, rather than at the top level.

> [!NOTE]
> This target needs a display. Run it inside the container's VNC/noVNC desktop or over X11 forwarding. In a shell-only container it stops with `cannot open a window`. The `.png` and `.pdf` buttons hand the file to the desktop's registered handler, so those two need the full VNC/noVNC session and do not work over a bare X forward.


### Initialise Git Submodules

Initialises and updates the repository submodules (for example [ArtistIC](https://github.com/pulp-platform/artistic) in `flow/artistic/`):

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

Every testbench pulls in a FET `.save` file through its `SAVE` code block (for example `.include tinywhisper_top_tb_tran.save`). That file lists the operating-point parameters of every transistor (`ids`, `gm`, `gds`, `vth` and so on), which the `annotate_fet_params` symbols and the `Annotate OP` launcher read back from the raw file. The include uses the bare file name, so it resolves inside `testbenches/xschem/simulations/`, where ngspice runs. Both `sim-gl-xschem` and the schematic's `Simulate` launcher write the file on every run, so it always matches the devices currently in the schematic and a fresh clone needs no manual export. Xschem's **IHP > Create FET .save file** menu entry writes the same file by hand.

The simulation runs in **batch mode**: the target netlists the testbench with `xschem netlist` and then invokes `ngspice -b` directly instead of using `xschem simulate`. `xschem simulate` would spawn an interactive ngspice in a terminal detached from `make`: the target would return immediately, the result would never be checked, and the process (with its X server) would leak. Running the simulator directly makes `make` block until the run finishes and see its exit status.

Because the run is headless, the `plot` commands in a testbench's `.control` block are a no-op and no plot windows appear. Every testbench instead exports its results with `wrdata` to `testbenches/xschem/plot_simulations/data/`, from where they are plotted with `sim-view-xschem`.

> [!NOTE]
> `sim-gl-xschem` is part of `sim-all`, but it may take a long time depending on the hardware used.

To plot the Xschem simulation results, use `sim-view-xschem`. It runs a plotting script from `testbenches/xschem/plot_simulations/` (`SIM_PLOT_DIR`), selected with the `SCRIPT` variable, given without the `.py` extension (default: `plot_<CELL>`), and reproduces the plots of the testbench's `.control` block with matplotlib from the exported data in `plot_simulations/data/`:

```sh
make sim-view-xschem                      # run the default plotting script (plot_<CELL>)
make sim-view-xschem SCRIPT=<scriptname>  # run another plotting script
```

The target runs `SHOW_PLOTS=1 python3 testbenches/xschem/plot_simulations/$(SCRIPT).py`. Every script writes its figures to `testbenches/xschem/plot_simulations/figures/`. Run through `sim-view-xschem`, the script additionally opens the plot windows when a display is available (e.g. the container's X/VNC session). Headless, only the figures are written.

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

Renders the final top-level GDS `layout/tinywhisper_top_logo_fill.gds.gz` (with logo and filler) with `sak-render.py` from the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS):

```sh
make render-gds
```

Three images are written to the `render/img/` folder:

- `tinywhisper_top_white.png` and `tinywhisper_top_black.png`: all physical mask layers, on a white and on a black background.
- `tinywhisper_top_black_TM2.png`: only `TopMetal2`, `TopVia2`, the `TopMetal2` filler and `Passiv` on a black background, which shows the chip logo and the padframe.

All three images are 2048 px wide and rendered with 4x oversampling. `sak-render.py` reads the layer colours from the PDK's own KLayout layer properties and crops to the drawn geometry, so the images have no border margin.

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

For each digital macro this dispatches to its in-tree `make all`, which runs the macro's full flow: lint, build (FPGA and LibreLane, including netlists), verify (DRC and LVS within the LibreLane flow) and simulate. The simulations run after the build, so the gate-level simulations run on the netlists produced by this build.

The FPGA part of that build emulates the macro on a [pico-ice](https://pico-ice.tinyvision.ai/) board (Lattice iCE40UP5K). The flow is split into a board-independent part and one folder per board, selected with `BOARD=`, so a further board is one folder with its `Makefile` and pin constraints. See [macros/riscv/fpga/README.md](macros/riscv/fpga/README.md) for the pin assignment, the toolchain notes, and how to add one.

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

Internally this executes (in order): `librelane-nodrc` -> `copy-reports` -> `copy-gds` -> `copy-netlist` -> `copy-render` -> `add-logo-fill` -> `render-gds`.

> [!NOTE]
> `build-top` runs `librelane-nodrc` instead of `librelane` for the same reason the DRC reports are not copied: IHP's `metal1_pin_offgrid` rule trips on the pad ring (see [IHP-Open-PDK#683](https://github.com/IHP-GmbH/IHP-Open-PDK/issues/683#issuecomment-4065791975)).
> Once it is fixed upstream, `Makefile :: build-top` switches back to `librelane`.


### Build All

To initialise submodules, build the bondpad, build the logos, build the macros, and run the full `build-top` flow, run:

```sh
make build-all
```

> [!NOTE]
> The `make build-all` target does **not** currently call `make build-macros`: the RISC-V CPU is built with nix-shell and the top-level with the `next` IIC-OSIC-TOOLS release (see the TODO in the [Makefile](Makefile)).
> To build specific macros, use `make build-riscv`, `make build-iqmod`, or `make build-macros` to build all enabled macros separately.

This is useful if you want to rebuild the chip from scratch. Clone the repository, enter the IIC-OSIC-TOOLS environment, and run `make build-all`.


### Add Logo and Fill

To add the TinyWhisper logo (PNG -> GDS) and the fill structures on top of the LibreLane output (so the final GDS in `layout/` includes the artwork), run:

```sh
make add-logo-fill
```

This calls `scripts/add_logo_fill.sh` and writes `layout/tinywhisper_top_logo_fill.gds.gz`. The step is also called from `make build-top`.

> [!NOTE]
> In the future, it is planned to replace this script and Makefile target with a custom LibreLane step.


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
| Density (full-chip fill) | – | – | ✓ |
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


### Build Xschem PEX Symbol

Builds the Xschem symbol the PEX flow needs, `schematic/xschem/<CELL>_pex.sym`, from the regular cell symbol `schematic/xschem/<CELL>.sym`:

```sh
make symbol-pex                  # build tinywhisper_top_pex.sym from tinywhisper_top.sym
make symbol-pex CELL=<cellname>  # build the PEX symbol of another cell
```

The generated symbol is a verbatim copy of `<CELL>.sym` with a single change: `type=subcircuit` becomes `type=primitive`. Everything else (pin boxes and their order, `format`, `spectre_format`, `template`, graphics) is inherited, which is exactly what the PEX flow needs:

- **`type=primitive`** stops Xschem from descending into a schematic of the same name. There is no `<CELL>_pex.sch`, so the instance line is emitted as it stands and the subcircuit comes from the `.include`d PEX netlist instead.
- **`format="@name @pinlist @symname"`** makes the instance reference `@symname`, which resolves to `<CELL>_pex`, exactly the `.subckt` name the PEX flow writes.
- **The pin order** is what `sak-pin-reorder.py` reorders the extracted netlist to, so it has to be that of the cell symbol.

`symbol-pex` runs automatically at the start of `klayout-pex` and `magic-pex`, so the symbol is rebuilt from the current `<CELL>.sym` before every extraction and cannot go stale when a pin is added, removed or renamed. Calling it by hand is only needed to refresh the symbol without re-running an extraction. Anything added to the generated file by hand is lost at the next extraction, so make the change in `<CELL>.sym` instead.

If `<CELL>.sym` does not exist, the target prints a note and does nothing, which leaves the PEX targets running without a pin reorder just as before. It fails only when `<CELL>.sym` declares neither `type=subcircuit` nor `type=primitive`.

The cell symbol `<CELL>.sym` that this one is derived from is a hand-drawn source file at the chip top-level, because its pins are the pad ring and their placement is part of the drawing. The digital macro has two further targets for its own cell symbol, `symbol-gl` to scaffold one from the ports of a freshly hardened design and `symbol-check` to verify it on every build, see [Build the Xschem Symbol](macros/riscv/README.md#build-the-xschem-symbol). They are macro targets only: they key on the `sim_pinname` property that the gate-level XSPICE flow needs, and `tinywhisper_top.sym` neither carries it nor has an XSPICE model to match.

> [!NOTE]
> Every symbol in this project also carries `spectre_format="@name ( @pinlist ) @symname"`. Xschem writes that line itself whenever a symbol is built from a schematic's pin list (key `a`, `make_sym.awk`), and it is read **only** by the Spectre netlister, which is also the one that drives VACASK (`xschem.tcl` configures `vacask "$N"` as the default simulator for `netlist_type spectre`). The SPICE netlister used for ngspice ignores it, so it has no effect on any target in this Makefile.
> Do not strip it: without it, instances of the symbol are **silently dropped** from a Spectre/VACASK netlist and the `subckt` line of the symbol itself comes out with an empty port list, with no warning at all.


### Parasitic Extraction (PEX)

Runs parasitic extraction on the GDS layout in `layout/`. The extracted SPICE netlist is written to `netlist/pex/`.

The extracted SPICE filenames include the selected extraction mode:
- `klayout-pex` writes `netlist/pex/<CELL>_klayout_pex_<EXT_MODE>.spice`
- `magic-pex` writes `netlist/pex/<CELL>_magic_pex_<EXT_MODE>.spice`

The `EXT_MODE` parameter selects the extraction mode:
- `1` = C-decoupled
- `2` = C-coupled
- `3` = full-RC (default)

> [!NOTE]
> For `klayout-pex`, `EXT_MODE=1` (C-decoupled) is not yet supported by kpex and automatically falls back to `EXT_MODE=2` (C-coupled) with a warning.

The `.subckt` name in the extracted SPICE file is `<CELL>_pex`: `magic-pex` sets it directly via the `sak-pex.sh` option `-n <CELL>_pex`, while for `klayout-pex` it is automatically renamed from `<CELL>` (kpex).

Both targets start by running `symbol-pex` (see above), so `schematic/xschem/<CELL>_pex.sym` always reflects the current cell symbol. The `.subckt` pin order in the extracted SPICE file is then reordered with `sak-pin-reorder.py` (installed in the IIC-OSIC-TOOLS container) to match that symbol's pin positions. This ensures the PEX netlist can be used directly with the corresponding Xschem symbol for simulation regardless of the selected `EXT_MODE`.

Both targets finish by running [`scripts/check_pex_ports.py`](scripts/check_pex_ports.py) on the netlist they just wrote. It verifies that every pin of the `.subckt` really reaches the circuit, and fails the target otherwise. Two cases are caught:

- A port that is declared in the `.subckt` line but referenced by no element at all. Whatever is wired to that pin from outside is then left floating.
- A port whose net was split into `<port>.t<n>` and `<port>.n<n>` fragments by `extresist` (`EXT_MODE=3`), where none of the fragments is connected back to the port. The pin is then dangling even though the fragments themselves are wired up.

Both produce a netlist that ngspice reads without a single warning while the cell behaves completely differently in simulation, so the check is worth the two seconds it costs. It can also be run by hand on any SPICE netlist:

```sh
python3 scripts/check_pex_ports.py netlist/pex/tinywhisper_top_magic_pex_3.spice
python3 scripts/check_pex_ports.py -v netlist/pex/*.spice     # -v also prints the size of each subcircuit
```

**KLayout PEX** currently uses `kpex` with the Magic extraction engine (the 2.5D engine is work in progress):

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

1. **`THRESHOLD`** (`-t`, in mOhm, default `10000` = 10 Ohm) decides **which nets are extracted at all**. Before doing any real work, Magic makes a quick end-to-end resistance guess for every net. The guess is deliberately pessimistic: it is an absolute worst case. Nets that stay below `THRESHOLD` even in that worst case cannot matter, so they are treated as ideal wires and skipped. This is the cheap first pass that removes the many short, low-resistance nets.
2. **`MINDELAY`** (`-y`, in ps, default `1`) decides **which of the extracted nets are kept**. Because the guess above overestimates, Magic re-checks each net once it has been properly extracted and discards its resistor network again if the RC delay it adds stays below `MINDELAY`. Setting `MINDELAY=0` switches the delay criterion off and applies `THRESHOLD` a second time instead, now against the accurately extracted resistance rather than the initial guess.
3. **`MINRES`** (`-r`, in mOhm, default `1000` = 1 Ohm) decides **how detailed the kept networks are**. Inside a net, neighbouring resistors below `MINRES` are merged as far as possible, which shrinks the network without changing its overall resistance much.

In short: `THRESHOLD` and `MINDELAY` control *how many* nets carry parasitic resistance, while `MINRES` controls *how finely* each of them is modelled. Raising all three gives a smaller netlist that simulates faster with less detail. Lowering them gives a more accurate but considerably larger one.

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
- `render/img/tinywhisper_top_black_TM2.png` -> `release/v.<VERSION>/img/tinywhisper_top_black_TM2.png`
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
- Exactly **one** Xschem testbench (`iqmod_mfb_lpf_tb_ac_cl`) and **one** CACE parameter set (the AC VDD sweep `ac_params` of `iqmod_mfb_lpf.yaml`, no Monte Carlo) are run. Swap `ac_params` for `ac_mc_params` / `ac_mm_params` in the target to also exercise the Monte Carlo flow.
- In the default `regression` the riscv macro is **not re-hardened**: `librelane-magicdrc` (the full RTL-to-GDS of the CPU, ≈2 h wall clock), the flows that depend on its fresh outputs (`copy-final`, the gate-level cocotb simulation `sim-gl-cocotb` with ≈12 min for the full suite, `generate-xspice`, which is called for consistency with the template but skips itself while the riscv RTL carries its stock settings, and the gate-level Xschem simulation `sim-gl-xschem`) and the Icarus RTL testbench (`sim-rtl-verilog`) only run in `regression-nightly` (`NIGHTLY_REGRESSION=1`). In the default variant the riscv macro is covered at RTL (lint + cocotb, which also exercises Icarus as its simulator), and the LibreLane flow itself is still exercised by the chip top-level `librelane-nodrc` run. A fast gate-level smoke run of a single test (≈20 s) is available via `COCOTB_TEST_FILTER=test_cpu_fibonacci_fast make sim-gl-cocotb`.

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
| Magic LEF export + LIB + Verilog stub + `sak-render.py` render | iqmod `build-top` |
| Verilator lint | riscv `lint-verilog-all` |
| cocotb (RTL, Icarus as simulator) | riscv `sim-rtl-cocotb` |
| LibreLane (OpenROAD / Yosys / KLayout streamout / Netgen LVS) | chip `librelane-nodrc` |

The following flows are only covered by `regression-nightly`:

| Tool / flow | Target (in `macros/riscv/`) |
| --- | --- |
| Icarus Verilog with the plain SystemVerilog testbench | `sim-rtl-verilog` |
| LibreLane macro hardening + Magic sign-off DRC (≈2 h) | `librelane-magicdrc` + `copy-final` |
| cocotb gate-level | `sim-gl-cocotb` (manual smoke run: `COCOTB_TEST_FILTER=test_cpu_fibonacci_fast make sim-gl-cocotb`) |
| `verilog2sym.py` (Xschem symbol check) + `spi2xspice.py` + `sak-pin-reorder.py` (XSPICE model) | `generate-xspice`, **skipped by its guard** while `macros/riscv/rtl/memory.sv` carries its stock settings, so these three are only exercised when the model is regenerated on purpose |
| Xschem gate-level (ngspice + xspice) | `sim-gl-xschem` |

The FPGA flow (Yosys + nextpnr-ice40 + icepack, riscv `build-fpga`) is not part of either regression variant and must be run manually.


### Clean

`make clean` deletes everything the chip top-level targets generate. The sources stay untouched: the RTL, the schematics, symbols and testbenches, the scripts, the LibreLane and packaging configurations, the custom top-level LVS flow in [`verification/lvs/`](verification/lvs/) (its scripts, reference netlists and `lvs.out`), the EUROPRACTICE package library `packaging/layout/EP_PACKAGES_08022018.gds`, and `render/blender/`. Deleted are:

- `flow/librelane/runs/` and `flow/final/` (LibreLane run directories and the saved views)
- `layout/` (`tinywhisper_top.gds.gz` and `tinywhisper_top_logo_fill.gds.gz`)
- `netlist/` (schematic, layout, PEX, PnL, NL and SPICE netlists)
- `render/img/` (the chip renders)
- `verification/drc/`, `verification/reports/` and the per-cell `klayout-lvs` and `magic-lvs` run folders in `verification/lvs/`
- `schematic/xschem/simulations/`, `testbenches/xschem/simulations/` and the `plot_simulations/` outputs (`data/`, `figures/`, `__pycache__/`)
- `testbenches/cocotb/sim_build/` and the `__pycache__` folders under `scripts/`, `packaging/scripts/` and `testbenches/cocotb/`
- the bondplan outputs in `packaging/` (`render/`, `result.md`, and in `layout/` the generated `tinywhisper_bondplan.gds`, `tinywhisper_top_logo_TM2.gds.gz` and the extracted package footprint `OP_QFN48_A4_FIT.gds`)

The macros under [`macros/`](macros/) and the IPs under [`ip/`](ip/) are left alone. `make clean-all` runs `clean` here and then `make clean` in every IP and macro:

```sh
make clean        # chip top-level only
make clean-all    # chip top-level, IPs and macros
```

[`release/`](release/) is never deleted, so published versions survive a clean. Every target recreates the folders it writes to, so a full rebuild from a clean tree is:

```sh
make clean-all
make all
```

> [!WARNING]
> Most of these outputs are committed in this repository, so `make clean` leaves a large deletion set in `git status`. Run `git restore .` to get the tracked ones back if you did not mean to remove them. The LibreLane run directories under `flow/librelane/runs/` are **not** tracked and cannot be restored that way.

> [!NOTE]
> The chip top-level testbenches include the riscv XSPICE model `macros/riscv/netlist/xspice/riscv_top.xspice`. `clean-all` keeps it on purpose: it is a committed source file that no target regenerates from the committed RTL, so neither `make build-riscv` nor `make all` could bring it back. If it is lost anyway, restore it with `git restore ihp130/macros/riscv/netlist/xspice` before `make sim-gl-xschem`, otherwise the include fails.
