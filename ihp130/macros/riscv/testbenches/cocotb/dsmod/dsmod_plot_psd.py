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
# Post-processing script: reads the dsmod output bitstream and plots
# the PSD (Power Spectral Density) of the 1-bit delta-sigma output.

import os
import sys
import numpy as np
import matplotlib.pyplot as plt


def main():
    script_dir = os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__)))

    # Read simulation parameters
    params_path = os.path.join(script_dir, "dsmod_params.txt")
    params = {}
    with open(params_path, "r") as f:
        for line in f:
            key, val = line.strip().split("=")
            params[key] = float(val)

    clk_freq  = params["clk_freq"]
    osr       = int(params["osr"])
    sine_freq = params["sine_freq"]
    amplitude = params.get("amplitude", 0.5)
    order     = int(params.get("order", 2))
    amp_db    = 20.0 * np.log10(amplitude) if amplitude > 0 else -999

    # Read output bitstream (already bipolar +1/-1 from differential output)
    out_path = os.path.join(script_dir, "dsmod_output.txt")
    bipolar = np.loadtxt(out_path, dtype=float)

    # Apply Hann window and compute FFT
    N = len(bipolar)
    win = np.hanning(N)
    # Coherent gain of Hann window
    S1 = np.sum(win)
    windowed = bipolar * win
    spectrum = np.fft.rfft(windowed)
    # One-sided amplitude spectrum normalised to 0 dBFS
    # (a full-scale sinusoid with peak amplitude = 1 maps to 0 dB)
    magnitude = np.abs(spectrum)
    psd = magnitude * 2.0 / S1
    psd[0] = magnitude[0] / S1  # DC bin is not doubled
    freq = np.fft.rfftfreq(N, d=1.0 / clk_freq)

    # Convert to dBFS
    psd_db = 20 * np.log10(psd + 1e-30)

    # Plot
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.semilogx(freq, psd_db, linewidth=0.5)
    ax.set_xlabel("Frequency (Hz)")
    ax.set_ylabel("PSD (dBFS)")
    order_str = "1st" if order == 1 else "2nd"
    ax.set_title(
        f"Delta-Sigma Modulator Output PSD\n"
        f"({order_str} order, OSR={osr}, f_clk={clk_freq/1e6:.0f} MHz, "
        f"f_sine={sine_freq/1e3:.1f} kHz, {amp_db:.0f} dBFS)"
    )
    ax.set_xlim([1e3, clk_freq / 2])
    # Marker at the peak of the input tone
    tone_idx = np.argmin(np.abs(freq - sine_freq))
    ax.plot(freq[tone_idx], psd_db[tone_idx], "ro", markersize=6,
            label=f"Input tone peak: {psd_db[tone_idx]:.1f} dBFS")
    ax.axvline(clk_freq / (2 * osr), color="g", linestyle="--", alpha=0.7,
               label=f"Signal BW = {clk_freq/(2*osr)/1e3:.1f} kHz")
    ax.legend()
    ax.grid(True, which="both", alpha=0.3)

    plot_path = os.path.join(script_dir, f"dsmod_psd_ord{order}_osr{osr}_amp{amp_db:.0f}dBFS.png")
    fig.savefig(plot_path, dpi=150, bbox_inches="tight")
    print(f"PSD plot saved to {plot_path}")
    plt.close(fig)


if __name__ == "__main__":
    main()
