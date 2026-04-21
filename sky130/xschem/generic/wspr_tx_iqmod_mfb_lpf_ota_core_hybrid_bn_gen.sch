v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 120 -1260 1060 -1260 1060 -220 120 -220 120 -1260 {dash = 8}
P 4 5 1120 -1260 1120 -220 1780 -220 1780 -1260 1120 -1260 {dash = 8}
T {Barthelemy / Nauta Hybrid OTA Core} 520 -1720 0 0 1.5 1.5 {}
T {Features of the Barthelemy / Nauta Hybrid OTA Core:
-) Paper: https://www.mdpi.com/2674-0729/2/1/1
-) The inverter-based OTA topologies Nauta (N), Barthelemy (B) and Manfredini (M) 
can be merged to create hybrid versions such as Barthelemy / Nauta (B/N).
-) The B/N hybrid OTA has a much higher common-mode rejection ratio (CMRR) compared to N, B, M OTAs.
-) However, B/N OTA suffers from the same drawback seen in the Nauta OTA, the reduced differential output voltage.} 160 -1560 0 0 0.6 0.6 {}
T {Inverter for Enable} 2070 -910 0 0 0.3 0.3 {}
T {di_ota_core_en = 1... enable
di_ota_core_en = 0... disable} 2050 -620 0 0 0.25 0.25 {}
T {B} 220 -1010 0 0 0.6 0.6 {}
T {B} 220 -460 0 0 0.6 0.6 {}
T {C} 490 -770 0 0 0.6 0.6 {}
T {A} 490 -1160 0 0 0.6 0.6 {}
T {A} 490 -400 0 0 0.6 0.6 {}
T {D} 940 -840 0 0 0.6 0.6 {}
T {D} 940 -640 0 0 0.6 0.6 {}
T {C} 2060 -790 0 0 0.6 0.6 {}
T {E} 1370 -970 0 0 0.6 0.6 {}
T {E} 1510 -590 0 0 0.6 0.6 {}
T {F} 1220 -670 0 0 0.6 0.6 {}
T {F} 1660 -830 0 0 0.6 0.6 {}
T {Nauta} 1130 -1250 0 0 0.8 0.8 {}
T {Barthelemy} 130 -1250 0 0 0.8 0.8 {}
N 2220 -740 2260 -740 {lab=ota_core_en_n}
N 2040 -740 2080 -740 {lab=di_ota_core_en}
N 560 -1180 560 -1160 {lab=VDD}
N 580 -1060 580 -1040 {lab=VSS}
N 600 -1180 600 -1160 {lab=ota_core_en_n}
N 560 -420 560 -400 {lab=VDD}
N 580 -300 580 -280 {lab=VSS}
N 600 -420 600 -400 {lab=ota_core_en_n}
N 560 -1180 560 -1160 {lab=VDD}
N 580 -1060 580 -1040 {lab=VSS}
N 600 -1180 600 -1160 {lab=ota_core_en_n}
N 980 -560 1000 -560 {lab=VDD}
N 860 -540 880 -540 {lab=VSS}
N 980 -520 1000 -520 {lab=ota_core_en_n}
N 980 -880 1000 -880 {lab=VDD}
N 860 -900 880 -900 {lab=VSS}
N 980 -920 1000 -920 {lab=ota_core_en_n}
N 180 -940 200 -940 {lab=VDD}
N 300 -920 320 -920 {lab=VSS}
N 180 -900 200 -900 {lab=ota_core_en_n}
N 180 -500 200 -500 {lab=VDD}
N 300 -520 320 -520 {lab=VSS}
N 180 -540 200 -540 {lab=ota_core_en_n}
N 260 -340 520 -340 {lab=vinn}
N 260 -460 260 -340 {lab=vinn}
N 260 -720 260 -600 {lab=#net1}
N 260 -840 260 -720 {lab=#net1}
N 260 -1100 260 -980 {lab=vinp}
N 920 -460 920 -340 {lab=voutp}
N 260 -1100 520 -1100 {lab=vinp}
N 920 -1100 920 -980 {lab=#net2}
N 660 -1100 920 -1100 {lab=#net2}
N 920 -840 920 -720 {lab=#net1}
N 920 -720 920 -600 {lab=#net1}
N 660 -340 920 -340 {lab=voutp}
N 560 -800 560 -780 {lab=VDD}
N 580 -680 580 -660 {lab=VSS}
N 600 -800 600 -780 {lab=ota_core_en_n}
N 260 -720 520 -720 {lab=#net1}
N 660 -720 920 -720 {lab=#net1}
N 740 -900 740 -720 {lab=#net1}
N 440 -900 740 -900 {lab=#net1}
N 440 -900 440 -720 {lab=#net1}
N 2140 -700 2140 -680 {lab=VSS}
N 2140 -800 2140 -780 {lab=VDD}
N 2140 -820 2140 -800 {lab=VDD}
N 1260 -920 1380 -920 {lab=#net2}
N 1520 -920 1640 -920 {lab=#net2}
N 1520 -540 1640 -540 {lab=voutp}
N 1260 -540 1380 -540 {lab=voutp}
N 1640 -660 1640 -540 {lab=voutp}
N 1260 -660 1260 -540 {lab=voutp}
N 1260 -920 1260 -800 {lab=#net2}
N 1640 -920 1640 -800 {lab=#net2}
N 1480 -620 1480 -600 {lab=VDD}
N 1460 -500 1460 -480 {lab=VSS}
N 1440 -620 1440 -600 {lab=ota_core_en_n}
N 1420 -1000 1420 -980 {lab=VDD}
N 1440 -880 1440 -860 {lab=VSS}
N 1460 -1000 1460 -980 {lab=ota_core_en_n}
N 1180 -700 1200 -700 {lab=VDD}
N 1300 -720 1320 -720 {lab=VSS}
N 1180 -740 1200 -740 {lab=ota_core_en_n}
N 1700 -760 1720 -760 {lab=VDD}
N 1580 -740 1600 -740 {lab=VSS}
N 1700 -720 1720 -720 {lab=ota_core_en_n}
N 1260 -1100 1260 -920 {lab=#net2}
N 1260 -540 1260 -340 {lab=voutp}
N 1640 -540 1640 -340 {lab=voutp}
N 1260 -340 1640 -340 {lab=voutp}
N 1260 -1100 1640 -1100 {lab=#net2}
N 1640 -1100 1640 -920 {lab=#net2}
N 920 -1100 1260 -1100 {lab=#net2}
N 910 -340 1260 -340 {lab=voutp}
N 100 -340 260 -340 {lab=vinn}
N 100 -1100 260 -1100 {lab=vinp}
N 1640 -1100 1800 -1100 {lab=#net2}
N 1640 -340 1800 -340 {lab=voutp}
N 100 -340 260 -340 {lab=vinn}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 2040 -740 0 0 {name=p5 lab=di_ota_core_en}
C {ipin.sym} 100 -1100 0 0 {name=p4 lab=vinp}
C {ipin.sym} 100 -340 0 0 {name=p6 lab=vinn}
C {opin.sym} 1800 -340 0 0 {name=p3 lab=voutp}
C {opin.sym} 1800 -1100 0 0 {name=p11 lab=voutn}
C {lab_wire.sym} 2260 -740 0 1 {name=p2 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 580 -340 0 0 {name=x2 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 600 -420 0 1 {name=p22 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 560 -420 3 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 580 -280 1 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 560 -1180 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 580 -1040 1 0 {name=p24 lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 580 -1100 0 0 {name=x1 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 600 -1180 0 1 {name=p25 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 920 -540 1 0 {name=x4 W_P=a*W_D L_P=L NF_P=NF_D W_N=W_D L_N=L NF_N=NF_D}
C {lab_wire.sym} 1000 -520 1 1 {name=p9 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1000 -560 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 860 -540 2 1 {name=p13 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 920 -900 1 1 {name=x5 W_P=a*W_D L_P=L NF_P=NF_D W_N=W_D L_N=L NF_N=NF_D}
C {lab_wire.sym} 1000 -920 1 0 {name=p17 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1000 -880 2 0 {name=p18 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 860 -900 0 0 {name=p19 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 260 -920 3 1 {name=x6 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 180 -900 3 0 {name=p20 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 180 -940 0 0 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 320 -920 2 0 {name=p26 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 260 -520 3 0 {name=x3 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 180 -540 3 1 {name=p27 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 180 -500 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 320 -520 0 1 {name=p29 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 580 -720 0 0 {name=x7 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {lab_wire.sym} 600 -800 0 1 {name=p1 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 560 -800 3 1 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 580 -660 1 1 {name=p14 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 2140 -820 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2140 -680 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_gen.sym} 2140 -740 0 0 {name=x8 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1460 -540 0 1 {name=x9 W_P=a*W_E L_P=L NF_P=NF_E W_N=W_E L_N=L NF_N=NF_E}
C {lab_wire.sym} 1440 -620 0 0 {name=p30 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1480 -620 1 0 {name=p31 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1460 -480 3 0 {name=p32 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1440 -920 0 0 {name=x10 W_P=a*W_E L_P=L NF_P=NF_E W_N=W_E L_N=L NF_N=NF_E}
C {lab_wire.sym} 1460 -1000 0 1 {name=p33 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1420 -1000 3 1 {name=p34 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1440 -860 1 1 {name=p35 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1260 -720 3 0 {name=x11 W_P=a*W_F L_P=L NF_P=NF_F W_N=W_F L_N=L NF_N=NF_F}
C {lab_wire.sym} 1180 -740 3 1 {name=p36 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1180 -700 2 1 {name=p37 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1320 -720 0 1 {name=p38 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1640 -740 1 0 {name=x12 W_P=a*W_F L_P=L NF_P=NF_F W_N=W_F L_N=L NF_N=NF_F}
C {lab_wire.sym} 1720 -720 1 1 {name=p39 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1720 -760 0 1 {name=p40 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1580 -740 2 1 {name=p41 sig_type=std_logic lab=VSS}
