#!/usr/bin/env python3
# =============================================================================
# run_bondplan.py - automated bondplan generation
#
# Reads a LibreLane-style config.yaml and:
#   1. extracts the top-metal view (Passiv/TopVia2/TopMetal2 + pad labels)
#      from the top-level die GDS,
#   2. places it into the package GDS relative to the package inner border,
#   3. detects die bondpads (Passiv openings) and their names
#      (TopMetal2.text labels),
#   4. detects package leads and pin numbers from the package GDS,
#   5. draws bondwires (and exposed-pad downbonds) on Exchange0.drawing,
#   6. checks wire lengths / crossings / spacing and writes a CSV bond table.
#
# Usage:
#   python3 run_bondplan.py [config.yaml]
#   klayout -b -r run_bondplan.py -rd config=config.yaml
# =============================================================================

import sys
import os
import csv
import math

import yaml

try:
    import pya                      # KLayout batch mode or pymod on PYTHONPATH
except ImportError:
    import klayout.db as pya        # pip install klayout


# ---------------------------------------------------------------------------
# Config handling
# ---------------------------------------------------------------------------

DEFAULTS = {
    "DESIGN_NAME": "design",
    "DIE_CELL": None,               # default: top cell of DIE_GDS
    "DIE_EXTRACT_CELL": None,       # default: keep original cell name
    "DIE_KEEP_LABELS": True,
    "DIE_PAD_LAYER": "9/0",
    "DIE_PAD_MIN_SIZE": 40.0,
    "DIE_PAD_LABEL_LAYER": "134/25",
    "PACKAGE_CELL": None,           # default: top cell of PACKAGE_GDS
    "PACKAGE_FOOTPRINT_CELL": None, # default: PACKAGE_CELL
    "PACKAGE_LEAD_LAYER": "210/0",
    "PACKAGE_PIN_LABEL_LAYER": "211/0",
    "PACKAGE_PIN_LABEL_OFFSET": 250.0,  # um, pin number beyond its lead end
    "BONDWIRE_LAYER": "190/0",
    "BONDWIRE_TEXT_LAYER": "190/25",
    "BONDWIRE_WIDTH": 30.0,
    "BONDWIRE_LABELS": True,
    "BONDWIRE_LEAD_SITE": 0.5,
    "BONDWIRE_MAX_LENGTH": 3500.0,
    "EPAD_WIRE_LENGTH": 500.0,
    "BONDPLAN_CELL": "bondplan",
    "BONDPLAN_DELETE_LAYERS": [],
    "BONDPLAN_REPORT": None,
    "BONDPLAN_PNG": None,
    "BONDPLAN_SVG": None,
    "IMAGE_WIDTH": 2000,
    "IMAGE_OVERSAMPLING": 2,
    "IMAGE_REGION": "package",      # package | full
}

REQUIRED = ["DIE_GDS", "DIE_EXTRACT_LAYERS", "DIE_EXTRACT_GDS",
            "PACKAGE_GDS", "BONDPLAN_GDS", "PINOUT"]

KNOWN = set(DEFAULTS) | set(REQUIRED) | {"meta", "DIE_PLACEMENT"}


def info(msg):
    print("[INFO] %s" % msg)


def warn(msg):
    print("[WARNING] %s" % msg)


def die(msg):
    print("[ERROR] %s" % msg)
    sys.exit(1)


def load_config(path):
    if not os.path.isfile(path):
        die("config file not found: %s" % path)
    with open(path) as f:
        cfg = yaml.safe_load(f)
    for key in cfg:
        if key not in KNOWN:
            warn("unknown config key: %s" % key)
    for key in REQUIRED:
        if key not in cfg:
            die("missing required config key: %s" % key)
    merged = dict(DEFAULTS)
    merged.update(cfg)
    merged["_dir"] = os.path.dirname(os.path.abspath(path))
    return merged


def resolve(cfg, value):
    """Resolve a path; `dir::` (or a relative path) is relative to config."""
    if value.startswith("dir::"):
        value = value[len("dir::"):]
    if not os.path.isabs(value):
        value = os.path.join(cfg["_dir"], value)
    return os.path.normpath(value)


def parse_layer(spec):
    layer, dtype = str(spec).split("/")
    return int(layer), int(dtype)


