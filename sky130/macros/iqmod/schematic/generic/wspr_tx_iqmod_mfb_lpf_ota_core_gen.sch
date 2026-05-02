v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 1960 -680 1960 -240 2380 -240 2380 -680 1960 -680 {dash = 8}
P 4 5 1500 -680 1500 -240 1920 -240 1920 -680 1500 -680 {dash = 8}
P 4 5 1040 -680 1040 -240 1460 -240 1460 -680 1040 -680 {dash = 8}
P 4 5 580 -680 580 -240 1000 -240 1000 -680 580 -680 {dash = 8}
P 4 5 120 -680 120 -240 540 -240 540 -680 120 -680 {dash = 8}
P 4 5 1040 -1320 1040 -760 1460 -760 1460 -1320 1040 -1320 {dash = 8}
T {OTA Core Wrapper} 890 -1720 0 0 1.5 1.5 {}
T {With this wrapper of the inverter-based OTA core you can choose between:
-) Nauta OTA
-) Barthelemy OTA
-) Manfredini OTA
-) Barthelemy / Nauta OTA
-) Barthelemy / Manfredini OTA} 120 -1540 0 0 0.6 0.6 {}
T {Barthelemy / Manfredini OTA} 1970 -670 0 0 0.5 0.5 {}
T {Barthelemy / Nauta OTA} 1510 -670 0 0 0.5 0.5 {}
T {Manfredini OTA} 1050 -670 0 0 0.5 0.5 {}
T {Barthelemy OTA} 590 -670 0 0 0.5 0.5 {}
T {Nauta OTA} 130 -670 0 0 0.5 0.5 {}
T {DUT} 1050 -1310 0 0 0.5 0.5 {}
N 1120 -1060 1160 -1060 {lab=vinp}
N 1120 -980 1160 -980 {lab=vinn}
N 1240 -920 1240 -880 {lab=VSS}
N 1240 -1160 1240 -1120 {lab=VDD}
N 1280 -1160 1280 -1140 {lab=di_ota_core_en}
N 1260 -1140 1280 -1140 {lab=di_ota_core_en}
N 1260 -1140 1260 -1120 {lab=di_ota_core_en}
N 1340 -1040 1380 -1040 {lab=voutn}
N 1340 -1000 1380 -1000 {lab=#net1}
C {devices/ipin.sym} 1280 -1160 1 0 {name=p5 lab=di_ota_core_en}
C {ipin.sym} 1120 -1060 0 0 {name=p4 lab=vinp}
C {ipin.sym} 1120 -980 0 0 {name=p6 lab=vinn}
C {opin.sym} 1380 -1000 0 0 {name=p3 lab=voutp}
C {opin.sym} 1380 -1040 0 0 {name=p11 lab=voutn}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1240 -1160 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 1240 -880 1 0 {name=p24 lab=VSS}
C {wspr_tx_iqmod_mfb_lpf_ota_core_barthelemy_gen.sym} 760 -500 0 0 {name=x3 spice_ignore=true W_A=W_long W_B=W_long W_C=W_short W_D=W_long a=a L=L NF_A=NF_long NF_B=NF_long NF_C=NF_short NF_D=NF_long}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bn_gen.sym} 1680 -500 0 0 {name=x5 spice_ignore=true W_A=W_long W_B=W_long W_C=W_short W_D=W_long W_E=W_long W_F=W_short a=a L=L NF_A=NF_long NF_B=NF_long NF_C=NF_short NF_D=NF_long NF_E=NF_long NF_F=NF_short}
C {wspr_tx_iqmod_mfb_lpf_ota_core_manfredini_gen.sym} 1220 -500 0 0 {name=x4 spice_ignore=true W_A=W_long W_B=W_long W_C=W_short W_D=W_long W_E=W_long W_F=W_long a=a L=L NF_A=NF_long NF_B=NF_long NF_C=NF_short NF_D=NF_long NF_E=NF_long NF_F=NF_long}
C {wspr_tx_iqmod_mfb_lpf_ota_core_nauta_gen.sym} 300 -500 0 0 {name=x2 spice_ignore=true W_A=W_long W_B=W_short W_C=W_long a=a L=L NF_A=NF_long NF_B=NF_short NF_C=NF_long}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm_gen.sym} 1240 -1020 0 0 {name=x1 W_A=W_long W_B=W_long W_C=W_short W_D=W_long W_E=W_long W_F=W_short W_G=W_long a=a L=L NF_A=NF_long NF_B=NF_long NF_C=NF_short NF_D=NF_long NF_E=NF_long NF_F=NF_short NF_G=NF_long}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm_gen.sym} 2140 -500 0 0 {name=x6 spice_ignore=true W_A=W_long W_B=W_long W_C=W_short W_D=W_long W_E=W_long W_F=W_short W_G=W_long a=a L=L NF_A=NF_long NF_B=NF_long NF_C=NF_short NF_D=NF_long NF_E=NF_long NF_F=NF_short NF_G=NF_long}
