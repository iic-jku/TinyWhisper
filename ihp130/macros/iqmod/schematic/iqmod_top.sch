v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {IQ Modulator} 1030 -1750 0 0 1.5 1.5 {}
N 1340 -1000 1340 -980 {lab=VSS}
N 1340 -1560 1340 -1540 {lab=VDD}
N 1080 -1560 1080 -1540 {lab=di_analog_en}
N 1460 -840 1460 -820 {lab=psub}
N 1680 -1360 1720 -1360 {lab=voutp_I_RF}
N 1680 -1300 1720 -1300 {lab=voutn_I_RF}
N 960 -1140 1000 -1140 {lab=di_lo_I}
N 960 -1080 1000 -1080 {lab=di_lo_Ix}
N 960 -1460 1000 -1460 {lab=di_spdt_ctrl_I}
N 960 -1420 1000 -1420 {lab=vinp_I}
N 960 -1380 1000 -1380 {lab=di_ds_I_p}
N 960 -1280 1000 -1280 {lab=vinn_I}
N 960 -1240 1000 -1240 {lab=di_ds_I_n}
N 960 -1560 1080 -1560 {lab=di_analog_en}
N 1340 -840 1340 -820 {lab=VSS}
N 1340 -280 1340 -260 {lab=VDD}
N 1080 -280 1080 -260 {lab=di_analog_en}
N 1680 -460 1720 -460 {lab=voutp_Q_RF}
N 1680 -520 1720 -520 {lab=voutn_Q_RF}
N 960 -680 1000 -680 {lab=di_lo_Q}
N 960 -740 1000 -740 {lab=di_lo_Qx}
N 960 -360 1000 -360 {lab=di_spdt_ctrl_Q}
N 960 -400 1000 -400 {lab=vinp_Q}
N 960 -440 1000 -440 {lab=di_ds_Q_p}
N 960 -540 1000 -540 {lab=vinn_Q}
N 960 -580 1000 -580 {lab=di_ds_Q_n}
N 960 -260 1080 -260 {lab=di_analog_en}
N 1460 -1000 1460 -980 {lab=psub}
C {devices/iopin.sym} 1340 -1560 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1720 -1360 0 0 {name=p7 lab=voutp_I_RF}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {lab_pin.sym} 1340 -260 1 1 {name=p18 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} 1340 -980 1 0 {name=p3 lab=VSS}
C {devices/ipin.sym} 960 -680 0 0 {name=p14 lab=di_lo_Q}
C {devices/ipin.sym} 960 -740 2 1 {name=p15 lab=di_lo_Qx}
C {devices/ipin.sym} 960 -1140 2 1 {name=p16 lab=di_lo_I}
C {devices/ipin.sym} 960 -1080 0 0 {name=p17 lab=di_lo_Ix}
C {devices/ipin.sym} 960 -1380 2 1 {name=p8 lab=di_ds_I_p}
C {devices/iopin.sym} 1720 -1300 0 0 {name=p21 lab=voutn_I_RF}
C {devices/iopin.sym} 1720 -460 0 0 {name=p23 lab=voutp_Q_RF}
C {devices/iopin.sym} 1720 -520 0 0 {name=p24 lab=voutn_Q_RF}
C {devices/ipin.sym} 960 -1560 2 1 {name=p25 lab=di_analog_en}
C {lab_pin.sym} 960 -260 2 1 {name=p26 sig_type=std_logic lab=di_analog_en}
C {devices/ipin.sym} 960 -1420 2 1 {name=p47 lab=vinp_I}
C {devices/ipin.sym} 960 -1280 2 1 {name=p48 lab=vinn_I}
C {devices/ipin.sym} 960 -1460 2 1 {name=p29 lab=di_spdt_ctrl_I
}
C {devices/ipin.sym} 960 -1240 2 1 {name=p30 lab=di_ds_I_n}
C {devices/ipin.sym} 960 -440 0 0 {name=p31 lab=di_ds_Q_p}
C {lab_pin.sym} 1340 -840 3 1 {name=p33 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 960 -400 0 0 {name=p40 lab=vinp_Q}
C {devices/ipin.sym} 960 -540 0 0 {name=p41 lab=vinn_Q}
C {devices/ipin.sym} 960 -360 0 0 {name=p45 lab=di_spdt_ctrl_Q
}
C {devices/ipin.sym} 960 -580 0 0 {name=p46 lab=di_ds_Q_n}
C {lab_pin.sym} 1460 -840 3 1 {name=p53 sig_type=std_logic lab=psub}
C {iqmod_top_half.sym} 1340 -1280 0 0 {name=x1}
C {iqmod_top_half.sym} 1340 -540 2 1 {name=x2}
C {lab_pin.sym} 1460 -980 1 1 {name=p2 sig_type=std_logic lab=psub}
