# Top-Level LVS Reports

Run folders of the top-level LVS, written by `make klayout-lvs` (`<CELL>.klayout.lvs/`) and by `make magic-lvs` (`<CELL>.magic.lvs/`) for `CELL=tinywhisper_top` or `CELL=tinywhisper_top_logo_fill`. Each folder is wiped at the start of its run, so it always reflects the latest run only.

- `<CELL>.lvs.summary`: the verdict of `scripts/lvs_top.py check`, the circuit pairs and device counts, and every circuit that did not match.
- KLayout: `<CELL>.lvsdb`, to open in the KLayout netlist browser together with the GDS, and the extracted netlist `<CELL>_extracted.cir`, neither committed (the database has 190 to 300 MB).
- Magic + Netgen: the Netgen report `<CELL>.lvs.out`, the setup Netgen ran with (`netgen_setup_<CELL>.tcl`) and the extracted netlist `<CELL>.ext.spc`, which is not committed.

See [Top-Level Layout Versus Schematic (LVS)](../../README.md#top-level-layout-versus-schematic-lvs) in the top-level README.
