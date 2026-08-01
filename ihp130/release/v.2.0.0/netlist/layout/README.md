# Extracted Layout Netlists

Layout netlists of `tinywhisper_top`, extracted from the GDS during LVS.

They are written by `make klayout-lvs` (`tinywhisper_top_klayout.cir`) and by `make magic-lvs` (`tinywhisper_top_magic.ext.spc`), which move the extracted netlist here out of the LVS run folder in `verification/lvs/`. The committed `tinywhisper_top.spice` is the extracted netlist of the custom top-level LVS flow in [`verification/lvs/`](../../verification/lvs/).

See [Layout Versus Schematic (LVS)](../../README.md#layout-versus-schematic-lvs--design-rule-check-drc) in the top-level README.
