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
N 1620 -660 1620 -620 {lab=VSS}
N 1620 -540 1620 -500 {lab=VDD}
N 1640 -660 1640 -620 {lab=vinn_LO_inv}
N 1640 -540 1640 -500 {lab=vinn_LO_buf}
N 1480 -1080 1560 -1080 {lab=vinp_IF}
N 1480 -580 1560 -580 {lab=vinn_IF}
N 760 -1020 760 -1000 {lab=VSS}
N 760 -1160 760 -1140 {lab=VDD}
N 760 -520 760 -500 {lab=VDD}
N 760 -660 760 -640 {lab=VSS}
N 520 -1080 580 -1080 {lab=vinp_LO}
N 940 -1100 1000 -1100 {lab=vinp_LO_buf}
N 940 -1060 1000 -1060 {lab=vinp_LO_inv}
N 520 -580 580 -580 {lab=vinn_LO}
N 940 -560 1000 -560 {lab=vinn_LO_buf}
N 940 -600 1000 -600 {lab=vinn_LO_inv}
N 1720 -580 1800 -580 {lab=voutn_RF}
N 1720 -1080 1800 -1080 {lab=voutp_RF}
N 1660 -1060 1660 -1050 {lab=psub}
N 1660 -1110 1660 -1100 {lab=nwell1}
N 1660 -610 1660 -600 {lab=psub}
N 1660 -560 1660 -550 {lab=nwell2}
N 820 -1150 820 -1140 {lab=nwell1}
N 880 -1150 880 -1140 {lab=nwell3}
N 820 -520 820 -510 {lab=nwell2}
N 880 -520 880 -510 {lab=nwell3}
N 820 -650 820 -640 {lab=psub}
N 820 -1020 820 -1010 {lab=psub}
C {devices/iopin.sym} 1620 -1160 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1620 -1000 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 1480 -1080 0 0 {name=p8 lab=vinp_IF}
C {devices/ipin.sym} 1480 -580 0 0 {name=p26 lab=vinn_IF}
C {devices/iopin.sym} 1800 -1080 0 0 {name=p7 lab=voutp_RF}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 520 -1080 0 0 {name=p3 lab=vinp_LO}
C {devices/lab_pin.sym} 1000 -1100 2 0 {name=l5 sig_type=std_logic lab=vinp_LO_buf}
C {devices/lab_pin.sym} 1000 -1060 2 0 {name=l3 sig_type=std_logic lab=vinp_LO_inv}
C {lab_pin.sym} 760 -1160 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -1000 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1000 -560 0 1 {name=l2 sig_type=std_logic lab=vinn_LO_buf}
C {devices/lab_pin.sym} 1000 -600 0 1 {name=l4 sig_type=std_logic lab=vinn_LO_inv}
C {devices/ipin.sym} 520 -580 0 0 {name=p9 lab=vinn_LO}
C {devices/lab_pin.sym} 1640 -1160 3 1 {name=l8 sig_type=std_logic lab=vinp_LO_buf}
C {devices/lab_pin.sym} 1640 -1000 3 0 {name=l9 sig_type=std_logic lab=vinp_LO_inv}
C {lab_pin.sym} 1620 -660 3 1 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1620 -500 1 1 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1640 -500 3 0 {name=l12 sig_type=std_logic lab=vinn_LO_buf}
C {devices/lab_pin.sym} 1640 -660 3 1 {name=l13 sig_type=std_logic lab=vinn_LO_inv}
C {lab_pin.sym} 760 -500 1 1 {name=p17 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -660 3 1 {name=p21 sig_type=std_logic lab=VSS}
C {iqmod_mixer_tg.sym} 1640 -1080 0 0 {name=x2}
C {iqmod_mixer_tg.sym} 1640 -580 2 1 {name=x4}
C {iqmod_mixer_se2diff.sym} 760 -1080 0 0 {name=x1}
C {iqmod_mixer_se2diff.sym} 760 -580 2 1 {name=x3}
C {devices/iopin.sym} 1800 -580 2 1 {name=p5 lab=voutn_RF}
C {lab_wire.sym} 1660 -1050 2 0 {name=p37 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1660 -1110 0 1 {name=p66 sig_type=std_logic lab=nwell1}
C {lab_wire.sym} 1660 -610 0 1 {name=p6 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1660 -550 2 0 {name=p11 sig_type=std_logic lab=nwell2}
C {lab_wire.sym} 820 -1150 0 1 {name=p12 sig_type=std_logic lab=nwell1}
C {lab_wire.sym} 820 -510 2 0 {name=p13 sig_type=std_logic lab=nwell2}
C {lab_wire.sym} 820 -650 0 1 {name=p14 sig_type=std_logic lab=psub}
C {lab_wire.sym} 880 -510 2 0 {name=p19 sig_type=std_logic lab=nwell3}
C {lab_wire.sym} 880 -1150 0 1 {name=p20 sig_type=std_logic lab=nwell3}
C {devices/iopin.sym} 820 -1010 0 0 {name=p23 lab=psub}
