#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Description: Build doc/dashboard.html from the committed simulation data, CACE results and LibreLane reports.

"""Usage: gen_dashboard.py [--repo <repo root>] [--out <html file>]

The parsed datasets (AC curves, CACE samples, STA and power per corner, cell mix,
RTL size, errata, RF output power) follow the committed files. The tables in CURATED are read by hand
from the reports named in their source column, so update them after a new run.
"""

import argparse
import csv
import datetime
import json
import math
import re
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent

CURATED = {
    "signoff": [
        # block, check, tool, result, status, source
        ("Chip top", "DRC", "Magic", "0 errors (top + logo fill)", "pass", "ihp130/verification/drc/"),
        ("Chip top", "LVS", "Netgen", "Match, 328 devices", "pass", "ihp130/verification/reports/lvs.netgen.rpt"),
        ("Chip top", "Antenna", "OpenROAD", "0 violations", "pass", "ihp130/verification/reports/"),
        ("Chip top", "Setup / hold", "OpenSTA", "+1.841 ns / +0.080 ns", "pass", "ihp130/verification/reports/"),
        ("Chip top", "Max slew", "OpenSTA", "21 violations (slow)", "warn", "ihp130/verification/reports/"),
        ("riscv_top", "DRC", "Magic", "0 errors", "pass", "ihp130/macros/riscv/verification/drc.magic.rpt"),
        ("riscv_top", "LVS", "Netgen", "Match, 31,882 devices", "pass", "ihp130/macros/riscv/verification/lvs.netgen.rpt"),
        ("riscv_top", "Antenna", "OpenROAD", "0 nets, 0 pins", "pass", "ihp130/macros/riscv/verification/antenna_summary.rpt"),
        ("riscv_top", "Setup / hold", "OpenSTA", "+2.667 ns / +0.254 ns", "pass", "ihp130/macros/riscv/verification/stapostpnr_summary.rpt"),
        ("riscv_top", "Max slew", "OpenSTA", "3 violations (slow, typ 1.2 V)", "warn", "ihp130/macros/riscv/verification/stapostpnr_summary.rpt"),
        ("riscv_top", "IR drop", "OpenROAD", "VDD 8.08 mV (0.54 %)", "pass", "ihp130/macros/riscv/verification/irdrop.rpt"),
        ("iqmod_top", "DRC", "Magic + KLayout", "0 errors", "pass", "ihp130/macros/iqmod/verification/drc/"),
        ("iqmod_top", "LVS", "KLayout", "All xrefs match (296 top)", "pass", "ihp130/macros/iqmod/verification/lvs/"),
        ("iqmod_top", "LVS", "Netgen", "Unique match, rhigh mm_ok property only", "warn", "ihp130/macros/iqmod/verification/lvs/iqmod_top.magic.lvs/iqmod_top.lvs.out"),
        ("iqmod_top", "PEX", "Magic", "Full RC: 11,755 C, 42,373 R", "pass", "ihp130/macros/iqmod/netlist/pex/"),
        ("MFB LPF", "CACE fc >= 350 kHz", "ngspice MC", "min 345.5 kHz in 200 samples", "warn", "ihp130/macros/iqmod/verification/cace/scripts/iqmod_mfb_lpf_tb_ac.csv"),
        ("iqmod_top", "Supply power", "ngspice", "24.4 mW (schematic). PEX tran fails to find an operating point", "warn", "ihp130/macros/iqmod/testbenches/xschem/iqmod_top_tb_tran.sch"),
        ("Silicon", "Lab measurement", "-", "Dies back (SoC4219), not measured yet", "open", "measurements/README.md"),
    ],
    "chip_specs": [
        ("Technology", "IHP SG13G2 (sg13cmos), 130 nm CMOS", "doc/specifications.md"),
        ("Die / core", "2000 × 2000 µm / 1270 × 1270 µm", "README.md"),
        ("Clock", "56 MHz (17 ns STA period)", "ihp130/macros/riscv/flow/librelane/config.yaml"),
        ("Supplies", "Core 1.5 V, I/O 3.3 V", "doc/specifications.md"),
        ("Pads / package", "56 pads, QFN-48, 12 VSS downbonds", "doc/pinout.md"),
        ("Tapeout", "IHP MPW, March 2026 (SoC4219)", "README.md"),
        ("riscv_top macro", "700 × 1130 µm, density 40 %", "ihp130/macros/riscv/flow/librelane/config.yaml"),
        ("iqmod_top macro", "337.0 × 142.3 µm", "ihp130/macros/iqmod/final/lef/iqmod_top.lef"),
    ],
    # band, RF (MHz), LO (MHz), IF (kHz), LO divider: doc/index.qmd and rtl/lo_gen.v
    "bands": [("80 m", 3.5686, 3.5, 68.6, 8), ("40 m", 7.0386, 7.0, 38.6, 4),
              ("20 m", 14.0956, 14.0, 95.6, 2), ("10 m", 28.1246, 28.0, 124.6, 1)],
    "analog_nominal": [
        # block, metric, value, data file in macros/iqmod/testbenches/xschem/plot_simulations/data/
        ("MFB LPF", "DC gain (closed loop)", "-0.453 dB", "iqmod_mfb_lpf_tb_ac_cl.txt"),
        ("MFB LPF", "-3 dB corner", "401.8 kHz (target 400)", "iqmod_mfb_lpf_tb_ac_cl.txt"),
        ("MFB LPF", "Rejection at 56 MHz", "-130 dB", "iqmod_mfb_lpf_tb_ac_cl.txt"),
        ("MFB LPF", "Loop gain / PM", "21.2 dB / ≈95°", "iqmod_mfb_lpf_tb_loopgain_all.txt"),
        ("MFB LPF", "CMRR / PSRR (DC)", "45.9 / 59.6 dB", "iqmod_mfb_lpf_tb_CMRR.txt, _PSRR.txt"),
        ("MFB LPF", "Output noise 1 Hz to 400 kHz", "229 µVrms", "iqmod_mfb_lpf_tb_noise.txt"),
        ("OTA (B/M inverter)", "Open-loop gain", "27.44 dB", "iqmod_mfb_lpf_ota_core_tb_ac_ol.txt"),
        ("OTA (B/M inverter)", "f-3dB / UGF", "4.02 MHz / 93 MHz", "iqmod_mfb_lpf_ota_core_tb_ac_ol.txt"),
        ("OTA (B/M inverter)", "CMRR / PSRR (DC)", "68.3 / 29.8 dB", "iqmod_mfb_lpf_ota_core_tb_CMRR.txt, _PSRR.txt"),
        ("OTA (B/M inverter)", "Output swing", "0.076 to 1.44 V", "iqmod_mfb_lpf_ota_core_tb_Vout.txt"),
        ("Mixer TG", "Ron over 0 to 1.5 V", "4.6 to 12.4 Ω", "iqmod_mixer_tg_tb_dc_Ron.txt"),
        ("iqmod_top", "Supply power, 10 m band tran", "24.4 mW at 1.5 V (schematic)", "iqmod_top_tb_tran with the schematic netlist, ngspice-47, IIC-OSIC-TOOLS latest"),
        ("iqmod_top", "RF output and efficiency (schematic)", "71.3 µW, 0.29 %", "iqmod_top_tb_tran with the schematic netlist, ngspice-47, IIC-OSIC-TOOLS latest"),
        ("Mixer TG", "Size N / P", "108 / 324 µm, L 0.13 µm", "ihp130/macros/iqmod/netlist/schematic/iqmod_top_magic.spice"),
    ],
}


