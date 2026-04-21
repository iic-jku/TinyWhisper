# Important Lessons Learned on March 2026 IHP Tapeout

Harald Pretl, 2026-03-30

## First Rule of Tapeout

The first rule of tapeout is: **No tapeout without toplevel LVS on transistorlevel!**

## Metal Fill Density

The distance of the metal fill structure can be set when performing the fill. The default setting might lead to too low density, depending on specific layout constellation. After fill, check the densities. If they are good, proceed. If density fails, repeat the fill with changes distance settings, until the density is met.

## Zero-Length Paths Fails MPW-precheck

If there are zero-length paths in the layout (which should not be there in the first place) then the IHP MPW-precheck fails silently. This is hard to debug. We need a check in the future to scan a layout for this (the DRC is not reporting this as very, as this are essentially non-existing layout structures).

## Trial Run Early, Trial Run Often

The different DRC runsets (KLayout, Magic, IHP MPW-precheck) differ and are generally unstable. When getting closer to tapeout, run trial runs early, as soon as there are a few cells available. This catches potential issues early and leaves time for debug (which can be a lengthy procedure).

## LibreLane Supply Connections

LibreLane only knows what is in the DEF file, not the full GDS content of a cell. This can lead to double, slightly misaligned vias when connecting the supply grid (and potentially other lines). Be careful to include the relevant details in the DEF used for layout assembly.

## Be Careful When Doing Manual Layout Adaptions

Late before tapeout some manual layout fixes might be required. This is an error-prone and dangerous procedure. In order to check these layout manipulations, there is script `gds_xor.py` which compares two GDS files and writes the difference into another GDS file. Check this result carefully for unintended changes.

## KLayout DRC Pre-Check

The DRC pre-check can be easily run from commandline with:
```
python3 $PDK_ROOT/$PDK/libs.tech/klayout/tech/drc/run_drc.py --precheck_drc --mp=64 --no_offgrid --density_thr=64 --no_angle --disable_extra_rules --no_recommended --path=SoC4219.gds.gz
```

## Be Finished Before Tapeout Day

On tapeout day, hell breaks loose. Everyone and their neighbor trie to get their chip to the tapeout, which means all online services are overloaded, and run times explode. This is not a good spot to be in, so be finished ahead of the deadline. There is also no time to ask back questions if need be. The last few days before tapeout are only for verification simulations.
