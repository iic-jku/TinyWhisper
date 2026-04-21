# ihp-sg13g2 RISC-V CPU

> [!IMPORTANT]
> This repository requires the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container with tag `2026.04` or later.

<p align="center">
  <a href="img/riscv_top_white.png">
    <img src="img/riscv_top_white.png" alt="Render of the ihp-sg13g2 RISC-V layout (700um x 1130um)" width=50%>
  </a>
  <br>
  <em>Render of the ihp-sg13g2 RISC-V layout (700um x 1130um).</em>
</p>

## Implement the Design

> [!NOTE]
> If you aren't in the Nix shell, run `nix-shell` from the root of this repository.

With this shell enabled, run the implementation:

```sh
make librelane
```

Additional targets are available for different DRC configurations:

- `make librelane-nodrc` – run LibreLane without DRC checks
- `make librelane-magicdrc` – run LibreLane with only Magic DRC checks
- `make librelane-klayoutdrc` – run LibreLane with only KLayout DRC checks

After the LibreLane flow has completed successfully, the `final/` folder from the latest run is copied to the root directory of the repository.

## View the Design

After completion, you can view the design using the OpenROAD GUI:

```sh
make librelane-openroad
```

Or using KLayout:

```sh
make librelane-klayout
```

## Copying important Reports to the Reports Folder

To copy yosys, antenna violations, DRC errors, hold & setup timing and manufacturability reports of the latest run to the `reports/` folder in the root directory of the repository, run the following command:

```sh
make copy-reports
```

This will only work if the last run was completed without errors.

## Render Layout of the Design

To render your latest GDS in the `final/` folder in the root directory of the repository and save it in the `img/` folder, run the following command:

```sh
make render-image
```

This will only work if the last run was completed without errors.

## Build All

To build the macro, copy its reports, and render its GDS, run the following command:

```sh
make all
```

## Generate XSPICE file

To generate an XSPICE file of the macro for mixed-signal simulation in Xschem, run the following command:

```sh
make generate-xspice
```

Note that these commands should not be run in all, since this XSPICE file is generated once with specific CPU settings for a more convenient simulation.
Note that this method does not work with the `.nl.v` file in the `final/` folder. The `.nl.v` file from the LibreLane step `yosys-synthesis` has to be used.
Conversion pipeline: Copy gate-level Verilog without power connections (`.nl.v`) → Verilog with power pins (`.vp`) → SPICE (`.spice`) → XSPICE (`.xspice`) → Reorder pins in XSPICE file according to the Xschem symbol.

## Verification and Simulation

We use [cocotb](https://www.cocotb.org/), a Python-based testbench environment, for the verification of the chip.
The underlying simulator is Icarus Verilog (https://github.com/steveicarus/iverilog).

The testbench is located in `cocotb/riscv_top.py`. To run the RTL simulation, run the following command:

```sh
make sim
```

To run the GL (gate-level) simulation, run the following command:

```sh
make sim-gl
```

> [!NOTE]
> You need to have the latest implementation of your design in the `final/` folder.

In both cases, a waveform file will be generated under `cocotb/sim_build/riscv_top.fst`.
You can view it using a waveform viewer, for example, [GTKWave](https://gtkwave.github.io/gtkwave/).

```sh
make sim-view
```
