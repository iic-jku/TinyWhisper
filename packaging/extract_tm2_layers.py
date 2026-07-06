# Extracts the TM2 stack -- passive (9/0), TopVia2 (133/0) and TopMetal2
# (134/0) -- from the full logo-fill GDS and writes a compressed GDS for the
# bondplan. Run from the repo root in KLayout batch mode:
#   klayout -b -r packaging/extract_tm2_layers.py
import pya

infile  = "ihp130/layout/tinywhisper_top_logo_fill.gds.gz"
outfile = "packaging/tinywhisper_top_logo_TM2.gds.gz"

opt = pya.LoadLayoutOptions()
lm  = pya.LayerMap()
lm.map(pya.LayerInfo(9, 0),   0)   # passive.drawing
lm.map(pya.LayerInfo(133, 0), 1)   # TopVia2.drawing
lm.map(pya.LayerInfo(134, 0), 2)   # TopMetal2.drawing
# False => do NOT create any other layers found in the file
opt.set_layer_map(lm, False)

ly = pya.Layout()
ly.read(infile, opt)
ly.top_cell().name = "tinywhisper_top_logo_TM2"   # rename cell to match file
ly.write(outfile)
print("Wrote %s (top cell: %s)" % (outfile, ly.top_cell().name))
