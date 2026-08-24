# ihp-sg13g2 IQ-Modulator

<p align="center">
  <a href="render/img/iqmod_top_white.png">
    <img src="render/img/iqmod_top_white.png" alt="Render of the ihp-sg13g2 IQ modulator layout (337um x 142um)" width=70%>
  </a>
  <br>
  <em>Render of the ihp-sg13g2 IQ modulator layout (337um x 142um).</em>
</p>


## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 iqmod/
├─ 📁 final/
│  ├─ 📁 gds/
│  │  └─ iqmod_top.gds
│  ├─ 📁 lef/
│  │  └─ iqmod_top.lef
│  ├─ 📁 lib/
│  │  └─ iqmod_top.lib
│  └─ 📁 vh/
│     └─ iqmod_top.vh
├─ 📁 layout/
│  ├─ *.gds
│  ├─ *.klay.gds
│  ├─ iqmod_mfb_lpf.klay.gds
│  ├─ iqmod_mfb_lpf_ota_core_hybrid_bm.klay.gds
│  ├─ iqmod_mixer.klay.gds
│  ├─ iqmod_mixer_se2diff.klay.gds
│  ├─ iqmod_mixer_tg.gds
│  ├─ iqmod_top.gds
│  ├─ iqmod_top.klay.gds
│  └─ iqmod_top.klay.klib
├─ 📁 netlist/
│  ├─ 📁 layout/
│  │  ├─ *.cir
│  │  ├─ *.ext.spc
│  │  ├─ iqmod_top_klayout.cir
│  │  └─ iqmod_top_magic.ext.spc
│  ├─ 📁 pex/
│  │  ├─ *.spice
│  │  ├─ iqmod_top_klayout_pex_*.spice
│  │  └─ iqmod_top_magic_pex_*.spice
│  └─ 📁 schematic/
│     ├─ *.cdl
│     ├─ *.spice
│     ├─ iqmod_top_klayout.cdl
│     └─ iqmod_top_magic.spice
├─ 📁 render/
│  ├─ 📁 blender/
│  └─ 📁 img/
│     ├─ iqmod_top_black.png
│     └─ iqmod_top_white.png
├─ 📁 schematic/
│  └─ 📁 xschem/
│     ├─ *.sch
│     ├─ *.sym
│     ├─ iqmod_mfb_lpf.sch
│     ├─ iqmod_mfb_lpf.sym
│     ├─ iqmod_mfb_lpf_pex.sym
│     ├─ iqmod_mfb_lpf_ota_core_hybrid_bm.sch
│     ├─ iqmod_mfb_lpf_ota_core_hybrid_bm.sym
│     ├─ iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym
│     ├─ iqmod_mixer.sch
│     ├─ iqmod_mixer.sym
│     ├─ iqmod_mixer_pex.sym
│     ├─ iqmod_mixer_se2diff.sch
│     ├─ iqmod_mixer_se2diff.sym
│     ├─ iqmod_mixer_se2diff_pex.sym
│     ├─ iqmod_mixer_tg.sch
│     ├─ iqmod_mixer_tg.sym
│     ├─ iqmod_mixer_tg_pex.sym
│     ├─ iqmod_top.sch
│     ├─ iqmod_top.sym
│     ├─ iqmod_top_pex.sym
│     └─ xschemrc
├─ 📁 scripts/
│  ├─ check_pex_ports.py
│  ├─ 📁 filter_designer/
│  │  ├─ 📁 figures/
│  │  ├─ 3rd_order_mfb_lpf_designer.mcdx
│  │  ├─ 3rd_order_mfb_lpf_designer.py
│  │  └─ biquad_mfb_lpf_designer.py
│  ├─ 📁 pwm_generator/
│  │  ├─ 📁 data/
│  │  └─ pwm_generator.py
│  └─ 📁 sizing/
│     ├─ 📁 figures/
│     ├─ lookup_commands.ipynb
│     ├─ sizing_inverter_based_ota_barthelemy.ipynb
│     ├─ sizing_inverter_based_ota_hybrid_bm.ipynb
│     ├─ sizing_inverter_based_ota_hybrid_bn.ipynb
│     ├─ sizing_inverter_based_ota_manfredini.ipynb
│     └─ sizing_inverter_based_ota_nauta.ipynb
├─ 📁 testbenches/
│  └─ 📁 xschem/
│     ├─ 📁 plot_simulations/
│     │  ├─ 📁 data/
│     │  ├─ 📁 figures/
│     │  ├─ ngspice2python.py
│     │  ├─ plot_dsm_sine.py
│     │  ├─ plot_iqmod_mfb_lpf.py
│     │  └─ plot_iqmod_mfb_lpf_riscv.py
│     ├─ *_tb_*.sch
│     ├─ iqmod_mfb_lpf_ota_core_tb_ac_ol.sch
│     ├─ iqmod_mfb_lpf_riscv_tb_tran.sch
│     ├─ iqmod_mfb_lpf_tb_ac_cl.sch
│     ├─ iqmod_mixer_se2diff_tb_tran.sch
│     ├─ iqmod_mixer_tb_tran.sch
│     ├─ iqmod_mixer_tg_tb_tran.sch
│     ├─ iqmod_top_tb_ac.sch
│     ├─ iqmod_top_tb_tran.sch
│     └─ xschemrc
├─ 📁 verification/
│  ├─ 📁 cace/
│  │  ├─ 📁 results/
│  │  ├─ 📁 scripts/
│  │  ├─ 📁 templates/
│  │  ├─ iqmod_mfb_lpf.yaml
│  │  └─ iqmod_mfb_lpf_ota_core.yaml
│  ├─ 📁 drc/
│  │  ├─ 📁 *.klayout.drc/
│  │  ├─ 📁 *.magic.drc/
│  │  ├─ 📁 iqmod_top.klayout.drc/
│  │  └─ 📁 iqmod_top.magic.drc/
│  └─ 📁 lvs/
│     ├─ 📁 *.klayout.lvs/
│     ├─ 📁 *.magic.lvs/
│     ├─ 📁 iqmod_top.klayout.lvs/
│     └─ 📁 iqmod_top.magic.lvs/
├─ Makefile
└─ README.md
```

</details>


## Makefile Targets

### Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```