# Layer palette for PNG/SVG export: (layer source, color, visible).
# Draw order is bottom-up: later entries are drawn on top.
IMAGE_LAYERS = [
    ("208/0", "#3a2a10", True),    # package body
    ("210/0", "#c87820", True),    # package leads
    ("133/0", "#b36b00", False),   # TopVia2
    ("9/0",   "#ffffff", False),   # Passiv
    ("134/0", "#ff9900", True),    # TopMetal2
    ("190/0", "#00e070", True),    # bondwires
    ("211/0", "#00ccff", True),    # package pin numbers (texts)
    ("190/25", "#00e070", True),   # bond table (texts)
]

TEXT_ANCHOR = {"211/0": "middle"}  # SVG text-anchor per layer, default "start"

# LibreLane/DEF orientation -> KLayout fixpoint transformation
ORIENT = {
    "N": pya.DTrans.R0,  "S": pya.DTrans.R180,
    "W": pya.DTrans.R90, "E": pya.DTrans.R270,
    "FN": pya.DTrans.M90, "FS": pya.DTrans.M0,
    "FW": pya.DTrans.M45, "FE": pya.DTrans.M135,
}


# ---------------------------------------------------------------------------
# Small 2D geometry helpers (all in um)
# ---------------------------------------------------------------------------

def _pt_seg_dist(p, a, b):
    vx, vy = b[0] - a[0], b[1] - a[1]
    l2 = vx * vx + vy * vy
    if l2 == 0.0:
        return math.hypot(p[0] - a[0], p[1] - a[1])
    t = max(0.0, min(1.0, ((p[0] - a[0]) * vx + (p[1] - a[1]) * vy) / l2))
    return math.hypot(p[0] - (a[0] + t * vx), p[1] - (a[1] + t * vy))


def seg_cross(a, b, c, d):
    """True if segments a-b and c-d properly intersect."""
    def orient(p, q, r):
        return (q[0] - p[0]) * (r[1] - p[1]) - (q[1] - p[1]) * (r[0] - p[0])
    o1, o2 = orient(a, b, c), orient(a, b, d)
    o3, o4 = orient(c, d, a), orient(c, d, b)
    return o1 * o2 < 0 and o3 * o4 < 0


def seg_seg_dist(a, b, c, d):
    if seg_cross(a, b, c, d):
        return 0.0
    return min(_pt_seg_dist(c, a, b), _pt_seg_dist(d, a, b),
               _pt_seg_dist(a, c, d), _pt_seg_dist(b, c, d))


def ray_polygon_hits(pts, origin, direction):
    """Parameters t > 0 where origin + t*direction crosses the polygon edge."""
    ts = []
    n = len(pts)
    ox, oy = origin
    dx, dy = direction
    for i in range(n):
        ax, ay = pts[i]
        bx, by = pts[(i + 1) % n]
        ex, ey = bx - ax, by - ay
        det = ex * dy - ey * dx
        if abs(det) < 1e-12:
            continue
        t = (ex * (ay - oy) - ey * (ax - ox)) / det
        s = (dx * (ay - oy) - dy * (ax - ox)) / det
        if t > 1e-9 and -1e-9 <= s <= 1.0 + 1e-9:
            ts.append(t)
    return sorted(ts)


# ---------------------------------------------------------------------------
# Step 1: die - load, detect pads, extract top-metal view
# ---------------------------------------------------------------------------

def pick_cell(layout, name, what):
    if name:
        cell = layout.cell(name)
        if cell is None:
            die("%s cell '%s' not found" % (what, name))
        return cell
    tops = layout.top_cells()
    if len(tops) != 1:
        die("%s has %d top cells, set the cell name in the config "
            "(found: %s)" % (what, len(tops), ", ".join(c.name for c in tops)))
    return tops[0]


