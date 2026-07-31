# Coupled-Resonator LC Band-Pass Filter

This macro contains schematic-only models of double-terminated, double-tuned (coupled-resonator) LC band-pass filters.
They are used as ideal off-chip matching / filter networks in the TinyWhisper system-level simulations, for example together with the [iqmod](../iqmod) macro and the RF output pads.

Since the macro is schematic-only, it has no layout, no build and no verification targets: its `Makefile` only provides the Xschem simulation targets.

| Cell | Description |
|------|-------------|
| `coupled_resonator_lc_bpf_1k_1k` | LC band-pass filter, 1 kΩ source / 1 kΩ load termination |
| `coupled_resonator_lc_bpf_1k_50R` | LC band-pass filter, 1 kΩ source / 50 Ω load termination |


## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 coupled_resonator_lc_bpf/
├─ 📁 schematic/
│  └─ 📁 xschem/
│     ├─ coupled_resonator_lc_bpf_1k_1k.sch
│     ├─ coupled_resonator_lc_bpf_1k_1k.sym
│     ├─ coupled_resonator_lc_bpf_1k_50R.sch
│     ├─ coupled_resonator_lc_bpf_1k_50R.sym
│     └─ xschemrc
├─ 📁 scripts/
│  ├─ Double-Terminated Double-Tuned LC Bandpass Filters.mcdx
│  └─ Double-Terminated Double-Tuned LC Bandpass Filters.pdf
├─ 📁 testbenches/
│  └─ 📁 xschem/
│     ├─ coupled_resonator_lc_bpf_tb_ac.sch
│     └─ xschemrc
├─ Makefile
└─ README.md
```

</details>


## Makefile Targets

### Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```


### Run Xschem Testbench Simulation

Runs a single Xschem testbench in batch mode (no display): saves the schematic, exports the netlist to `testbenches/xschem/simulations/`, and runs the simulator.

The target netlists the testbench with `xschem netlist` and then invokes `ngspice -b` directly instead of using `xschem simulate`. `xschem simulate` would spawn an interactive ngspice in a terminal detached from `make`: the target would return immediately, the result would never be checked, and the process (with its X server) would leak. Running the simulator directly makes `make` block until the run finishes and see its exit status.

The testbench name **must** be specified via the `TB` variable:

```sh
make sim-xschem TB=coupled_resonator_lc_bpf_tb_ac
```

To open the testbench interactively instead:

```sh
cd testbenches/xschem
xschem --rcfile xschemrc coupled_resonator_lc_bpf_tb_ac.sch
```


### Simulate All

Runs every testbench of this macro (currently the single AC testbench):

```sh
make sim-all
```


### Simulate All Target

`make all` is an alias for `sim-all`, since this macro is schematic-only:

```sh
make all
```


## Component Values

The component values are derived in [`scripts/Double-Terminated Double-Tuned LC Bandpass Filters.pdf`](scripts/Double-Terminated%20Double-Tuned%20LC%20Bandpass%20Filters.pdf), exported from the corresponding Mathcad worksheet in the same folder.
