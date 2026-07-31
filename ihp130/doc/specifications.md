# Chip Specifications

This document describes the TinyWhisper chip from a designer's point of view: what it contains, how it behaves, and where each subsystem is configured. The numbers below are read from the actual design files. If you change them in the source, please mirror them here.

Related documents:
- Pinout: [pinout.md](pinout.md)
- Floorplan: [floorplan.md](floorplan.md)

## Where things live

| Topic                    | File                                                                                        |
| ------------------------ | ------------------------------------------------------------------------------------------- |
| Padframe generation      | [rtl/tinywhisper_top.sv](../rtl/tinywhisper_top.sv)                                         |
| Top-level assembly       | [rtl/tinywhisper_core.sv](../rtl/tinywhisper_core.sv)                                       |
| Padframe / pin lists     | [flow/librelane/config.yaml](../flow/librelane/config.yaml) (`PAD_*` arrays)                |
| Macro placement          | [flow/librelane/config.yaml](../flow/librelane/config.yaml) (`MACROS`)                      |
| Power-distribution rules | [flow/librelane/pdn_cfg.tcl](../flow/librelane/pdn_cfg.tcl)                                 |
| Timing constraints       | [flow/librelane/tinywhisper_top.sdc](../flow/librelane/tinywhisper_top.sdc)                 |
| Cocotb testbench         | [testbenches/cocotb/tinywhisper_top_tb.py](../testbenches/cocotb/tinywhisper_top_tb.py)     |
| Xschem mixed-signal TB   | [testbenches/xschem/tinywhisper_top_tb_tran.sch](../testbenches/xschem/tinywhisper_top_tb_tran.sch) |
| Build automation         | [Makefile](../Makefile) (see `make help`)                                                   |

## Overview

| Parameter           | Value                                                                                              |
| ------------------- | -------------------------------------------------------------------------------------------------- |
| Technology          | IHP SG13G2 (130 nm CMOS, Open-PDK)                                                                 |
| Die area            | 2.0 mm × 2.0 mm (4.0 mm²): `DIE_AREA: [0, 0, 2000, 2000]`                                          |
| Core area           | 1.27 mm × 1.27 mm: `CORE_AREA: [365, 365, 1635, 1635]`                                             |
| Clock frequency     | ~56 MHz (`CLOCK_PERIOD: 17` ns in [config.yaml](../flow/librelane/config.yaml))                    |
| Core supply         | 1.5 V                                                                                              |
| I/O supply          | 3.3 V                                                                                              |
| Total bondpads      | 56 (14 per side), see [pinout.md](pinout.md)                                                      |
| Packaging           | QFN-48 (`OP_QFN48_A4_FIT`, see [packaging/](../packaging/))                                        |
| Temperature range   | -40 °C to +125 °C                                                                                  |
| STA corners         | nom_fast_1p32V_m40C · nom_fast_1p65V_m40C · nom_slow_1p35V_125C · nom_typ_1p20V_25C · nom_typ_1p50V_25C |
| Default STA corner  | `nom_typ_1p50V_25C`                                                                                |

## Padframe layout (4 × 14 = 56 pads)

The padframe uses the generic top-level port names defined in [tinywhisper_top.sv](../rtl/tinywhisper_top.sv). The mapping of bit indices to roles is in [tinywhisper_core.sv](../rtl/tinywhisper_core.sv).

| Side  | Pads                                                                                                          |
| ----- | ------------------------------------------------------------------------------------------------------------- |
| West  | UART (`tx`, `rx`), I²C (`scl`, `sda`), supplies, SPI SRAM interface (`sram_ce`, `sclk`, `si`, `so`), `rst_n`, `clk` |
| North | supplies, `GPIO_i[3:0]`, baseband I bidir pads (`I_p`, `I_n`, `lo_I`, `lo_Ix`)                                |
| South | supplies, `GPIO_o[3:0]`, baseband Q bidir pads (`Q_p`, `Q_n`, `lo_Q`, `lo_Qx`)                                |
| East  | analog inputs (`Vinp_Q`, `Vinn_Q`, `Vinn_I`, `Vinp_I`), RF outputs (`Voutp/n_Q_RF`, `Voutn/p_I_RF`), supplies |

Full per-pad breakdown including pad-cell instance names is in [pinout.md](pinout.md) and the `PAD_*` arrays in [config.yaml](../flow/librelane/config.yaml).

## On-die macros

| Macro          | Cell name    | Count | Role                                                                                       |
| -------------- | ------------ | ----- | ------------------------------------------------------------------------------------------ |
| RISC-V SoC     | `riscv_top`  | 1     | RV32 CPU with UART, I²C, SPI, GPIO, ΔΣ modulator, CORDIC and LO/frequency generation       |
| I/Q modulator  | `iqmod_top`  | 1     | Analog I/Q modulator: MFB low-pass filters, passive mixers and SPDT switches (RF path)     |

Exact coordinates and the floorplan are in [floorplan.md](floorplan.md); build details per macro are in [macros/riscv/](../macros/riscv/) and [macros/iqmod/](../macros/iqmod/).

## Power and reset

- Three IOVDD/IOVSS pairs power the I/O ring; filler pads distribute the supply around the four sides.
- Multiple VDD/VSS pairs power the core; dedicated supply pad groups shield the analog and RF pad quads.
- `iqmod_top` has its own power ring on Metal5 (horizontal) and TopMetal1 (vertical). A custom PDN grid bridges the chip ring to the macro ring ([pdn_cfg.tcl](../flow/librelane/pdn_cfg.tcl)).
- Active-low reset on `rst_n_PAD`.