def detect_die_pads(cfg):
    """Return (pads, die_bbox_um). Pads: dicts with name/x/y in die um."""
    ly = pya.Layout()
    ly.read(resolve(cfg, cfg["DIE_GDS"]))
    cell = pick_cell(ly, cfg["DIE_CELL"], "die")
    dbu = ly.dbu

    li = ly.find_layer(*parse_layer(cfg["DIE_PAD_LAYER"]))
    if li is None:
        die("die pad layer %s not present in %s"
            % (cfg["DIE_PAD_LAYER"], cfg["DIE_GDS"]))
    region = pya.Region(cell.begin_shapes_rec(li))
    region.merge()

    min_size = float(cfg["DIE_PAD_MIN_SIZE"]) / dbu
    pads = []
    for poly in region.each():
        bb = poly.bbox()
        if bb.width() >= min_size and bb.height() >= min_size:
            pads.append({"name": None,
                         "x": bb.center().x * dbu, "y": bb.center().y * dbu,
                         "w": bb.width() * dbu, "h": bb.height() * dbu})

    # Name the pads from labels that fall inside the pad opening
    li = ly.find_layer(*parse_layer(cfg["DIE_PAD_LABEL_LAYER"]))
    if li is None:
        warn("die pad label layer %s not present - pads stay unnamed"
             % cfg["DIE_PAD_LABEL_LAYER"])
    else:
        labels = []
        it = cell.begin_shapes_rec(li)
        while not it.at_end():
            shape = it.shape()
            if shape.is_text():
                t = shape.text.transformed(it.trans())
                labels.append((shape.text.string, t.x * dbu, t.y * dbu))
            it.next()
        for pad in pads:
            best = None
            for name, x, y in labels:
                if (abs(x - pad["x"]) <= pad["w"] / 2.0
                        and abs(y - pad["y"]) <= pad["h"] / 2.0):
                    d = math.hypot(x - pad["x"], y - pad["y"])
                    if best is None or d < best[0]:
                        best = (d, name)
            if best:
                pad["name"] = best[1]

    pads.sort(key=lambda p: (p["x"], p["y"]))
    named = sum(1 for p in pads if p["name"])
    info("die: %d bondpads detected on %s (%d named via %s)"
         % (len(pads), cfg["DIE_PAD_LAYER"], named, cfg["DIE_PAD_LABEL_LAYER"]))
    return pads, cell.dbbox(), dbu


def extract_die(cfg):
    """Extract DIE_EXTRACT_LAYERS (+ labels) into DIE_EXTRACT_GDS."""
    layers = [parse_layer(l) for l in cfg["DIE_EXTRACT_LAYERS"]]
    if cfg["DIE_KEEP_LABELS"]:
        label_layer = parse_layer(cfg["DIE_PAD_LABEL_LAYER"])
        if label_layer not in layers:
            layers.append(label_layer)

    lmap = pya.LayerMap()
    for i, (layer, dtype) in enumerate(layers):
        lmap.map(pya.LayerInfo(layer, dtype), i)
    opt = pya.LoadLayoutOptions()
    opt.set_layer_map(lmap, False)   # False: create mapped layers only

    ly = pya.Layout()
    ly.read(resolve(cfg, cfg["DIE_GDS"]), opt)
    cell = pick_cell(ly, cfg["DIE_CELL"], "die")
    if cfg["DIE_EXTRACT_CELL"]:
        cell.name = cfg["DIE_EXTRACT_CELL"]

    out = resolve(cfg, cfg["DIE_EXTRACT_GDS"])
    ly.write(out)
    info("die: extracted %s -> %s (top cell: %s)"
         % (", ".join(cfg["DIE_EXTRACT_LAYERS"]), out, cell.name))
    return ly, cell


# ---------------------------------------------------------------------------
# Step 2: package - leads, pin numbers, bond points, inner border
# ---------------------------------------------------------------------------

def find_cell_transforms(parent, target):
    """All accumulated transformations of `target` instances under `parent`."""
    if parent.cell_index() == target.cell_index():
        return [pya.DCplxTrans()]
    found = []

    def walk(cell, trans):
        for inst in cell.each_inst():
            t = trans * inst.dcplx_trans
            if inst.cell.cell_index() == target.cell_index():
                found.append(t)
            else:
                walk(inst.cell, t)

    walk(parent, pya.DCplxTrans())
    return found


