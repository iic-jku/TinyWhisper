v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {IQ Modulator - Half} 890 -1750 0 0 1.5 1.5 {}
N 1200 -1100 1200 -1080 {lab=VSS}
N 1180 -1520 1180 -1500 {lab=VDD}
N 1820 -1320 2020 -1320 {lab=voutp_RF}
N 780 -1340 980 -1340 {lab=vinp_spdt}
N 780 -1260 980 -1260 {lab=vinn_spdt}
N 1720 -1420 1720 -1400 {lab=VDD}
N 1760 -1200 1760 -1180 {lab=VSS}
N 1420 -1320 1620 -1320 {lab=voutp_lpf}
N 1420 -1280 1620 -1280 {lab=voutn_lpf}
N 1680 -1200 1680 -1000 {lab=di_lo_p}
N 1720 -1200 1720 -960 {lab=di_lo_n}
N 1820 -1280 2020 -1280 {lab=voutn_RF}
N 1220 -1520 1220 -1500 {lab=di_analog_en}
N 500 -1480 520 -1480 {lab=VSS}
N 640 -1480 660 -1480 {lab=VDD}
N 640 -1200 660 -1200 {lab=VDD}
N 500 -1200 520 -1200 {lab=VSS}
N 500 -1460 520 -1460 {lab=vinp}
N 500 -1180 520 -1180 {lab=vinn}
N 500 -1420 520 -1420 {lab=di_ds_p}
N 500 -1140 520 -1140 {lab=di_ds_n}
N 780 -1440 780 -1340 {lab=vinp_spdt}
N 640 -1440 780 -1440 {lab=vinp_spdt}
N 500 -1000 1680 -1000 {lab=di_lo_p}
N 500 -960 1720 -960 {lab=di_lo_n}
N 640 -1160 780 -1160 {lab=vinn_spdt}
N 780 -1260 780 -1160 {lab=vinn_spdt}
N 500 -1100 550 -1100 {lab=psub}
N 490 -1380 550 -1380 {lab=psub}
N 500 -1060 580 -1060 {lab=di_spdt_ctrl}
N 580 -1100 580 -1060 {lab=di_spdt_ctrl}
N 580 -1380 580 -1340 {lab=di_spdt_ctrl}
N 500 -1340 580 -1340 {lab=di_spdt_ctrl}
N 1260 -1100 1260 -1080 {lab=#net1}
N 1820 -1240 1840 -1240 {lab=psub}
N 1840 -1240 1840 -1180 {lab=psub}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1180 -1520 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 2020 -1320 0 0 {name=p7 lab=voutp_RF}
C {devices/iopin.sym} 1200 -1080 1 0 {name=p3 lab=VSS}
C {lab_pin.sym} 1720 -1420 1 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1760 -1180 3 0 {name=p11 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 500 -1000 2 1 {name=p16 lab=di_lo_p}
C {devices/ipin.sym} 500 -960 0 0 {name=p17 lab=di_lo_n}
C {devices/ipin.sym} 500 -1420 2 1 {name=p8 lab=di_ds_p}
C {lab_wire.sym} 1560 -1320 0 0 {name=p20 sig_type=std_logic lab=voutp_lpf}
C {lab_wire.sym} 1560 -1280 2 1 {name=p22 sig_type=std_logic lab=voutn_lpf}
C {iqmod_mixer.sym} 1720 -1300 0 0 {name=x3}
C {iqmod_mfb_lpf.sym} 1200 -1300 0 0 {name=x1}
C {devices/iopin.sym} 2020 -1280 0 0 {name=p21 lab=voutn_RF}
C {devices/ipin.sym} 1220 -1520 3 1 {name=p25 lab=di_analog_en}
C {iqmod_spdt_switch.sym} 580 -1440 1 0 {name=x5}
C {iqmod_spdt_switch.sym} 580 -1160 1 0 {name=x6}
C {lab_pin.sym} 660 -1480 2 0 {name=p35 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -1480 0 0 {name=p36 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 660 -1200 2 0 {name=p37 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -1200 0 0 {name=p38 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 500 -1460 2 1 {name=p47 lab=vinp}
C {devices/ipin.sym} 500 -1180 2 1 {name=p48 lab=vinn}
C {lab_wire.sym} 780 -1440 0 1 {name=p27 sig_type=std_logic lab=vinp_spdt}
C {lab_wire.sym} 780 -1160 2 0 {name=p28 sig_type=std_logic lab=vinn_spdt}
C {lab_pin.sym} 500 -1060 0 0 {name=p9 sig_type=std_logic lab=di_spdt_ctrl}
C {devices/ipin.sym} 500 -1340 2 1 {name=p29 lab=di_spdt_ctrl
}
C {devices/ipin.sym} 500 -1140 2 1 {name=p30 lab=di_ds_n}
C {lab_pin.sym} 500 -1100 2 1 {name=p2 sig_type=std_logic lab=psub}
C {lab_pin.sym} 490 -1380 2 1 {name=p4 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1840 -1180 1 1 {name=p52 sig_type=std_logic lab=psub}
C {devices/iopin.sym} 1260 -1080 1 0 {name=p5 lab=psub}
