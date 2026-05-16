# SPDX-FileCopyrightText: 2026 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
#
# Cocotb testbench for the delta-sigma modulator (dsmod).
# Feeds a digital sine wave, captures the 1-bit output stream,
# and plots the PSD of the output.

import os
import math

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
from cocotb_tools.runner import get_runner

# ----- Configuration -----
NBIT       = 30            # dsmod data width
CLK_FREQ   = 56e6          # 56 MHz clock
CLK_PERIOD = 1 / CLK_FREQ  # in seconds

# Easily adjustable via environment variables
ORDER      = int(os.environ.get("DSMOD_ORDER", "2"))      # 1=1st order, 2=2nd order
OSR        = int(os.environ.get("DSMOD_OSR", "64"))        # 32, 64, 128, or 256
AMP_PSD_DB = float(os.environ.get("DSMOD_AMP_PSD", "-3")) # PSD test amplitude in dBFS

# Derived parameters
N_SAMPLES   = 4096          # number of input samples to feed
SAMPLE_RATE = CLK_FREQ / OSR  # effective sample rate at input
AMPLITUDE   = 10.0 ** (AMP_PSD_DB / 20.0)  # linear amplitude for PSD test

# Coherent sampling: snap sine frequency to the nearest FFT bin so that
# the tone falls exactly on a bin and spectral leakage is minimised.
_N_BITSTREAM = N_SAMPLES * OSR           # total output samples
_DF          = CLK_FREQ / _N_BITSTREAM   # FFT bin spacing
SINE_FREQ    = round(8192 / _DF) * _DF   # nearest coherent frequency

# Port value mappings for dsmod hardware
OSR_TO_PORT   = {32: 0, 64: 1, 128: 2, 256: 3}
ORDER_TO_PORT = {1: 0, 2: 1}

# Amplitude sweep parameters (for SNDR test)
AMP_SWEEP_DB_START = -60   # start amplitude in dBFS
AMP_SWEEP_DB_STOP  = -1    # stop amplitude in dBFS
AMP_SWEEP_DB_STEP  = 3     # step size in dB


def generate_sine_samples(n_samples, freq, fs, amplitude, nbit):
    """Generate signed integer sine wave samples."""
    max_val = (1 << (nbit - 1)) - 1
    samples = []
    for i in range(n_samples):
        t = i / fs
        val = amplitude * math.sin(2 * math.pi * freq * t)
        sample = int(round(val * max_val))
        # Clamp
        sample = max(-(1 << (nbit - 1)), min(max_val, sample))
        samples.append(sample)
    return samples


def to_twos_complement(val, nbit):
    """Convert signed integer to two's complement unsigned for cocotb assignment."""
    if val < 0:
        return val + (1 << nbit)
    return val


@cocotb.test()
async def dsmod_psd_test(dut):
    """Feed a digital sine wave into the dsmod and capture output for PSD analysis."""

    # Start clock
    cocotb.start_soon(Clock(dut.i_clk, int(1e9 / CLK_FREQ), unit="ns").start())

    # Initialize signals
    dut.i_rst_n.value   = 0
    dut.i_ena_mod.value = 0
    dut.i_data.value    = 0
    dut.i_mode.value    = ORDER_TO_PORT[ORDER]
    dut.i_osr.value     = OSR_TO_PORT[OSR]

    # Reset
    for _ in range(10):
        await RisingEdge(dut.i_clk)
    dut.i_rst_n.value = 1
    for _ in range(5):
        await RisingEdge(dut.i_clk)

    # Enable modulator
    dut.i_ena_mod.value = 1

    # Generate sine wave samples
    sine_samples = generate_sine_samples(N_SAMPLES, SINE_FREQ, SAMPLE_RATE, AMPLITUDE, NBIT)

    # Capture output stream
    output_bits = []
    sample_idx = 0

    # Feed samples based on o_data_rd strobe
    dut.i_data.value = to_twos_complement(sine_samples[0], NBIT)
    sample_idx = 1

    total_clocks = N_SAMPLES * OSR + OSR  # enough clocks to process all samples

    for clk_cycle in range(total_clocks):
        await RisingEdge(dut.i_clk)

        # Capture differential output: o_ds=1 → +1, o_ds=0 → -1
        output_bits.append(1 if int(dut.o_ds.value) else -1)

        # When dsmod requests next sample, feed it
        if dut.o_data_rd.value == 1:
            if sample_idx < N_SAMPLES:
                dut.i_data.value = to_twos_complement(sine_samples[sample_idx], NBIT)
                sample_idx += 1

    cocotb.log.info(f"Simulation complete: {sample_idx} samples fed, {len(output_bits)} output bits captured")

    # Write output bits to file for post-processing
    out_path = os.path.join(os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__))), "dsmod_output.txt")
    with open(out_path, "w") as f:
        for bit in output_bits:
            f.write(f"{bit}\n")
    cocotb.log.info(f"Output bitstream written to {out_path}")

    # Write simulation parameters for the plotting script
    params_path = os.path.join(os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__))), "dsmod_params.txt")
    with open(params_path, "w") as f:
        f.write(f"clk_freq={CLK_FREQ}\n")
        f.write(f"osr={OSR}\n")
        f.write(f"sine_freq={SINE_FREQ}\n")
        f.write(f"n_samples={N_SAMPLES}\n")
        f.write(f"amplitude={AMPLITUDE}\n")
        f.write(f"nbit={NBIT}\n")
        f.write(f"order={ORDER}\n")
    cocotb.log.info(f"Simulation parameters written to {params_path}")