def analyze_package(cfg):
    ly = pya.Layout()
    ly.read(resolve(cfg, cfg["PACKAGE_GDS"]))
    dbu = ly.dbu
    pkg_cell = pick_cell(ly, cfg["PACKAGE_CELL"], "package")
    fp_name = cfg["PACKAGE_FOOTPRINT_CELL"] or pkg_cell.name
    fp_cell = pick_cell(ly, fp_name, "package footprint")

    transforms = find_cell_transforms(pkg_cell, fp_cell)
    if len(transforms) == 0:
        die("footprint cell %s not instantiated under %s"
            % (fp_cell.name, pkg_cell.name))
    if len(transforms) > 1:
        warn("footprint cell %s placed %d times under %s - using the first"
             % (fp_cell.name, len(transforms), pkg_cell.name))
    fp_trans = transforms[0]

    # Lead polygons, in footprint um coordinates
    li = ly.find_layer(*parse_layer(cfg["PACKAGE_LEAD_LAYER"]))
    if li is None:
        die("package lead layer %s not present" % cfg["PACKAGE_LEAD_LAYER"])
    region = pya.Region(fp_cell.begin_shapes_rec(li))
    region.merge()
    leads = []
    for poly in region.each():
        bb = poly.bbox()
        leads.append({
            "pts": [(p.x * dbu, p.y * dbu) for p in poly.each_point_hull()],
            "cx": bb.center().x * dbu, "cy": bb.center().y * dbu,
        })

    bb = region.bbox()
    center = (bb.center().x * dbu, bb.center().y * dbu)
    inner = min(max(abs(x - center[0]), abs(y - center[1]))
                for lead in leads for (x, y) in lead["pts"])

    # Pin number labels -> nearest lead
    li = ly.find_layer(*parse_layer(cfg["PACKAGE_PIN_LABEL_LAYER"]))
    if li is None:
        die("package pin label layer %s not present"
            % cfg["PACKAGE_PIN_LABEL_LAYER"])
    pins = {}
    used_leads = {}
    sizes = {}
    it = fp_cell.begin_shapes_rec(li)
    while not it.at_end():
        shape = it.shape()
        if shape.is_text():
            try:
                num = int(shape.text.string.strip())
            except ValueError:
                it.next()
                continue
            t = shape.text.transformed(it.trans())
            x, y = t.x * dbu, t.y * dbu
            sizes[num] = t.size * dbu if t.size > 0 else 120.0
            idx = min(range(len(leads)),
                      key=lambda i: (leads[i]["cx"] - x) ** 2
                                  + (leads[i]["cy"] - y) ** 2)
            if idx in used_leads:
                warn("pins %d and %d map to the same lead" % (used_leads[idx], num))
            used_leads[idx] = num
            pins[num] = leads[idx]
        it.next()

    # Per pin, on the ray center -> lead: the bond point (between lead tip,
    # site 0, and far end, site 1) and the pin number label (on the lead
    # axis, PACKAGE_PIN_LABEL_OFFSET beyond the lead end)
    site = float(cfg["BONDWIRE_LEAD_SITE"])
    label_off = float(cfg["PACKAGE_PIN_LABEL_OFFSET"])
    bond_pts = {}
    pin_labels = {}
    text_box = None
    for num, lead in pins.items():
        direction = (lead["cx"] - center[0], lead["cy"] - center[1])
        norm = math.hypot(*direction)
        direction = (direction[0] / norm, direction[1] / norm)
        ts = ray_polygon_hits(lead["pts"], center, direction)
        if len(ts) >= 2:
            t = ts[0] + site * (ts[-1] - ts[0])
            pt = (center[0] + t * direction[0], center[1] + t * direction[1])
            t_label = ts[-1] + label_off
        else:                                   # degenerate: use lead center
            pt = (lead["cx"], lead["cy"])
            t_label = norm + label_off
        bond_pts[num] = fp_trans * pya.DPoint(*pt)

        size = sizes.get(num, 120.0)
        lx = center[0] + t_label * direction[0]
        ly_ = center[1] + t_label * direction[1]
        pin_labels[num] = (fp_trans * pya.DPoint(lx, ly_), size)
        half_w = len(str(num)) * size * 0.35     # centered glyph extent
        glyph_box = pya.DBox(lx - half_w, ly_ - size * 0.55,
                             lx + half_w, ly_ + size * 0.55)
        text_box = glyph_box if text_box is None else text_box + glyph_box

    center = fp_trans * pya.DPoint(*center)
    inner *= fp_trans.mag
    # Footprint extent incl. pin-number glyphs (for zero-border image crops)
    view_box = pya.DBox(bb.left * dbu, bb.bottom * dbu,
                        bb.right * dbu, bb.top * dbu)
    if text_box is not None:
        view_box += text_box
    view_box = view_box.transformed(fp_trans)

    info("package: %d leads, %d numbered pins, inner border %.1f x %.1f um"
         % (len(leads), len(pins), 2 * inner, 2 * inner))
    return {"layout": ly, "cell": pkg_cell, "bond_pts": bond_pts,
            "pin_labels": pin_labels, "center": center, "inner": inner,
            "view_box": view_box}


# ---------------------------------------------------------------------------
# Step 3: die placement transformation
# ---------------------------------------------------------------------------