The `sim-xschem` target accepts an optional `TB=<testbenchname>` parameter (default: `<CELL>_tb_tran`), and `sim-view-xschem` an optional `SCRIPT=<scriptname>` parameter (default: `plot_<CELL>`).

All targets that operate on a specific cell accept an optional `CELL=<cellname>` parameter. The default is the top-level cell (`iqmod_top`).

```sh
make <target> [CELL=<cellname>] [EXT_MODE=<1|2|3>] [THRESHOLD=<mOhm>] [MINRES=<mOhm>] [MINDELAY=<ps>] [DRC_LEVEL=<precheck|macro|regular>] [EV_PRECISION=<digits>] [TB=<testbenchname>] [SCRIPT=<scriptname>] [OPEN_ARGS=<options>]
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

Schematics and symbols that belong to one design unit share a single tabbed Xschem instance instead of one process per click. The unit is the nearest ancestor holding a `Makefile`, so this macro gets its own instance and every tab writes its netlists to the folder this macro's `xschemrc` pins, see [Xschem Configuration](../../README.md#xschem-configuration).

The tree is rescanned every 15 s, so files a running flow produces appear on their own and are highlighted for a minute. Generated directories are skipped by default: `runs/`, `sim_build/`, `obj_dir/`, `simulations/`, `__pycache__/`, `_freeze/` and `.git/`. The Xschem `simulations/` folder is one of them, so the `.raw` files show up only with `--all`. Pass extra options with `OPEN_ARGS`:

```sh
make open OPEN_ARGS=--all              # include the build outputs
make open OPEN_ARGS="--prune backups"  # skip one more directory name
```

At most 400 buttons are drawn at once, because each one is an X window, and what is left out is stated at the end of the list. That cap is easy to hit with `--all`, which pulls in the CACE run directories and every simulation output of this macro. Narrow it with `--prune` when that happens.

> [!NOTE]
> This target needs a display. Run it inside the container's VNC/noVNC desktop or over X11 forwarding. In a shell-only container it stops with `cannot open a window`. The `.png` and `.pdf` buttons hand the file to the desktop's registered handler, so those two need the full VNC/noVNC session and do not work over a bare X forward.


### Layout File Extension Usage

The Makefile defines a `_GDS_EXT` variable that auto-selects the layout file extension: it prefers `.gds` when available, and falls back to `.klay.gds` otherwise.

- All DRC, LVS and PEX targets use `layout/<name>.$(_GDS_EXT)` and work with either `.gds` or `.klay.gds`:
  - `klayout-lvs`, `magic-lvs`
  - `klayout-drc`, `magic-drc`
  - `klayout-pex`, `magic-pex`

- Build targets always use `layout/<name>.gds`:
  - `lef`
  - `copy-gds`
  - `render-gds`


### Run Xschem Testbench Simulation

Runs a single Xschem testbench in batch mode (no display): saves the schematic, exports the netlist to `testbenches/xschem/simulations/`, and runs the simulator.

The target netlists the testbench with `xschem netlist` and then invokes `ngspice -b` directly instead of using `xschem simulate`. `xschem simulate` would spawn an interactive ngspice in a terminal detached from `make`: the target would return immediately, the result would never be checked, and the process (with its X server) would leak. Running the simulator directly makes `make` block until the run finishes and see its exit status.

Because the run is headless, the `plot` commands in a testbench's `.control` block are a no-op and no plot windows appear. Every testbench instead exports its results with `wrdata` to `testbenches/xschem/plot_simulations/data/`, from where they are plotted with `sim-view-xschem`.

The testbench is selected with the `TB` variable, given without the `.sch` extension (default: `<CELL>_tb_tran`):

```sh
make sim-xschem                     # run the default testbench (iqmod_top_tb_tran)
make sim-xschem TB=<testbenchname>  # run another testbench
```

For example:

```sh
make sim-xschem TB=iqmod_top_tb_tran
make sim-xschem TB=iqmod_top_tb_ac
make sim-xschem TB=iqmod_mfb_lpf_tb_ac_cl
make sim-xschem TB=iqmod_mfb_lpf_ota_core_tb_ac_ol
make sim-xschem TB=iqmod_mixer_se2diff_tb_tran
make sim-xschem TB=iqmod_mixer_tb_tran
```

All available testbench schematics are located in `testbenches/xschem/`. Generated netlists are written to `testbenches/xschem/simulations/`.

Every testbench pulls in a FET `.save` file through its `SAVE` code block (for example `.include iqmod_top_tb_tran.save`). That file lists the operating-point parameters of every transistor (`ids`, `gm`, `gds`, `vth` and so on), which the `annotate_fet_params` symbols and the `Annotate OP` launcher read back from the raw file. The include uses the bare file name, so it resolves inside `testbenches/xschem/simulations/`, where ngspice runs. Both `sim-xschem` and the schematic's `Simulate` launcher write the file on every run, so it always matches the devices currently in the schematic and a fresh clone needs no manual export. Xschem's **IHP > Create FET .save file** menu entry writes the same file by hand.


### Plot Xschem Simulation Results

Plots simulation results using a macro-specific plotting script in `testbenches/xschem/plot_simulations/`, selected by `SCRIPT`, given without the `.py` extension (default: `plot_<CELL>`):

```sh
make sim-view-xschem                      # run the default plotting script (plot_iqmod_top)
make sim-view-xschem SCRIPT=<scriptname>  # run another plotting script
```

The target runs `SHOW_PLOTS=1 python3 testbenches/xschem/plot_simulations/<SCRIPT>.py`. Every script writes its figures to `testbenches/xschem/plot_simulations/figures/`. Run through `sim-view-xschem`, the script additionally opens the plot windows when a display is available (e.g. the container's X/VNC session). Headless, only the figures are written.

For example:

```sh
make sim-view-xschem SCRIPT=plot_iqmod_mfb_lpf
```


### CACE Simulations

Runs [CACE](https://github.com/fossi-foundation/cace) characterization simulations for the LPF and OTA core, collecting result plots into `verification/cace/results/`. Each CACE YAML
- `iqmod_mfb_lpf.yaml`: characterization of the 3rd-order MFB low-pass filter
- `iqmod_mfb_lpf_ota_core.yaml`: characterization of the inverter-based OTA core
is invoked with its AC parameter sets (`ac_mm_params`, `ac_mc_params`, and `ac_params`), the generated plots are copied, and temporary run artifacts are cleaned up:

```sh
make sim-cace
```

Result plots are saved to:
- `verification/cace/results/iqmod_mfb_lpf/`: closed-loop gain, CMRR, and unity-gain frequency plots
- `verification/cace/results/iqmod_mfb_lpf_ota_core/`: open-loop gain, CMRR, and unity-gain frequency plots


### Simulate All

Runs the complete simulation flow in sequence:
- Xschem simulations for:
  - `iqmod_mfb_lpf_ota_core_tb_ac_ol`
  - `iqmod_mfb_lpf_tb_ac_cl`
  - `iqmod_mixer_se2diff_tb_tran`
  - `iqmod_mixer_tb_tran`
  - `iqmod_top_tb_ac`
  - `iqmod_top_tb_tran`
- CACE characterization via `sim-cace`

> [!NOTE]
> The `sim-view-xschem` target is intentionally **not** called by `sim-all`.
> It opens the generated Python figures, which blocks the shell until the window is closed.
> They are designed for interactive use and must be called manually after the simulation has completed.

Run with:

```sh
make sim-all
```

### Build Top Cell

Builds the top-level cell deliverables in sequence: LEF export, LIB generation, Verilog stub generation, GDS copy, and layout image rendering:

```sh
make build-top
```


### Export LEF

Exports a LEF file (`final/lef/<TOP>.lef`) from the top-level layout GDS in `layout/` using Magic with the `-hide` option:

```sh
make lef
```


### Liberty Timing Library

Generates a Liberty timing library stub (`final/lib/<TOP>.lib`) with default threshold settings for the top-level cell:

```sh
make lib
```


### Verilog Stub

Generates a Verilog stub (`final/vh/<TOP>.vh`) for top-level integration into the LibreLane flow by parsing pins from an extracted PEX netlist in `netlist/pex/`.

The `verilog` target:
- requires one of the following PEX files (run `make magic-pex` or `make klayout-pex` first):
  - `netlist/pex/<TOP>_magic_pex_1.spice`
  - `netlist/pex/<TOP>_magic_pex_2.spice`
  - `netlist/pex/<TOP>_magic_pex_3.spice`
  - `netlist/pex/<TOP>_klayout_pex_1.spice`
  - `netlist/pex/<TOP>_klayout_pex_2.spice`
  - `netlist/pex/<TOP>_klayout_pex_3.spice`
  - `netlist/pex/<TOP>_pex.spice` (the committed netlist of this macro)
- auto-selects the first existing file from the list above
- reads the `.subckt <TOP>_pex` pin list (including continuation lines)
- emits recognized supply pins (`VDD`, `VSS`, `VPWR`, `VGND`, `VNB`, `VPB`) as `inout` under `` `ifdef USE_POWER_PINS ``
- classifies signal pins by prefix: `di_*` as `input`, `do_*` as `output`, others as `inout`

