# Top-Level LVS

Custom top-level LVS flow of `tinywhisper_top`, plus the per-cell LVS run folders written by `make klayout-lvs` (`tinywhisper_top.klayout.lvs/`) and `make magic-lvs` (`tinywhisper_top.magic.lvs/`).

The custom flow extracts a SPICE netlist from the released GDS and compares it hierarchically against the schematic netlists with Netgen:

| File | Purpose |
|------|---------|
| `run_lvs.sh` | Main entry point: GDS extraction + Netgen LVS of the whole chip |
| `run_lvs_se2diff.sh` | LVS variant for the single-ended-to-differential mixer cells |
| `gds2spice.sh` | Extract a SPICE netlist from the GDS with Magic |
| `merge_spice.py` | Merge the macro netlists (`riscv_top.spice`, `iqmod_top.spice`) into the top-level netlist |
| `normalize_analog.py` | Normalize analog device parameters before comparison |
| `check_floating_nets.py` | Report floating nets in the extracted netlist |
| `remove_dollar1.sh` | Strip `$1` suffixes Magic appends to some net names |
| `sg13g2_io.spi`, `sg13g2_stdcell.spice` | IO cell and standard-cell reference netlists |
| `lvs.out` | Netgen result of the last full run |