def die_transform(cfg, die_bbox, pkg):
    placement = cfg.get("DIE_PLACEMENT") or {}
    orient = placement.get("orientation", "N")
    if orient not in ORIENT:
        die("unknown orientation '%s' (use %s)"
            % (orient, "/".join(ORIENT)))
    t0 = pya.DCplxTrans(ORIENT[orient])
    bb0 = die_bbox.transformed(t0)

    inner_ll = (pkg["center"].x - pkg["inner"], pkg["center"].y - pkg["inner"])
    location = placement.get("location")
    if location is None:                        # default: center the die
        location = [pkg["inner"] - bb0.width() / 2.0,
                    pkg["inner"] - bb0.height() / 2.0]

    dx = inner_ll[0] + float(location[0]) - bb0.left
    dy = inner_ll[1] + float(location[1]) - bb0.bottom
    trans = pya.DCplxTrans(1.0, 0.0, False, dx, dy) * t0
    info("die: placed at inner border + (%.1f, %.1f) um, orientation %s"
         % (float(location[0]), float(location[1]), orient))
    return trans


# ---------------------------------------------------------------------------
# Step 4: pinout -> wire list
# ---------------------------------------------------------------------------

def normalize_targets(value):
    if value is None or value == "NC":
        return []
    if isinstance(value, (list, tuple)):
        return [str(v) for v in value]
    return [str(value)]


def assign_wires(cfg, pads, pkg, die_center):
    pinout = cfg["PINOUT"]
    epad_names = normalize_targets(pinout.get("EPAD"))

    pads_by_name = {}
    for pad in pads:
        if pad["name"]:
            pads_by_name.setdefault(pad["name"], []).append(pad)

    # Collect lead-bond requests: (pin, name)
    requests = {}
    for pin, value in pinout.items():
        if pin == "EPAD":
            continue
        if not isinstance(pin, int):
            die("PINOUT key must be a pin number or EPAD, got: %r" % pin)
        if pin not in pkg["bond_pts"]:
            die("pin %d not found on the package (numbered pins: %d..%d)"
                % (pin, min(pkg["bond_pts"]), max(pkg["bond_pts"])))
        for name in normalize_targets(value):
            requests.setdefault(name, []).append(pin)

    # Shortest-wire assignment per pad name (handles VDD/VSS/... groups)
    wires = []
    for name, pin_list in sorted(requests.items()):
        candidates = pads_by_name.get(name, [])
        if len(candidates) < len(pin_list):
            die("pinout requests %d x pad '%s' but the die has %d "
                "(known pads: %s)"
                % (len(pin_list), name, len(candidates),
                   ", ".join(sorted(pads_by_name)) or "none"))
        pairs = []
        for i, pin in enumerate(pin_list):
            bp = pkg["bond_pts"][pin]
            for j, pad in enumerate(candidates):
                pairs.append((math.hypot(pad["x"] - bp.x, pad["y"] - bp.y),
                              i, j))
        pairs.sort()
        done_pins, done_pads = set(), set()
        for dist, i, j in pairs:
            if i in done_pins or j in done_pads:
                continue
            done_pins.add(i)
            done_pads.add(j)
            pad = candidates[j]
            pad["used"] = True
            bp = pkg["bond_pts"][pin_list[i]]
            wires.append({"pin": pin_list[i], "name": name,
                          "p0": (pad["x"], pad["y"]), "p1": (bp.x, bp.y),
                          "length": dist})

    # Exposed-pad downbonds: stubs from leftover pads, oriented parallel
    # to the neighboring bondwires (radial from die center as fallback)
    def stub_direction(pad):
        near = sorted(wires, key=lambda w: (w["p0"][0] - pad["x"]) ** 2
                                         + (w["p0"][1] - pad["y"]) ** 2)[:2]
        vx = vy = 0.0
        for w in near:
            dx, dy = w["p1"][0] - w["p0"][0], w["p1"][1] - w["p0"][1]
            norm = math.hypot(dx, dy)
            vx += dx / norm
            vy += dy / norm
        norm = math.hypot(vx, vy)
        if norm < 1e-9:
            vx, vy = pad["x"] - die_center[0], pad["y"] - die_center[1]
            norm = math.hypot(vx, vy) or 1.0
        return vx / norm, vy / norm

    stub = float(cfg["EPAD_WIRE_LENGTH"])
    for name in epad_names:
        left = [p for p in pads_by_name.get(name, []) if not p.get("used")]
        if not left:
            die("EPAD requests pad '%s' but no unused pad of that name is left"
                % name)
        pad = sorted(left, key=lambda p: (p["x"], p["y"]))[0]
        pad["used"] = True
        direction = stub_direction(pad)
        p1 = (pad["x"] + stub * direction[0],
              pad["y"] + stub * direction[1])
        wires.append({"pin": "EPAD", "name": name,
                      "p0": (pad["x"], pad["y"]), "p1": p1, "length": stub})

    unbonded = [p["name"] for p in pads if p["name"] and not p.get("used")]
    if unbonded:
        info("unbonded named pads: %s" % ", ".join(sorted(unbonded)))
    nc = sorted(set(pkg["bond_pts"]) - {w["pin"] for w in wires})
    if nc:
        info("NC package pins: %s" % ", ".join(map(str, nc)))
    return wires