def ac_curve(path, series, fmin=1e3, fmax=1e8, step=0.04):
    """Read an ngspice wrdata AC file and keep one point per `step` decades."""
    out, last = [], -1e9
    for line in path.read_text().splitlines()[1:]:
        f, g, *_ = (float(x) for x in line.split())
        if fmin <= f <= fmax and math.log10(f) - last >= step:
            out.append({"series": series, "freq_hz": f, "gain_db": round(g, 3)})
            last = math.log10(f)
    return out


def rf_output(path, rload=1e3):
    """RF power into the testbench load from the vout_RF_filt column of iqmod_top_tb_tran.txt.

    The testbench drives a 1 kOhm / 1 kOhm coupled-resonator BPF at 28 MHz, terminated by Rload = 1 kOhm,
    so the real power is the time average of v(vout_RF_filt)^2 / Rload (trapezoid over the non-uniform steps).
    """
    t, v = [], []
    for line in path.read_text().splitlines()[1:]:
        c = line.split()
        t.append(float(c[0]))
        v.append(float(c[10]))
    span = t[-1] - t[0]
    ms = sum((v[i] ** 2 + v[i + 1] ** 2) / 2 * (t[i + 1] - t[i]) for i in range(len(t) - 1)) / span
    p = ms / rload
    return [{"band": "10 m", "lo_mhz": 28.0, "load_ohm": rload, "window_us": round(span * 1e6, 2),
             "vrms_mv": round(math.sqrt(ms) * 1e3, 1), "vpk_mv": round(max(abs(x) for x in v) * 1e3, 1),
             "pout_uw": round(p * 1e6, 1), "pout_dbm": round(10 * math.log10(p / 1e-3), 2)}]


