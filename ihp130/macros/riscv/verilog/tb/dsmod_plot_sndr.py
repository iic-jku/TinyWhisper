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
# Post-processing script: reads the dsmod SNDR sweep results and plots
# SNDR vs. input amplitude (dBFS).

import os
import numpy as np
import matplotlib.pyplot as plt


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Read simulation parameters
    params_path = os.path.join(script_dir, "dsmod_params.txt")
    params = {}
    with open(params_path, "r") as f:
        for line in f:
            if line.startswith("#"):
                continue
            key, val = line.strip().split("=")
            params[key] = float(val)

    clk_freq  = params["clk_freq"]
    osr       = int(params["osr"])
    sine_freq = params["sine_freq"]
    order     = int(params.get("order", 2))

    # Read SNDR sweep data
    data_path = os.path.join(script_dir, "dsmod_sndr.txt")
    data = np.loadtxt(data_path)
    amp_db = data[:, 0]
    sndr   = data[:, 2]

    # Peak SNDR and dynamic range
    peak_sndr = np.max(sndr)
    peak_idx  = np.argmax(sndr)
    peak_amp  = amp_db[peak_idx]

    # Dynamic range: range where SNDR > 0 dB
    dr_mask = sndr > 0
    if np.any(dr_mask):
        dr = amp_db[dr_mask][-1] - amp_db[dr_mask][0]
    else:
        dr = 0

    # Plot
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.plot(amp_db, sndr, "b.-", linewidth=1.5, markersize=5)

    # Reference line: ideal SNDR = amp + peak_sndr_at_reference
    ax.plot(amp_db, amp_db - peak_amp + peak_sndr, "k--", alpha=0.3,
            linewidth=0.8, label="Ideal slope (1 dB/dB)")

    ax.axhline(0, color="gray", linestyle=":", alpha=0.5)
    ax.set_xlabel("Input Amplitude (dBFS)")
    ax.set_ylabel("SNDR (dB)")
    order_str = "1st" if order == 1 else "2nd"
    ax.set_title(
        f"Delta-Sigma Modulator SNDR vs. Input Amplitude\n"
        f"({order_str} order, OSR={osr}, f_clk={clk_freq/1e6:.0f} MHz, "
        f"f_sine={sine_freq/1e3:.1f} kHz)"
    )
    ax.annotate(
        f"Peak SNDR = {peak_sndr:.1f} dB\n@ {peak_amp:.0f} dBFS",
        xy=(peak_amp, peak_sndr),
        xytext=(peak_amp - 20, peak_sndr - 15),
        arrowprops=dict(arrowstyle="->", color="red"),
        fontsize=10, color="red",
    )
    ax.legend()
    ax.grid(True, alpha=0.3)

    plot_path = os.path.join(script_dir, f"dsmod_sndr_ord{order}_osr{osr}.png")
    fig.savefig(plot_path, dpi=150, bbox_inches="tight")
    print(f"SNDR plot saved to {plot_path}")
    print(f"Peak SNDR: {peak_sndr:.1f} dB @ {peak_amp:.0f} dBFS")
    print(f"Dynamic range (SNDR > 0 dB): {dr:.0f} dB")
    plt.close(fig)


if __name__ == "__main__":
    main()