# ---------------------------------------------------------------------------
# Step 5: build the bondplan layout
# ---------------------------------------------------------------------------

def build_bondplan(cfg, pkg, die_layout, die_cell, die_trans, wires):
    if abs(die_layout.dbu - pkg["layout"].dbu) > 1e-12:
        die("die dbu (%g) != package dbu (%g) - not supported"
            % (die_layout.dbu, pkg["layout"].dbu))

    ly = pya.Layout()
    ly.dbu = pkg["layout"].dbu
    top = ly.create_cell(cfg["BONDPLAN_CELL"])

    pkg_copy = ly.create_cell(pkg["cell"].name)
    pkg_copy.copy_tree(pkg["cell"])
    top.insert(pya.DCellInstArray(pkg_copy.cell_index(), pya.DCplxTrans()))

    die_copy = ly.create_cell(die_cell.name)
    die_copy.copy_tree(die_cell)
    top.insert(pya.DCellInstArray(die_copy.cell_index(), die_trans))

    wire_li = ly.layer(*parse_layer(cfg["BONDWIRE_LAYER"]))
    width = float(cfg["BONDWIRE_WIDTH"])
    for wire in wires:
        top.shapes(wire_li).insert(
            pya.DPath([pya.DPoint(*wire["p0"]), pya.DPoint(*wire["p1"])],
                      width))

    # Bond table on the text layer, placed right next to the bondplan
    table_box = None
    if cfg["BONDWIRE_LABELS"]:
        text_li = ly.layer(*parse_layer(cfg["BONDWIRE_TEXT_LAYER"]))
        size, spacing = 90.0, 120.0
        x = pkg["view_box"].right + 200.0

        def key(w):
            return (1, 0) if w["pin"] == "EPAD" else (0, w["pin"])
        rows = ["%s %s" % (w["pin"], w["name"]) for w in sorted(wires, key=key)]
        y_first = pkg["center"].y + (len(rows) - 1) * spacing / 2.0
        y = y_first
        for row in rows:
            top.shapes(text_li).insert(
                pya.DText(row, pya.DTrans(pya.DVector(x, y)), size, 0))
            y -= spacing
        table_box = pya.DBox(x, y + spacing - size * 0.6,
                             x + max(map(len, rows)) * size * 0.62,
                             y_first + size * 0.6)

    # The lead layer is only authoritative inside the footprint cell; drop
    # drawing-sheet decor (frame rulers, logos) on it
    fp_cell = ly.cell(cfg["PACKAGE_FOOTPRINT_CELL"] or pkg["cell"].name)
    if fp_cell is not None:
        keep = {fp_cell.cell_index()} | set(fp_cell.called_cells())
        li = ly.find_layer(*parse_layer(cfg["PACKAGE_LEAD_LAYER"]))
        if li is not None:
            for cell in ly.each_cell():
                if cell.cell_index() not in keep:
                    cell.shapes(li).clear()

    # Replace the package pin numbers: drop the drawing-sheet texts (they
    # sit offset from their leads) and re-insert each number centered on
    # its lead axis, PACKAGE_PIN_LABEL_OFFSET beyond the lead end
    pin_li = ly.layer(*parse_layer(cfg["PACKAGE_PIN_LABEL_LAYER"]))
    for cell in ly.each_cell():
        cell.shapes(pin_li).clear()
    for num, (pt, size) in sorted(pkg["pin_labels"].items()):
        text = pya.DText(str(num), pya.DTrans(pya.DVector(pt.x, pt.y)),
                         size, 0)
        text.halign = pya.HAlign.HAlignCenter
        text.valign = pya.VAlign.VAlignCenter
        top.shapes(pin_li).insert(text)

    # Drop unwanted layers (e.g. drawing frame, die pad labels)
    for spec in cfg["BONDPLAN_DELETE_LAYERS"]:
        li = ly.find_layer(*parse_layer(spec))
        if li is not None:
            ly.clear_layer(li)
            ly.delete_layer(li)
            info("deleted layer %s from the bondplan" % spec)

    out = resolve(cfg, cfg["BONDPLAN_GDS"])
    ly.write(out)
    info("bondplan: %d bondwires (w=%g um on %s) -> %s"
         % (len(wires), width, cfg["BONDWIRE_LAYER"], out))
    return out, ly, top, table_box


