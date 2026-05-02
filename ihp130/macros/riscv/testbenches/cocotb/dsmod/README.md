# Delta-Sigma Modulator (`dsmod`) Cocotb Testbench

Cocotb-based verification environment for the delta-sigma modulator. Supports PSD analysis of the output bitstream, SNDR vs. input amplitude sweeps, and a ramp interpolation test.


## Prerequisites

- **Python 3.13** (cocotb 2.0.1 is incompatible with Python 3.14)
- **Icarus Verilog** (`iverilog`, `vvp`)
- Python packages: `cocotb`, `numpy`, `scipy`, `matplotlib`, `find_libpython`

Install dependencies:

```sh
pip3.13 install cocotb numpy scipy matplotlib find_libpython
```


## File Overview

| File                  | Purpose                                      |
|-----------------------|----------------------------------------------|
| `dsmod_cocotb.py`     | Cocotb test module (PSD + SNDR tests)        |
| `dsmod_sndr_sweep.py` | Parallel SNDR sweep runner                   |
| `dsmod_plot_psd.py`   | PSD post-processing and plotting             |
| `dsmod_plot_analog.py`| Reconstructed analog output plotting         |
| `dsmod_plot_sndr.py`  | SNDR post-processing and plotting            |
| `dsmod_ramp_cocotb.py`| Cocotb ramp interpolation test               |
| `dsmod_plot_ramp.py`  | Ramp interpolation analysis and plotting     |
| `Makefile`            | Make targets: `help`, `sim`, `psd`, `sndr`, `ramp`, `clean`, `all`, `all_runs` |


## Fixed Test Parameters

| Parameter   | Value   | Description                     |
|-------------|---------|---------------------------------|
| `CLK_FREQ`  | 56 MHz  | Modulator clock frequency       |
| `NBIT`      | 30      | Input data width                |
| `SINE_FREQ` | 8192 Hz | Test tone frequency             |
| `N_SAMPLES` | 4096    | Number of input samples per run |


## Fixed Simulation Settings

| Variable                   | Value                          |
|----------------------------|--------------------------------|
| `TOPLEVEL`                 | `dsmod`                        |
| `VERILOG_SOURCES`          | `$(SRC_DIR)/dsmod.v`           |
| `COCOTB_TEST_MODULES`      | `dsmod_cocotb`                 |
| `SIM_BUILD`                | `results/dsmod_sim_build` (default `sim` target) |
| `COCOTB_RESULTS_FILE`      | `results/dsmod_results.xml` (default `sim` target) |
| `COCOTB_HDL_TIMEUNIT`      | `1ns`                          |
| `COCOTB_HDL_TIMEPRECISION` | `100ps`                        |
| `COMPILE_ARGS`             | `-g2012`                       |


## Show Available Targets

The default Make target is `help`, so running `make` prints all available custom targets:

```sh
make
make help
```


## Simulation Notes

The Makefile includes cocotb's `Makefile.sim`, so the standard `sim` target is available directly:

```sh
make sim
```

The custom targets use dedicated result subdirectories:

- `make psd` writes to `results/psd/`
- `make sndr` writes to `results/sndr/`
- `make ramp` writes to `results/ramp/`

For `psd` and `ramp`, the recursive `sim` call passes `SIM_BUILD` and `COCOTB_RESULTS_FILE` as make command-line variables, so cocotb artefacts are written directly into the respective subdirectory (instead of `results/`).

## Clean

Removes the full `results/` tree (including `results/psd/`, `results/sndr/`, and `results/ramp/`).

```sh
make clean
```


## PSD Simulation

Runs only the PSD test (`dsmod_psd_test`) from `dsmod_cocotb`, then generates PSD and analog-output plots. Runs a single-tone test and plots the Power Spectral Density of the 1-bit output stream.

```sh
make psd
make psd PYTHON_BIN=python3.13
```

### Configuration

Parameters are set via environment variables (defaults in parentheses):

