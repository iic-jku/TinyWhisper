# ihp-sg13g2 IQ-Modulator

<p align="center">
  <a href="render/img/iqmod_top_white.png">
    <img src="render/img/iqmod_top_white.png" alt="Render of the ihp-sg13g2 IQ modulator layout (337um x 142um)" width=70%>
  </a>
  <br>
  <em>Render of the ihp-sg13g2 IQ modulator layout (337um x 142um).</em>
</p>


## Directory Structure

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
│     └─ iqmod_top.v
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
│  │  ├─ iqmod_top_magic_pex_*.spice
│  │  └─ reorder_spice_pins.py
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
│  ├─ *.sch
│  ├─ *.sym
│  ├─ iqmod_mfb_lpf.sch
│  ├─ iqmod_mfb_lpf.sym
│  ├─ iqmod_mfb_lpf_pex.sym
│  ├─ iqmod_mfb_lpf_ota_core_hybrid_bm.sch
│  ├─ iqmod_mfb_lpf_ota_core_hybrid_bm.sym
│  ├─ iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym
│  ├─ iqmod_mixer.sch
│  ├─ iqmod_mixer.sym
│  ├─ iqmod_mixer_pex.sym
│  ├─ iqmod_mixer_se2diff.sch
│  ├─ iqmod_mixer_se2diff.sym
│  ├─ iqmod_mixer_se2diff_pex.sym
│  ├─ iqmod_mixer_tg.sch
│  ├─ iqmod_mixer_tg.sym
│  ├─ iqmod_mixer_tg_pex.sym
│  ├─ iqmod_top.sch
│  ├─ iqmod_top.sym
│  ├─ iqmod_top_pex.sym
│  └─ xschemrc
├─ 📁 scripts/
│  ├─ 📁 filter_designer/
│  │  ├─ 📁 figures/
│  │  ├─ 3rd_order_mfb_lpf_designer.mcdx
│  │  ├─ 3rd_order_mfb_lpf_designer.py
│  │  └─ biquad_mfb_lpf_designer.py
│  ├─ 📁 plot_simulations/
│  │  ├─ 📁 data/
│  │  ├─ 📁 figures/
│  │  ├─ ngspice2python.py
│  │  ├─ plot_dsm_sine.py
│  │  ├─ plot_iqmod_mfb_lpf.py
│  │  └─ plot_iqmod_mfb_lpf_riscv.py
│  ├─ 📁 pwm_generator/
│  │  ├─ 📁 data/
│  │  └─ pwm_generator.py
│  ├─ 📁 sizing/
│  │  ├─ 📁 figures/
│  │  ├─ lookup_commands.ipynb
│  │  ├─ sizing_inverter_based_ota_barthelemy.ipynb
│  │  ├─ sizing_inverter_based_ota_hybrid_bm.ipynb
│  │  ├─ sizing_inverter_based_ota_hybrid_bn.ipynb
│  │  ├─ sizing_inverter_based_ota_manfredini.ipynb
│  │  └─ sizing_inverter_based_ota_nauta.ipynb
│  └─ lay2img.py
├─ 📁 testbenches/
│  ├─ *_tb_*.sch
│  ├─ iqmod_mfb_lpf_ota_core_tb_ac_ol.sch
│  ├─ iqmod_mfb_lpf_riscv_tb_tran.sch
│  ├─ iqmod_mfb_lpf_tb_ac_cl.sch
│  ├─ iqmod_mixer_se2diff_tb_tran.sch
│  ├─ iqmod_mixer_tb_tran.sch
│  ├─ iqmod_mixer_tg_tb_tran.sch
│  ├─ iqmod_top_tb_ac.sch
│  ├─ iqmod_top_tb_tran.sch
│  └─ xschemrc
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


## Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```

For the `sim-xschem` target, `TB=<testbenchname>` is required.

All targets that operate on a specific cell accept an optional `CELL=<cellname>` parameter. The default is the top-level cell (`iqmod_top`).

