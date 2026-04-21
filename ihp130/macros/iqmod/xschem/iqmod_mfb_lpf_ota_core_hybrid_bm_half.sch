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
T {Barthelemy / Manfredini Hybrid OTA Core - Half} 330 -1740 0 0 1.5 1.5 {}
T {B} 580 -1010 0 0 0.6 0.6 {}
T {C} 820 -790 0 0 0.6 0.6 {}
T {A} 660 -1160 0 0 0.6 0.6 {}
T {D} 1300 -840 0 0 0.6 0.6 {}
T {Manfredini} 2100 -1245 0 0 0.8 0.8 {}
T {Barthelemy} 475 -1250 0 0 0.8 0.8 {}
T {E} 2180 -1010 0 0 0.6 0.6 {}
T {F} 2010 -770 0 1 0.6 0.6 {}
T {G} 1650 -770 0 0 0.6 0.6 {}
T {Enable Switches} 150 -735 0 0 0.6 0.6 {}
N 740 -1160 740 -1140 {lab=VDD}
N 740 -1060 740 -1040 {lab=VSS}
N 1320 -900 1340 -900 {lab=VDD}
N 1220 -900 1240 -900 {lab=VSS}
N 560 -920 580 -920 {lab=VDD}
N 660 -920 680 -920 {lab=VSS}
N 620 -840 620 -720 {lab=#net1}
N 620 -1100 620 -980 {lab=node_vinp}
N 1280 -1100 1280 -980 {lab=voutn}
N 1280 -840 1280 -720 {lab=#net2}
N 960 -840 960 -820 {lab=VDD}
N 960 -740 960 -720 {lab=VSS}
N 1120 -720 1280 -720 {lab=#net2}
N 2160 -920 2180 -920 {lab=VDD}
N 2260 -920 2280 -920 {lab=VSS}
N 2220 -1100 2220 -980 {lab=voutn}
N 780 -720 850 -720 {lab=#net1}
N 880 -780 900 -780 {lab=#net1}
N 1040 -780 1060 -780 {lab=#net2}
N 1030 -720 1060 -780 {lab=#net2}
N 1030 -720 1120 -720 {lab=#net2}
N 850 -720 880 -780 {lab=#net1}
N 1940 -780 1960 -780 {lab=#net3}
N 1960 -780 1990 -720 {lab=#net3}
N 1780 -780 1810 -720 {lab=#net4}
N 1780 -780 1800 -780 {lab=#net4}
N 1880 -840 1880 -820 {lab=VDD}
N 1880 -740 1880 -720 {lab=VSS}
N 1600 -780 1620 -780 {lab=#net4}
N 1620 -780 1650 -720 {lab=#net4}
N 1440 -780 1470 -720 {lab=#net2}
N 1440 -780 1460 -780 {lab=#net2}
N 1540 -840 1540 -820 {lab=VDD}
N 1540 -740 1540 -720 {lab=VSS}
N 200 -1060 220 -1060 {lab=VSS}
N 340 -1060 360 -1060 {lab=VDD}
N 620 -1100 680 -1100 {lab=node_vinp}
N 180 -1120 220 -1120 {lab=VDD}
N 180 -1160 180 -1120 {lab=VDD}
N 280 -1180 280 -1160 {lab=di_ota_en}
N 340 -1100 620 -1100 {lab=node_vinp}
N 820 -1100 1280 -1100 {lab=voutn}
N 940 -1040 940 -1020 {lab=VDD}
N 940 -940 940 -920 {lab=VSS}
N 1900 -1040 1900 -1020 {lab=VDD}
N 1900 -940 1900 -920 {lab=VSS}
N 1720 -720 1810 -720 {lab=#net4}
N 960 -1080 960 -1020 {lab=di_ota_en}
N 1880 -1080 1880 -1020 {lab=di_ota_en}
N 100 -1080 220 -1080 {lab=vinp}
N 1860 -760 1860 -720 {lab=psub}
N 1860 -960 1860 -950 {lab=psub}
N 1860 -1010 1860 -1000 {lab=nwell1}
N 2160 -900 2200 -900 {lab=nwell1}
N 2240 -900 2280 -900 {lab=psub}
N 1520 -760 1520 -720 {lab=psub}
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
N 620 -720 780 -720 {lab=#net1}
N 780 -980 780 -720 {lab=#net1}
N 1120 -980 1120 -720 {lab=#net2}
N 1040 -980 1120 -980 {lab=#net2}
N 780 -980 880 -980 {lab=#net1}
N 1720 -980 1800 -980 {lab=#net4}
N 1720 -980 1720 -720 {lab=#net4}
N 1960 -980 2060 -980 {lab=#net3}
N 2060 -980 2060 -720 {lab=#net3}
N 1990 -720 2060 -720 {lab=#net3}
N 1650 -720 1720 -720 {lab=#net4}
N 1280 -720 1470 -720 {lab=#net2}
N 1280 -1100 2220 -1100 {lab=voutn}
N 2060 -720 2220 -720 {lab=#net3}
N 2220 -840 2220 -720 {lab=#net3}
N 2220 -1100 2380 -1100 {lab=voutn}
N 280 -1020 280 -960 {lab=ota_en_n_1}
N 250 -1020 250 -980 {lab=psub}
N 310 -1020 310 -980 {lab=nwell1}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {ipin.sym} 100 -1080 0 0 {name=p4 lab=vinp}
C {devices/iopin.sym} 740 -1160 3 0 {name=p23 lab=VDD}
C {devices/iopin.sym} 740 -1040 1 0 {name=p24 lab=VSS}
C {lab_pin.sym} 1340 -900 2 0 {name=p18 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1220 -900 0 0 {name=p19 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 560 -920 0 0 {name=p21 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 680 -920 2 0 {name=p26 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 960 -840 3 1 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 960 -720 1 1 {name=p14 sig_type=std_logic lab=VSS}
C {opin.sym} 2380 -1100 0 0 {name=p11 lab=voutn}
C {lab_pin.sym} 2160 -920 0 0 {name=p37 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2280 -920 2 0 {name=p38 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1880 -840 1 0 {name=p43 sig_type=std_logic lab=VDD}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 1280 -900 1 1 {name=x6}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 2220 -920 3 1 {name=x11}
C {iqmod_mfb_lpf_ota_core_inv_NF10.sym} 620 -920 3 1 {name=x9}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 1880 -780 0 1 {name=x5}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 960 -780 0 0 {name=x1}
C {lab_pin.sym} 1880 -720 3 0 {name=p5 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1540 -840 1 0 {name=p16 sig_type=std_logic lab=VDD}
C {iqmod_mfb_lpf_ota_core_inv_NF6.sym} 1540 -780 0 1 {name=x8}
C {lab_pin.sym} 1540 -720 3 0 {name=p17 sig_type=std_logic lab=VSS}
C {iqmod_mfb_lpf_ota_core_inv_NF20.sym} 740 -1100 0 0 {name=x2}
C {iqmod_mfb_lpf_ota_core_spdt_switch.sym} 280 -1100 1 1 {name=x16}
C {lab_pin.sym} 200 -1060 2 1 {name=p25 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 360 -1060 0 1 {name=p27 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 180 -1160 3 1 {name=p32 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 940 -1040 3 1 {name=p33 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 940 -920 1 1 {name=p39 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1900 -1040 1 0 {name=p44 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1900 -920 3 0 {name=p45 sig_type=std_logic lab=VSS}
C {devices/ipin.sym} 280 -1180 3 1 {name=p42 lab=di_ota_en}
C {lab_wire.sym} 560 -1100 0 0 {name=p53 sig_type=std_logic lab=node_vinp}
C {iqmod_mfb_lpf_ota_core_tg.sym} 960 -980 0 0 {name=x15}
C {iqmod_mfb_lpf_ota_core_tg.sym} 1880 -980 0 1 {name=x18}
C {lab_pin.sym} 1860 -720 3 0 {name=p66 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1860 -950 2 1 {name=p69 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1860 -1010 0 0 {name=p70 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 2160 -900 2 1 {name=p71 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 2280 -900 0 1 {name=p72 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1520 -720 3 0 {name=p76 sig_type=std_logic lab=psub}
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
C {lab_pin.sym} 280 -960 3 0 {name=p95 sig_type=std_logic lab=ota_en_n_1}
C {lab_pin.sym} 960 -1080 2 0 {name=p49 sig_type=std_logic lab=di_ota_en}
C {lab_pin.sym} 1880 -1080 2 1 {name=p50 sig_type=std_logic lab=di_ota_en}
C {lab_pin.sym} 960 -910 2 0 {name=p48 sig_type=std_logic lab=ota_en_n_1}
C {lab_pin.sym} 1880 -910 2 1 {name=p51 sig_type=std_logic lab=ota_en_n_1}
C {lab_pin.sym} 310 -980 3 0 {name=p85 sig_type=std_logic lab=nwell1}
C {devices/iopin.sym} 250 -980 1 0 {name=p30 lab=psub}
