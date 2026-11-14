# SPDX-FileCopyrightText: 2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Description: Turn a KPEX netlist into <cell>_pex.spice: rename the subcircuit and merge the substrate port into the ground net.

import argparse
import re
import sys


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("kpex_netlist", help="KPEX SPICE netlist (e.g. <cell>_k25d_pex_netlist_reduced.spice)")
    ap.add_argument("out", help="output netlist, e.g. netlist/pex/<cell>_pex.spice")
    ap.add_argument("--cell", required=True, help="extracted cell, its subcircuit becomes <cell>_pex")
    ap.add_argument("--substrate", default="sub!", help="substrate port KPEX adds (default: sub!)")
    ap.add_argument("--ground", default="VSS", help="net the substrate is merged into (default: VSS)")
    ap.add_argument("--note", default="", help="provenance line written at the top")
    args = ap.parse_args()

    lines = open(args.kpex_netlist).read().splitlines()
    sub_re = re.compile(r"(?<!\S)" + re.escape(args.substrate) + r"(?!\S)")
    out, in_header, header_ports = [], False, []
    for line in lines:
        tok = line.split()
        if tok and tok[0].upper() == ".SUBCKT" and tok[1] == args.cell:
            # The port list may continue on '+' lines, collect it first.
            in_header, header_ports = True, tok[2:]
            continue
        if in_header:
            if line.startswith("+"):
                header_ports += tok[1:]
                continue
            in_header = False
            if args.ground not in header_ports:
                sys.exit(f"error: ground net {args.ground} is not a port of {args.cell}")
            ports = [p for p in header_ports if p != args.substrate]
            out.append(f".SUBCKT {args.cell}_pex " + " ".join(ports))
        if tok and tok[0].upper() == ".ENDS":
            out.append(f".ENDS {args.cell}_pex")
            continue
        out.append(sub_re.sub(args.ground, line))

    with open(args.out, "w") as f:
        if args.note:
            f.write(f"* {args.note}\n")
        f.write("\n".join(out) + "\n")


if __name__ == "__main__":
    main()
