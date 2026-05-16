# SPDX-FileCopyrightText: 2026 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
#
# Post-processing script: reads the dsmod output bitstream, reconstructs
# the analog signal by low-pass filtering, and plots the time-domain waveform.

import os
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import firwin, lfilter


def main():
    script_dir = os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__)))

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
    amplitude = params.get("amplitude", 0.5)
    order     = int(params.get("order", 2))
    amp_db    = 20.0 * np.log10(amplitude) if amplitude > 0 else -999

    # Read output bitstream (bipolar +1/-1)
    out_path = os.path.join(script_dir, "dsmod_output.txt")
    bipolar = np.loadtxt(out_path, dtype=float)

    N = len(bipolar)
    dt = 1.0 / clk_freq
    t = np.arange(N) * dt

    # Design low-pass FIR filter at signal bandwidth
    bw = clk_freq / (2.0 * osr)
    # Use a filter order proportional to OSR for good stopband rejection
    numtaps = 4 * osr + 1
    nyq = clk_freq / 2.0
    fir_coeffs = firwin(numtaps, bw / nyq)

    # Filter the bitstream to reconstruct the analog signal
    analog = lfilter(fir_coeffs, 1.0, bipolar)

    # Compensate for FIR group delay
    delay = (numtaps - 1) // 2
    analog = analog[delay:]
    t_analog = t[:len(analog)]

    # Show a few periods of the sine wave
    n_periods = 5
    period = 1.0 / sine_freq
    t_show = n_periods * period
    show_mask = t_analog <= t_show

    # Also generate the ideal input sine for comparison
    n_samples = int(params.get("n_samples", 4096))
    nbit = int(params.get("nbit", 30))
    max_val = (1 << (nbit - 1)) - 1
    sample_rate = clk_freq / osr
    t_input = np.arange(n_samples) / sample_rate
    ideal_sine = amplitude * np.sin(2 * np.pi * sine_freq * t_input)
    input_mask = t_input <= t_show

    # Plot
    fig, ax = plt.subplots(figsize=(10, 5))

    ax.plot(t_analog[show_mask] * 1e3, analog[show_mask],
            linewidth=1.0, label="Reconstructed output", color="C0")
    ax.plot(t_input[input_mask] * 1e3, ideal_sine[input_mask],
            linewidth=1.0, linestyle="--", alpha=0.7,
            label="Input sine", color="C1")

    ax.set_xlabel("Time (ms)")
    ax.set_ylabel("Amplitude (normalized)")
    order_str = "1st" if order == 1 else "2nd"
    ax.set_title(
        f"Delta-Sigma Modulator — Reconstructed Analog Output\n"
        f"({order_str} order, OSR={osr}, f_clk={clk_freq/1e6:.0f} MHz, "
        f"f_sine={sine_freq/1e3:.1f} kHz, {amp_db:.0f} dBFS)"
    )
    ax.legend()
    ax.grid(True, alpha=0.3)

    plot_path = os.path.join(
        script_dir,
        f"dsmod_analog_ord{order}_osr{osr}_amp{amp_db:.0f}dBFS.png",
    )
    fig.savefig(plot_path, dpi=150, bbox_inches="tight")
    print(f"Analog output plot saved to {plot_path}")
    plt.close(fig)


if __name__ == "__main__":
    main()