```sh
make verilog
```


### Copy GDS

Copies the top-level GDS from `layout/` to `final/gds/`:

```sh
make copy-gds
```


### Render Layout Image

Renders the top-level layout GDS with `sak-render.py` from the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) and saves the two images `iqmod_top_black.png` and `iqmod_top_white.png` (2048 px wide, 4x oversampling) in `render/img/`:

```sh
make render-gds
```


### Design Rule Check (DRC)

Runs DRC on the layout in `layout/`. Both `klayout-drc` and `magic-drc` use `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`).

Both flows use `sak-drc.sh` and write their reports into per-cell run folders: `verification/drc/<CELL>.magic.drc/` (Magic) and `verification/drc/<CELL>.klayout.drc/` (KLayout, `.lyrdb`). The run folders are wiped at the start of each run, so they always reflect the latest run only.

The `DRC_LEVEL` parameter selects the KLayout DRC level (`sak-drc.sh -l`). It is ignored by `magic-drc`, since Magic has no selectable rule decks and always runs the full rule set compiled into the PDK's Magic tech file:

- `precheck` = core FEOL + BEOL manufacturing rules only (fast iteration)
- `macro` = block-in-isolation sign-off: `precheck` plus off-grid, zero-area, and pin/label checks (default)
- `regular` = full-chip sign-off: all checks, including density and antenna

