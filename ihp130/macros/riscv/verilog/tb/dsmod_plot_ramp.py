# SPDX-FileCopyrightText: 2026 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
#
# Post-processing script: reads the dsmod ramp interpolation data and
# plots the interpolated signal vs. ideal ramp.  Reports any step
# discontinuities that exceed the expected interpolation step size.

import os
import sys
import numpy as np
import matplotlib.pyplot as plt


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Read parameters
    params_path = os.path.join(script_dir, "dsmod_ramp_params.txt")
    params = {}
    with open(params_path, "r") as f:
        for line in f:
            if line.startswith("#"):
                continue
            key, val = line.strip().split("=")
            params[key] = float(val)

    osr       = int(params["osr"])
    order     = int(params.get("order", 1))
    nbit      = int(params["nbit"])
    n_samples = int(params["n_samples"])
    n_per_leg = int(params.get("n_per_leg", n_samples))
    clk_freq  = params["clk_freq"]

    # Read interpolated values (in hardware representation: NBIT+8 bits)
    interp = np.loadtxt(os.path.join(script_dir, "dsmod_ramp_interp.txt"), dtype=float)

    # Read input ramp samples (already scaled by ×256)
    ramp_input = np.loadtxt(os.path.join(script_dir, "dsmod_ramp_input.txt"), dtype=float)

    # Read fetch counter log
    fetch = np.loadtxt(os.path.join(script_dir, "dsmod_ramp_fetch.txt"), dtype=int)

    N = len(interp)
    t_us = np.arange(N) / clk_freq * 1e6  # time in µs

    # Build the ideal piecewise-linear interpolation for comparison.
    # The hardware interpolates between sample N-1 and sample N during the
    # period AFTER sample N arrives.  At the boundary the modulator sees
    # interp(old) from the previous segment, then data_pre_r on the next
    # clock, followed by OSR-2 increments.
    # For a constant-slope ramp the overall sequence is smooth.

    # Mark sample boundaries (where fetch_ctr transitions to 0)
    boundaries = np.where(fetch == 0)[0]

    # --- Step-discontinuity check ---
    # For the triangle waveform, the slope changes at the leg boundaries.
    # Within each leg the slope is constant, so the clock-to-clock diff
    # should be constant.  At leg transitions the diff changes sign/magnitude
    # which is expected.  We check that within each constant-slope segment
    # there are no unexpected jumps.
    diffs = np.diff(interp)

    # Compute expected per-clock step for each leg (from input sample diffs)
    input_diffs = np.diff(ramp_input)  # per-sample deltas (already ×256)
    # Each input sample spans OSR clocks, so per-clock step = input_diff / OSR
    # Build a per-clock expected-step array
    expected_per_clock = np.zeros(N)
    for i, bd in enumerate(boundaries):
        if i < len(input_diffs):
            seg_step = input_diffs[i] / osr
            end = boundaries[i + 1] if i + 1 < len(boundaries) else N
            expected_per_clock[bd:end] = seg_step

    # Skip initial transient (first 2 OSR periods)
    check_start = 2 * osr

    # Tolerance: max expected step magnitude × 1.5 (for truncation)
    max_step = np.max(np.abs(input_diffs)) / osr if len(input_diffs) > 0 else 1.0
    tolerance = 1.5 * max_step

    # Check: within each constant-slope segment, diffs should not exceed tolerance
    # We exclude leg transition points (±1 clock around boundaries after check_start)
    transition_set = set()
    for bd in boundaries:
        for offset in range(-1, 2):
            transition_set.add(bd + offset)

    diffs_check = diffs[check_start:]
    violation_indices = []
    for j, d in enumerate(diffs_check):
        idx = j + check_start
        if idx in transition_set:
            continue  # expected slope change at leg boundary
        if abs(d) > tolerance:
            violation_indices.append(idx)

    n_violations = len(violation_indices)
    violations = np.array(violation_indices, dtype=int)

    if n_violations > 0:
        print(f"WARN: {n_violations} step discontinuities exceed "
              f"{tolerance:.1f} (1.5× max per-clock step)")
        for idx in violations[:10]:
            print(f"  clock {idx}: Δ = {diffs[idx]:.1f} "
                  f"(tolerance = {tolerance:.1f})")
        if n_violations > 10:
            print(f"  ... and {n_violations - 10} more")
    else:
        print(f"OK: No unexpected step discontinuities detected "
              f"(tolerance = {tolerance:.1f}, checked from clock {check_start})")

    # --- Plot ---
    fig, axes = plt.subplots(2, 1, figsize=(12, 8), sharex=True)

    # Top: Interpolated value vs. time
    ax1 = axes[0]
    ax1.plot(t_us, interp, linewidth=0.6, label="data_interp_r (HW)")

    # Overlay ideal ramp (one point per input sample, at boundary times)
    if len(boundaries) > 0 and len(boundaries) <= len(ramp_input):
        ax1.plot(t_us[boundaries[:len(ramp_input)]], ramp_input[:len(boundaries)],
                 "r.", markersize=4, label="Input samples (×256)")

    ax1.set_ylabel("Interpolated value (NBIT+8 bits)")
    order_str = "1st" if order == 1 else "2nd"
    ax1.set_title(f"dsmod Interpolation Verification — Triangle Ramp (0→+FS→−FS→0)\n"
                  f"({order_str} order, OSR={osr})")
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    # Bottom: Clock-to-clock difference (should be constant for a ramp)
    ax2 = axes[1]
    ax2.plot(t_us[1:], diffs, linewidth=0.5)
    ax2.axhline(max_step, color="r", linestyle="--", alpha=0.5,
                label=f"+step = {max_step:.1f}")
    ax2.axhline(-max_step, color="r", linestyle="--", alpha=0.5,
                label=f"−step = {-max_step:.1f}")
    ax2.set_xlabel("Time (µs)")
    ax2.set_ylabel("Δ(data_interp_r)")
    ax2.set_title("Clock-to-Clock Difference (constant within each ramp leg)")
    ax2.legend()
    ax2.grid(True, alpha=0.3)

    # Mark violations
    if n_violations > 0:
        ax2.plot(t_us[violations + 1], diffs[violations], "rx", markersize=6,
                 label=f"{n_violations} violations")
        ax2.legend()

    plot_path = os.path.join(
        script_dir,
        f"dsmod_ramp_ord{order}_osr{osr}.png",
    )
    fig.savefig(plot_path, dpi=150, bbox_inches="tight")
    print(f"Ramp plot saved to {plot_path}")
    plt.close(fig)

    if n_violations > 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