# ---------------------------------------------------------------------------
# Step 6: checks and report
# ---------------------------------------------------------------------------

def check_wires(cfg, wires):
    max_len = float(cfg["BONDWIRE_MAX_LENGTH"])
    width = float(cfg["BONDWIRE_WIDTH"])
    for wire in wires:
        if wire["length"] > max_len:
            warn("wire pin %s (%s) is %.0f um long (> %.0f um)"
                 % (wire["pin"], wire["name"], wire["length"], max_len))

    min_gap, min_pair = None, None
    for i in range(len(wires)):
        for j in range(i + 1, len(wires)):
            a, b = wires[i], wires[j]
            # ignore wires bonded to the same lead (deliberate double bonds)
            if a["pin"] == b["pin"] and a["pin"] != "EPAD":
                continue
            if seg_cross(a["p0"], a["p1"], b["p0"], b["p1"]):
                warn("wires cross: pin %s (%s) x pin %s (%s)"
                     % (a["pin"], a["name"], b["pin"], b["name"]))
            gap = seg_seg_dist(a["p0"], a["p1"], b["p0"], b["p1"]) - width
            if min_gap is None or gap < min_gap:
                min_gap, min_pair = gap, (a, b)
    if min_pair:
        a, b = min_pair
        level = warn if min_gap < 0 else info
        level("minimum wire-to-wire gap: %.1f um (pin %s %s / pin %s %s)"
              % (min_gap, a["pin"], a["name"], b["pin"], b["name"]))

    lengths = [w["length"] for w in wires if w["pin"] != "EPAD"]
    if lengths:
        info("wire lengths: min %.0f / max %.0f um"
             % (min(lengths), max(lengths)))


def write_report(cfg, wires):
    if not cfg["BONDPLAN_REPORT"]:
        return
    out = resolve(cfg, cfg["BONDPLAN_REPORT"])
    with open(out, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["pin", "die_pad", "die_x_um", "die_y_um",
                         "pkg_x_um", "pkg_y_um", "length_um"])
        def key(w):
            return (1, 0) if w["pin"] == "EPAD" else (0, w["pin"])
        for w in sorted(wires, key=key):
            writer.writerow([w["pin"], w["name"],
                             "%.3f" % w["p0"][0], "%.3f" % w["p0"][1],
                             "%.3f" % w["p1"][0], "%.3f" % w["p1"][1],
                             "%.1f" % w["length"]])
    info("bond table -> %s" % out)


# ---------------------------------------------------------------------------
# Step 7: PNG / SVG export (PNG follows ihp130/scripts/lay2img.py)
# ---------------------------------------------------------------------------

def image_size(cfg, crop):
    width = int(cfg["IMAGE_WIDTH"])
    return width, max(1, int(round(width * crop.height() / crop.width())))


def export_png(cfg, gds_path, crop):
    try:
        import klayout.lay as klay
    except ImportError:
        klay = pya if hasattr(pya, "LayoutView") else None
    if klay is None:
        warn("PNG export skipped: klayout.lay (LayoutView) not available")
        return

    lv = klay.LayoutView()
    lv.set_config("grid-visible", "false")
    lv.set_config("grid-show-ruler", "false")
    lv.set_config("text-visible", "true")
    lv.load_layout(gds_path, 0)
    lv.max_hier()

    lv.clear_layers()
    for source, color, visible in IMAGE_LAYERS:            # later = drawn on top
        props = klay.LayerProperties()
        props.source = source + "@1"
        rgb = int(color[1:], 16)
        props.fill_color = rgb
        props.frame_color = rgb
        props.dither_pattern = 0                            # solid
        props.visible = visible
        lv.insert_layer(lv.end_layers(), props)

    width, height = image_size(cfg, crop)
    base, ext = os.path.splitext(resolve(cfg, cfg["BONDPLAN_PNG"]))
    for suffix, bg in (("_white", "#FFFFFF"), ("_black", "#000000")):
        lv.set_config("background-color", bg)
        lv.save_image_with_options(
            base + suffix + ext, width, height,
            oversampling=int(cfg["IMAGE_OVERSAMPLING"]),
            target=crop)                            # exact box, zero border
        info("image -> %s" % (base + suffix + ext))


