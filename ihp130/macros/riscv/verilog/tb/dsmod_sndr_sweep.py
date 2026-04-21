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
# Parallel SNDR sweep runner for the delta-sigma modulator.
# Builds the Verilog design once, then launches parallel simulator
# processes — one per amplitude point — and collects results.

import os
import sys
import subprocess
import tempfile
from concurrent.futures import ProcessPoolExecutor, as_completed

# ----- Sweep configuration (must match dsmod_cocotb.py) -----
AMP_SWEEP_DB_START = -80
AMP_SWEEP_DB_STOP  = -1
AMP_SWEEP_DB_STEP  = 3
OSR   = int(os.environ.get("DSMOD_OSR", "64"))
ORDER = int(os.environ.get("DSMOD_ORDER", "2"))

# Max parallel simulator processes (adjust to your CPU core count)
MAX_WORKERS = int(os.environ.get("DSMOD_JOBS", os.cpu_count() or 4))


def _find_paths():
    """Resolve project paths."""
    script_dir = os.path.dirname(os.path.abspath(__file__))
    src_path = os.path.normpath(os.path.join(script_dir, "..", "src"))
    return script_dir, src_path


def _build(script_dir, src_path, build_dir):
    """Compile the Verilog design once with Icarus Verilog."""
    os.makedirs(build_dir, exist_ok=True)
    vvp_path = os.path.join(build_dir, "sim.vvp")
    src_file = os.path.join(src_path, "dsmod.v")

    # Create a timescale file (needed when running vvp directly)
    ts_file = os.path.join(build_dir, "timescale.v")
    with open(ts_file, "w") as f:
        f.write("`timescale 1ns/100ps\n")

    # Get cocotb VPI library paths and libpython location
    cocotb_lib = subprocess.check_output(
        ["python3.13", "-c",
         "import cocotb; import os; print(os.path.join(os.path.dirname(cocotb.__file__), 'libs'))"],
        text=True
    ).strip()

    libpython_loc = subprocess.check_output(
        ["python3.13", "-c",
         "import find_libpython; print(find_libpython.find_libpython())"],
        text=True
    ).strip()

    cmd = [
        "iverilog", "-o", vvp_path, "-s", "dsmod",
        "-g2012", ts_file, src_file
    ]
    print(f"[build] {' '.join(cmd)}")
    subprocess.check_call(cmd)
    return vvp_path, cocotb_lib, libpython_loc


def _run_single_amplitude(args):
    """Run one simulator instance for a single amplitude point."""
    amp_db, vvp_path, cocotb_lib, libpython_loc, script_dir, out_dir = args

    env = os.environ.copy()
    env["COCOTB_TEST_MODULES"] = "dsmod_cocotb"
    env["COCOTB_TEST_FILTER"] = "dsmod_sndr_single_test"
    env["COCOTB_TOPLEVEL"] = "dsmod"
    env["TOPLEVEL_LANG"] = "verilog"
    env["LIBPYTHON_LOC"] = libpython_loc
    env["COCOTB_HDL_TIMEUNIT"] = "1ns"
    env["COCOTB_HDL_TIMEPRECISION"] = "100ps"
    env["DSMOD_AMP_DB"] = str(amp_db)
    env["DSMOD_OUT_DIR"] = out_dir
    env["DSMOD_OSR"] = str(OSR)
    env["DSMOD_ORDER"] = str(ORDER)
    # cocotb 2.0 needs PYGPI_PYTHON_BIN to find the Python interpreter
    env["PYGPI_PYTHON_BIN"] = sys.executable
    # Suppress cocotb dsmod_results.xml to avoid conflicts
    env["COCOTB_RESULTS_FILE"] = os.path.join(out_dir, f"dsmod_results_{amp_db:+.0f}dB.xml")

    cmd = ["vvp", "-M", cocotb_lib, "-m", "libcocotbvpi_icarus", vvp_path]

    result = subprocess.run(
        cmd, capture_output=True, text=True, cwd=script_dir, env=env
    )

    if result.returncode != 0:
        print(f"[FAIL] amp={amp_db:+.0f} dBFS — vvp returned {result.returncode}",
              file=sys.stderr)
        if result.stderr:
            print(result.stderr[-1000:], file=sys.stderr)
        if result.stdout:
            print(result.stdout[-1000:], file=sys.stderr)
        return amp_db, None

    # Read result file
    result_file = os.path.join(out_dir, f"dsmod_sndr_{amp_db:+.0f}dB.txt")
    if os.path.exists(result_file):
        with open(result_file) as f:
            parts = f.read().strip().split()
            return float(parts[0]), float(parts[2])
    else:
        # Log stdout for debugging
        log_file = os.path.join(out_dir, f"dsmod_debug_{amp_db:+.0f}dB.log")
        with open(log_file, "w") as f:
            f.write("=== STDOUT ===\n")
            f.write(result.stdout or "(empty)")
            f.write("\n=== STDERR ===\n")
            f.write(result.stderr or "(empty)")
        print(f"[WARN] No result file for amp={amp_db:+.0f} dBFS (debug log: {log_file})",
              file=sys.stderr)
        return amp_db, None