| Variable        | Description                        | Default |
|-----------------|------------------------------------|---------|
| `DSMOD_ORDER`   | Modulator order: `1` or `2`        | `2`     |
| `DSMOD_OSR`     | Oversampling ratio: 32/64/128/256  | `64`    |
| `DSMOD_AMP_PSD` | Input amplitude in dBFS            | `-8`    |

Example — 1st-order modulator, OSR=128, at −20 dBFS:

```sh
DSMOD_ORDER=1 DSMOD_OSR=128 DSMOD_AMP_PSD=-20 make psd PYTHON_BIN=python3.13
```

Output plots in `results/psd/`:
- `dsmod_psd_ord<ORDER>_osr<OSR>_amp<AMP>dBFS.png` — Power Spectral Density
- `dsmod_analog_ord<ORDER>_osr<OSR>_amp<AMP>dBFS.png` — Reconstructed analog output (low-pass filtered bitstream vs. input sine)

Additional generated files in `results/psd/`:
- `dsmod_output.txt` — Captured 1-bit output stream
- `dsmod_params.txt` — Simulation parameters consumed by the plotting scripts
- `dsmod_results.xml` — Cocotb results XML
- `dsmod_sim_build/` — Cocotb simulator build directory


## SNDR Sweep

Sweeps input amplitude from −80 to −1 dBFS (3 dB steps) and plots SNDR vs. input level. Runs amplitude points in parallel across all CPU cores.

```sh
make sndr
make sndr PYTHON_BIN=python3.13
```

### Configuration

| Variable       | Description                         | Default       |
|----------------|-------------------------------------|---------------|
| `DSMOD_ORDER`  | Modulator order: `1` or `2`         | `2`           |
| `DSMOD_OSR`    | Oversampling ratio: 32/64/128/256   | `64`          |
| `DSMOD_JOBS`   | Max parallel simulator processes    | CPU count     |

Example — 2nd-order, OSR=256:

```sh
DSMOD_ORDER=2 DSMOD_OSR=256 make sndr PYTHON_BIN=python3.13
```

Generated outputs in `results/sndr/`:
- `dsmod_sndr_ord<ORDER>_osr<OSR>.png` — SNDR sweep plot
- `dsmod_sndr.txt` — Combined sweep results
- `dsmod_sndr_results/` — Per-amplitude logs and XML result files
- `dsmod_results.xml` — Cocotb results XML
- `dsmod_sim_build/` — Cocotb simulator build directory

## Ramp Interpolation Test

Feeds a linear ramp into the dsmod and captures the internal `data_interp_r` signal to verify correct piecewise-linear interpolation. Reports any step discontinuities.

```sh
make ramp
make ramp PYTHON_BIN=python3.13
```

Configuration uses `DSMOD_ORDER` and `DSMOD_OSR` (same as above).

Generated outputs in `results/ramp/`:
- `dsmod_ramp_ord<ORDER>_osr<OSR>.png` — Ramp interpolation plot
- `dsmod_ramp_interp.txt` — Captured interpolated samples
- `dsmod_ramp_input.txt` — Input ramp samples
- `dsmod_ramp_fetch.txt` — Fetch counter trace
- `dsmod_ramp_params.txt` — Ramp post-processing parameters
- `dsmod_results.xml` — Cocotb results XML
- `dsmod_sim_build/` — Cocotb simulator build directory


## All

Runs `clean`, then `psd`, `sndr`, and `ramp` in sequence with fixed baseline settings (`DSMOD_ORDER=2`, `DSMOD_OSR=64`):

```sh
make all PYTHON_BIN=python3.13
```


## All Runs

Runs `clean`, then executes `psd`, `sndr`, and `ramp` for all combinations:

- `DSMOD_ORDER`: `1`, `2`
- `DSMOD_OSR`: `32`, `64`, `128`, `256`

```sh
make all_runs PYTHON_BIN=python3.13
```

This target performs a full characterization sweep and can take significantly longer than `make all`.
