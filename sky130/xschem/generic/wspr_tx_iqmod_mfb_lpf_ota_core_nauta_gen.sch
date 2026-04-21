v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Nauta OTA Core} 940 -1720 0 0 1.5 1.5 {}
T {Inverter for Enable} 1910 -840 0 0 0.3 0.3 {}
T {di_ota_core_en = 1... enable
di_ota_core_en = 0... disable} 1890 -540 0 0 0.25 0.25 {}
T {Features of the Nauta OTA Core:
-) Paper: https://ris.utwente.nl/ws/portalfiles/portal/6771395/cmos_transconductance.pdf
-) No internal nodes: theoretically infinite bandwidth
-) DC gain enhancement would theoretically lead to infinite dc gain. However, transconductance error due to mismatch limits the dc gain to around 40dB.
-) Linear V-I conversion: beta_n = beta_p --> mu_n = 3 mu_p --> W_p / L_p = 3 W_n / L_n
-) beta_n = beta_p, Vth_n ~ -Vth_p --> V_cm ~ 1/2 VDD
-) DC gain enhancement: g_m3 > g_m4, g_m6 > g_m5, g_m5 = g_m4, g_m6 = g_m3 --> W_4 = W_5 < W_3 = W_6
-) In this filter design, gm1, gm2, gm3 and gm6 are chosen equal, and gm4 and gm5 are designed slightly smaller.
-) To avoid instability in a filter, Acm must be smaller than unity and therefore requires gm5 + gm6 > gm1. This is fulfilled with above gm-choices.
-) Lengths: To achieve a maximal filter cut-off frequency the channel lengths are chosen minimal (L_p = L_n = 0.35um). 
Note that L_n is minimum 0.15um, but L_p is minimum 0.35um.
-) Tradeoffs: The width of the transistors is a compromise between matching and accuracy (large W) on one hand and area and dissipation (small W) on the other hand. 
The widths of the p-channel transistors are a factor 3 larger than those of the n-channel devices.} 140 -1580 0 0 0.5 0.5 {}
T {A} 420 -980 0 0 0.6 0.6 {}
T {A} 420 -280 0 0 0.6 0.6 {}
T {B} 1010 -890 0 0 0.6 0.6 {}
T {B} 1150 -510 0 0 0.6 0.6 {}
T {C} 860 -590 0 0 0.6 0.6 {}
T {C} 1300 -750 0 0 0.6 0.6 {}
T {B} 1900 -710 0 0 0.6 0.6 {}
N 2060 -660 2100 -660 {lab=ota_core_en_n}
N 1880 -660 1920 -660 {lab=di_ota_core_en}
N 1980 -620 1980 -600 {lab=VSS}
N 1980 -720 1980 -700 {lab=VDD}
N 1280 -1000 1560 -1000 {lab=voutn}
N 360 -1000 440 -1000 {lab=vinp}
N 360 -300 440 -300 {lab=vinn}
N 480 -1080 480 -1060 {lab=VDD}
N 500 -960 500 -940 {lab=VSS}
N 900 -840 1020 -840 {lab=voutn}
N 900 -1000 900 -840 {lab=voutn}
N 580 -1000 900 -1000 {lab=voutn}
N 1160 -840 1280 -840 {lab=voutn}
N 1280 -1000 1280 -840 {lab=voutn}
N 900 -1000 1280 -1000 {lab=voutn}
N 1160 -460 1280 -460 {lab=#net1}
N 900 -460 1020 -460 {lab=#net1}
N 900 -460 900 -300 {lab=#net1}
N 1280 -460 1280 -300 {lab=#net1}
N 580 -300 900 -300 {lab=#net1}
N 900 -300 1280 -300 {lab=#net1}
N 1280 -300 1560 -300 {lab=#net1}
N 1280 -580 1280 -460 {lab=#net1}
N 900 -580 900 -460 {lab=#net1}
N 900 -840 900 -720 {lab=voutn}
N 1280 -840 1280 -720 {lab=voutn}
N 520 -1080 520 -1060 {lab=ota_core_en_n}
N 480 -380 480 -360 {lab=VDD}
N 500 -260 500 -240 {lab=VSS}
N 520 -380 520 -360 {lab=ota_core_en_n}
N 480 -1080 480 -1060 {lab=VDD}
N 500 -960 500 -940 {lab=VSS}
N 520 -1080 520 -1060 {lab=ota_core_en_n}
N 1120 -540 1120 -520 {lab=VDD}
N 1100 -420 1100 -400 {lab=VSS}
N 1080 -540 1080 -520 {lab=ota_core_en_n}
N 1060 -920 1060 -900 {lab=VDD}
N 1080 -800 1080 -780 {lab=VSS}
N 1100 -920 1100 -900 {lab=ota_core_en_n}
N 820 -620 840 -620 {lab=VDD}
N 940 -640 960 -640 {lab=VSS}
N 820 -660 840 -660 {lab=ota_core_en_n}
N 1340 -680 1360 -680 {lab=VDD}
N 1220 -660 1240 -660 {lab=VSS}
N 1340 -640 1360 -640 {lab=ota_core_en_n}
N 1980 -740 1980 -720 {lab=VDD}
C {devices/ipin.sym} 1880 -660 0 0 {name=p5 lab=di_ota_core_en}
C {ipin.sym} 360 -1000 0 0 {name=p4 lab=vinp}
C {ipin.sym} 360 -300 0 0 {name=p6 lab=vinn}
C {opin.sym} 1560 -300 0 0 {name=p3 lab=voutp}
C {opin.sym} 1560 -1000 0 0 {name=p11 lab=voutn}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {lab_wire.sym} 2100 -660 0 1 {name=p2 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1980 -740 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1980 -600 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_gen.sym} 1980 -660 0 0 {name=x7 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 500 -300 0 0 {name=x2 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 520 -380 0 1 {name=p22 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 480 -380 3 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -240 1 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 480 -1080 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 500 -940 1 0 {name=p24 lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 500 -1000 0 0 {name=x1 W_P=a*W_A L_P=L NF_P=NF_A W_N=W_A L_N=L NF_N=NF_A}
C {lab_wire.sym} 520 -1080 0 1 {name=p25 sig_type=std_logic lab=ota_core_en_n}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1100 -460 0 1 {name=x4 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 1080 -540 0 0 {name=p9 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1120 -540 1 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1100 -400 3 0 {name=p13 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1080 -840 0 0 {name=x5 W_P=a*W_B L_P=L NF_P=NF_B W_N=W_B L_N=L NF_N=NF_B}
C {lab_wire.sym} 1100 -920 0 1 {name=p17 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1060 -920 3 1 {name=p18 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1080 -780 1 1 {name=p19 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 900 -640 3 0 {name=x6 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {lab_wire.sym} 820 -660 3 1 {name=p20 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 820 -620 2 1 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 960 -640 0 1 {name=p26 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_en_gen.sym} 1280 -660 1 0 {name=x3 W_P=a*W_C L_P=L NF_P=NF_C W_N=W_C L_N=L NF_N=NF_C}
C {lab_wire.sym} 1360 -640 1 1 {name=p27 sig_type=std_logic lab=ota_core_en_n}
C {lab_pin.sym} 1360 -680 0 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1220 -660 2 1 {name=p29 sig_type=std_logic lab=VSS}