**KLayout DRC** runs a KLayout DRC at the selected `DRC_LEVEL`:

```sh
make klayout-drc
make klayout-drc CELL=iqmod_top
make klayout-drc CELL=iqmod_top DRC_LEVEL=regular
```

**Magic DRC** runs a Magic DRC with all subcells flattened (`sak-drc.sh -f "*"`):

```sh
make magic-drc
make magic-drc CELL=iqmod_top
```


### Export Schematic Netlist for LVS

Exports the schematic netlist for LVS from Xschem and places it in `netlist/schematic/`.

The `EV_PRECISION` parameter sets the number of significant digits used by Xschem's `ev` function when calculating device properties (default: 5). Increase this to avoid LVS mismatches caused by floating-point rounding differences between Xschem and KLayout (see [xschem#465](https://github.com/StefanSchippers/xschem/issues/465)).

The `ntap` and `ptap` substrate contacts are ignored during LVS in both flows. `sak-lvs.sh` runs KLayout LVS with the `--disable_tap_extraction` option so it does not extract `ntap` and `ptap` devices from the layout (matching Magic + Netgen LVS). The iqmod schematics contain no `ntap`/`ptap` devices and no `nwell`/`psub` pins: the well and substrate nets are shorted directly to `VDD` and `VSS`, matching the tap-less extraction.

