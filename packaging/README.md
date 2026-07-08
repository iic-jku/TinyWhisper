# Packaging

## Automated Bondplan Generation

The bondplan (die placed in the package cavity + all bondwires + pin table)
is generated fully automatically by [scripts/run_bondplan.py](scripts/run_bondplan.py), driven by [config.yaml](config.yaml). The config is structured like a LibreLane `config.yaml`: flat `UPPER_CASE` keys, `dir::` paths relative to the config file, and placement as `location` / `orientation`. No new config style to learn.

### Requirements

- KLayout Python module (`pya`) and PyYAML. Both available out of the box in the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container.
- The die GDS with `Passiv` pad openings and pad name labels (`TopMetal2.text`), e.g. the LibreLane output `ihp130/layout/tinywhisper_top_logo_fill.gds.gz`.
- A package GDS containing the lead frame polygons and pin number texts (here: the EUROPRACTICE QFN48 drawing, cell `OP_QFN48`).

### Quick Start

```bash
cd packaging
python3 scripts/run_bondplan.py config.yaml
# or: klayout -b -r scripts/run_bondplan.py -rd config=config.yaml
```

### Folder Structure

| Path | Content |
|---|---|
| `config.yaml` | flow configuration incl. the full pinout |
| `scripts/run_bondplan.py` | the flow (plain Python, KLayout `pya` API) |
| `layout/` | package GDS (input) + generated bondplan / die-extract GDS |
| `render/` | generated PNG / SVG images and the CSV bond table |

### How the Flow Works

1. **Extract** — reads the die layout GDS with a layer map so only `DIE_EXTRACT_LAYERS` (Passiv, TopVia2, TopMetal2) are loaded and writes the lightweight die view `DIE_EXTRACT_GDS` (top cell renamed to `DIE_EXTRACT_CELL`).
2. **Detect die pads** — merged `Passiv` (9/0) openings larger than `DIE_PAD_MIN_SIZE` are the bondpads. Their names come from the `TopMetal2.text` (134/25) labels placed on the pad centers by LibreLane. No LEF file is needed.
3. **Analyze the package** — inside `PACKAGE_FOOTPRINT_CELL` the lead polygons (210/0) and the pin number texts (211/0) are read. Each pin number is matched to its nearest lead. The bond point lies on the ray from the package center through the lead (`BONDWIRE_LEAD_SITE`: 0 = lead tip, 1 = outer end). The package *inner border* (the square touching the lead tips) is derived from the lead geometry.
4. **Place the die** — `DIE_PLACEMENT.location` is the lower-left corner of the (oriented) die outline relative to the lower-left corner of the inner border. Omit it to center the die. `orientation` accepts the LibreLane/DEF values `N/S/E/W/FN/FS/FE/FW`.
5. **Draw the bondwires** — `PINOUT` maps each package pin to a die pad name. Wires are `BONDWIRE_WIDTH` wide paths on `BONDWIRE_LAYER` (`Exchange0.drawing - 190/0`, a documentation-only layer, nothing in the PDK consumes it). A bond table (`pin pad`) is written on `BONDWIRE_TEXT_LAYER` next to the plan, and the package pin numbers are regenerated centered on their lead axes (`PACKAGE_PIN_LABEL_OFFSET`).
6. **Check & export** — wire lengths (`BONDWIRE_MAX_LENGTH`), wire crossings and the minimum wire-to-wire gap are checked and reported. Outputs: bondplan GDS, CSV bond table (`BONDPLAN_REPORT`) and zero-border PNG / SVG images in `_white` / `_black` variants (following `ihp130/scripts/lay2img.py`).

### Pinout Format

```yaml
PINOUT:
  1:  "clk_PAD"                 # pin 1 -> die pad labeled clk_PAD
  7:  "IOVDD"                   # duplicate names (VDD/VSS/...) are
  8:  "VDD"                     #   resolved by shortest-wire assignment
  16: ["VSS", "VSS"]            # a list = several wires to one lead
  17: ~                         # ~ (null) = NC pin
  EPAD: ["VSS", "IOVSS"]        # downbonds to the exposed pad (GND);
                                #   drawn parallel to neighboring wires
```