async def _run_dsmod(dut, amplitude, n_samples, sine_freq, sample_rate, nbit, osr, clk_freq, order=2):
    """Run the dsmod at a given amplitude and return the bipolar output list."""

    # Start clock (idempotent — if already running cocotb handles it)
    cocotb.start_soon(Clock(dut.i_clk, int(1e9 / clk_freq), unit="ns").start())

    # Reset
    dut.i_rst_n.value   = 0
    dut.i_ena_mod.value = 0
    dut.i_data.value    = 0
    dut.i_mode.value    = ORDER_TO_PORT[order]
    dut.i_osr.value     = OSR_TO_PORT[osr]

    for _ in range(10):
        await RisingEdge(dut.i_clk)
    dut.i_rst_n.value = 1
    for _ in range(5):
        await RisingEdge(dut.i_clk)

    dut.i_ena_mod.value = 1

    sine_samples = generate_sine_samples(n_samples, sine_freq, sample_rate, amplitude, nbit)

    output_bits = []
    sample_idx = 0

    dut.i_data.value = to_twos_complement(sine_samples[0], nbit)
    sample_idx = 1

    total_clocks = n_samples * osr + osr

    for _ in range(total_clocks):
        await RisingEdge(dut.i_clk)
        output_bits.append(1 if int(dut.o_ds.value) else -1)
        if dut.o_data_rd.value == 1:
            if sample_idx < n_samples:
                dut.i_data.value = to_twos_complement(sine_samples[sample_idx], nbit)
                sample_idx += 1

    return output_bits


@cocotb.test()
async def dsmod_sndr_single_test(dut):
    """Run a single SNDR measurement at amplitude from DSMOD_AMP_DB env var."""
    import numpy as np

    amp_db = float(os.environ.get("DSMOD_AMP_DB", "-6"))
    amplitude = 10.0 ** (amp_db / 20.0)
    cocotb.log.info(f"SNDR single point: {amp_db} dBFS (amplitude={amplitude:.6f})")

    output_bits = await _run_dsmod(
        dut, amplitude, N_SAMPLES, SINE_FREQ, SAMPLE_RATE, NBIT, OSR, CLK_FREQ, ORDER
    )

    # Compute SNDR in-band
    bipolar = np.array(output_bits, dtype=float)
    N = len(bipolar)
    win = np.hanning(N)
    S2 = np.sum(win ** 2)
    spectrum = np.fft.rfft(bipolar * win)
    psd = (2.0 / (CLK_FREQ * S2)) * np.abs(spectrum) ** 2
    psd[0] /= 2.0
    freq = np.fft.rfftfreq(N, d=1.0 / CLK_FREQ)

    bw = CLK_FREQ / (2.0 * OSR)
    in_band = freq <= bw

    signal_band = in_band & (freq >= SINE_FREQ * 0.8) & (freq <= SINE_FREQ * 1.2)
    if np.any(signal_band):
        sig_idx = np.argmax(psd[signal_band])
        sig_indices = np.where(signal_band)[0]
        peak_idx = sig_indices[sig_idx]
        sig_bins = range(max(1, peak_idx - 3), min(len(psd), peak_idx + 4))
        signal_power = np.sum(psd[list(sig_bins)]) * (freq[1] - freq[0])
    else:
        signal_power = 1e-30

    nd_mask = in_band.copy()
    nd_mask[0] = False
    for b in sig_bins:
        nd_mask[b] = False
    noise_power = np.sum(psd[nd_mask]) * (freq[1] - freq[0])

    sndr = 10.0 * np.log10(signal_power / (noise_power + 1e-30))
    cocotb.log.info(f"  amp={amp_db:+.1f} dBFS  SNDR={sndr:.1f} dB")

    # Write result to a per-amplitude file
    out_dir = os.environ.get(
        "DSMOD_OUT_DIR",
        os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__))),
    )
    result_path = os.path.join(out_dir, f"dsmod_sndr_{amp_db:+.0f}dB.txt")
    with open(result_path, "w") as f:
        f.write(f"{amp_db} {amplitude:.8e} {sndr:.2f}\n")
    cocotb.log.info(f"Result written to {result_path}")


