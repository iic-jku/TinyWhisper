# Schematic Netlists

Reference netlists of the top-level LVS, built by `scripts/lvs_top.py` from the netlists listed in `flow/lvs/config.yaml`.

They are written by `make klayout-lvs-netlist` (CDL, `<CELL>_klayout.cdl`) and by `make magic-lvs-netlist` (SPICE, `<CELL>_magic.spice`) for `CELL=tinywhisper_top` or `CELL=tinywhisper_top_logo_fill`. Both targets also run as the first step of `make klayout-lvs` and `make magic-lvs`. The header of each netlist lists its inputs with their MD5 and every change made to them.

See [Top-Level Layout Versus Schematic (LVS)](../../README.md#top-level-layout-versus-schematic-lvs) in the top-level README.