```sh
make <target> [CELL=<cellname>] [EXT_MODE=<1|2|3>] [THRESHOLD=<mOhm>] [MINRES=<mOhm>] [MINDELAY=<ps>] [DRC_LEVEL=<precheck|macro|regular>] [EV_PRECISION=<digits>]
```


## Layout File Extension Usage

The Makefile defines a `_GDS_EXT` variable that auto-selects the layout file extension: it prefers `.gds` when available, and falls back to `.klay.gds` otherwise.

- All LVS, DRC and PEX targets use `layout/<name>.$(_GDS_EXT)` and work with either `.gds` or `.klay.gds`:
  - `klayout-lvs`, `magic-lvs`
  - `klayout-drc`, `magic-drc`
  - `klayout-pex`, `magic-pex`

- Build targets always use `layout/<name>.gds`:
  - `lef`
  - `copy-gds`
  - `render-gds`


## Run Xschem Testbench Simulation

Runs a single Xschem testbench in batch mode (no display): saves the schematic, exports the netlist to `testbenches/simulations/`, and runs the simulator. The testbench name **must** be specified via the `TB` variable:

```sh
make sim-xschem TB=<testbenchname>
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

All available testbench schematics are located in `testbenches/`. Generated netlists are written to `testbenches/simulations/`.


## Plot Xschem Simulation Results

Plots simulation results using a macro-specific plotting script in `scripts/plot_simulations/`:

```sh
make sim-plot-xschem CELL=<cellname>
```

For example:

```sh
make sim-plot-xschem CELL=iqmod_mfb_lpf
```


## CACE Simulations

Runs [CACE](https://github.com/fossi-foundation/cace) characterization simulations for the LPF and OTA core, collecting result plots into `verification/cace/results/`. Each CACE YAML
- `iqmod_mfb_lpf.yaml` — characterization of the 3rd-order MFB low-pass filter
- `iqmod_mfb_lpf_ota_core.yaml` — characterization of the inverter-based OTA core
is invoked with its AC parameter sets (`ac_mm_params`, `ac_mc_params`, and `ac_params`), the generated plots are copied, and temporary run artifacts are cleaned up:

```sh
make sim-cace
```

Result plots are saved to:
- `verification/cace/results/iqmod_mfb_lpf/` — closed-loop gain, CMRR, and unity-gain frequency plots
- `verification/cace/results/iqmod_mfb_lpf_ota_core/` — open-loop gain, CMRR, and unity-gain frequency plots


## Simulate All

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
> The `sim-plot-xschem` target is intentionally **not** called by `sim-all`.
> It opens the generated Python figures, which blocks the shell until the window is closed.
> They are designed for interactive use and must be called manually after the simulation has completed.

Run with:

```sh
make sim-all
```

## Build Top Cell

Builds the top-level cell deliverables in sequence: LEF export, LIB generation, Verilog stub generation, GDS copy, and layout image rendering:

```sh
make build-top
```


## Export LEF

Exports a LEF file (`final/lef/<TOP>.lef`) from the top-level layout GDS in `layout/` using Magic with the `-hide` option:

```sh
make lef
```


## Liberty Timing Library

Generates a Liberty timing library stub (`final/lib/<TOP>.lib`) with default threshold settings for the top-level cell:

```sh
make lib
```


## Verilog Stub

Generates a Verilog stub (`final/vh/<TOP>.v`) for top-level integration into the LibreLane flow by parsing pins from the Magic PEX netlist (`netlist/pex/<TOP>_magic_pex.spice`).

The `verilog` target:
- requires `netlist/pex/<TOP>_magic_pex.spice` (run `make magic-pex` first)
- reads the `.subckt <TOP>_pex` pin list (including continuation lines)
- emits recognized supply pins (`VDD`, `VSS`, `VPWR`, `VGND`, `VNB`, `VPB`) as `inout` under `` `ifdef USE_POWER_PINS ``
- classifies signal pins by prefix: `di_*` as `input`, `do_*` as `output`, others as `inout`

```sh
make verilog
```


## Copy GDS

Copies the top-level GDS from `layout/` to `final/gds/`:

```sh
make copy-gds
```


## Render Layout Image

