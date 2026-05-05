# ihp-sg13g2 IQ-Modulator

> [!IMPORTANT]
> This repository requires the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container with tag `2026.05` or later.

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
│  │  ├─ iqmod_top_pex.spice
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
│  │  │  *.magic.drc.rpt
│  │  │  *_full.lyrdb
│  │  │  iqmod_top.magic.drc.rpt
│  │  └─ iqmod_top.klay_iqmod_top_full.lyrdb
│  └─ 📁 lvs/
│     ├─ *.lvsdb
│     └─ iqmod_top.lvsdb
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
make <target> [CELL=<cellname>] [EXT_MODE=<1|2|3>] [EV_PRECISION=<digits>]
```


## Layout File Extension Usage

The Makefile defines a `_GDS_EXT` variable that auto-selects the layout file extension: it prefers `.gds` when available, and falls back to `.klay.gds` otherwise.

- KLayout targets use `layout/<name>.$(_GDS_EXT)` and work with either `.gds` or `.klay.gds`:
  - `klayout-lvs`
  - `klayout-drc`
  - `klayout-pex`

- Magic targets always use `layout/<name>.gds` (Magic requires standard `.gds`):
  - `magic-lvs`
  - `magic-drc`
  - `magic-pex`

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


## CACE Simulations

Runs [CACE](https://github.com/fossi-foundation/cace) characterization simulations for the LPF and OTA core, collecting result plots into `verification/cace/results/`. Each CACE YAML
- `iqmod_mfb_lpf.yaml` — characterization of the 3rd-order MFB low-pass filter
- `iqmod_mfb_lpf_ota_core.yaml` — characterization of the inverter-based OTA core
is invoked with its AC parameter sets (mismatch, Monte Carlo, corner sweep), the generated plots are copied, and temporary run artifacts are cleaned up:

```sh
make sim-cace
```

Result plots are saved to:
- `verification/cace/results/iqmod_mfb_lpf/` — closed-loop gain, CMRR, and unity-gain frequency plots
- `verification/cace/results/iqmod_mfb_lpf_ota_core/` — open-loop gain, CMRR, and unity-gain frequency plots


## Simulate All

Runs all simulations:

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

Generates a Verilog stub (`final/vh/<TOP>.v`) for top-level integration into the LibreLane flow. The pin names are hardcoded and all ports are declared as `inout`. After writing the stub, the target performs a bidirectional check against the PEX netlist (`netlist/pex/<TOP>_pex.spice`) to ensure both pin sets match:

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

Currently, KLayout LVS extracts `ntap` and `ptap` devices, so the schematic netlist must include them as well. In contrast, Magic + Netgen LVS does not extract `ntap` and `ptap`. Therefore, the schematic uses `lvs_ignore = short` for these devices and conditional net labels (see [xschem#474](https://github.com/StefanSchippers/xschem/issues/474)). To make this effective during schematic netlist export, `set lvs_ignore 1` must be set in the `magic-lvs-netlist` target.

KLayout uses CDL netlists, while Magic uses SPICE netlists. Accordingly, `klayout-lvs-netlist` uses the Xschem commands `set spiceprefix 1`, `set lvs_netlist 1`, `set top_is_subckt 1`, and `set lvs_ignore 0`. In contrast, `magic-lvs-netlist` uses `set spiceprefix 1`, `set lvs_netlist 0`, `set top_is_subckt 1`, and `set lvs_ignore 1`.

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

Exports the schematic netlist from Xschem, then runs LVS. Compares the layout in `layout/` against the schematic netlist in `netlist/schematic/`.

- `klayout-lvs` uses `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`)
- `magic-lvs` uses `layout/<CELL>.gds` (Magic requires `.gds`)

Reports are saved to `verification/lvs/`. The extracted layout netlist is moved to `netlist/layout/`.

**KLayout LVS** uses `run_lvs.py` from the IHP Open-PDK:

```sh
make klayout-lvs
make klayout-lvs CELL=iqmod_top
```

**Magic + Netgen LVS** uses `sak-lvs.sh`:

```sh
make magic-lvs
make magic-lvs CELL=iqmod_top
```


## Design Rule Check (DRC)

Runs DRC on the layout in `layout/`.

- `klayout-drc` uses `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`)
- `magic-drc` uses `layout/<CELL>.gds` (Magic requires `.gds`)

Reports are saved to `verification/drc/`.

**KLayout DRC** uses `run_drc.py` from the IHP Open-PDK with relaxed rules (FEOL, density checks, and extra rules disabled):

```sh
make klayout-drc
make klayout-drc CELL=iqmod_top
```

**Magic DRC** uses `sak-drc.sh`:

```sh
make magic-drc
make magic-drc CELL=iqmod_top
```


## Parasitic Extraction (PEX)

Runs parasitic extraction on the layout in `layout/`. The extracted SPICE netlist is written to `netlist/pex/`.

- `klayout-pex` uses `layout/<CELL>.$(_GDS_EXT)` (`.gds` if present, otherwise `.klay.gds`)
- `magic-pex` uses `layout/<CELL>.gds` (Magic requires `.gds`)

The `EXT_MODE` parameter selects the extraction mode:
- `1` = C-decoupled
- `2` = C-coupled
- `3` = full-RC (default)

> **Note:** For `klayout-pex`, `EXT_MODE=1` (C-decoupled) is not yet supported by kpex and automatically falls back to `EXT_MODE=2` (CC) with a warning.

The `.subckt` name in the extracted SPICE file is automatically renamed from `<CELL>_flat` (kpex) or `<CELL>` (Magic) to `<CELL>_pex`.

If a matching Xschem symbol (`schematic/<CELL>_pex.sym`) exists, the `.subckt` pin order in the extracted SPICE file is automatically reordered to match the symbol's pin positions. This ensures the PEX netlist can be used directly with the corresponding Xschem symbol for simulation.

**KLayout PEX** uses `kpex` with the Magic extraction engine currently (2.5D engine is work in progress):

```sh
make klayout-pex
make klayout-pex CELL=iqmod_top
make klayout-pex CELL=iqmod_top EXT_MODE=3
```

**Magic PEX** uses `sak-pex.sh`:

```sh
make magic-pex
make magic-pex CELL=iqmod_top
make magic-pex CELL=iqmod_top EXT_MODE=3
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
