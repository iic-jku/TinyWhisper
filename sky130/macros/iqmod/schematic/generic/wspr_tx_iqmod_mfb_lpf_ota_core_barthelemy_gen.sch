v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Barthelemy OTA Core} 770 -1720 0 0 1.5 1.5 {}
T {Inverter for Enable} 1890 -910 0 0 0.3 0.3 {}
T {di_ota_core_en = 1... enable
di_ota_core_en = 0... disable} 1870 -620 0 0 0.25 0.25 {}
T {Features of the Barthelemy OTA Core:
-) Paper: https://link.springer.com/article/10.1007/s10470-008-9167-8
-) Inverter-based OTA based on the common-mode input feedforward rejection technique.
-) This OTA topology main advantage is its output voltage headroom, as the Nauta topology greatly reduces it.} 200 -1550 0 0 0.6 0.6 {}
T {B} 560 -1030 0 0 0.6 0.6 {}
T {B} 560 -480 0 0 0.6 0.6 {}
T {C} 830 -790 0 0 0.6 0.6 {}
T {A} 830 -1180 0 0 0.6 0.6 {}
T {A} 830 -420 0 0 0.6 0.6 {}
T {D} 1280 -860 0 0 0.6 0.6 {}
T {D} 1280 -660 0 0 0.6 0.6 {}
T {C} 1880 -790 0 0 0.6 0.6 {}
N 2040 -740 2080 -740 {lab=ota_core_en_n}
N 1860 -740 1900 -740 {lab=di_ota_core_en}
N 900 -1200 900 -1180 {lab=VDD}
N 920 -1080 920 -1060 {lab=VSS}
N 940 -1200 940 -1180 {lab=ota_core_en_n}
N 900 -440 900 -420 {lab=VDD}
N 920 -320 920 -300 {lab=VSS}
N 940 -440 940 -420 {lab=ota_core_en_n}
N 900 -1200 900 -1180 {lab=VDD}
N 920 -1080 920 -1060 {lab=VSS}
N 940 -1200 940 -1180 {lab=ota_core_en_n}
N 1320 -580 1340 -580 {lab=VDD}
N 1200 -560 1220 -560 {lab=VSS}
N 1320 -540 1340 -540 {lab=ota_core_en_n}
N 1320 -900 1340 -900 {lab=VDD}
N 1200 -920 1220 -920 {lab=VSS}
N 1320 -940 1340 -940 {lab=ota_core_en_n}
N 520 -960 540 -960 {lab=VDD}
N 640 -940 660 -940 {lab=VSS}
N 520 -920 540 -920 {lab=ota_core_en_n}
N 520 -520 540 -520 {lab=VDD}
N 640 -540 660 -540 {lab=VSS}
N 520 -560 540 -560 {lab=ota_core_en_n}
N 340 -360 600 -360 {lab=vinn}
N 600 -360 860 -360 {lab=vinn}
N 600 -480 600 -360 {lab=vinn}
N 600 -740 600 -620 {lab=#net1}
N 600 -860 600 -740 {lab=#net1}
N 600 -1120 600 -1000 {lab=vinp}
N 1260 -480 1260 -360 {lab=#net2}
N 340 -1120 600 -1120 {lab=vinp}
N 600 -1120 860 -1120 {lab=vinp}
N 1260 -1120 1260 -1000 {lab=voutn}
N 1000 -1120 1260 -1120 {lab=voutn}
N 1260 -1120 1520 -1120 {lab=voutn}
N 1260 -860 1260 -740 {lab=#net1}
N 1260 -740 1260 -620 {lab=#net1}
N 1000 -360 1260 -360 {lab=#net2}
N 1260 -360 1520 -360 {lab=#net2}
N 900 -820 900 -800 {lab=VDD}
N 920 -700 920 -680 {lab=VSS}
N 940 -820 940 -800 {lab=ota_core_en_n}
N 600 -740 860 -740 {lab=#net1}
N 1000 -740 1260 -740 {lab=#net1}
N 1080 -920 1080 -740 {lab=#net1}
N 780 -920 1080 -920 {lab=#net1}
N 780 -920 780 -740 {lab=#net1}
N 1960 -700 1960 -680 {lab=VSS}
N 1960 -800 1960 -780 {lab=VDD}
N 1960 -820 1960 -800 {lab=VDD}
C {devices/ipin.sym} 1860 -740 0 0 {name=p5 lab=di_ota_core_en}
C {ipin.sym} 340 -1120 0 0 {name=p4 lab=vinp}
C {ipin.sym} 340 -360 0 0 {name=p6 lab=vinn}
C {opin.sym} 1520 -360 0 0 {name=p3 lab=voutp}
C {opin.sym} 1520 -1120 0 0 {name=p11 lab=voutn}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {lab_wire.sym} 2080 -740 0 1 {name=p2 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 920 -360 0 0 {name=x2 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 940 -440 0 1 {name=p22 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 900 -440 3 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 920 -300 1 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 900 -1200 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 920 -1060 1 0 {name=p24 lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 920 -1120 0 0 {name=x1 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 940 -1200 0 1 {name=p25 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1260 -560 1 0 {name=x4 W_P=a*W_D L_P=L NF_P=NF_D W_N=W_D L_N=L NF_N=NF_D}
C {lab_wire.sym} 1340 -540 1 1 {name=p9 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1340 -580 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1200 -560 2 1 {name=p13 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1260 -920 1 1 {name=x5 W_P=a*W_D L_P=L NF_P=NF_D W_N=W_D L_N=L NF_N=NF_D}
C {lab_wire.sym} 1340 -940 1 0 {name=p17 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1340 -900 2 0 {name=p18 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1200 -920 0 0 {name=p19 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 600 -940 3 1 {name=x6 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 520 -920 3 0 {name=p20 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 520 -960 0 0 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 660 -940 2 0 {name=p26 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 600 -540 3 0 {name=x3 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 520 -560 3 1 {name=p27 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 520 -520 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 660 -540 0 1 {name=p29 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 920 -740 0 0 {name=x7 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {lab_wire.sym} 940 -820 0 1 {name=p1 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 900 -820 3 1 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 920 -680 1 1 {name=p14 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1960 -820 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1960 -680 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_gen.sym} 1960 -740 0 0 {name=x8 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