def cace_samples(iq):
    rows = []
    for blk, name in (("MFB LPF", "iqmod_mfb_lpf_tb_ac.csv"), ("OTA core", "iqmod_mfb_lpf_ota_core_tb_ac.csv")):
        with (iq / "verification/cace/scripts" / name).open() as fh:
            for i, row in enumerate(csv.DictReader(fh)):
                d = {"block": blk, "sample": i}
                for k, v in row.items():
                    d[k.removesuffix("_arr")] = float(v)
                d["fcu_khz"] = round(d.pop("fcu") / 1e3, 2)
                rows.append(d)
    return rows


def riscv_sta(ver):
    rows = []
    for line in (ver / "stapostpnr_summary.rpt").read_text().splitlines():
        m = re.match(r"│\s*(nom_\S+)\s*│(.*)│\s*$", line)
        if not m:
            continue
        c = [x.strip() for x in m.group(2).split("│")]
        corner = m.group(1)
        pw = (ver / f"stapostpnr_{corner}_power.rpt").read_text()

        def total(group):
            return float(re.search(rf"^{group}\s+\S+\s+\S+\s+\S+\s+(\S+)", pw, re.M).group(1)) * 1e3

        rows.append({"corner": corner, "hold_wns_ns": float(c[0]), "hold_vio": int(c[3]),
                     "setup_wns_ns": float(c[5]), "setup_vio": int(c[8]), "max_slew_vio": int(c[11]),
                     "power_mw": round(total("Total"), 2), "seq_mw": round(total("Sequential"), 2),
                     "comb_mw": round(total("Combinational"), 2), "clock_mw": round(total("Clock"), 2)})
    return rows


def cell_group(base):
    for prefix, group in ((("dfr", "dfs", "dll", "sdf", "dlh"), "Flip-flops / latches"),
                          (("buf", "inv", "dly", "clk"), "Buffers / inverters"),
                          (("fill", "decap", "tie", "antenna"), "Fill / tie"),
                          (("mux",), "Multiplexers"), (("xor", "xnor"), "XOR / XNOR"),
                          (("nand", "nor", "and", "or"), "NAND / NOR / AND / OR")):
        if base.startswith(prefix):
            return group
    return "AOI / OAI complex"