Renders the top-level layout GDS using `lay2img.py` and saves the image to `render/img/`:

```sh
make render-gds
```


## Export Schematic Netlist for LVS

Exports the schematic netlist for LVS from Xschem and places it in `netlist/schematic/`.

The `EV_PRECISION` parameter sets the number of significant digits used by Xschem's `ev` function when calculating device properties (default: 5). Increase this to avoid LVS mismatches caused by floating-point rounding differences between Xschem and KLayout (see [xschem#465](https://github.com/StefanSchippers/xschem/issues/465)).

The `ntap` and `ptap` substrate contacts are ignored during LVS in both flows. `sak-lvs.sh` runs KLayout LVS with the `--disable_tap_extraction` option so it does not extract `ntap` and `ptap` devices from the layout (matching Magic + Netgen LVS). The schematic uses `lvs_ignore = short` for these devices and conditional net labels (see [xschem#474](https://github.com/StefanSchippers/xschem/issues/474)), which takes effect during schematic netlist export via `set lvs_ignore 1`.

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


## Layout Versus Schematic (LVS)

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


## Design Rule Check (DRC)

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


## Parasitic Extraction (PEX)

Runs parasitic extraction on the layout in `layout/`. The extracted SPICE netlist is written to `netlist/pex/`. Both `klayout-pex` and `magic-pex` use `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`).

The extracted SPICE filenames include the selected extraction mode:
- `klayout-pex` writes `netlist/pex/<CELL>_klayout_pex_<EXT_MODE>.spice`
- `magic-pex` writes `netlist/pex/<CELL>_magic_pex_<EXT_MODE>.spice`

The `EXT_MODE` parameter selects the extraction mode:
- `1` = C-decoupled
- `2` = C-coupled
- `3` = full-RC (default)

> **Note:** For `klayout-pex`, `EXT_MODE=1` (C-decoupled) is not yet supported by kpex and automatically falls back to `EXT_MODE=2` (CC) with a warning.

The `.subckt` name in the extracted SPICE file is `<CELL>_pex`: `magic-pex` sets it directly via the `sak-pex.sh` option `-n <CELL>_pex`, while for `klayout-pex` it is automatically renamed from `<CELL>_flat` (kpex).

If a matching Xschem symbol (`schematic/<CELL>_pex.sym`) exists, the `.subckt` pin order in the extracted SPICE file is automatically reordered to match the symbol's pin positions. This ensures the PEX netlist can be used directly with the corresponding Xschem symbol for simulation regardless of the selected `EXT_MODE`.

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

For full-RC extraction (`EXT_MODE=3`), `magic-pex` additionally exposes the `sak-pex.sh` `extresist` tuning parameters. They are ignored in `EXT_MODE=1`/`2`:

- `THRESHOLD` - extresist threshold in mOhm (`-t`, default `10000` = 10 Ohm)
- `MINRES` - extresist minimum resistance in mOhm (`-r`, default `1000` = 1 Ohm)
- `MINDELAY` - extresist minimum delay in ps (`-y`, default `1`; `0` = gate by resistance)

```sh
make magic-pex CELL=iqmod_top EXT_MODE=3 THRESHOLD=5000 MINRES=500 MINDELAY=2
```


## Verify with KLayout

**Verify a single cell** by running LVS, DRC, and PEX in sequence:

```sh
make klayout-verify
make klayout-verify CELL=iqmod_mixer
```

**Verify all cells** (`iqmod_mfb_lpf`, `iqmod_mixer`, `iqmod_top`):

```sh
make klayout-verify-all
```


## Verify with Magic

**Verify a single cell** by running LVS, DRC, and PEX in sequence:

```sh
make magic-verify
make magic-verify CELL=iqmod_mixer
```

**Verify all cells** (`iqmod_mfb_lpf`, `iqmod_mixer`, `iqmod_top`):

```sh
make magic-verify-all
```


## Build All

Runs the full flow in sequence: simulations, top-level build deliverables, and all verification steps (`sim-all`, `build-top`, `klayout-verify-all`, `magic-verify-all`):

```sh
make all
```
