v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {IQ Modulator} 1010 -1750 0 0 1.5 1.5 {}
N 1200 -1100 1200 -1080 {lab=VSS}
N 1180 -1520 1180 -1500 {lab=VDD}
N 1180 -340 1180 -320 {lab=VDD}
N 1200 -760 1200 -740 {lab=VSS}
N 1820 -1320 2020 -1320 {lab=voutp_I_RF}
N 1820 -560 2020 -560 {lab=voutn_Q_RF}
N 780 -580 980 -580 {lab=vinn_Q_spdt}
N 780 -500 980 -500 {lab=vinp_Q_spdt}
N 780 -1340 980 -1340 {lab=vinp_I_spdt}
N 780 -1260 980 -1260 {lab=vinn_I_spdt}
N 1720 -1420 1720 -1400 {lab=VDD}
N 1760 -1200 1760 -1180 {lab=VSS}
N 1760 -660 1760 -640 {lab=VSS}
N 1720 -440 1720 -420 {lab=VDD}
N 1420 -1320 1620 -1320 {lab=voutp_I_lpf}
N 1420 -1280 1620 -1280 {lab=voutn_I_lpf}
N 1420 -520 1620 -520 {lab=voutp_Q_lpf}
N 1420 -560 1620 -560 {lab=voutn_Q_lpf}
N 1680 -1200 1680 -1000 {lab=di_lo_I}
N 1720 -1200 1720 -960 {lab=di_lo_Ix}
N 1720 -880 1720 -640 {lab=di_lo_Qx}
N 1680 -840 1680 -640 {lab=di_lo_Q}
N 1820 -1280 2020 -1280 {lab=voutn_I_RF}
N 1820 -520 2020 -520 {lab=voutp_Q_RF}
N 1220 -1520 1220 -1500 {lab=di_analog_en}
N 1220 -340 1220 -320 {lab=di_analog_en}
N 500 -1480 520 -1480 {lab=VSS}
N 640 -1480 660 -1480 {lab=VDD}
N 640 -1200 660 -1200 {lab=VDD}
N 500 -1200 520 -1200 {lab=VSS}
N 500 -1460 520 -1460 {lab=vinp_I}
N 500 -1180 520 -1180 {lab=vinn_I}
N 500 -1420 520 -1420 {lab=di_ds_I_p}
N 500 -1140 520 -1140 {lab=di_ds_I_n}
N 780 -1440 780 -1340 {lab=vinp_I_spdt}
N 640 -1440 780 -1440 {lab=vinp_I_spdt}
N 500 -1000 1680 -1000 {lab=di_lo_I}
N 500 -960 1720 -960 {lab=di_lo_Ix}
N 500 -880 1720 -880 {lab=di_lo_Qx}
N 500 -840 1680 -840 {lab=di_lo_Q}
N 500 -360 520 -360 {lab=VSS}
N 640 -360 660 -360 {lab=VDD}
N 640 -640 660 -640 {lab=VDD}
N 500 -640 520 -640 {lab=VSS}
N 500 -380 520 -380 {lab=vinp_Q}
N 500 -660 520 -660 {lab=vinn_Q}
N 500 -420 520 -420 {lab=di_ds_Q_p}
N 500 -700 520 -700 {lab=di_ds_Q_n}
N 500 -500 580 -500 {lab=di_spdt_ctrl_Q}
N 780 -680 780 -580 {lab=vinn_Q_spdt}
N 780 -500 780 -400 {lab=vinp_Q_spdt}
N 640 -400 780 -400 {lab=vinp_Q_spdt}
N 640 -1160 780 -1160 {lab=vinn_I_spdt}
N 780 -1260 780 -1160 {lab=vinn_I_spdt}
N 640 -680 780 -680 {lab=vinn_Q_spdt}
N 500 -1100 550 -1100 {lab=psub}
N 490 -1380 550 -1380 {lab=psub}
N 500 -740 550 -740 {lab=psub}
N 500 -460 550 -460 {lab=psub}
N 580 -500 580 -460 {lab=di_spdt_ctrl_Q}
N 500 -780 580 -780 {lab=di_spdt_ctrl_Q}
N 580 -780 580 -740 {lab=di_spdt_ctrl_Q}
N 500 -1060 580 -1060 {lab=di_spdt_ctrl_I}
N 580 -1100 580 -1060 {lab=di_spdt_ctrl_I}
N 580 -1380 580 -1340 {lab=di_spdt_ctrl_I}
N 500 -1340 580 -1340 {lab=di_spdt_ctrl_I}
N 1260 -1100 1260 -1080 {lab=psub}
N 1820 -1240 1840 -1240 {lab=psub}
N 1840 -1240 1840 -1180 {lab=psub}
N 1260 -760 1260 -740 {lab=psub}
N 1820 -600 1840 -600 {lab=psub}
N 1840 -660 1840 -600 {lab=psub}
C {devices/iopin.sym} 1180 -1520 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 2020 -1320 0 0 {name=p7 lab=voutp_I_RF}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {lab_pin.sym} 1200 -760 3 1 {name=p19 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1180 -320 1 1 {name=p18 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} 1200 -1080 1 0 {name=p3 lab=VSS}
C {lab_pin.sym} 1720 -1420 1 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1760 -1180 3 0 {name=p11 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1720 -420 1 1 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1760 -660 3 1 {name=p6 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 500 -840 0 0 {name=p14 lab=di_lo_Q}
C {devices/ipin.sym} 500 -880 2 1 {name=p15 lab=di_lo_Qx}
C {devices/ipin.sym} 500 -1000 2 1 {name=p16 lab=di_lo_I}
C {devices/ipin.sym} 500 -960 0 0 {name=p17 lab=di_lo_Ix}
C {devices/ipin.sym} 500 -1420 2 1 {name=p8 lab=di_ds_I_p}
C {lab_wire.sym} 1560 -560 0 0 {name=p12 sig_type=std_logic lab=voutn_Q_lpf}
C {lab_wire.sym} 1560 -520 2 1 {name=p13 sig_type=std_logic lab=voutp_Q_lpf}
C {lab_wire.sym} 1560 -1320 0 0 {name=p20 sig_type=std_logic lab=voutp_I_lpf}
C {lab_wire.sym} 1560 -1280 2 1 {name=p22 sig_type=std_logic lab=voutn_I_lpf}
C {iqmod_mixer.sym} 1720 -1300 0 0 {name=x3}
C {iqmod_mixer.sym} 1720 -540 2 1 {name=x4}
C {iqmod_mfb_lpf.sym} 1200 -1300 0 0 {name=x1}
C {iqmod_mfb_lpf.sym} 1200 -540 2 1 {name=x2}
C {devices/iopin.sym} 2020 -1280 0 0 {name=p21 lab=voutn_I_RF}
C {devices/iopin.sym} 2020 -520 0 0 {name=p23 lab=voutp_Q_RF}
C {devices/iopin.sym} 2020 -560 0 0 {name=p24 lab=voutn_Q_RF}
C {devices/ipin.sym} 1220 -1520 3 1 {name=p25 lab=di_analog_en}
C {lab_pin.sym} 1220 -320 1 1 {name=p26 sig_type=std_logic lab=di_analog_en}
C {iqmod_spdt_switch.sym} 580 -1440 1 0 {name=x5}
C {iqmod_spdt_switch.sym} 580 -1160 1 0 {name=x6}
C {lab_pin.sym} 660 -1480 2 0 {name=p35 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -1480 0 0 {name=p36 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 660 -1200 2 0 {name=p37 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -1200 0 0 {name=p38 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 500 -1460 2 1 {name=p47 lab=vinp_I}
C {devices/ipin.sym} 500 -1180 2 1 {name=p48 lab=vinn_I}
C {lab_wire.sym} 780 -1440 0 1 {name=p27 sig_type=std_logic lab=vinp_I_spdt}
C {lab_wire.sym} 780 -1160 2 0 {name=p28 sig_type=std_logic lab=vinn_I_spdt}
C {lab_pin.sym} 500 -1060 0 0 {name=p9 sig_type=std_logic lab=di_spdt_ctrl_I}
C {devices/ipin.sym} 500 -1340 2 1 {name=p29 lab=di_spdt_ctrl_I
}
C {devices/ipin.sym} 500 -1140 2 1 {name=p30 lab=di_ds_I_n}
C {devices/ipin.sym} 500 -420 0 0 {name=p31 lab=di_ds_Q_p}
C {iqmod_spdt_switch.sym} 580 -400 1 1 {name=x7}
C {iqmod_spdt_switch.sym} 580 -680 1 1 {name=x8}
C {lab_pin.sym} 660 -360 0 1 {name=p32 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -360 2 1 {name=p33 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 660 -640 0 1 {name=p34 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -640 2 1 {name=p39 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 500 -380 0 0 {name=p40 lab=vinp_Q}
C {devices/ipin.sym} 500 -660 0 0 {name=p41 lab=vinn_Q}
C {lab_wire.sym} 780 -400 2 0 {name=p42 sig_type=std_logic lab=vinp_Q_spdt}
C {lab_wire.sym} 780 -680 0 1 {name=p43 sig_type=std_logic lab=vinn_Q_spdt}
C {lab_pin.sym} 500 -780 2 1 {name=p44 sig_type=std_logic lab=di_spdt_ctrl_Q}
C {devices/ipin.sym} 500 -500 0 0 {name=p45 lab=di_spdt_ctrl_Q
}
C {devices/ipin.sym} 500 -700 0 0 {name=p46 lab=di_ds_Q_n}
C {lab_pin.sym} 500 -1100 2 1 {name=p2 sig_type=std_logic lab=psub}
C {lab_pin.sym} 490 -1380 2 1 {name=p4 sig_type=std_logic lab=psub}
C {lab_pin.sym} 500 -740 2 1 {name=p49 sig_type=std_logic lab=psub}
C {lab_pin.sym} 500 -460 2 1 {name=p50 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1260 -1080 1 1 {name=p51 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1840 -1180 1 1 {name=p52 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1260 -760 3 1 {name=p53 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1840 -660 1 0 {name=p54 sig_type=std_logic lab=psub}
