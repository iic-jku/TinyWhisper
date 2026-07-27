# Coupled-Resonator LC Band-Pass Filter

This macro contains schematic-only models of double-terminated, double-tuned (coupled-resonator) LC band-pass filters.
They are used as ideal off-chip matching/filter networks in the TinyWhisper system-level simulations
(e.g. together with the [iqmod](../iqmod) macro and the RF output pads).

## Cells

| Cell | Description |
|------|-------------|
| `coupled_resonator_lc_bpf_1k_1k` | LC band-pass filter, 1 kΩ source / 1 kΩ load termination |
| `coupled_resonator_lc_bpf_1k_50R` | LC band-pass filter, 1 kΩ source / 50 Ω load termination |

## Folder Structure

| Folder | Content |
|--------|---------|
| `schematic/xschem/` | Xschem schematics and symbols (+ `xschemrc`) |
| `testbenches/xschem/` | Xschem AC testbench (+ `xschemrc`) |
| `scripts/` | Filter design worksheet (Mathcad `.mcdx` + PDF export) |

## Usage

Run the AC testbench with:

```bash
make sim-xschem TB=coupled_resonator_lc_bpf_tb_ac
```

or open it interactively:

```bash
cd testbenches/xschem
xschem --rcfile xschemrc coupled_resonator_lc_bpf_tb_ac.sch
```

The component values are derived in `scripts/Double-Terminated Double-Tuned LC Bandpass Filters.pdf`.
