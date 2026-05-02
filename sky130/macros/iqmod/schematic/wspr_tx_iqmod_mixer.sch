v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Passive Voltage-Mode Mixer} 650 -1720 0 0 1.5 1.5 {}
T {Features of the passive voltage-mode mixer (2 LO phases):
-) 2 x Mixer: The 4 LO phases generated in the LO generation block drive 4 TGs (as we want to be able to switch rail-rail voltage signals coming out of the lowpass filters)
-) As we use 25% LO signals there is only minimum overlap between the LO signals, hence we can simply connect (add) the outputs of the mixer switches.
-) As the digital LO generation block generates 4 single-ended LO signals, local drivers (inverters and buffers) are included to drive the NMOS and PMOS of the TGs.} 2380 -1440 2 0 0.5 0.5 {}
N 1540 -1040 1540 -1020 {lab=VSS}
N 1540 -1140 1540 -1120 {lab=VDD}
N 1560 -1140 1560 -1120 {lab=vinp_LO_buf}
N 1540 -1160 1540 -1140 {lab=VDD}
N 1560 -1040 1560 -1020 {lab=vinp_LO_inv}
N 1540 -1020 1540 -1000 {lab=VSS}
N 1560 -1160 1560 -1140 {lab=vinp_LO_buf}
N 1560 -1020 1560 -1000 {lab=vinp_LO_inv}
N 1540 -520 1540 -500 {lab=VSS}
N 1540 -620 1540 -600 {lab=VDD}
N 1560 -620 1560 -600 {lab=vinn_LO_buf}
N 1540 -640 1540 -620 {lab=VDD}
N 1560 -520 1560 -500 {lab=vinn_LO_inv}
N 1540 -500 1540 -480 {lab=VSS}
N 1560 -640 1560 -620 {lab=vinn_LO_buf}
N 1560 -500 1560 -480 {lab=vinn_LO_inv}
N 1640 -1080 1840 -1080 {lab=vout_RF}
N 1640 -560 1840 -560 {lab=vout_RF}
N 880 -1100 960 -1100 {lab=vinp_LO_buf}
N 880 -1060 960 -1060 {lab=vinp_LO_inv}
N 560 -1080 640 -1080 {lab=vinp_LO}
N 880 -580 960 -580 {lab=vinn_LO_buf}
N 880 -540 960 -540 {lab=vinn_LO_inv}
N 560 -560 640 -560 {lab=vinn_LO}
N 1400 -1080 1480 -1080 {lab=vinp_IF}
N 1400 -560 1480 -560 {lab=vinn_IF}
N 1840 -1080 1840 -820 {lab=vout_RF}
N 1840 -820 1840 -560 {lab=vout_RF}
N 1840 -820 1920 -820 {lab=vout_RF}
N 760 -1020 760 -1000 {lab=VSS}
N 760 -1160 760 -1140 {lab=VDD}
N 760 -640 760 -620 {lab=VDD}
N 760 -500 760 -480 {lab=VSS}
C {devices/iopin.sym} 1540 -1160 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1540 -1000 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 1400 -1080 0 0 {name=p8 lab=vinp_IF}
C {devices/ipin.sym} 1400 -560 2 1 {name=p26 lab=vinn_IF}
C {devices/opin.sym} 1920 -820 0 0 {name=p7 lab=vout_RF}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 560 -1080 0 0 {name=p3 lab=vinp_LO}
C {devices/lab_pin.sym} 960 -1100 2 0 {name=l5 sig_type=std_logic lab=vinp_LO_buf}
C {devices/lab_pin.sym} 960 -1060 2 0 {name=l3 sig_type=std_logic lab=vinp_LO_inv}
C {lab_pin.sym} 760 -1160 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -1000 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 960 -580 2 0 {name=l2 sig_type=std_logic lab=vinn_LO_buf}
C {devices/lab_pin.sym} 960 -540 2 0 {name=l4 sig_type=std_logic lab=vinn_LO_inv}
C {devices/ipin.sym} 560 -560 2 1 {name=p9 lab=vinn_LO}
C {devices/lab_pin.sym} 1560 -1160 2 0 {name=l8 sig_type=std_logic lab=vinp_LO_buf}
C {devices/lab_pin.sym} 1560 -1000 0 1 {name=l9 sig_type=std_logic lab=vinp_LO_inv}
C {lab_pin.sym} 1540 -480 3 0 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1540 -640 1 0 {name=p10 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1560 -640 2 0 {name=l12 sig_type=std_logic lab=vinn_LO_buf}
C {devices/lab_pin.sym} 1560 -480 2 0 {name=l13 sig_type=std_logic lab=vinn_LO_inv}
C {lab_pin.sym} 760 -640 1 0 {name=p17 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -480 3 0 {name=p21 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mixer_tg.sym} 1560 -1080 0 0 {name=x2}
C {wspr_tx_iqmod_mixer_tg.sym} 1560 -560 0 0 {name=x4}
C {wspr_tx_iqmod_mixer_lo_logic.sym} 760 -1080 0 0 {name=x1}
C {wspr_tx_iqmod_mixer_lo_logic.sym} 760 -560 0 0 {name=x3}
