# Delta-Sigma Modulator (`dsmod`) Cocotb Testbench

Cocotb-based verification environment for the delta-sigma modulator. Supports PSD analysis of the output bitstream and SNDR vs. input amplitude sweeps.

## Prerequisites

- **Python 3.13** (cocotb 2.0.1 is incompatible with Python 3.14)
- **Icarus Verilog** (`iverilog`, `vvp`)
- Python packages: `cocotb`, `numpy`, `scipy`, `matplotlib`, `find_libpython`

Install dependencies:

```bash
pip3.13 install cocotb numpy scipy matplotlib find_libpython
```

## PSD Simulation

Runs a single-tone test and plots the Power Spectral Density of the 1-bit output stream.

```bash
make -f Makefile.dsmod plot PYTHON_BIN=python3.13
```

### Configuration

Parameters are set via environment variables (defaults in parentheses):

| Variable        | Description                        | Default |
|-----------------|------------------------------------|---------|
| `DSMOD_ORDER`   | Modulator order: `1` or `2`        | `2`     |
| `DSMOD_OSR`     | Oversampling ratio: 32/64/128/256  | `64`    |
| `DSMOD_AMP_PSD` | Input amplitude in dBFS            | `-8`    |

Example — 1st-order modulator, OSR=128, at −20 dBFS:

```bash
DSMOD_ORDER=1 DSMOD_OSR=128 DSMOD_AMP_PSD=-20 \
  make -f Makefile.dsmod plot PYTHON_BIN=python3.13
```

Output plots:
- `dsmod_psd_ord<ORDER>_osr<OSR>_amp<AMP>dBFS.png` — Power Spectral Density
- `dsmod_analog_ord<ORDER>_osr<OSR>_amp<AMP>dBFS.png` — Reconstructed analog output (low-pass filtered bitstream vs. input sine)

## SNDR Sweep

Sweeps input amplitude from −80 to −1 dBFS (3 dB steps) and plots SNDR vs. input level. Runs amplitude points in parallel across all CPU cores.

```bash
make -f Makefile.dsmod sndr PYTHON_BIN=python3.13
```

### Configuration

| Variable       | Description                         | Default       |
|----------------|-------------------------------------|---------------|
| `DSMOD_ORDER`  | Modulator order: `1` or `2`         | `2`           |
| `DSMOD_OSR`    | Oversampling ratio: 32/64/128/256   | `64`          |
| `DSMOD_JOBS`   | Max parallel simulator processes    | CPU count     |

Example — 2nd-order, OSR=256:

```bash
DSMOD_ORDER=2 DSMOD_OSR=256 \
  make -f Makefile.dsmod sndr PYTHON_BIN=python3.13
```

Output plot: `dsmod_sndr_ord<ORDER>_osr<OSR>.png`

## Ramp Interpolation Test

Feeds a linear ramp into the dsmod and captures the internal `data_interp_r` signal to verify correct piecewise-linear interpolation. Reports any step discontinuities.

```bash
make -f Makefile.dsmod ramp PYTHON_BIN=python3.13
```

Configuration uses `DSMOD_ORDER` and `DSMOD_OSR` (same as above).

Output plot: `dsmod_ramp_ord<ORDER>_osr<OSR>.png`

## Fixed Parameters

| Parameter  | Value   | Description                    |
|------------|---------|--------------------------------|
| `CLK_FREQ` | 32 MHz  | Modulator clock frequency      |
| `NBIT`     | 30      | Input data width               |
| `SINE_FREQ`| 8192 Hz | Test tone frequency             |
| `N_SAMPLES`| 4096    | Number of input samples per run |

## File Overview

| File                    | Purpose                                      |
|-------------------------|----------------------------------------------|
| `dsmod_cocotb.py`       | Cocotb test module (PSD + SNDR tests)        |
| `dsmod_sndr_sweep.py`   | Parallel SNDR sweep runner                   |
| `dsmod_plot_psd.py`     | PSD post-processing and plotting             |
| `dsmod_plot_analog.py`  | Reconstructed analog output plotting         |
| `dsmod_plot_sndr.py`    | SNDR post-processing and plotting            |
| `dsmod_ramp_cocotb.py`  | Cocotb ramp interpolation test               |
| `dsmod_plot_ramp.py`    | Ramp interpolation analysis and plotting     |
| `Makefile.dsmod`        | Make targets: `plot`, `sndr`, `ramp`         |
