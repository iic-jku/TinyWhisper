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
# Cocotb testbench for verifying the dsmod linear interpolation.
# Feeds a linear ramp and captures the internal interpolated signal
# (data_interp_r) to check for smooth interpolation without steps.

import os
import math

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

# ----- Configuration -----
NBIT       = 30
CLK_FREQ   = 32e6
OSR        = int(os.environ.get("DSMOD_OSR", "32"))
ORDER      = int(os.environ.get("DSMOD_ORDER", "1"))
N_PER_LEG  = 64             # samples per ramp leg

# Port value mappings
OSR_TO_PORT   = {32: 0, 64: 1, 128: 2, 256: 3}
ORDER_TO_PORT = {1: 0, 2: 1}


def to_twos_complement(val, nbit):
    """Convert signed integer to two's complement unsigned for cocotb."""
    if val < 0:
        return val + (1 << nbit)
    return val


def from_twos_complement(val, nbit):
    """Convert two's complement unsigned to signed integer."""
    if val >= (1 << (nbit - 1)):
        return val - (1 << nbit)
    return val


@cocotb.test()
async def dsmod_ramp_test(dut):
    """Feed a linear ramp into the dsmod and capture the internal interpolated
    signal to verify correct piecewise-linear interpolation."""

    cocotb.start_soon(Clock(dut.i_clk, int(1e9 / CLK_FREQ), unit="ns").start())

    # Initialize
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

    # Generate triangle waveform: 0 → +FS → −FS → 0
    max_val = (1 << (NBIT - 1)) - 1
    min_val = -(1 << (NBIT - 1))

    # Leg 1: 0 → +max_val  (N_PER_LEG samples)
    leg1 = [int(round(max_val * i / (N_PER_LEG - 1))) for i in range(N_PER_LEG)]
    # Leg 2: +max_val → min_val  (2×N_PER_LEG samples, twice the range)
    leg2 = [int(round(max_val - (max_val - min_val) * i / (2 * N_PER_LEG - 1)))
            for i in range(1, 2 * N_PER_LEG)]
    # Leg 3: min_val → 0  (N_PER_LEG samples)
    leg3 = [int(round(min_val - min_val * i / (N_PER_LEG - 1)))
            for i in range(1, N_PER_LEG)]

    ramp_samples = leg1 + leg2 + leg3
    N_SAMPLES = len(ramp_samples)

    # Pre-load first sample
    dut.i_data.value = to_twos_complement(ramp_samples[0], NBIT)
    sample_idx = 1

    total_clocks = N_SAMPLES * OSR + OSR

    interp_width = NBIT + 8  # data_interp_r is [NBIT-1+8:0]
    interp_values = []
    input_samples_at_cycle = []
    fetch_ctr_log = []

    for clk_cycle in range(total_clocks):
        await RisingEdge(dut.i_clk)

        # Read internal interpolated value
        raw = int(dut.data_interp_r.value)
        interp_signed = from_twos_complement(raw, interp_width)
        interp_values.append(interp_signed)

        # Read fetch counter
        fetch_ctr_log.append(int(dut.fetch_ctr_r.value))

        # Feed next sample when requested
        if dut.o_data_rd.value == 1:
            if sample_idx < N_SAMPLES:
                dut.i_data.value = to_twos_complement(ramp_samples[sample_idx], NBIT)
                sample_idx += 1

    cocotb.log.info(f"Ramp test complete: {sample_idx} samples fed, "
                    f"{len(interp_values)} interpolated values captured")

    # Write results for post-processing
    out_dir = os.path.dirname(__file__) or "."

    interp_path = os.path.join(out_dir, "dsmod_ramp_interp.txt")
    with open(interp_path, "w") as f:
        for val in interp_values:
            f.write(f"{val}\n")
    cocotb.log.info(f"Interpolated values written to {interp_path}")

    fetch_path = os.path.join(out_dir, "dsmod_ramp_fetch.txt")
    with open(fetch_path, "w") as f:
        for val in fetch_ctr_log:
            f.write(f"{val}\n")

    params_path = os.path.join(out_dir, "dsmod_ramp_params.txt")
    with open(params_path, "w") as f:
        f.write(f"osr={OSR}\n")
        f.write(f"order={ORDER}\n")
        f.write(f"nbit={NBIT}\n")
        f.write(f"n_samples={N_SAMPLES}\n")
        f.write(f"n_per_leg={N_PER_LEG}\n")
        f.write(f"clk_freq={CLK_FREQ}\n")

    # Write the input ramp samples (extended to match hardware representation)
    ramp_path = os.path.join(out_dir, "dsmod_ramp_input.txt")
    with open(ramp_path, "w") as f:
        for s in ramp_samples:
            f.write(f"{s * 256}\n")  # ×256 to match {i_data, 8'b0} extension

    cocotb.log.info("Ramp test data files written — run dsmod_plot_ramp.py to analyse")