KLayout uses CDL netlists, while Magic uses SPICE netlists. Accordingly, `klayout-lvs-netlist` uses the Xschem commands `set spiceprefix 1`, `set lvs_netlist 1`, `set top_is_subckt 1`, and `set lvs_ignore 1`, while `magic-lvs-netlist` uses `set spiceprefix 1`, `set lvs_netlist 0`, `set top_is_subckt 1`, and `set lvs_ignore 1`. Hence, switching between CDL and SPICE netlists can be done with `lvs_netlist`.

To extract a CDL schematic netlist for KLayout LVS, use:
```sh
make klayout-lvs-netlist
make klayout-lvs-netlist CELL=iqmod_top
make klayout-lvs-netlist EV_PRECISION=5
```

To extract a SPICE schematic netlist for Magic + Netgen LVS, use:
```sh
make magic-lvs-netlist
make magic-lvs-netlist CELL=iqmod_top
make magic-lvs-netlist EV_PRECISION=5
```


### Layout Versus Schematic (LVS)

Exports the schematic netlist from Xschem, then runs LVS. Compares the layout in `layout/` against the schematic netlist in `netlist/schematic/`. Both `klayout-lvs` and `magic-lvs` use `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`).

Both flows use `sak-lvs.sh` and write their reports into per-cell run folders: `verification/lvs/<CELL>.magic.lvs/` (Magic + Netgen) and `verification/lvs/<CELL>.klayout.lvs/` (KLayout, `.lvsdb`). The run folders are wiped at the start of each run, so they always reflect the latest run only. The extracted layout netlist is moved to `netlist/layout/`.

**KLayout LVS** uses `sak-lvs.sh` (KLayout mode `-k`), which wraps `run_lvs.py` from the IHP Open-PDK:

```sh
make klayout-lvs
make klayout-lvs CELL=iqmod_top
```

**Magic + Netgen LVS** uses `sak-lvs.sh` (Magic + Netgen mode `-m`, the default), which extracts the layout netlist with Magic and compares it against the schematic netlist with Netgen, using the Netgen setup from the IHP Open-PDK:

```sh
make magic-lvs
make magic-lvs CELL=iqmod_top
```


### Build Xschem PEX Symbol

Builds the Xschem symbol the PEX flow needs, `schematic/xschem/<CELL>_pex.sym`, from the regular cell symbol `schematic/xschem/<CELL>.sym`:

```sh
make symbol-pex                  # build iqmod_top_pex.sym from iqmod_top.sym
make symbol-pex CELL=<cellname>  # build the PEX symbol of another cell
```

The generated symbol is a verbatim copy of `<CELL>.sym` with a single change: `type=subcircuit` becomes `type=primitive`. Everything else (pin boxes and their order, `format`, `spectre_format`, `template`, graphics) is inherited, which is exactly what the PEX flow needs:

- **`type=primitive`** stops Xschem from descending into a schematic of the same name. There is no `<CELL>_pex.sch`, so the instance line is emitted as it stands and the subcircuit comes from the `.include`d PEX netlist instead.
- **`format="@name @pinlist @symname"`** makes the instance reference `@symname`, which resolves to `<CELL>_pex`, exactly the `.subckt` name the PEX flow writes.
- **The pin order** is what `sak-pin-reorder.py` reorders the extracted netlist to, so it has to be the one of the cell symbol.

`symbol-pex` runs automatically at the start of `klayout-pex` and `magic-pex`, so the symbol is rebuilt from the current `<CELL>.sym` before every extraction and cannot go stale when a pin is added, removed or renamed. Calling it by hand is only needed to refresh the symbol without re-running an extraction. Anything added to the generated file by hand is lost at the next extraction, so make the change in `<CELL>.sym` instead.