def riscv_cells(ver):
    groups = {}
    for line in (ver / "stat.rpt").read_text().splitlines():
        m = re.match(r"^\s+(\d+)\s+([\d.Ee+]+)\s+sg13g2_(\S+)", line)
        if m:
            g = cell_group(m.group(3).rsplit("_", 1)[0])
            e = groups.setdefault(g, {"group": g, "cells": 0, "area_um2": 0.0})
            e["cells"] += int(m.group(1))
            e["area_um2"] += float(m.group(2))
    for e in groups.values():
        e["area_um2"] = round(e["area_um2"], 1)
    return sorted(groups.values(), key=lambda e: -e["area_um2"])


def riscv_rtl(rtl):
    rows = []
    for p in sorted(rtl.glob("*.*v")):
        name = p.stem
        group = ("DSP" if re.match(r"(cordic|dsmod|freq_gen|lo_gen)", name) else
                 "Peripheral" if re.match(r"(i2c|uart|spi)", name) else
                 "Sim only" if name == "sram_sim" else "CPU / SoC")
        rows.append({"file": p.name, "lines": len(p.read_text().splitlines()), "group": group})
    return rows


def errata(md):
    text = md.read_text()
    return [{"severity": s, "count": len(re.findall(rf"\|\s*{s}\s*\|", text))} for s in ("Critical", "Major", "Minor")]


def build(repo):
    iq = repo / "ihp130/macros/iqmod"
    rv = repo / "ihp130/macros/riscv"
    sim = iq / "testbenches/xschem/plot_simulations/data"
    cur = CURATED
    return {
        "analog_ac": ac_curve(sim / "iqmod_mfb_lpf_ota_core_tb_ac_ol.txt", "OTA open loop")
                     + ac_curve(sim / "iqmod_mfb_lpf_tb_ac_cl.txt", "MFB LPF closed loop"),
        "cace_mc": cace_samples(iq),
        "rf_out": rf_output(sim / "iqmod_top_tb_tran.txt"),
        "riscv_sta": riscv_sta(rv / "verification"),
        "riscv_cells": riscv_cells(rv / "verification"),
        "riscv_rtl": riscv_rtl(rv / "rtl"),
        "errata": errata(repo / "ihp130/doc/errata.md"),
        "signoff": [dict(zip(("block", "check", "tool", "result", "status", "source"), r)) for r in cur["signoff"]],
        "chip_specs": [dict(zip(("item", "value", "source"), r)) for r in cur["chip_specs"]],
        "bands": [dict(zip(("band", "rf_mhz", "lo_mhz", "if_khz", "lo_div"), r)) for r in cur["bands"]],
        "analog_nominal": [dict(zip(("block", "metric", "value", "source"), r)) for r in cur["analog_nominal"]],
    }


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--repo", type=Path, default=HERE.parents[1])
    ap.add_argument("--out", type=Path, default=None)
    args = ap.parse_args()
    repo = args.repo.resolve()
    out = args.out or repo / "doc/dashboard.html"

    data = build(repo)
    try:
        rev = subprocess.run(["git", "-C", str(repo), "rev-parse", "--short", "HEAD"],
                             capture_output=True, text=True, check=True).stdout.strip()
    except (OSError, subprocess.CalledProcessError):
        rev = "unknown"
    stamp = f"{datetime.date.today().isoformat()} from commit {rev}"

    # "</" inside the JSON would end the <script> element early
    blob = json.dumps(data, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/")
    html = (HERE / "dashboard_template.html").read_text()
    html = html.replace("__DATA__", blob).replace("__STAMP__", stamp)
    html = html.replace("Template of the TinyWhisper chip dashboard, filled by gen_dashboard.py into doc/dashboard.html.",
                        "Generated by ihp130/scripts/gen_dashboard.py from dashboard_template.html. Do not edit.")
    out.write_text(html)
    print(f"Wrote {out} ({len(html) // 1024} KiB, {sum(len(v) for v in data.values())} rows)")


if __name__ == "__main__":
    main()
