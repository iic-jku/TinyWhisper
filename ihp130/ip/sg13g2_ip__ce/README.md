# sg13g2_ip__ce

A logo IP block for [Julius-Maximilians-Universität Würzburg, Computer Engineering](https://www.informatik.uni-wuerzburg.de/ce/), rendered as a GDSII layout on `Metal5` with `NoMetFiller` for the IHP SG13G2 130 nm CMOS process.

## Directory Structure

```
sg13g2_ip__ce/
├── Makefile                # Build automation
├── image/
│   └── ce_logo.png         # Source PNG image
├── script/
│   └── make_gds.py         # PNG-to-GDS converter
├── gds/
│   └── sg13g2_ip__ce.gds   # Generated GDSII layout
├── lef/
│   └── sg13g2_ip__ce.lef   # LEF macro for place-and-route
├── lib/
│   └── sg13g2_ip__ce.lib   # Liberty timing stub
├── vh/
│   └── sg13g2_ip__ce.v     # Verilog blackbox stub
└── reports/                # DRC report
```

## Usage

Build everything (clean, generate logo GDS, LEF, Liberty, Verilog, run DRC):

```bash
make all
```

### Individual Targets

| Target    | Description                                              |
|-----------|----------------------------------------------------------|
| `logo`    | Convert PNG to GDSII using `make_gds.py`                 |
| `lef`     | Generate LEF macro (CLASS BLOCK, Metal5 OBS)             |
| `lib`     | Generate Liberty timing stub (empty cell)                |
| `verilog` | Generate Verilog blackbox stub (no ports)                |
| `drc`     | Run IHP DRC checks using `run_drc.py`                    |
| `clean`   | Remove all generated output directories                  |

### Parameters

The following Makefile variables can be overridden:

| Variable      | Default  | Description                                                                 |
|---------------|----------|-----------------------------------------------------------------------------|
| `IMG_SIZE_PX` | `750`    | Source image width/height in pixels                                         |
| `BLOCK_SIZE`  | `143.25` | Desired physical block size in µm                                           |
| `PIXEL_SIZE`  | `0.25`   | Pixel size in µm (must be ≥ M5 min width of 0.21 µm to avoid DRC violations)|

The image scale factor is computed automatically.

## Logo Generator Script

The `script/make_gds.py` script converts a PNG image into a GDSII layout:

- Each dark pixel becomes a rectangle on the `Metal5` layer (67/0)
- Boundary layers 189/0 and 160/0 mark the block outline
- `--invert` inverts the image (dark ↔ light)
- `--merge` merges adjacent rectangles to reduce polygon count
- `--pixel-size` sets the physical size of each pixel in µm
- `--scale` downscales the image before conversion

## DRC Notes

The DRC target uses `run_drc.py` from the IHP PDK with the following flags:

- `--no_feol` — skip front-end-of-line rules (no active devices)
- `--no_density` — skip metal density rules (evaluated at chip level)
- `--disable_extra_rules` — skip fill/auxiliary rules

No `--antenna` flag is needed since there are no connected pins.
