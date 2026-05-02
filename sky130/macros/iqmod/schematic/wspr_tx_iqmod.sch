v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 4 2020 -1080 2300 -800 {fill = false
dash = 16}
T {IQ Modulator} 920 -1730 0 0 1.5 1.5 {}
T {afe_en = 1... enable
afe_en = 0... disable} 980 -1560 0 0 0.25 0.25 {}
T {afe_en = 1... enable
afe_en = 0... disable} 980 -840 0 0 0.25 0.25 {}
T {Decoupling Capacitors} 2030 -1070 0 0 0.4 0.4 {}
N 840 -1100 840 -1080 {lab=VSS}
N 820 -1520 820 -1500 {lab=VDD}
N 860 -820 860 -780 {lab=di_afe_en}
N 820 -800 820 -780 {lab=VDD}
N 840 -380 840 -360 {lab=VSS}
N 1660 -940 1700 -940 {lab=vout_RF}
N 1060 -1320 1260 -1320 {lab=voutp_I_lpf}
N 1060 -1280 1260 -1280 {lab=voutn_I_lpf}
N 1460 -1300 1660 -1300 {lab=vout_RF}
N 1060 -600 1260 -600 {lab=voutp_Q_lpf}
N 1060 -560 1260 -560 {lab=voutn_Q_lpf}
N 1460 -580 1660 -580 {lab=vout_RF}
N 420 -540 620 -540 {lab=vinn_Q}
N 420 -620 620 -620 {lab=vinp_Q}
N 420 -1340 620 -1340 {lab=vinp_I}
N 420 -1260 620 -1260 {lab=vinn_I}
N 1360 -1420 1360 -1400 {lab=VDD}
N 1400 -1200 1400 -1180 {lab=VSS}
N 1400 -480 1400 -460 {lab=VSS}
N 1360 -700 1360 -680 {lab=VDD}
N 1660 -1300 1660 -940 {lab=vout_RF}
N 1660 -940 1660 -580 {lab=vout_RF}
N 420 -1000 1320 -1000 {lab=di_LO_I}
N 420 -960 1360 -960 {lab=di_LO_IX}
N 420 -280 1320 -280 {lab=di_LO_Q}
N 420 -240 1360 -240 {lab=di_LO_QX}
N 1320 -480 1320 -280 {lab=di_LO_Q}
N 1360 -480 1360 -240 {lab=di_LO_QX}
N 1320 -1200 1320 -1000 {lab=di_LO_I}
N 1360 -1200 1360 -960 {lab=di_LO_IX}
N 860 -1540 860 -1500 {lab=di_afe_en}
N 1200 -1360 1200 -1320 {lab=voutp_I_lpf}
N 1200 -1280 1200 -1240 {lab=voutn_I_lpf}
N 1200 -640 1200 -600 {lab=voutp_Q_lpf}
N 1200 -560 1200 -520 {lab=voutn_Q_lpf}
N 2160 -980 2160 -960 {lab=VDD}
N 2160 -900 2160 -880 {lab=VSS}
C {devices/iopin.sym} 820 -1520 3 0 {name=p1 lab=VDD}
C {devices/opin.sym} 1700 -940 0 0 {name=p7 lab=vout_RF}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {lab_pin.sym} 840 -360 3 0 {name=p19 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 820 -800 1 0 {name=p18 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} 840 -1080 1 0 {name=p3 lab=VSS}
C {devices/ipin.sym} 860 -1540 0 1 {name=p21 lab=di_afe_en}
C {devices/lab_pin.sym} 860 -820 2 0 {name=l4 sig_type=std_logic lab=di_afe_en}
C {lab_pin.sym} 1360 -1420 1 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1400 -1180 3 0 {name=p11 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1360 -700 1 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1400 -460 3 0 {name=p6 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 420 -620 2 1 {name=p2 lab=vinp_Q}
C {devices/ipin.sym} 420 -280 2 1 {name=p14 lab=di_LO_Q}
C {devices/ipin.sym} 420 -240 0 0 {name=p15 lab=di_LO_QX}
C {devices/ipin.sym} 420 -1000 2 1 {name=p16 lab=di_LO_I}
C {devices/ipin.sym} 420 -960 0 0 {name=p17 lab=di_LO_IX}
C {devices/ipin.sym} 420 -540 2 1 {name=p4 lab=vinn_Q}
C {devices/ipin.sym} 420 -1340 2 1 {name=p8 lab=vinp_I}
C {devices/ipin.sym} 420 -1260 2 1 {name=p9 lab=vinn_I}
C {lab_pin.sym} 1200 -520 2 1 {name=p12 sig_type=std_logic lab=voutn_Q_lpf}
C {lab_pin.sym} 1200 -640 2 1 {name=p13 sig_type=std_logic lab=voutp_Q_lpf}
C {lab_pin.sym} 1200 -1360 2 1 {name=p20 sig_type=std_logic lab=voutp_I_lpf}
C {lab_pin.sym} 1200 -1240 2 1 {name=p22 sig_type=std_logic lab=voutn_I_lpf}
C {wspr_tx_iqmod_mixer.sym} 1360 -1300 0 0 {name=x3}
C {wspr_tx_iqmod_mixer.sym} 1360 -580 0 0 {name=x4}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2160 -930 0 0 {name=C1 model=cap_mim_m3_1 W=3.0 L=3.0 MF=56 spiceprefix=X}
C {lab_pin.sym} 2160 -980 1 0 {name=p23 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2160 -880 3 0 {name=p24 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf.sym} 840 -1300 0 0 {name=x1}
C {wspr_tx_iqmod_mfb_lpf.sym} 840 -580 0 0 {name=x2}