def svg_escape(text):
    return (text.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;"))


def export_svg(cfg, ly, top, crop):
    dbu = ly.dbu
    clip = pya.Region(pya.Box(int(crop.left / dbu), int(crop.bottom / dbu),
                              int(crop.right / dbu), int(crop.top / dbu)))
    shapes, texts = [], []
    for source, color, visible in IMAGE_LAYERS:
        if not visible:
            continue
        li = ly.find_layer(*parse_layer(source))
        if li is None:
            continue

        region = pya.Region(top.begin_shapes_rec(li)) & clip
        if not region.is_empty():
            parts = []
            for poly in region.each():
                rings = [poly.each_point_hull()]
                rings += [poly.each_point_hole(h) for h in range(poly.holes())]
                for ring in rings:
                    parts.append("M" + "L".join(
                        "%.2f %.2f" % (p.x * dbu, -p.y * dbu) for p in ring) + "Z")
            shapes.append('<path d="%s" fill="%s" fill-rule="evenodd"/>'
                          % ("".join(parts), color))

        anchor = TEXT_ANCHOR.get(source, "start")
        it = top.begin_shapes_rec(li)
        while not it.at_end():
            shape = it.shape()
            if shape.is_text():
                t = shape.text.transformed(it.trans())
                x, y = t.x * dbu, t.y * dbu
                if crop.contains(pya.DPoint(x, y)):
                    size = t.size * dbu if t.size > 0 else 120.0
                    texts.append(
                        '<text x="%.1f" y="%.1f" font-size="%.0f" '
                        'font-family="monospace" text-anchor="%s" fill="%s">'
                        '%s</text>' % (x, -y + size * 0.35, size, anchor,
                                       color, svg_escape(shape.text.string)))
            it.next()

    width, height = image_size(cfg, crop)
    base, ext = os.path.splitext(resolve(cfg, cfg["BONDPLAN_SVG"]))
    for suffix, bg in (("_white", "#FFFFFF"), ("_black", "#000000")):
        with open(base + suffix + ext, "w") as f:
            f.write('<svg xmlns="http://www.w3.org/2000/svg" '
                    'viewBox="%.2f %.2f %.2f %.2f" width="%d" height="%d">\n'
                    % (crop.left, -crop.top, crop.width(), crop.height(),
                       width, height))
            f.write('<rect x="%.2f" y="%.2f" width="%.2f" height="%.2f" '
                    'fill="%s"/>\n' % (crop.left, -crop.top, crop.width(),
                                       crop.height(), bg))
            f.write("\n".join(shapes + texts))
            f.write("\n</svg>\n")
        info("image -> %s" % (base + suffix + ext))


def export_images(cfg, pkg, gds_path, ly, top, table_box):
    if not (cfg["BONDPLAN_PNG"] or cfg["BONDPLAN_SVG"]):
        return
    # Zero-border crop: exact content extent (footprint incl. pin numbers,
    # plus the bond table), no margin
    crop = top.dbbox() if cfg["IMAGE_REGION"] == "full" else pkg["view_box"]
    if table_box:
        crop += table_box
    if cfg["BONDPLAN_PNG"]:
        export_png(cfg, gds_path, crop)
    if cfg["BONDPLAN_SVG"]:
        export_svg(cfg, ly, top, crop)


# ---------------------------------------------------------------------------

def main():
    cfg_path = globals().get("config")          # klayout -rd config=...
    if not cfg_path:
        for arg in sys.argv[1:]:
            if arg.endswith((".yaml", ".yml")):
                cfg_path = arg
                break
    cfg = load_config(cfg_path or "config.yaml")
    info("bondplan flow for design '%s'" % cfg["DESIGN_NAME"])

    pads, die_bbox, _ = detect_die_pads(cfg)
    die_layout, die_cell = extract_die(cfg)
    pkg = analyze_package(cfg)

    trans = die_transform(cfg, die_bbox, pkg)
    for pad in pads:                            # die -> bondplan coordinates
        p = trans * pya.DPoint(pad["x"], pad["y"])
        pad["x"], pad["y"] = p.x, p.y
    center = trans * die_bbox.center()

    wires = assign_wires(cfg, pads, pkg, (center.x, center.y))
    out, bp_layout, bp_top, table_box = build_bondplan(
        cfg, pkg, die_layout, die_cell, trans, wires)
    check_wires(cfg, wires)
    write_report(cfg, wires)
    export_images(cfg, pkg, out, bp_layout, bp_top, table_box)
    info("done")


main()
