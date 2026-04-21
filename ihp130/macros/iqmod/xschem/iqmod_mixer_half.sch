v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Passive Voltage-Mode Mixer} 700 -1720 0 0 1.5 1.5 {}
T {Features of the passive voltage-mode mixer (2 LO phases):
-) 2 x Mixer: The 4 LO phases generated in the LO generation block drive 4 TGs (as we want to be able to switch rail-rail voltage signals coming out of the lowpass filters)
-) As we use 25% LO signals there is only minimum overlap between the LO signals, hence we can simply connect (add) the outputs of the mixer switches.
-) As the digital LO generation block generates 4 single-ended LO signals, local drivers (inverters and buffers) are included to drive the NMOS and PMOS of the TGs.} 2380 -1440 2 0 0.5 0.5 {}
N 1620 -1040 1620 -1000 {lab=VSS}
N 1620 -1160 1620 -1120 {lab=VDD}
N 1640 -1040 1640 -1000 {lab=vinp_LO_inv}
N 1640 -1160 1640 -1120 {lab=vinp_LO_buf}
N 1480 -1080 1560 -1080 {lab=vinp_IF}
N 760 -1020 760 -1000 {lab=VSS}
N 760 -1160 760 -1140 {lab=VDD}
N 520 -1080 580 -1080 {lab=vinp_LO}
N 940 -1100 1000 -1100 {lab=vinp_LO_buf}
N 940 -1060 1000 -1060 {lab=vinp_LO_inv}
N 1720 -1080 1800 -1080 {lab=voutp_RF}
N 1660 -1060 1660 -1050 {lab=psub}
N 1660 -1110 1660 -1100 {lab=nwell1}
N 820 -1150 820 -1140 {lab=nwell1}
N 880 -1150 880 -1140 {lab=#net1}
N 820 -1020 820 -1010 {lab=psub}
C {devices/iopin.sym} 1620 -1160 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1620 -1000 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 1480 -1080 0 0 {name=p8 lab=vinp_IF}
C {devices/iopin.sym} 1800 -1080 0 0 {name=p7 lab=voutp_RF}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 520 -1080 0 0 {name=p3 lab=vinp_LO}
C {devices/lab_pin.sym} 1000 -1100 2 0 {name=l5 sig_type=std_logic lab=vinp_LO_buf}
C {devices/lab_pin.sym} 1000 -1060 2 0 {name=l3 sig_type=std_logic lab=vinp_LO_inv}
C {lab_pin.sym} 760 -1160 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -1000 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1640 -1160 3 1 {name=l8 sig_type=std_logic lab=vinp_LO_buf}
C {devices/lab_pin.sym} 1640 -1000 3 0 {name=l9 sig_type=std_logic lab=vinp_LO_inv}
C {iqmod_mixer_tg.sym} 1640 -1080 0 0 {name=x2}
C {iqmod_mixer_se2diff.sym} 760 -1080 0 0 {name=x1}
C {lab_wire.sym} 1660 -1050 2 0 {name=p37 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1660 -1110 0 1 {name=p66 sig_type=std_logic lab=nwell1}
C {lab_wire.sym} 820 -1150 0 1 {name=p12 sig_type=std_logic lab=nwell1}
C {lab_wire.sym} 820 -1010 2 0 {name=p18 sig_type=std_logic lab=psub}
C {lab_wire.sym} 880 -1150 0 1 {name=p20 sig_type=std_logic lab=nwell3}
