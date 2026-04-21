# bondpad_70x70

A 70 µm × 70 µm square bondpad for the IHP SG13G2 130 nm CMOS process, generated using the KLayout PCell engine and the `SG13_dev` library.

## Directory Structure

```
bondpad_70x70/
├── Makefile                # Build automation
├── script/
│   └── bondpad.py          # KLayout PCell-based bondpad generator
├── gds/
│   └── bondpad_70x70.gds   # Generated GDSII layout
├── lef/
│   └── bondpad_70x70.lef   # LEF macro for place-and-route
├── vh/
│   └── bondpad_70x70.v     # Verilog blackbox stub
└── reports/                # DRC report
```

## Usage

Build everything (clean, generate bondpad, generate Verilog, run DRC):

```s
make all
```

### Individual Targets

| Target    | Description                                  |
| --------- | -------------------------------------------- |
| `bondpad` | Generate GDS and LEF via `bondpad.py`        |
| `verilog` | Generate Verilog blackbox stub (`inout pad`) |
| `drc`     | Run IHP DRC checks using `run_drc.py`        |
| `clean`   | Remove all generated output directories      |

### Parameters

The following Makefile variables can be overridden:

| Variable   | Default  | Description                        |
| ---------- | -------- | ---------------------------------- |
| `DIAMETER` | `70.0`   | Bondpad diameter/side length in µm |
| `SHAPE`    | `square` | Bondpad shape (`square`/`octagon`/`circle`)  |

Example — generate a octagon 70 µm bondpad:

```bash
make bondpad DIAMETER=70.0 SHAPE=octagon
```

## Bondpad Generator Script

The `script/bondpad.py` script runs in KLayout batch mode. It:

1. Instantiates the `bondpad` PCell from the `SG13_dev` library
2. Flattens the PCell into a static layout
3. Exports the layout as GDSII
4. Generates a matching LEF file (with `pad` pin on Metal2–TopMetal2 and metal obstruction layers)

The metal stack used for the bondpad covers Metal2 through TopMetal2, with the `bottom_metal` parameter set to index 1 (Metal2) by default.

## DRC Notes

The DRC target uses `run_drc.py` from the IHP PDK with the following flags:

- `--antenna` — enable antenna rule checks
- `--no_feol` — skip front-end-of-line rules (no active devices in a bondpad)
- `--no_density` — skip metal density rules (evaluated at chip level)
- `--disable_extra_rules` — skip fill/auxiliary rules