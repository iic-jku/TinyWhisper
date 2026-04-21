v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 1420 -980 {}
P 4 5 100 -380 940 -380 940 -1040 100 -1040 100 -380 {dash = 8
lock = true}
P 4 5 960 -380 1440 -380 1440 -1040 960 -1040 960 -380 {dash = 8
lock = true}
P 4 5 1460 -380 2380 -380 2380 -1040 1460 -1040 1460 -380 {dash = 8
lock = true}
T {Single-Ended to Differential Converter} 720 -1690 0 0 1 1 {}
T {Tapered Buffer} 1460 -370 0 0 0.4 0.4 {}
T {Cross-Coupling of Edges} 960 -370 0 0 0.4 0.4 {}
T {Features of the single-ended to differential converter:
-) First, vin is buffered and inverted. The TG provides roughly the same propagation delay as one inverter.
-) Second, the edges of the buffered and inverted signals are locked with a cross-coupled weaker inverter pair.
-) Finally, the drive strength for the mixer transmission gate is guaranteed by a tapered buffer chain of factor 3.
More information on tapered buffers: https://ieeexplore.ieee.org/document/10645490 or https://cse14-iiith.vlabs.ac.in/exp/chain-of-inverters/theory.html
More information on single-ended to differential converters: https://ieeexplore.ieee.org/document/11044975} 2190 -1300 2 0 0.5 0.5 {}
T {Buffering Input} 100 -370 0 0 0.4 0.4 {}
N 330 -850 330 -830 {lab=VDD}
N 330 -750 330 -730 {lab=VSS}
N 840 -480 840 -460 {lab=VDD}
N 840 -580 840 -560 {lab=VSS}
N 1120 -720 1140 -720 {lab=VDD}
N 1020 -720 1040 -720 {lab=VSS}
N 1260 -700 1280 -700 {lab=VDD}
N 1360 -700 1380 -700 {lab=VSS}
N 1540 -480 1540 -460 {lab=VDD}
N 1540 -580 1540 -560 {lab=VSS}
N 1540 -960 1540 -940 {lab=VDD}
N 1540 -860 1540 -840 {lab=VSS}
N 1840 -960 1840 -940 {lab=VDD}
N 1840 -860 1840 -840 {lab=VSS}
N 1840 -480 1840 -460 {lab=VDD}
N 1840 -580 1840 -560 {lab=VSS}
N 840 -960 840 -940 {lab=VDD}
N 840 -860 840 -840 {lab=VSS}
N 520 -900 560 -900 {lab=vse}
N 1320 -900 1480 -900 {lab=vcrossp}
N 1080 -900 1080 -780 {lab=vcrossp}
N 1320 -900 1320 -780 {lab=vcrossp}
N 1320 -520 1480 -520 {lab=vcrossn}
N 1320 -640 1320 -520 {lab=vcrossn}
N 1080 -640 1080 -520 {lab=vcrossn}
N 620 -480 620 -460 {lab=VDD}
N 620 -460 640 -460 {lab=VDD}
N 640 -480 640 -460 {lab=VDD}
N 620 -580 620 -560 {lab=VSS}
N 640 -580 640 -560 {lab=VSS}
N 620 -580 640 -580 {lab=VSS}
N 520 -520 560 -520 {lab=vse}
N 1080 -900 1320 -900 {lab=vcrossp}
N 1080 -520 1320 -520 {lab=vcrossn}
N 1620 -900 1780 -900 {lab=vscale1n}
N 1620 -520 1780 -520 {lab=vscale1p}
N 620 -960 620 -940 {lab=VDD}
N 620 -860 620 -840 {lab=VSS}
N 1920 -520 2080 -520 {lab=vscale2n}
N 1920 -900 2080 -900 {lab=vscale2p}
N 2140 -960 2140 -940 {lab=VDD}
N 2140 -860 2140 -840 {lab=VSS}
N 2140 -480 2140 -460 {lab=VDD}
N 2140 -580 2140 -560 {lab=VSS}
N 920 -900 1080 -900 {lab=vcrossp}
N 920 -520 1080 -520 {lab=vcrossn}
N 700 -900 780 -900 {lab=#net1}
N 2220 -900 2400 -900 {lab=voutp}
N 2220 -520 2400 -520 {lab=voutn}
N 250 -670 250 -650 {lab=VSS}
N 250 -570 250 -550 {lab=VDD}
N 520 -710 520 -520 {lab=vse}
N 720 -520 780 -520 {lab=#net2}
N 130 -610 190 -610 {lab=vin}
N 330 -610 390 -610 {lab=vse}
N 130 -610 170 -710 {lab=vin}
N 170 -710 200 -790 {lab=vin}
N 200 -790 270 -790 {lab=vin}
N 390 -610 430 -710 {lab=vse}
N 430 -710 460 -790 {lab=vse}
N 410 -790 460 -790 {lab=vse}
N 80 -710 170 -710 {lab=vin}
N 430 -710 520 -710 {lab=vse}
N 520 -900 520 -710 {lab=vse}
N 660 -550 660 -540 {lab=psub}
N 860 -580 860 -540 {lab=psub}
N 1340 -720 1380 -720 {lab=psub}
N 1020 -700 1060 -700 {lab=psub}
N 640 -880 640 -840 {lab=psub}
N 1560 -580 1560 -540 {lab=psub}
N 1860 -580 1860 -540 {lab=psub}
N 2160 -580 2160 -540 {lab=psub}
N 860 -880 860 -840 {lab=psub}
N 1560 -880 1560 -840 {lab=psub}
N 1860 -880 1860 -840 {lab=psub}
N 2160 -880 2160 -840 {lab=psub}
N 350 -770 350 -730 {lab=psub}
N 270 -670 270 -630 {lab=psub}
N 350 -850 350 -810 {lab=nwell1}
N 640 -960 640 -920 {lab=nwell1}
N 860 -960 860 -920 {lab=nwell1}
N 1560 -960 1560 -920 {lab=nwell1}
N 1860 -960 1860 -920 {lab=nwell1}
N 2160 -960 2160 -920 {lab=nwell1}
N 1100 -700 1140 -700 {lab=nwell1}
N 860 -500 860 -460 {lab=nwell2}
N 270 -590 270 -550 {lab=nwell2}
N 1560 -500 1560 -460 {lab=nwell2}
N 1860 -500 1860 -460 {lab=nwell2}
N 2160 -500 2160 -460 {lab=nwell2}
N 660 -500 660 -490 {lab=nwell2}
N 1260 -720 1300 -720 {lab=nwell2}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 80 -710 0 0 {name=p3 lab=vin}
C {lab_pin.sym} 840 -460 1 1 {name=p14 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 840 -580 3 1 {name=p17 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1020 -720 0 0 {name=p21 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1140 -720 2 0 {name=p22 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1260 -700 0 0 {name=p23 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1380 -700 2 0 {name=p24 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1540 -960 1 0 {name=p25 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1540 -840 3 0 {name=p27 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1540 -580 3 1 {name=p28 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1540 -460 1 1 {name=p29 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1840 -960 1 0 {name=p30 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1840 -840 3 0 {name=p31 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1840 -460 1 1 {name=p34 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1840 -580 3 1 {name=p36 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 330 -850 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 330 -730 1 0 {name=p2 lab=VSS}
C {devices/opin.sym} 2400 -900 0 0 {name=p7 lab=voutp}
C {devices/opin.sym} 2400 -520 0 0 {name=p4 lab=voutn}
C {lab_pin.sym} 840 -960 1 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 840 -840 3 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1200 -900 2 1 {name=p8 sig_type=std_logic lab=vcrossp}
C {lab_wire.sym} 1200 -520 0 0 {name=p9 sig_type=std_logic lab=vcrossn}
C {lab_wire.sym} 1700 -900 2 1 {name=p10 sig_type=std_logic lab=vscale1n}
C {lab_wire.sym} 1700 -520 2 1 {name=p11 sig_type=std_logic lab=vscale1p}
C {lab_pin.sym} 620 -460 1 1 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 620 -580 3 1 {name=p13 sig_type=std_logic lab=VSS}
C {iqmod_mixer_se2diff_tg_NF6.sym} 640 -520 2 1 {name=x3}
C {iqmod_mixer_se2diff_inv_NF18.sym} 1840 -900 0 0 {name=x8}
C {iqmod_mixer_se2diff_inv_NF2.sym} 1080 -720 1 0 {name=x5}
C {iqmod_mixer_se2diff_inv_NF2.sym} 1320 -700 3 0 {name=x6}
C {iqmod_mixer_se2diff_inv_NF6.sym} 840 -900 0 0 {name=x2}
C {iqmod_mixer_se2diff_inv_NF6.sym} 840 -520 2 1 {name=x4}
C {lab_pin.sym} 620 -960 1 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 620 -840 3 0 {name=p16 sig_type=std_logic lab=VSS}
C {iqmod_mixer_se2diff_inv_NF6.sym} 1540 -900 0 0 {name=x7}
C {iqmod_mixer_se2diff_inv_NF6.sym} 620 -900 0 0 {name=x1}
C {lab_wire.sym} 2000 -900 2 1 {name=p18 sig_type=std_logic lab=vscale2p}
C {lab_wire.sym} 2000 -520 2 1 {name=p19 sig_type=std_logic lab=vscale2n}
C {iqmod_mixer_se2diff_inv_NF54.sym} 2140 -900 0 0 {name=x9}
C {iqmod_mixer_se2diff_inv_NF6.sym} 1540 -520 2 1 {name=x10}
C {iqmod_mixer_se2diff_inv_NF18.sym} 1840 -520 2 1 {name=x11}
C {iqmod_mixer_se2diff_inv_NF54.sym} 2140 -520 2 1 {name=x12}
C {iqmod_mixer_se2diff_inv_NF2.sym} 250 -610 2 1 {name=x13}
C {lab_pin.sym} 2140 -960 1 0 {name=p20 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2140 -840 3 0 {name=p26 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 2140 -460 1 1 {name=p32 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2140 -580 3 1 {name=p33 sig_type=std_logic lab=VSS}
C {iqmod_mixer_se2diff_inv_NF2.sym} 330 -790 0 0 {name=x14}
C {lab_wire.sym} 520 -710 2 0 {name=p38 sig_type=std_logic lab=vse}
C {lab_pin.sym} 250 -550 1 1 {name=p41 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 250 -670 3 1 {name=p42 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 660 -550 0 1 {name=p37 sig_type=std_logic lab=psub}
C {lab_pin.sym} 860 -580 3 1 {name=p35 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1380 -720 2 0 {name=p39 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1020 -700 0 0 {name=p40 sig_type=std_logic lab=psub}
C {lab_pin.sym} 640 -840 3 0 {name=p43 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1560 -580 3 1 {name=p44 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1860 -580 3 1 {name=p45 sig_type=std_logic lab=psub}
C {lab_pin.sym} 2160 -580 3 1 {name=p46 sig_type=std_logic lab=psub}
C {lab_pin.sym} 860 -840 3 0 {name=p47 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1560 -840 3 0 {name=p48 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1860 -840 3 0 {name=p49 sig_type=std_logic lab=psub}
C {lab_pin.sym} 2160 -840 3 0 {name=p50 sig_type=std_logic lab=psub}
C {lab_pin.sym} 270 -670 3 1 {name=p52 sig_type=std_logic lab=psub}
C {lab_pin.sym} 640 -960 3 1 {name=p54 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 860 -960 3 1 {name=p55 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 1560 -960 3 1 {name=p56 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 1860 -960 3 1 {name=p57 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 2160 -960 3 1 {name=p58 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 1140 -700 0 1 {name=p59 sig_type=std_logic lab=nwell1}
C {lab_pin.sym} 860 -460 1 1 {name=p61 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1560 -460 1 1 {name=p62 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1860 -460 1 1 {name=p63 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 2160 -460 1 1 {name=p64 sig_type=std_logic lab=nwell2}
C {lab_wire.sym} 660 -490 2 0 {name=p66 sig_type=std_logic lab=nwell2}
C {lab_pin.sym} 1260 -720 2 1 {name=p65 sig_type=std_logic lab=nwell2}
C {devices/iopin.sym} 350 -850 3 0 {name=p67 lab=nwell1}
C {devices/iopin.sym} 350 -730 1 0 {name=p68 lab=psub}
C {devices/iopin.sym} 270 -550 3 1 {name=p60 lab=nwell2}
