# Extracted Layout Netlists

The top-level LVS keeps the layout netlists it extracts from the GDS in its run folders in `verification/lvs/` (`<CELL>.klayout.lvs/<CELL>_extracted.cir`, `<CELL>.magic.lvs/<CELL>.ext.spc`) and does not commit them: every run rewrites them, 5 to 8 MB each, and the KLayout database next to them takes 190 to 300 MB. `make klayout-lvs` and `make magic-lvs` write them again.

See [Top-Level Layout Versus Schematic (LVS)](../../README.md#top-level-layout-versus-schematic-lvs) in the top-level README.