@cocotb.test()
async def dsmod_sndr_sweep_test(dut):
    """Sweep input amplitude and record SNDR for each level."""
    import numpy as np

    amp_db_values = list(range(AMP_SWEEP_DB_START, AMP_SWEEP_DB_STOP + 1, AMP_SWEEP_DB_STEP))
    results = []

    for amp_db in amp_db_values:
        amplitude = 10.0 ** (amp_db / 20.0)
        cocotb.log.info(f"Running amplitude sweep: {amp_db} dBFS (amplitude={amplitude:.6f})")

        output_bits = await _run_dsmod(
            dut, amplitude, N_SAMPLES, SINE_FREQ, SAMPLE_RATE, NBIT, OSR, CLK_FREQ, ORDER
        )

        # Compute SNDR in-band
        bipolar = np.array(output_bits, dtype=float)
        N = len(bipolar)
        win = np.hanning(N)
        S2 = np.sum(win ** 2)
        spectrum = np.fft.rfft(bipolar * win)
        psd = (2.0 / (CLK_FREQ * S2)) * np.abs(spectrum) ** 2
        psd[0] /= 2.0
        freq = np.fft.rfftfreq(N, d=1.0 / CLK_FREQ)

        # In-band: DC to f_clk / (2 * OSR)
        bw = CLK_FREQ / (2.0 * OSR)
        in_band = freq <= bw

        # Find signal bin (largest in-band bin near SINE_FREQ)
        signal_band = in_band & (freq >= SINE_FREQ * 0.8) & (freq <= SINE_FREQ * 1.2)
        if np.any(signal_band):
            sig_idx = np.argmax(psd[signal_band])
            sig_indices = np.where(signal_band)[0]
            peak_idx = sig_indices[sig_idx]
            # Signal power: peak bin ± 3 bins (Hann window leakage)
            sig_bins = range(max(1, peak_idx - 3), min(len(psd), peak_idx + 4))
            signal_power = np.sum(psd[list(sig_bins)]) * (freq[1] - freq[0])
        else:
            signal_power = 1e-30

        # Noise+distortion: all in-band bins except signal bins
        nd_mask = in_band.copy()
        nd_mask[0] = False  # exclude DC
        for b in sig_bins:
            nd_mask[b] = False
        noise_power = np.sum(psd[nd_mask]) * (freq[1] - freq[0])

        sndr = 10.0 * np.log10(signal_power / (noise_power + 1e-30))
        results.append((amp_db, amplitude, sndr))
        cocotb.log.info(f"  amp={amp_db:+4d} dBFS  SNDR={sndr:.1f} dB")

    # Write results to file
    out_path = os.path.join(os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__))), "dsmod_sndr.txt")
    with open(out_path, "w") as f:
        f.write("# amp_dBFS amplitude SNDR_dB\n")
        for amp_db, amplitude, sndr in results:
            f.write(f"{amp_db} {amplitude:.8e} {sndr:.2f}\n")
    cocotb.log.info(f"SNDR sweep results written to {out_path}")

    # Write params for plotting
    params_path = os.path.join(os.environ.get("DSMOD_RESULT_DIR", os.path.dirname(os.path.abspath(__file__))), "dsmod_params.txt")
    with open(params_path, "w") as f:
        f.write(f"clk_freq={CLK_FREQ}\n")
        f.write(f"osr={OSR}\n")
        f.write(f"sine_freq={SINE_FREQ}\n")
        f.write(f"n_samples={N_SAMPLES}\n")
        f.write(f"amplitude={AMPLITUDE}\n")
        f.write(f"nbit={NBIT}\n")
        f.write(f"order={ORDER}\n")
    cocotb.log.info(f"Parameters written to {params_path}")


# ----- Runner for standalone execution -----
def test_dsmod_runner():
    """Entry point for running the simulation."""
    sim = os.getenv("SIM", "icarus")
    proj_path = os.path.dirname(os.path.abspath(__file__))
    src_path = os.path.join(proj_path, "..", "src")

    runner = get_runner(sim)
    runner.build(
        verilog_sources=[os.path.join(src_path, "dsmod.v")],
        hdl_toplevel="dsmod",
        build_dir=os.path.join(proj_path, "dsmod_sim_build"),
        build_args=["-g2012"],
    )
    runner.test(
        hdl_toplevel="dsmod",
        test_module="dsmod_cocotb",
        build_dir=os.path.join(proj_path, "dsmod_sim_build"),
        waves=True,
    )


if __name__ == "__main__":
    test_dsmod_runner()
