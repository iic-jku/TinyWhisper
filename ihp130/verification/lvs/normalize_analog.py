#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
#
# normalize_analog.py - Prepare an xschem-generated schematic SPICE netlist for
# netgen LVS against a magic-extracted layout netlist.
#
# 1. Tap devices (ntap1/ptap1) are removed and their two terminal nets are
#    merged, because magic does not extract taps as devices; it connects the
#    bulk of the MOSFETs directly to the well/substrate net (i.e. the rail).
#    Net merging is local to each .subckt. The surviving net name is chosen by
#    preference: power rail (VSS/VDD/IOVSS/IOVDD), then a port of the subckt,
#    then the first-seen net.
# 2. xschem resistor lines of the form
#        RRx net1 net2 <value> $SUB=net3 $[model] w=... l=... b=0
#    are rewritten to the 3-pin subcircuit-instance form that magic writes:
#        XRRx net1 net2 net3 model w=... l=...
# 3. Capacitor lines using a PDK subcircuit model, e.g.
#        C1a net1 net2 cap_cmim w=... l=... m=...
#    are rewritten to X-instance form (XC1a net1 net2 cap_cmim ...), because
#    netgen otherwise treats them as builtin capacitors with pins named
#    top/bottom, which cannot be matched against the positional-pin subckt
#    placeholder created for the layout's X-instances.
#
# 4. For instances of cells listed in PIN_SHORTS, the nets on the given pin
#    pairs are merged in the instantiating cell. This models pins that are
#    physically the same metal but distinct (one dangling) in the SPICE model:
#    the 'padbare' pin of sg13g2_IOPadAnalog is the bare bond-pad metal, i.e.
#    electrically identical to 'pad', which is how magic extracts it.
#
# Ports that lose their last internal connection through net merging are
# cleaned up afterwards by check_floating_nets.py --fix-ports.
#
# Usage:
#    python3 normalize_analog.py <input.spice> -o <output.spice>

import argparse
import sys

TAP_MODELS = {'ntap1', 'ptap1'}
CAP_MODELS = {'cap_cmim', 'cap_rfcmim'}
RAILS = {'vss', 'vdd', 'iovss', 'iovdd'}
PIN_SHORTS = {'sg13g2_IOPadAnalog': [('pad', 'padbare')]}
MAX_WIDTH = 132


def join_logical(raw_lines):
    """Join SPICE '+' continuation lines into logical lines."""
    out = []
    for ln in raw_lines:
        s = ln.rstrip('\n')
        if s.lstrip().startswith('+') and out:
            out[-1] += ' ' + s.lstrip()[1:].strip()
        else:
            out.append(s)
    return out


def wrap_line(text):
    """Wrap a long SPICE line using '+' continuations."""
    if len(text) <= MAX_WIDTH:
        return [text]
    toks = text.split()
    lines = [toks[0]]
    for t in toks[1:]:
        if len(lines[-1]) + 1 + len(t) > MAX_WIDTH:
            lines.append('+ ' + t)
        else:
            lines[-1] += ' ' + t
    return lines


class NetMerger:
    """Union-find over net names, preferring rails, then ports, as survivors."""

    def __init__(self, ports):
        self.parent = {}
        self.ports = set(ports)

    def _rank(self, n):
        if n.lower() in RAILS:
            return 0
        if n in self.ports:
            return 1
        return 2

    def find(self, n):
        while self.parent.get(n, n) != n:
            n = self.parent[n]
        return n

    def union(self, a, b):
        ra, rb = self.find(a), self.find(b)
        if ra == rb:
            return
        if self._rank(ra) <= self._rank(rb):
            keep, drop = ra, rb
        else:
            keep, drop = rb, ra
        self.parent[drop] = keep

    def map(self, n):
        return self.find(n)


def is_tap_line(tokens):
    """A device line whose model is ntap1/ptap1."""
    if len(tokens) < 4 or tokens[0][0].lower() not in 'rx':
        return False
    for t in tokens[3:]:
        if '=' in t:
            continue
        if t.lower() in TAP_MODELS:
            return True
    return False


def parse_rmodel_line(tokens):
    """Detect 'Rxx n1 n2 [value] $SUB=s $[model] params...' lines.

    Returns (name, n1, n2, subnet_or_None, model, params) or None.
    """
    if len(tokens) < 4 or tokens[0][0].lower() != 'r':
        return None
    model = None
    subnet = None
    params = []
    for t in tokens[3:]:
        if t.startswith('$[') and t.endswith(']'):
            model = t[2:-1]
        elif t.upper().startswith('$SUB='):
            subnet = t.split('=', 1)[1]
        elif '=' in t and not t.startswith('$'):
            if t.split('=', 1)[0].lower() != 'b':
                params.append(t)
        # other bare tokens (the resistance value) are dropped
    if model is None:
        return None
    return tokens[0], tokens[1], tokens[2], subnet, model, params


