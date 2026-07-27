# Chip Floorplan

This document describes the physical floorplan of the TinyWhisper chip and is the human-readable companion to the macro `instances` blocks in [config.yaml](../flow/librelane/config.yaml).

Related documents:
- Pinout: [pinout.md](pinout.md)
- Specifications: [specifications.md](specifications.md)


## Die / core geometry

| Parameter                | Value                                                |
| ------------------------ | ---------------------------------------------------- |
| `DIE_AREA`               | `[0, 0, 2000, 2000]` µm  (2.0 mm × 2.0 mm)           |
| `CORE_AREA`              | `[365, 365, 1635, 1635]` µm  (1270 µm × 1270 µm)     |
| Padframe margin per side | 365 µm (between die edge and core)                   |
| `FP_SIZING`              | `absolute`                                           |
| Clock period             | 17 ns (~56 MHz)                                      |
| Core supply              | 1.5 V (`VDD` / `VSS`)                                |
| I/O supply               | 3.3 V (`IOVDD` / `IOVSS`)                            |

The 365 µm padframe margin holds the [bondpads](../ip/sg13g2_ip__bondpad_70x70/), the [JKU](../ip/sg13g2_ip__jku/) / [CE](../ip/sg13g2_ip__ce/) logos and name plates, IHP IO cells, corner cells, fillers and the top-level power ring (see [config.yaml](../flow/librelane/config.yaml) and [pdn_cfg.tcl](../flow/librelane/pdn_cfg.tcl)).


## Hard macros

Two design macros and the logo cells are placed inside the core / padframe:

| Macro instance                    | Cell                  | Lower-left (x, y)    | Orientation |
| --------------------------------- | --------------------- | -------------------- | ----------- |
| `i_tinywhisper_core.riscv_top`    | `riscv_top`           | (435, 435)           | N           |
| `i_tinywhisper_core.iqmod_top`    | `iqmod_top`           | (1215.36, 932.40)    | N           |
| `ce_logo`                         | `sg13g2_ip__ce`       | die SE corner region | N           |
| `ce_names`                        | `sg13g2_ip__ce_names` | die SW corner region | N           |
| `jku_logo` / `jku_names`          | `sg13g2_ip__jku*`     | see config.yaml      | N           |

The values are kept in the `instances` blocks of [config.yaml](../flow/librelane/config.yaml). The `iqmod_top` coordinates are tied to the `Metal3` routing grid (`X` is a multiple of 0.48 µm, `Y` a multiple of 0.42 µm). See the [LibreLane Cheatsheet](librelane/librelane_cheatsheet.md) for more details on orientations and configuration.


## RF / analog routing

The four RF output nets (`Voutp_Q_RF`, `Voutn_Q_RF`, `Voutn_I_RF`, `Voutp_I_RF`, routed via `PADBARE`) use the `NDR_RF` non-default rule (1.35 µm width / 1.0 µm spacing, Metal1 through TopMetal2). The four analog input nets (`Vinp_Q`, `Vinn_Q`, `Vinn_I`, `Vinp_I`, routed via `PADRES`) use `NDR_analog` (1.35 µm width / 0.5 µm spacing). All eight nets are on the `RSZ_DONT_TOUCH_LIST` so the resizer leaves them untouched. See `NON_DEFAULT_RULES` / `DRT_ASSIGN_NDR` in [config.yaml](../flow/librelane/config.yaml).
