v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Manfredini OTA Core} 850 -1720 0 0 1.5 1.5 {}
T {Features of the Manfredini OTA Core:
-) Paper: https://www.mdpi.com/2079-9292/9/6/1019
-) Another approach is to adopt a CM feedback technique which can be used in a standalone single-stage amplifier.
-) As in the Nauta OTA the output signal is fed back to itself but without positive feedback.
-) The output common-mode signal is extracted from the differential output signals by inverters B and C. Inverters D and E invert the common-mode signal polarity, 
and inverters F feed the common-mode signal back to the output canceling it.
-) As the Barthelemy OTA, this OTA has increased differential output voltage capabilities.
-) Moreover, the maximum common-mode output voltage is increased.} 100 -1580 0 0 0.5 0.5 {}
T {Inverter for Enable} 2150 -910 0 0 0.3 0.3 {}
T {di_ota_core_en = 1... enable
di_ota_core_en = 0... disable} 2130 -620 0 0 0.25 0.25 {}
T {B} 1720 -1030 0 0 0.6 0.6 {}
T {B} 1720 -480 0 0 0.6 0.6 {}
T {C} 1540 -790 0 1 0.6 0.6 {}
T {A} 210 -1180 0 0 0.6 0.6 {}
T {A} 210 -420 0 0 0.6 0.6 {}
T {D} 1260 -790 0 0 0.6 0.6 {}
T {E} 1000 -760 2 1 0.6 0.6 {}
T {C} 2140 -790 0 0 0.6 0.6 {}
T {F} 640 -860 0 0 0.6 0.6 {}
T {F} 640 -660 0 0 0.6 0.6 {}
N 2300 -740 2340 -740 {lab=ota_core_en_n}
N 2120 -740 2160 -740 {lab=di_ota_core_en}
N 280 -1200 280 -1180 {lab=VDD}
N 300 -1080 300 -1060 {lab=VSS}
N 320 -1200 320 -1180 {lab=ota_core_en_n}
N 280 -440 280 -420 {lab=VDD}
N 300 -320 300 -300 {lab=VSS}
N 320 -440 320 -420 {lab=ota_core_en_n}
N 280 -1200 280 -1180 {lab=VDD}
N 300 -1080 300 -1060 {lab=VSS}
N 320 -1200 320 -1180 {lab=ota_core_en_n}
N 960 -820 960 -800 {lab=VDD}
N 940 -700 940 -680 {lab=VSS}
N 920 -820 920 -800 {lab=ota_core_en_n}
N 1220 -820 1220 -800 {lab=VDD}
N 1200 -700 1200 -680 {lab=VSS}
N 1180 -820 1180 -800 {lab=ota_core_en_n}
N 1680 -960 1700 -960 {lab=VDD}
N 1800 -940 1820 -940 {lab=VSS}
N 1680 -920 1700 -920 {lab=ota_core_en_n}
N 1680 -520 1700 -520 {lab=VDD}
N 1800 -540 1820 -540 {lab=VSS}
N 1680 -560 1700 -560 {lab=ota_core_en_n}
N 1480 -820 1480 -800 {lab=VDD}
N 1460 -700 1460 -680 {lab=VSS}
N 1440 -820 1440 -800 {lab=ota_core_en_n}
N 2220 -700 2220 -680 {lab=VSS}
N 2220 -800 2220 -780 {lab=VDD}
N 2220 -820 2220 -800 {lab=VDD}
N 120 -1120 240 -1120 {lab=vinp}
N 120 -360 240 -360 {lab=vinn}
N 680 -580 700 -580 {lab=VDD}
N 560 -560 580 -560 {lab=VSS}
N 680 -540 700 -540 {lab=ota_core_en_n}
N 680 -900 700 -900 {lab=VDD}
N 560 -920 580 -920 {lab=VSS}
N 680 -940 700 -940 {lab=ota_core_en_n}
N 620 -1120 620 -1000 {lab=voutn}
N 620 -480 620 -360 {lab=#net1}
N 620 -860 620 -740 {lab=#net2}
N 620 -740 620 -620 {lab=#net2}
N 620 -740 740 -740 {lab=#net2}
N 1000 -740 1120 -740 {lab=#net2}
N 1260 -740 1380 -740 {lab=#net3}
N 740 -740 860 -740 {lab=#net2}
N 740 -880 740 -740 {lab=#net2}
N 740 -880 1060 -880 {lab=#net2}
N 1060 -880 1060 -740 {lab=#net2}
N 1520 -740 1640 -740 {lab=#net3}
N 1640 -880 1640 -740 {lab=#net3}
N 1320 -880 1640 -880 {lab=#net3}
N 1320 -880 1320 -740 {lab=#net3}
N 1640 -740 1760 -740 {lab=#net3}
N 1760 -1120 1880 -1120 {lab=voutn}
N 620 -360 1760 -360 {lab=#net1}
N 1760 -360 1880 -360 {lab=#net1}
N 1760 -1120 1760 -1000 {lab=voutn}
N 1760 -860 1760 -740 {lab=#net3}
N 1760 -480 1760 -360 {lab=#net1}
N 1760 -740 1760 -620 {lab=#net3}
N 620 -1120 1760 -1120 {lab=voutn}
N 380 -1120 500 -1120 {lab=voutn}
N 500 -1120 620 -1120 {lab=voutn}
N 380 -360 500 -360 {lab=#net1}
N 500 -360 620 -360 {lab=#net1}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 2120 -740 0 0 {name=p5 lab=di_ota_core_en}
C {ipin.sym} 120 -1120 0 0 {name=p4 lab=vinp}
C {ipin.sym} 120 -360 0 0 {name=p6 lab=vinn}
C {opin.sym} 1880 -360 0 0 {name=p3 lab=voutp}
C {opin.sym} 1880 -1120 0 0 {name=p11 lab=voutn}
C {lab_wire.sym} 2340 -740 0 1 {name=p2 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 300 -360 0 0 {name=x2 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 320 -440 0 1 {name=p22 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 280 -440 3 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 300 -300 1 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 280 -1200 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 300 -1060 1 0 {name=p24 lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 300 -1120 0 0 {name=x1 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 320 -1200 0 1 {name=p25 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 940 -740 0 1 {name=x4 W_P=a*W_E L_P=L NF_P=NF_E W_N=W_E L_N=L NF_N=NF_E}
C {lab_wire.sym} 920 -820 0 0 {name=p9 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 960 -820 1 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 940 -680 3 0 {name=p13 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1200 -740 0 1 {name=x5 W_P=a*W_D L_P=L NF_P=NF_D W_N=W_D L_N=L NF_N=NF_D
}
C {lab_wire.sym} 1180 -820 0 0 {name=p17 sig_type=std_logic lab=ota_core_en_n
}
C {lab_pin.sym} 1220 -820 1 0 {name=p18 sig_type=std_logic lab=VDD
}
C {lab_pin.sym} 1200 -680 3 0 {name=p19 sig_type=std_logic lab=VSS
}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1760 -940 3 1 {name=x6 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 1680 -920 3 0 {name=p20 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1680 -960 0 0 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1820 -940 2 0 {name=p26 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1760 -540 3 0 {name=x3 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 1680 -560 3 1 {name=p27 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1680 -520 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1820 -540 0 1 {name=p29 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1460 -740 0 1 {name=x7 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {lab_wire.sym} 1440 -820 0 0 {name=p1 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1480 -820 1 0 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1460 -680 3 0 {name=p14 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 2220 -820 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2220 -680 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_gen.sym} 2220 -740 0 0 {name=x8 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 620 -560 1 0 {name=x9 W_P=a*W_F L_P=L NF_P=NF_F W_N=W_F L_N=L NF_N=NF_F}
C {lab_wire.sym} 700 -540 1 1 {name=p30 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 700 -580 0 1 {name=p31 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 560 -560 2 1 {name=p32 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 620 -920 1 1 {name=x10 W_P=a*W_F L_P=L NF_P=NF_F W_N=W_F L_N=L NF_N=NF_F}
C {lab_wire.sym} 700 -940 1 0 {name=p33 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 700 -900 2 0 {name=p34 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 560 -920 0 0 {name=p35 sig_type=std_logic lab=VSS}
