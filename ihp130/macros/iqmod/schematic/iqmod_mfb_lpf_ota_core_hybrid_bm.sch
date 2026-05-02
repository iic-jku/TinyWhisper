v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 5 440 -1300 440 -160 140 -160 140 -1300 440 -1300 {dash = 8}
P 4 5 1160 -1260 2340 -1260 2340 -200 1160 -200 1160 -1260 {dash = 8
}
P 4 5 460 -1260 1420 -1260 1420 -200 460 -200 460 -1260 {dash = 8
}
T {Features of the Barthelemy / Manfredini Hybrid OTA Core:
-) Paper: https://www.mdpi.com/2674-0729/2/1/1
-) The inverter-based OTA topologies Nauta (N), Barthelemy (B) and Manfredini (M) 
can be merged to create hybrid versions such as Barthelemy / Manfredini (B/M).
-) The B/M hybrid OTA has a much higher common-mode rejection ratio (CMRR) compared to N, B, and M OTAs.
-) The B/M hybrid OTA provides a solution to keep the high common-mode rejection 
while having a reasonable output voltage signal headroom compared to the B/N hybrid OTA.} 140 -1580 0 0 0.5 0.5 {}
T {Barthelemy / Manfredini Hybrid OTA Core} 420 -1740 0 0 1.5 1.5 {}
T {B} 580 -1010 0 0 0.6 0.6 {}
T {B} 580 -460 0 0 0.6 0.6 {}
T {C} 820 -790 0 0 0.6 0.6 {}
T {A} 660 -1160 0 0 0.6 0.6 {}
T {A} 660 -400 0 0 0.6 0.6 {}
T {D} 1300 -840 0 0 0.6 0.6 {}
T {D} 1300 -640 0 0 0.6 0.6 {}
T {Manfredini} 2100 -1245 0 0 0.8 0.8 {}
T {Barthelemy} 475 -1250 0 0 0.8 0.8 {}
T {E} 2180 -1010 0 0 0.6 0.6 {}
T {E} 2180 -470 0 0 0.6 0.6 {}
T {F} 2010 -770 0 1 0.6 0.6 {}
T {G} 1650 -770 0 0 0.6 0.6 {}
T {Enable Switches} 150 -735 0 0 0.6 0.6 {}
N 740 -1160 740 -1140 {lab=VDD}
N 740 -1060 740 -1040 {lab=VSS}
N 740 -300 740 -280 {lab=VDD}
N 740 -400 740 -380 {lab=VSS}
N 1320 -540 1340 -540 {lab=VDD}
N 1220 -540 1240 -540 {lab=VSS}
N 1320 -900 1340 -900 {lab=VDD}
N 1220 -900 1240 -900 {lab=VSS}
N 560 -920 580 -920 {lab=VDD}
N 660 -920 680 -920 {lab=VSS}
N 560 -520 580 -520 {lab=VDD}
N 660 -520 680 -520 {lab=VSS}
N 620 -460 620 -340 {lab=node_vinn}
N 620 -720 620 -600 {lab=node_BC}
N 620 -840 620 -720 {lab=node_BC}
N 620 -1100 620 -980 {lab=node_vinp}
N 1280 -460 1280 -340 {lab=voutp}
N 1280 -1100 1280 -980 {lab=voutn}
N 1280 -840 1280 -720 {lab=node_CDG}
N 1280 -720 1280 -600 {lab=node_CDG}
N 960 -840 960 -820 {lab=VDD}
N 960 -740 960 -720 {lab=VSS}
N 1120 -720 1280 -720 {lab=node_CDG}
N 2160 -920 2180 -920 {lab=VDD}
N 2260 -920 2280 -920 {lab=VSS}
N 2160 -520 2180 -520 {lab=VDD}
N 2260 -520 2280 -520 {lab=VSS}
N 2220 -1100 2220 -980 {lab=voutn}
N 2220 -460 2220 -340 {lab=voutp}
N 780 -720 850 -720 {lab=node_BC}
N 800 -640 820 -640 {lab=node_BC}
N 880 -780 900 -780 {lab=node_BC}
N 1040 -780 1060 -780 {lab=node_CDG}
N 1030 -720 1060 -780 {lab=node_CDG}
N 960 -640 990 -640 {lab=node_CDG}
N 1030 -720 1120 -720 {lab=node_CDG}
N 990 -640 1030 -720 {lab=node_CDG}
N 850 -720 880 -780 {lab=node_BC}
N 800 -640 850 -720 {lab=node_BC}
N 880 -700 880 -680 {lab=VSS}
N 2220 -720 2220 -600 {lab=node_EF}
N 1940 -780 1960 -780 {lab=node_EF}
N 1960 -780 1990 -720 {lab=node_EF}
N 1990 -720 2040 -640 {lab=node_EF}
N 2020 -640 2040 -640 {lab=node_EF}
N 1860 -640 1880 -640 {lab=node_FG}
N 1810 -720 1860 -640 {lab=node_FG}
N 1780 -780 1810 -720 {lab=node_FG}
N 1780 -780 1800 -780 {lab=node_FG}
N 1880 -840 1880 -820 {lab=VDD}
N 1880 -740 1880 -720 {lab=VSS}
N 1960 -600 1960 -580 {lab=VDD}
N 1960 -700 1960 -680 {lab=VSS}
N 1600 -780 1620 -780 {lab=node_FG}
N 1620 -780 1650 -720 {lab=node_FG}
N 1650 -720 1700 -640 {lab=node_FG}
N 1680 -640 1700 -640 {lab=node_FG}
N 1520 -640 1540 -640 {lab=node_CDG}
N 1470 -720 1520 -640 {lab=node_CDG}
N 1440 -780 1470 -720 {lab=node_CDG}
N 1440 -780 1460 -780 {lab=node_CDG}
N 1540 -840 1540 -820 {lab=VDD}
N 1540 -740 1540 -720 {lab=VSS}
N 1620 -600 1620 -580 {lab=VDD}
N 1620 -700 1620 -680 {lab=VSS}
N 200 -1060 220 -1060 {lab=VSS}
N 340 -1060 360 -1060 {lab=VDD}
N 620 -1100 680 -1100 {lab=node_vinp}
N 180 -1120 220 -1120 {lab=VDD}
N 180 -1160 180 -1120 {lab=VDD}
N 280 -1180 280 -1160 {lab=di_ota_en}
N 200 -380 220 -380 {lab=VSS}
N 340 -380 360 -380 {lab=VDD}
N 180 -320 220 -320 {lab=VDD}
N 180 -320 180 -280 {lab=VDD}
N 280 -280 280 -260 {lab=di_ota_en}
N 340 -1100 620 -1100 {lab=node_vinp}
N 340 -340 620 -340 {lab=node_vinn}
N 820 -1100 1280 -1100 {lab=voutn}
N 620 -340 680 -340 {lab=node_vinn}
N 820 -340 1280 -340 {lab=voutp}
N 940 -1040 940 -1020 {lab=VDD}
N 940 -940 940 -920 {lab=VSS}
N 1900 -1040 1900 -1020 {lab=VDD}
N 1900 -940 1900 -920 {lab=VSS}
N 1720 -720 1810 -720 {lab=node_FG}
N 960 -1080 960 -1020 {lab=di_ota_en}
N 1880 -1080 1880 -1020 {lab=di_ota_en}
N 880 -600 880 -580 {lab=VDD}
N 100 -1080 220 -1080 {lab=vinp}
N 100 -360 220 -360 {lab=vinn}
N 1860 -760 1860 -720 {lab=psub}
N 1860 -960 1860 -950 {lab=psub}
N 1860 -1010 1860 -1000 {lab=nwell1}
N 2160 -900 2200 -900 {lab=nwell1}
N 2240 -900 2280 -900 {lab=psub}
N 2240 -540 2280 -540 {lab=psub}
N 2160 -540 2200 -540 {lab=nwell2}
N 1940 -620 1940 -580 {lab=nwell2}
N 1600 -620 1600 -580 {lab=nwell2}
N 900 -620 900 -580 {lab=nwell2}
N 760 -320 760 -280 {lab=nwell2}
N 1300 -520 1340 -520 {lab=nwell2}
N 560 -540 600 -540 {lab=nwell2}
N 1520 -760 1520 -720 {lab=psub}
N 1600 -700 1600 -660 {lab=psub}
N 1940 -700 1940 -660 {lab=psub}
N 1220 -520 1260 -520 {lab=psub}
N 900 -700 900 -660 {lab=psub}
N 760 -400 760 -360 {lab=psub}
N 640 -540 680 -540 {lab=psub}
N 640 -900 680 -900 {lab=psub}
N 760 -1080 760 -1040 {lab=psub}
N 1220 -920 1260 -920 {lab=psub}
N 980 -760 980 -720 {lab=psub}
N 1860 -840 1860 -800 {lab=nwell1}
N 1520 -840 1520 -800 {lab=nwell1}
N 1300 -920 1340 -920 {lab=nwell1}
N 760 -1160 760 -1120 {lab=nwell1}
N 560 -900 600 -900 {lab=nwell1}
N 980 -840 980 -800 {lab=nwell1}
N 960 -940 960 -910 {lab=ota_en_n_1}
N 1880 -940 1880 -910 {lab=ota_en_n_1}
N 980 -960 980 -950 {lab=psub}
N 980 -1010 980 -1000 {lab=nwell1}
N 940 -420 940 -400 {lab=VDD}
N 940 -520 940 -500 {lab=VSS}
N 1040 -460 1120 -460 {lab=node_CDG}
N 960 -420 960 -360 {lab=di_ota_en}
N 960 -530 960 -500 {lab=ota_en_n_2}
N 980 -490 980 -480 {lab=psub}
N 1900 -420 1900 -400 {lab=VDD}
N 1900 -520 1900 -500 {lab=VSS}
N 1880 -420 1880 -360 {lab=di_ota_en}
N 1720 -460 1800 -460 {lab=node_FG}
N 1860 -490 1860 -480 {lab=psub}
N 1880 -530 1880 -500 {lab=ota_en_n_2}
N 1860 -440 1860 -430 {lab=nwell2}
N 980 -440 980 -430 {lab=nwell2}
N 1120 -720 1120 -460 {lab=node_CDG}
N 780 -460 880 -460 {lab=node_BC}
N 780 -720 780 -460 {lab=node_BC}
N 620 -720 780 -720 {lab=node_BC}
N 780 -980 780 -720 {lab=node_BC}
N 1120 -980 1120 -720 {lab=node_CDG}
N 1040 -980 1120 -980 {lab=node_CDG}
N 780 -980 880 -980 {lab=node_BC}
N 1720 -980 1800 -980 {lab=node_FG}
N 1720 -980 1720 -720 {lab=node_FG}
N 1960 -980 2060 -980 {lab=node_EF}
N 2060 -980 2060 -720 {lab=node_EF}
N 1990 -720 2060 -720 {lab=node_EF}
N 2060 -720 2060 -460 {lab=node_EF}
N 1960 -460 2060 -460 {lab=node_EF}
N 1650 -720 1720 -720 {lab=node_FG}
N 1720 -720 1720 -460 {lab=node_FG}
N 1280 -720 1470 -720 {lab=node_CDG}
N 1280 -1100 2220 -1100 {lab=voutn}
N 1280 -340 2220 -340 {lab=voutp}
N 2060 -720 2220 -720 {lab=node_EF}
N 2220 -840 2220 -720 {lab=node_EF}
N 2220 -1100 2380 -1100 {lab=voutn}
N 2220 -340 2380 -340 {lab=voutp}
N 280 -1020 280 -960 {lab=ota_en_n_1}
N 280 -440 280 -420 {lab=ota_en_n_2}
N 250 -1020 250 -980 {lab=psub}
N 250 -460 250 -420 {lab=psub}
N 310 -1020 310 -980 {lab=nwell1}
N 310 -460 310 -420 {lab=nwell2}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {ipin.sym} 100 -1080 0 0 {name=p4 lab=vinp}
C {ipin.sym} 100 -360 0 0 {name=p6 lab=vinn}
C {lab_pin.sym} 740 -280 1 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 740 -400 3 1 {name=p8 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 740 -1160 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 740 -1040 1 0 {name=p24 lab=VSS}
C {lab_pin.sym} 1340 -540 0 1 {name=p10 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1220 -540 2 1 {name=p13 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1340 -900 2 0 {name=p18 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1220 -900 0 0 {name=p19 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 560 -920 0 0 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 680 -920 2 0 {name=p26 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 560 -520 2 1 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 680 -520 0 1 {name=p29 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 960 -840 3 1 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 960 -720 1 1 {name=p14 sig_type=std_logic lab=VSS}
C {opin.sym} 2380 -340 0 0 {name=p3 lab=voutp}
C {opin.sym} 2380 -1100 0 0 {name=p11 lab=voutn}
C {lab_pin.sym} 2160 -920 0 0 {name=p37 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2280 -920 2 0 {name=p38 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 2160 -520 2 1 {name=p40 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2280 -520 0 1 {name=p41 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1880 -840 1 0 {name=p43 sig_type=std_logic lab=VDD}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 1280 -900 1 1 {name=x6}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 1280 -540 1 0 {name=x7}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 2220 -920 3 1 {name=x11}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 2220 -520 3 0 {name=x12}
C {iqmod_mfb_lpf_ota_core_inv_NF10.sym} 620 -920 3 1 {name=x9}
C {iqmod_mfb_lpf_ota_core_inv_NF10.sym} 620 -520 3 0 {name=x10}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 1880 -780 0 1 {name=x5}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 960 -780 0 0 {name=x1}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 880 -640 2 1 {name=x4}
C {lab_pin.sym} 880 -580 1 1 {name=p1 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 880 -700 3 1 {name=p2 sig_type=std_logic lab=VSS}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 1960 -640 2 0 {name=x13}
C {lab_pin.sym} 1880 -720 3 0 {name=p5 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1960 -700 3 1 {name=p9 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1960 -580 1 1 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1540 -840 1 0 {name=p16 sig_type=std_logic lab=VDD}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 1540 -780 0 1 {name=x8}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 1620 -640 2 0 {name=x14}
C {lab_pin.sym} 1540 -720 3 0 {name=p17 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1620 -700 3 1 {name=p20 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1620 -580 1 1 {name=p22 sig_type=std_logic lab=VDD}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 740 -1100 0 0 {name=x2}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 740 -340 2 1 {name=x3}
C {iqmod_mfb_lpf_ota_core_spdt_switch.sym} 280 -1100 1 1 {name=x16}
C {lab_pin.sym} 200 -1060 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 360 -1060 0 1 {name=p27 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 180 -1160 3 1 {name=p32 sig_type=std_logic lab=VDD}
C {iqmod_mfb_lpf_ota_core_spdt_switch.sym} 280 -340 1 0 {name=x17}
C {lab_pin.sym} 200 -380 0 0 {name=p34 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 360 -380 2 0 {name=p35 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 180 -280 3 0 {name=p36 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 940 -1040 3 1 {name=p33 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 940 -920 1 1 {name=p39 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1900 -1040 1 0 {name=p44 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1900 -920 3 0 {name=p45 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 280 -1180 3 1 {name=p42 lab=di_ota_en}
C {lab_pin.sym} 280 -260 3 0 {name=p52 sig_type=std_logic lab=di_ota_en}
C {lab_wire.sym} 620 -1100 0 0 {name=p53 sig_type=std_logic lab=node_vinp}
C {lab_wire.sym} 620 -340 2 1 {name=p54 sig_type=std_logic lab=node_vinn}
C {iqmod_mfb_lpf_ota_core_tg.sym} 960 -980 0 0 {name=x15}
C {iqmod_mfb_lpf_ota_core_tg.sym} 1880 -980 0 1 {name=x18}
C {lab_pin.sym} 1860 -720 3 0 {name=p66 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1860 -950 2 1 {name=p69 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1860 -1010 0 0 {name=p70 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 2160 -900 2 1 {name=p71 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 2280 -900 0 1 {name=p72 sig_type=std_logic lab=psub}
C {lab_pin.sym} 2280 -540 0 1 {name=p60 sig_type=std_logic lab=psub}
C {lab_pin.sym} 2160 -540 2 1 {name=p67 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1940 -580 1 1 {name=p68 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1600 -580 1 1 {name=p73 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 900 -580 3 0 {name=p74 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 760 -280 3 0 {name=p75 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1340 -520 0 1 {name=p62 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 560 -540 0 0 {name=p63 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1520 -720 3 0 {name=p76 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1600 -700 1 0 {name=p77 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1940 -700 1 0 {name=p78 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1220 -520 0 0 {name=p79 sig_type=std_logic lab=psub}
C {lab_pin.sym} 900 -700 1 0 {name=p80 sig_type=std_logic lab=psub}
C {lab_pin.sym} 760 -400 1 0 {name=p81 sig_type=std_logic lab=psub}
C {lab_pin.sym} 680 -540 2 0 {name=p82 sig_type=std_logic lab=psub}
C {lab_pin.sym} 680 -900 2 0 {name=p83 sig_type=std_logic lab=psub}
C {lab_pin.sym} 760 -1040 3 0 {name=p84 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1220 -920 0 0 {name=p87 sig_type=std_logic lab=psub}
C {lab_pin.sym} 980 -720 3 0 {name=p88 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1860 -840 1 0 {name=p89 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 1520 -840 1 0 {name=p90 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 1340 -920 2 0 {name=p91 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 760 -1160 3 1 {name=p92 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 560 -900 0 0 {name=p93 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 980 -840 3 1 {name=p94 sig_type=std_logic lab=nwell1}
C {lab_wire.sym} 980 -950 2 0 {name=p97 sig_type=std_logic lab=psub}
C {lab_wire.sym} 980 -1010 0 1 {name=p98 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 940 -400 3 0 {name=p61 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 940 -520 1 0 {name=p64 sig_type=std_logic lab=VSS}
C {iqmod_mfb_lpf_ota_core_tg.sym} 960 -460 2 1 {name=x20}
C {lab_wire.sym} 980 -490 0 1 {name=p101 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1900 -400 1 1 {name=p104 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1900 -520 3 1 {name=p105 sig_type=std_logic lab=VSS}
C {iqmod_mfb_lpf_ota_core_tg.sym} 1880 -460 2 0 {name=x23}
C {lab_wire.sym} 1860 -490 0 0 {name=p108 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1860 -430 2 1 {name=p102 sig_type=std_logic lab=nwell2}
C {lab_wire.sym} 980 -430 2 0 {name=p103 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 280 -960 3 0 {name=p95 sig_type=std_logic lab=ota_en_n_1}
C {lab_pin.sym} 280 -440 1 0 {name=p46 sig_type=std_logic lab=ota_en_n_2}
C {lab_pin.sym} 960 -1080 2 0 {name=p49 sig_type=std_logic lab=di_ota_en}
C {lab_pin.sym} 1880 -1080 2 1 {name=p50 sig_type=std_logic lab=di_ota_en}
C {lab_pin.sym} 960 -360 0 1 {name=p47 sig_type=std_logic lab=di_ota_en}
C {lab_pin.sym} 1880 -360 0 0 {name=p55 sig_type=std_logic lab=di_ota_en}
C {lab_pin.sym} 960 -910 2 0 {name=p48 sig_type=std_logic lab=ota_en_n_1}
C {lab_pin.sym} 1880 -910 2 1 {name=p51 sig_type=std_logic lab=ota_en_n_1}
C {lab_pin.sym} 960 -530 2 0 {name=p56 sig_type=std_logic lab=ota_en_n_2}
C {lab_pin.sym} 1880 -530 2 1 {name=p58 sig_type=std_logic lab=ota_en_n_2}
C {lab_pin.sym} 250 -460 1 0 {name=p65 sig_type=std_logic lab=psub}
C {lab_pin.sym} 310 -980 3 0 {name=p85 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 310 -460 3 1 {name=p86 sig_type=std_logic lab=nwell2}
C {devices/iopin.sym} 250 -980 1 0 {name=p30 lab=psub}
C {lab_wire.sym} 620 -720 0 1 {name=p31 sig_type=std_logic lab=node_BC}
C {lab_wire.sym} 2060 -720 0 1 {name=p57 sig_type=std_logic lab=node_EF}
C {lab_wire.sym} 1280 -720 0 1 {name=p59 sig_type=std_logic lab=node_CDG}
C {lab_wire.sym} 1720 -720 0 1 {name=p96 sig_type=std_logic lab=node_FG}