If `<CELL>.sym` does not exist, the target prints a note and does nothing, which leaves the PEX targets running without a pin reorder just as before. It fails only when `<CELL>.sym` declares neither `type=subcircuit` nor `type=primitive`.

The committed `netlist/pex/<CELL>_pex.spice` netlists that the testbenches include were reordered against these generated symbols, so their `.subckt` pin order and the `_pex.sym` pin order agree.

> [!NOTE]
> Every symbol in this project also carries `spectre_format="@name ( @pinlist ) @symname"`. Xschem writes that line itself whenever a symbol is built from a schematic's pin list (key `a`, `make_sym.awk`), and it is read **only** by the Spectre netlister, which is also the one that drives VACASK (`xschem.tcl` configures `vacask "$N"` as the default simulator for `netlist_type spectre`). The SPICE netlister used for ngspice ignores it, so it has no effect on any target in this Makefile.
> Do not strip it: without it, instances of the symbol are **silently dropped** from a Spectre/VACASK netlist and the `subckt` line of the symbol itself comes out with an empty port list, with no warning at all.


### Parasitic Extraction (PEX)

Runs parasitic extraction on the layout in `layout/`. The extracted SPICE netlist is written to `netlist/pex/`. Both `klayout-pex` and `magic-pex` use `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`).

The extracted SPICE filenames include the selected extraction mode:
- `klayout-pex` writes `netlist/pex/<CELL>_klayout_pex_<EXT_MODE>.spice`
- `magic-pex` writes `netlist/pex/<CELL>_magic_pex_<EXT_MODE>.spice`

The `EXT_MODE` parameter selects the extraction mode:
- `1` = C-decoupled
- `2` = C-coupled
- `3` = full-RC (default)

> **Note:** For `klayout-pex`, `EXT_MODE=1` (C-decoupled) is not yet supported by kpex and automatically falls back to `EXT_MODE=2` (CC) with a warning.

The `.subckt` name in the extracted SPICE file is `<CELL>_pex`: `magic-pex` sets it directly via the `sak-pex.sh` option `-n <CELL>_pex`, while for `klayout-pex` it is automatically renamed from `<CELL>` (kpex).

Both targets start by running `symbol-pex` (see above), so `schematic/xschem/<CELL>_pex.sym` always reflects the current cell symbol. The `.subckt` pin order in the extracted SPICE file is then reordered with `sak-pin-reorder.py` (installed in the IIC-OSIC-TOOLS container) to match that symbol's pin positions. This ensures the PEX netlist can be used directly with the corresponding Xschem symbol for simulation regardless of the selected `EXT_MODE`.

Both targets finish by running [`scripts/check_pex_ports.py`](scripts/check_pex_ports.py) on the netlist they just wrote. It verifies that every pin of the `.subckt` really reaches the circuit, and fails the target otherwise. Two cases are caught:

- A port that is declared in the `.subckt` line but referenced by no element at all. Whatever is wired to that pin from outside is then left floating.
- A port whose net was split into `<port>.t<n>` and `<port>.n<n>` fragments by `extresist` (`EXT_MODE=3`), where none of the fragments is connected back to the port. The pin is then dangling even though the fragments themselves are wired up.

Both produce a netlist that ngspice reads without a single warning while the cell behaves completely differently in simulation, so the check is worth the two seconds it costs. It can also be run by hand on any SPICE netlist:

```sh
python3 scripts/check_pex_ports.py netlist/pex/iqmod_top_pex.spice
python3 scripts/check_pex_ports.py -v netlist/pex/*.spice     # -v also prints the size of each subcircuit
```

**KLayout PEX** uses `kpex` with the Magic extraction engine currently (2.5D engine is work in progress):

```sh
make klayout-pex
make klayout-pex CELL=iqmod_top
make klayout-pex CELL=iqmod_top EXT_MODE=3
```

**Magic PEX** uses `sak-pex.sh`, which extracts the parasitics with Magic (C-decoupled, C-coupled, or full-RC):

```sh
make magic-pex
make magic-pex CELL=iqmod_top
make magic-pex CELL=iqmod_top EXT_MODE=3
```

For full-RC extraction (`EXT_MODE=3`), `magic-pex` additionally exposes the three `extresist` tuning parameters of `sak-pex.sh`. They are ignored in `EXT_MODE=1`/`2`.

A full-RC extraction models every wire as a resistor network, and most of those wires are so short that their resistance does not matter. The three parameters are the filters Magic applies to keep only the part of the network that is worth having. They run in this order:

