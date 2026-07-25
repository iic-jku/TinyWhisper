# ToDo List

## ihp-sg13g2 TinyWhisper

- [x] Padframe & setup using the following template: https://github.com/IHP-GmbH/ihp-sg13g2-librelane-template

- Analog Front-End — IQ Modulator
    - [x] Filter Design with `Python`
        - [ ] Add fourth-order model for OTA impact
    - [x] Inverter-Based OTA Transistor gm/ID Sizing with `Jupyter` Notebook
    - [x] Circuit Design with `Xschem` and `Ngspice`
    - [x] Process Variation & Mismatch Simulation with `CACE`
    - [ ] Harmonic Balance (HB) Simulation with `VACASK`
    - [x] Layout with `KLayout` (LVS, DRC, PEX)
    - [x] Post-Layout Simulation
- Digital Core
    - [x] Digital Design of RISC-V CPU with `(System)Verilog`
    - [x] Gate-Level testbench with `cocotb`
    - [x] Layout of Digital Core with `LibreLane`
- [x] Analog Mixed-Signal Gate-Level Simulation including Padframe with `Xschem`, `Xspice` and `Ngspice`
- [x] Layout of TinyWhisper Transmitter (Padframe + Logos + Digital Core + IQ Modulator) with `LibreLane`
- [ ] Analog Mixed-Signal Post-Layout Simulation including Padframe with `Xschem`, `Spice` and `Ngspice` (--> convergence issues --> see issue https://github.com/IHP-GmbH/IHP-Open-PDK/issues/921)


## sky130A TinyWhisper

- [ ] Padframe for sky130A: https://github.com/librelane/librelane/pull/925

- Analog Front-End — IQ Modulator
    - [x] Filter Design with `Python`
    - [x] Circuit Design with `Xschem` and `Ngspice`
    - [x] Process Variation & Mismatch Simulation with `CACE`
    - [x] Layout with `Magic` (LVS, DRC, PEX)
    - [x] Post-Layout Simulation
- Digital Core
    - [x] Digital Design of RISC-V CPU with `(System)Verilog`
    - [ ] Layout of Digital Core with `LibreLane`
- [ ] Analog Mixed-Signal Gate-Level Simulation with `Xschem`, `Xspice` and `Ngspice`
- [ ] Layout of TinyWhisper Transmitter (Digital Core + IQ Modulator)
- [ ] Analog Mixed-Signal Post-Layout Simulation with `Xschem`, `Spice` and `Ngspice`


## ToDo List

### ihp-sg13g2

- [ ] update changes from `ihp-sg13g2-ams-chip-template` to `TinyWhisper`
- [ ] find a better way of linking `xschemrc` files and `.designinit` --> see ihp-sg13g2-ams-chip-template
- [ ] clean up top-level LVS (Magic + Netgen) --> see ihp-sg13g2-ams-chip-template
- [ ] Custom LibreLane steps --> see ihp-sg13g2-ams-chip-template
    - flow without filler (GDS streamout + DRC check) --> default
    - add logo with ArtistIC --> custom
    - add filler structures --> custom
        - 0.75, 0.75, 0.75, 0.75, 0.75, 2.0, 2.0 (M1 - TM2)
        - KLayout & Magic Filler: https://librelane.readthedocs.io/en/stable/reference/step_config_vars.html
        - GDSFiller: https://github.com/aesc-silicon/gdsfill 
    - GDS streamout + DRC check --> custom
- [ ] add sg13g2_Filler2000_novdd to split VDD_CORE & VDD_ANA --> see ihp-sg13g2-ams-chip-template
- [ ] add sg13g2_io_custom to iic-jku/IHP-Open-PDK --> see ihp-sg13g2-ams-chip-template
- [ ] simulate with VACASK
    - Filter: https://codeberg.org/arpadbuermen/VACASK/src/branch/main/docs/cmd-analysis-acstb.md
    - Mixer: HB
- [ ] remove nwell / psub and ntap / ptap in iqmod schematics --> new KLayout LVS
- [ ] fix ntap in CACE (should be fixed after removing nwell / psub and ptap / ntap)
- [ ] update testbenches with https://github.com/StefanSchippers/xschem/issues/463
- [ ] merge `mfb-lpf-caps` branch into main
- [ ] increase the CORDIC resolution to 32-bits for higher frequency resolution
- [ ] add on-chip SRAM
- [ ] change DBU to 1nm for all cells
- [ ] delete scripts/pwm_generator and take DSM signal
- [ ] merge all klay.klib to one iqmod_top.klay.klib
- [ ] filter scripts: add fourth-order model
- [ ] finish ihp-sg13g2 TinyWhisper presentation

### sky130A

- [ ] remove run_drc_lvs_pex.sh and add Makefiles --> see sky130A-ams-chip-template
- [ ] finish sky130A TinyWhisper presentation

### General

- [ ] update main Makefile
    - run all testbenches (including macros)
    - compile the firmware / software
    - present: GDS and FW binary ready for DL plus verification results
- [ ] write documentation (https://tinytapeout.com/guides/documentation/)
- [ ] build same chip for sky130A, gf180mcuD and ihp-sg13cmos5l

### Improvement Potential

- Make KLayout DRC faster (plus multithreading), plus more stable (no more crashes at the end)
- Clean up IHP Padlib
- Zero-length paths must be checked in DRC
- LibreLane sets an incorrect prBoundary (IHP)