def parse_cmodel_line(tokens):
    """Detect 'Cxx n1 n2 <cap-model> params...' lines.

    Returns (name, n1, n2, model, params) or None.
    """
    if len(tokens) < 4 or tokens[0][0].lower() != 'c':
        return None
    model = None
    params = []
    for t in tokens[3:]:
        if '=' in t:
            params.append(t)
        elif t.lower() in CAP_MODELS:
            model = t
        # other bare tokens (the capacitance value) are dropped
    if model is None:
        return None
    return tokens[0], tokens[1], tokens[2], model, params


def process_subckt(header, body, stats, shorts_idx):
    """Process one .subckt: remove taps, merge nets, rewrite $[model] R-lines."""
    ports = header.split()[2:]
    merger = NetMerger(ports)

    # Pass 1: collect net merges from taps and PIN_SHORTS instances
    for line in body:
        s = line.strip()
        if not s or s.startswith('*') or s.startswith('.'):
            continue
        tokens = s.split()
        if is_tap_line(tokens):
            merger.union(tokens[1], tokens[2])
            continue
        if tokens[0][0].lower() == 'x' and shorts_idx:
            bare = [t for t in tokens[1:] if '=' not in t]
            if len(bare) >= 2 and bare[-1] in shorts_idx:
                nets = bare[:-1]
                for i1, i2 in shorts_idx[bare[-1]]:
                    if i1 < len(nets) and i2 < len(nets):
                        merger.union(nets[i1], nets[i2])
                        stats['shorts'] += 1

    def m(net):
        return merger.map(net)

    # Pass 2: rewrite
    out = []
    for line in body:
        s = line.strip()
        if not s or s.startswith('*') or s.startswith('.'):
            out.append(line)
            continue
        tokens = s.split()
        if is_tap_line(tokens):
            stats['taps'] += 1
            continue
        rmod = parse_rmodel_line(tokens)
        if rmod is not None:
            name, n1, n2, subnet, model, params = rmod
            new = ['X' + name, m(n1), m(n2)]
            if subnet is not None:
                new.append(m(subnet))
            new.append(model)
            new.extend(params)
            stats['rlines'] += 1
            out.append(' '.join(new))
            continue
        cmod = parse_cmodel_line(tokens)
        if cmod is not None:
            name, n1, n2, model, params = cmod
            new = ['X' + name, m(n1), m(n2), model] + params
            stats['clines'] += 1
            out.append(' '.join(new))
            continue
        # Generic net-name substitution on all non-name tokens
        new_tokens = [tokens[0]]
        for t in tokens[1:]:
            if '=' in t:
                k, v = t.split('=', 1)
                new_tokens.append(k + '=' + m(v))
            else:
                new_tokens.append(m(t))
        out.append(' '.join(new_tokens))

    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('input')
    ap.add_argument('-o', '--output', required=True)
    args = ap.parse_args()

    with open(args.input, 'r') as f:
        logical = join_logical(f.readlines())

    # Collect all .subckt headers to resolve PIN_SHORTS pin name -> index
    headers = {}
    for line in logical:
        s = line.strip()
        if s.lower().startswith('.subckt'):
            toks = s.split()
            headers[toks[1]] = toks[2:]
    shorts_idx = {}
    for cell, pairs in PIN_SHORTS.items():
        pins = headers.get(cell)
        if pins is None:
            continue
        idx = [(pins.index(a), pins.index(b))
               for a, b in pairs if a in pins and b in pins]
        if idx:
            shorts_idx[cell] = idx

    stats = {'taps': 0, 'rlines': 0, 'clines': 0, 'shorts': 0}
    out_lines = []
    i = 0
    n = len(logical)
    while i < n:
        line = logical[i]
        s = line.strip()
        if s.lower().startswith('.subckt'):
            header = s
            body = []
            i += 1
            while i < n and not logical[i].strip().lower().startswith('.ends'):
                body.append(logical[i])
                i += 1
            ends = logical[i] if i < n else '.ends'
            out_lines.extend(wrap_line(header))
            for bl in process_subckt(header, body, stats, shorts_idx):
                out_lines.extend(wrap_line(bl))
            out_lines.append(ends)
        else:
            out_lines.append(line)
        i += 1

    with open(args.output, 'w') as f:
        f.write('\n'.join(out_lines) + '\n')

    print(f"  Removed {stats['taps']} tap device(s) (models: {', '.join(sorted(TAP_MODELS))}), "
          f"merging their terminal nets")
    print(f"  Rewrote {stats['rlines']} xschem R-line(s) to X-instance form")
    print(f"  Rewrote {stats['clines']} capacitor C-line(s) to X-instance form")
    print(f"  Merged {stats['shorts']} physically-shorted pin pair(s) (PIN_SHORTS)")
    print(f"  Normalized netlist written to: {args.output}")
    return 0


if __name__ == '__main__':
    sys.exit(main())