Unlisted pins are reported as NC. Unbonded named pads are reported too, so a forgotten connection is visible in the log.

### Options Overview

Every key has a sensible default. A minimal config only needs `DIE_GDS`, `DIE_EXTRACT_LAYERS`, `DIE_EXTRACT_GDS`, `PACKAGE_GDS`, `BONDPLAN_GDS` and `PINOUT`. The most useful knobs:

| Key (default) | Effect |
|---|---|
| `DIE_CELL` / `PACKAGE_CELL` (top cell) | select cells explicitly |
| `PACKAGE_FOOTPRINT_CELL` (= `PACKAGE_CELL`) | cell with the clean lead/pin geometry, if the package GDS is a drawing sheet |
| `DIE_PAD_MIN_SIZE` (40 um) | Passiv openings smaller than this are ignored |
| `DIE_PLACEMENT` (centered, N) | die position/orientation in the cavity |
| `BONDWIRE_WIDTH` (30 um) | drawn wire width |
| `BONDWIRE_LEAD_SITE` (0.5) | where wires land on the lead (0 = tip, 1 = outer end) |
| `BONDWIRE_MAX_LENGTH` (3500 um) | length check threshold |
| `EPAD_WIRE_LENGTH` (500 um) | length of exposed-pad downbond stubs |
| `PACKAGE_PIN_LABEL_OFFSET` (250 um) | pin number distance beyond the lead end |
| `BONDPLAN_DELETE_LAYERS` ([]) | layers stripped from the output GDS (e.g. drawing frame) |
| `BONDPLAN_PNG` / `BONDPLAN_SVG` (off) | image export targets |
| `IMAGE_WIDTH` (2000 px), `IMAGE_OVERSAMPLING` (2) | image quality |
| `IMAGE_REGION` (`package`) | `package` = footprint + bond table, `full` = everything |

### Porting to another Package / Chip

The flow is not TinyWhisper-specific. For a different chip or package you need: a die GDS with labeled `Passiv` pad openings, a package GDS whose footprint cell contains one lead polygon per pin plus numeric pin texts, and an updated `PINOUT`. Everything else (pad/lead detection, inner border, placement, checks, rendering) is derived from the geometry.

## Bonding Diagram

<p align="center">
  <a href="../doc/fig/tinywhisper_bondplan.png">
    <img src="../doc/fig/tinywhisper_bondplan.png" alt="Bonding diagram of the ihp-sg13cmos TinyWhisper ASIC" width=70%>
  </a>
  <br>
  <em>Bonding diagram of the ihp-sg13cmos TinyWhisper ASIC.</em>
</p>

## Useful Links

- SERMA: https://www.serma-microelectronics.com/en/
- factronix: https://www.factronix.com/
- Plastic Open-Pak Packages, Open-molded Plastic Package (OmPP): https://www.qptechnologies.com/products/ompp/
- EUROPRACTICE - ASIC Packaging - Overview: https://europractice-ic.com/services/packaging/asic-packaging/
- EUROPRACTICE - ASIC Packaging - DRC: https://europractice-ic.com/wp-content/uploads/2020/06/ASIC_Prototype_Packaging_Design_Rules_2024.pdf
- EUROPRACTICE - ASIC Packaging - QFN-48: https://europractice-ic.com/wp-content/uploads/2019/06/MLP7X7-48-OP-02-R2-ECN-10501.pdf
- EUROPRACTICE - ASIC Packaging - GDS: https://europractice-ic.com/wp-content/uploads/2019/07/EP_PACKAGES_08022018.gds_.gz
- Take the DXF file from here: https://www.mirrorsemi.com/OpenChip.html and use https://www.artwork.com/gdsii/asm3500/windows/interface.htm to get the GDS file.