1. **`THRESHOLD`** (`-t`, in mOhm, default `10000` = 10 Ohm) decides **which nets are extracted at all**. Before doing any real work, Magic makes a quick end-to-end resistance guess for every net. The guess is deliberately pessimistic, it is an absolute worst case. Nets that stay below `THRESHOLD` even in that worst case cannot matter, so they are treated as ideal wires and skipped. This is the cheap first pass that removes the many short, low-resistance nets.
2. **`MINDELAY`** (`-y`, in ps, default `1`) decides **which of the extracted nets are kept**. Because the guess above overestimates, Magic re-checks each net once it has been properly extracted and discards its resistor network again if the RC delay it adds stays below `MINDELAY`. Setting `MINDELAY=0` switches the delay criterion off and applies `THRESHOLD` a second time instead, now against the accurately extracted resistance rather than the initial guess.
3. **`MINRES`** (`-r`, in mOhm, default `1000` = 1 Ohm) decides **how detailed the kept networks are**. Inside a net, neighbouring resistors below `MINRES` are merged as far as possible, which shrinks the network without changing its overall resistance much.

In short: `THRESHOLD` and `MINDELAY` control *how many* nets carry parasitic resistance, `MINRES` controls *how finely* each of them is modelled. Raising all three gives a smaller netlist that simulates faster with less detail, lowering them gives a more accurate but considerably larger one.

```sh
make magic-pex CELL=iqmod_top EXT_MODE=3 THRESHOLD=5000 MINRES=500 MINDELAY=2
```


### Verify with KLayout

**Verify a single cell** by running DRC, LVS, and PEX in sequence:

```sh
make klayout-verify
make klayout-verify CELL=iqmod_mixer
```

**Verify all cells** (`iqmod_mfb_lpf`, `iqmod_mixer`, `iqmod_top`):

```sh
make klayout-verify-all
```


### Verify with Magic

**Verify a single cell** by running DRC, LVS, and PEX in sequence:

```sh
make magic-verify
make magic-verify CELL=iqmod_mixer
```

**Verify all cells** (`iqmod_mfb_lpf`, `iqmod_mixer`, `iqmod_top`):

```sh
make magic-verify-all
```


### Verify, Build and Simulate All

Runs the full flow in sequence: KLayout verification, Magic verification, top-level build deliverables, and simulations (`klayout-verify-all`, `magic-verify-all`, `build-top`, `sim-all`):

```sh
make all
```

Verification runs first because DRC/LVS/PEX produce the fresh, pin-reordered PEX netlists from the current layout. The build follows, since the Verilog stub reads its pins from a PEX netlist. The simulations run **last**, so the testbenches include the PEX netlists produced by this run, not by a previous one.


### Clean

`make clean` deletes all generated files and folders. The sources stay untouched: the schematics, symbols and testbenches, the layout in `layout/`, the scripts, the CACE configuration and templates, and `render/blender/`. Deleted are:

- `final/` (GDS, LEF, Liberty and Verilog stub deliverables)
- `netlist/` (schematic, layout and PEX netlists)
- `render/img/` (the layout renders)
- `verification/drc/` and `verification/lvs/` (DRC and LVS reports)
- `schematic/xschem/simulations/`, `testbenches/xschem/simulations/` and the `plot_simulations/` outputs (`data/`, `figures/`, `__pycache__/`)
- the CACE outputs under `verification/cace/` (`_runs/`, `_docs/`, `netlist/`, `results/`, `templates/simulations/`)

Every target recreates the folders it writes to, so a clean rebuild is:

```sh
make clean
make all
```

> [!WARNING]
> Most of these outputs are committed in this repository, so `make clean` leaves a large deletion set in `git status`. Run `git restore .` to get them back if you did not mean to remove them.

> [!NOTE]
> Nearly every Xschem testbench `.include`s a PEX netlist from `netlist/pex/` (the committed `<cell>_pex.spice` files, which cover more cells than the three `*-verify-all` targets extract), and `make verilog` reads its pin list from one as well. After `make clean`, restore them with `git restore netlist/pex` or re-extract the cells you need with `make magic-pex CELL=<cellname>` before `make sim-xschem`, `make sim-all` or `make build-top`, otherwise the include fails. The system-level testbench `iqmod_mfb_lpf_riscv_tb_tran.sch` additionally needs the riscv XSPICE model, see [`macros/riscv/README.md`](../riscv/README.md).
