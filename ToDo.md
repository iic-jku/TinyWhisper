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

- [ ] **add [conditional labels](https://github.com/StefanSchippers/xschem/issues/474) nwell / psub to iqmod schematics or remove them entirely, wait final decision of IHP Open-PDK [issue 955](https://github.com/IHP-GmbH/IHP-Open-PDK/issues/955)**
- [ ] fix ntap in CACE (should be fixed after removing nwell / psub and ptap / ntap)
- [ ] iqmod PEX is currently not working --> seg fault (EXT_MODE = 3), wrong pins (EXT_MODE = 1/2)
- [ ] update testbenches with https://github.com/StefanSchippers/xschem/issues/463
- [ ] change DBU to 1nm for all cells
- [ ] clean up top-level LVS (Magic + Netgen)
- [ ] Custom LibreLane steps
    - flow without filler (GDS streamout + DRC check) --> default
    - add logo with ArtistIC --> custom
    - add filler structures --> custom
        - 0.75, 0.75, 0.75, 0.75, 0.75, 2.0, 2.0 (M1 - TM2)
        - KLayout & Magic Filler: https://librelane.readthedocs.io/en/stable/reference/step_config_vars.html
        - GDSFiller: https://github.com/aesc-silicon/gdsfill 
    - GDS streamout + DRC check --> custom
- [ ] delete scripts/pwm_generator and take DSM signal
- [ ] merge all klay.klib to one iqmod_top.klay.klib
- [ ] add sg13g2_Filler2000_novdd to split VDD_CORE & VDD_ANA
- [ ] filter scripts: add fourth-order model
- [ ] finish ihp-sg13g2 TinyWhisper presentation
- [ ] add sg13g2_io_custom to iic-jku/IHP-Open-PDK

### sky130A

- [ ] remove run_drc_lvs_pex.sh and add Makefiles
- [ ] finish sky130A TinyWhisper presentation

### General

- [ ] PR IHP sizing scripts
- [ ] update main Makefile
    - run all testbenches (including macros)
    - compile the firmware / software
    - present: GDS and FW binary ready for DL plus verification results
- [ ] write documentation (https://tinytapeout.com/guides/documentation/)
- [ ] build same chip for sky130A, gf180mcuD and ihp-sg13cmos5l