def main():
    script_dir, src_path = _find_paths()
    build_dir = os.path.join(script_dir, "dsmod_sim_build")
    out_dir = os.path.join(script_dir, "dsmod_sndr_results")
    os.makedirs(out_dir, exist_ok=True)

    # Build once
    print(f"[info] Building design...")
    vvp_path, cocotb_lib, libpython_loc = _build(script_dir, src_path, build_dir)

    # Generate amplitude sweep points
    amp_db_values = list(range(AMP_SWEEP_DB_START, AMP_SWEEP_DB_STOP + 1, AMP_SWEEP_DB_STEP))
    n_points = len(amp_db_values)

    print(f"[info] SNDR sweep: {n_points} amplitude points from "
          f"{AMP_SWEEP_DB_START} to {AMP_SWEEP_DB_STOP} dBFS (step {AMP_SWEEP_DB_STEP} dB)")
    print(f"[info] Parallel workers: {MAX_WORKERS}")

    # Prepare arguments for each worker
    work_items = [
        (amp_db, vvp_path, cocotb_lib, libpython_loc, script_dir, out_dir)
        for amp_db in amp_db_values
    ]

    # Run in parallel
    results = {}
    with ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        futures = {executor.submit(_run_single_amplitude, item): item[0]
                   for item in work_items}
        for future in as_completed(futures):
            amp_db = futures[future]
            try:
                a, sndr = future.result()
                if sndr is not None:
                    results[a] = sndr
                    print(f"  [{len(results):3d}/{n_points}] amp={a:+4.0f} dBFS  SNDR={sndr:.1f} dB")
                else:
                    print(f"  [{len(results):3d}/{n_points}] amp={amp_db:+4.0f} dBFS  FAILED")
            except Exception as e:
                print(f"  [{len(results):3d}/{n_points}] amp={amp_db:+4.0f} dBFS  ERROR: {e}")

    # Sort and write combined results
    sorted_results = sorted(results.items())
    out_path = os.path.join(script_dir, "dsmod_sndr.txt")
    with open(out_path, "w") as f:
        f.write("# amp_dBFS amplitude SNDR_dB\n")
        for amp_db, sndr in sorted_results:
            amplitude = 10.0 ** (amp_db / 20.0)
            f.write(f"{amp_db:.0f} {amplitude:.8e} {sndr:.2f}\n")
    print(f"\n[info] Combined SNDR results written to {out_path}")
    print(f"[info] {len(sorted_results)}/{n_points} points succeeded")

    # Write params for the plotting script
    # Compute coherent sine frequency to match dsmod_cocotb.py
    clk_freq = 32000000.0
    n_samples = 4096
    n_bitstream = n_samples * OSR
    df = clk_freq / n_bitstream
    sine_freq = round(8192 / df) * df
    params_path = os.path.join(script_dir, "dsmod_params.txt")
    with open(params_path, "w") as f:
        f.write(f"clk_freq={clk_freq}\n")
        f.write(f"osr={OSR}\n")
        f.write(f"sine_freq={sine_freq}\n")
        f.write(f"n_samples={n_samples}\n")
        f.write(f"amplitude=0.5\n")
        f.write(f"nbit=30\n")
        f.write(f"order={ORDER}\n")

    if len(sorted_results) < n_points:
        sys.exit(1)


if __name__ == "__main__":
    main()
