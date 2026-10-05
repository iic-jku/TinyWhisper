# Repository conventions

Guidance for coding agents and contributors working in this repo (TinyWhisper, a mixed-signal short-wave transmitter chip in IHP SG13G2).

## Reference template

The chip in `ihp130/` follows the structure and tooling of the template https://github.com/iic-jku/ihp-sg13g2-ams-chip-template, and its tutorial (https://iic-jku.github.io/ihp-sg13g2-ams-chip-template/index.html) explains the folder layout and the Makefiles.
When adding or reorganizing a macro, mirror the template layout and its per-macro `Makefile`.

## Environment

- Run every flow inside the IIC-OSIC-TOOLS container (https://github.com/iic-jku/IIC-OSIC-TOOLS), tag `2026.09` or later (`README.md`). CI uses `hpretl/iic-osic-tools:latest`.
- The PDK is `ihp-sg13g2`. `.designinit` exports `PDK` and the related variables, and `sak-pdk ihp-sg13g2` switches a running shell.
- The chip, macro and IP Makefiles check `$PDK` when they are parsed: every target except `help` and the clean targets aborts if it is not `ihp-sg13g2`. Fix the PDK instead of passing `REQUIRED_PDK=`.
- After cloning, run `make init-submodules` in `ihp130/`. It fetches `ihp130/flow/artistic` (ArtistIC) and the two submodules under `software/c_toolchain/`.

## Repository layout

| Path | Contents |
| --- | --- |
| `ihp130/` | The chip: `Makefile`, `README.md` (documents every target), `rtl/` (pad ring `tinywhisper_top.sv`, `tinywhisper_core.sv`), `flow/librelane/`, `layout/`, `netlist/`, `schematic/xschem/`, `testbenches/`, `verification/`, `packaging/` (bondplan), `release/v.<version>/` |
| `ihp130/macros/<name>/` | One macro per folder: `riscv` (digital), `iqmod` (analog), `coupled_resonator_lc_bpf` (schematic-only). `ihp130/macros/README.md` compares them. |
| `ihp130/ip/<name>/` | Bondpad and logo blocks, each with `Makefile` and `README.md`, plus the third-party pad cells in `sg13g2_io_custom/` |
| `software/` | C toolchain for the RISC-V core and the Python WSPR reference (`software/README.md`) |
| `doc/` | Quarto documentation site |
| `sky130/` | Legacy sky130 test chip, kept for reference and not maintained |
| `pcb/`, `enclosure/`, `measurements/`, `presentations/` | Board, enclosure, lab and talk material |

Inside a macro, folders exist only where the macro kind needs them:

| Folder | Contents |
| --- | --- |
| `rtl/` | SystemVerilog and Verilog sources, `constants.sv` (riscv) |
| `schematic/xschem/`, `layout/` | Schematics and symbols, hand-drawn GDS (iqmod) |
| `testbenches/cocotb/<cell>/`, `testbenches/verilog/<cell>/`, `testbenches/xschem/` | cocotb runners `<cell>_tb.py`, Icarus testbenches, Xschem testbenches with `plot_simulations/` |
| `netlist/` | `nl`, `pnl`, `spice`, `xspice` (riscv) or `schematic`, `layout`, `pex` (iqmod) |
| `flow/librelane/`, `final/` | LibreLane config and SDC, and the views the chip integrates (`gds`, `lef`, `lib`, `vh`, plus `nl`, `pnl`, `spef` for riscv) |
| `verification/` | Flow reports, DRC and LVS run folders, CACE datasheets (iqmod) |
| `scripts/`, `render/`, `fpga/` | Helper scripts, renders, FPGA emulation (riscv) |

## Makefiles

- `ihp130/`, every macro and every bondpad or logo IP has its own `Makefile` and `README.md`. The `README.md` documents each target. Read it before changing a flow.
- Each of these Makefiles sets `.DEFAULT_GOAL := help`, and `make help` lists every target from its `## ` comment. Give every new target a `## ` comment.
- Variables are set with `?=` and overridden on the command line, for example `CELL=<cell>`, `TB=<testbench>`, `EXT_MODE=<1|2|3>`, `WAVEFORM_VIEWER=surfer`.
- cocotb testbenches are self-contained Python runners (`cocotb_tools.runner.get_runner`). The targets run `python3 <cell>_tb.py` in the testbench folder, with `GL=1` for gate level. The exception is `macros/riscv/testbenches/cocotb/dsmod/`, which has its own `Makefile` that includes cocotb's `Makefile.sim`.
- Start a new macro with `make macro FROM=<macro> NAME=<name>` in `ihp130/macros/`, then follow "What Is Left to Do" in `ihp130/macros/README.md`.
- Each folder with schematics has its own `xschemrc`, and the targets pass it with `--rcfile`. See "Xschem Configuration" in `ihp130/README.md`.

## Build, simulate, verify

Run from `ihp130/`. These are the narrow targets for checking a change. The riscv LibreLane hardening alone takes about 2 h.

```sh
make help                                           # targets of the chip Makefile
make sim-rtl-cocotb                                 # chip RTL simulation (cocotb, Icarus)
make sim-gl-cocotb                                  # chip gate-level simulation
make -C macros/riscv lint-verilog-all               # Verilator lint of the riscv RTL
make -C macros/riscv sim-rtl-cocotb                 # riscv RTL simulation
make -C macros/iqmod sim-xschem TB=iqmod_mfb_lpf_tb_ac_cl   # one Xschem/ngspice testbench
make -C macros/iqmod klayout-verify CELL=iqmod_top  # KLayout DRC, LVS, PEX
make -C macros/iqmod magic-verify CELL=iqmod_top    # Magic DRC, Netgen LVS, Magic PEX
make build-top                                      # chip LibreLane run, copy-back, logo and fill, render
make regression                                     # tool/flow smoke test, reuses the committed riscv views
```

## CI

- `.github/workflows/license-check.yml` runs `reuse lint` on pushes and pull requests to `main`.
- `.github/workflows/regression.yml` runs `make regression-nightly` in `ihp130/` inside `hpretl/iic-osic-tools:latest`, nightly at 02:00 UTC if `main` has a commit from the last 25 h, and on manual dispatch. It is a tool/flow smoke test, not sign-off. "Regression" in `ihp130/README.md` lists what it covers.
- `.github/workflows/quarto-publish.yml` renders `doc/` and publishes it to `gh-pages` on every push to `main`.

## Design conventions

- Digital RTL lives in `ihp130/macros/riscv/rtl/` (mixed `.sv` and `.v`) and the chip top in `ihp130/rtl/`. The files do not share one naming scheme, so match the file you edit (`riscv_top.sv` uses `clk`, an active-low `reset` and `UPPER_SNAKE` parameters).
- Defines in use: `USE_POWER_PINS` (power ports for LibreLane), `FPGA` (FPGA build, set in `macros/riscv/fpga/fpga.mk`), `SIM` (Icarus runs, set by `sim-rtl-verilog` and the cocotb runners).
- Adding or removing a riscv RTL file means updating every source list: `MODULES_SYNTH` and `MODULES_SIM` in `macros/riscv/Makefile`, `VERILOG_FILES` in `macros/riscv/flow/librelane/config.yaml`, `DUT_SRCS` in `macros/riscv/fpga/dut.mk`, and the `sources` in `riscv_top_tb.py` and `ihp130/testbenches/cocotb/tinywhisper_top_tb.py`. `constants.sv` compiles first.
- Keep `make -C macros/riscv lint-verilog-all` clean. It runs `verilator --lint-only` and is part of the regression.
- Xschem testbenches run headless with `ngspice -b`, so `plot` commands in a `.control` block do nothing. Export results with `wrdata` to `testbenches/xschem/plot_simulations/data/` and plot them with a script in `plot_simulations/` (`make sim-view-xschem SCRIPT=<script>`).
- `<cell>_pex.sym` is regenerated from `<cell>.sym` before every extraction. Edit `<cell>.sym`, never the generated copy.

## Traps

- Most build outputs are committed (GDS, netlists, reports, renders, `final/` views). Targets overwrite them, and `make clean` and `make clean-all` delete them. Check `git status` after a run, commit only what the change needs, and `git restore` the rest.
- `make release` defaults to `VERSION=2.0.0` and overwrites the committed `ihp130/release/v.2.0.0/`. Never run it without an explicit new `VERSION`.
- `ihp130/macros/riscv/netlist/xspice/riscv_top.xspice` is a committed source that no target rebuilds from the stock RTL. `generate-xspice` skips itself while `freq_status[1:0] <= 2'b11;` is commented out in `rtl/memory.sv`. Leave that guard alone.
- `build-top` runs `librelane-nodrc` on purpose: IHP's `metal1_pin_offgrid` rule fails on the pad ring (TODO in `ihp130/Makefile`). Run DRC separately with `make magic-drc` or `make klayout-drc-regular`.
- `build-all` does not rebuild the macros. The chip integrates the committed views in `macros/riscv/final/` and `macros/iqmod/final/`.
- Third-party files keep their own license (see `REUSE.toml`): `ihp130/ip/sg13g2_io_custom/`, `ihp130/testbenches/xschem/models/`, the IHP cell netlists `sg13g2_io.spi` and `sg13g2_stdcell.spice` in `ihp130/verification/lvs/`, and the EUROPRACTICE package GDS in `ihp130/packaging/layout/`.

## License headers

The repo is licensed under the Solderpad Hardware License v2.1 (`LICENSE`), SPDX expression `Apache-2.0 WITH SHL-2.1`, and `reuse lint` must pass.

- Source files (RTL, C, Python, Makefiles, shell, Tcl, SDC, YAML, workflows) start with an SPDX header in their own comment syntax (`//` for SystemVerilog, Verilog and C, `#` otherwise), below the shebang if there is one:

  ```
  # SPDX-FileCopyrightText: 2026 The TinyWhisper Team
  # SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
  # Description: <one line>
  ```

- Team headers use `2026` or `2025-2026` as the year. The `Description:` line is what newer files carry (for example `ihp130/scripts/check_top_ports.py`). Do not paste the long Apache-2.0 boilerplate.
- Code derived from third-party sources keeps the original notice next to ours (`ihp130/macros/riscv/rtl/uart_tx.v`, `ihp130/flow/librelane/pdn_cfg.tcl`).
- Files without a header (Markdown, schematics, layouts, netlists, data, figures) are covered by path annotations in `REUSE.toml`. A new file without a header in a path no annotation covers fails `reuse lint`, so extend `REUSE.toml` in the same change.

## Writing style

These rules apply to documentation, code comments, commit messages, and pull request descriptions in this repo.

- No em-dashes, no double-hyphen dashes, and no semicolons in prose. Code is exempt. Use commas, colons, periods, or parentheses, and split long sentences instead.
- Plain, factual tone: numbers, paths, and verdicts over adjectives, no filler.
- Never hard-wrap prose at a fixed column. Put each sentence or paragraph on one line and let the editor wrap it. When editing, never reflow neighboring lines.
- Keep comments short and accurate: say what is non-obvious and why, never restate what the code already shows.
- Commits and pull requests carry no AI attribution: no `Co-Authored-By` trailers and no "generated with" lines for any coding agent.
