v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Transmission Gate with Dummies} 820 -1710 0 0 1 1 {}
T {-) In most cases, equal W/L ratios for both p- and n-MOSFETs are used.

-) For transmission gates, the sizing of PMOS could be the same as NMOS because large PMOS increases its 
parasitic capacitance at the drain and the source. Thus, the speed is decreased in turn when (W/L)p=3(W/L)n.

-) If W is increased, the on-resistance decreases and vice versa.
 
-) If L is increased, the drain-source leakage current decreases but the TG gets slower and vice versa.

-) Furthermore, larger switches have more charge in the inversion layer, which leads to increased charge injection when the switches are turned off. 
Larger switches also increase the drain-source overlap capacitance, which leads to increased clock feedthrough.
Accordingly, larger switches are not always the solution. Alternatively, one can use bootstrapped switches [Wulff].

-) To compensate charge injection and clock feedthrough dummy MOSFETs with half W can be used [Baker].

-) If available, minimum-sized thick-oxide MOSFETs decrease leakage currents and charge injection simultaneously [Fath].} 300 -1560 0 0 0.5 0.5 {}
T {di_tg_ctrl = 1, di_tg_ctrl_n = 0: v_a connected to v_b
di_tg_ctrl = 0, di_tg_ctrl_n = 1: v_a = X, v_b = HIGH-Z} 880 -320 0 0 0.5 0.5 {}
N 1160 -520 1160 -480 {
lab=di_tg_ctrl}
N 1160 -920 1160 -880 {
lab=di_tg_ctrl_n}
N 1190 -840 1200 -840 {
lab=v_b}
N 1200 -840 1200 -780 {
lab=v_b}
N 1260 -840 1270 -840 {
lab=v_b}
N 1260 -840 1260 -780 {
lab=v_b}
N 1200 -780 1260 -780 {
lab=v_b}
N 1330 -840 1340 -840 {
lab=v_b}
N 1340 -840 1340 -780 {
lab=v_b}
N 1260 -780 1340 -780 {
lab=v_b}
N 1300 -920 1300 -880 {
lab=di_tg_ctrl}
N 1120 -840 1130 -840 {
lab=v_a}
N 1120 -840 1120 -780 {
lab=v_a}
N 1000 -780 1120 -780 {
lab=v_a}
N 1120 -560 1130 -560 {
lab=v_a}
N 1120 -620 1120 -560 {
lab=v_a}
N 1000 -620 1120 -620 {
lab=v_a}
N 1260 -560 1270 -560 {
lab=v_b}
N 1260 -620 1260 -560 {
lab=v_b}
N 1200 -620 1260 -620 {
lab=v_b}
N 1200 -620 1200 -560 {
lab=v_b}
N 1190 -560 1200 -560 {
lab=v_b}
N 1300 -520 1300 -480 {
lab=di_tg_ctrl_n}
N 1160 -840 1160 -740 {
lab=nwell}
N 1300 -740 1400 -740 {
lab=nwell}
N 1300 -840 1300 -740 {
lab=nwell}
N 1160 -740 1300 -740 {
lab=nwell}
N 1160 -660 1160 -560 {
lab=psub}
N 1300 -660 1400 -660 {
lab=psub}
N 1300 -660 1300 -560 {
lab=psub}
N 1160 -660 1300 -660 {
lab=psub}
N 1000 -700 1000 -620 {
lab=v_a}
N 960 -700 1000 -700 {
lab=v_a}
N 1000 -780 1000 -700 {
lab=v_a}
N 1330 -560 1340 -560 {lab=v_b}
N 1340 -620 1340 -560 {lab=v_b}
N 1260 -620 1340 -620 {
lab=v_b}
N 1400 -840 1400 -740 {lab=nwell}
N 1400 -920 1400 -900 {lab=VDD}
N 1400 -660 1400 -560 {lab=psub}
N 1400 -500 1400 -480 {lab=VSS}
N 1340 -780 1520 -780 {lab=v_b}
N 1340 -620 1520 -620 {lab=v_b}
N 1520 -700 1520 -620 {lab=v_b}
N 1520 -700 1560 -700 {lab=v_b}
N 1520 -780 1520 -700 {lab=v_b}
N 1400 -740 1420 -740 {lab=nwell}
N 1400 -660 1420 -660 {lab=psub}
C {devices/title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 960 -700 0 1 {name=p2 lab=v_a}
C {devices/iopin.sym} 1560 -700 0 0 {name=p4 lab=v_b}
C {sg13g2_pr/sg13_lv_nmos.sym} 1160 -540 3 0 {name=M1
l=0.13u
w=108.0u
ng=36
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1160 -860 1 0 {name=M2
l=0.13u
w=324.0u
ng=36
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1300 -860 1 0 {name=Mdummy2
l=0.13u
w=162.0u
ng=18
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1300 -540 3 0 {name=Mdummy1
l=0.13u
w=54.0u
ng=18
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/lab_pin.sym} 1300 -920 1 0 {name=p12 sig_type=std_logic lab=di_tg_ctrl}
C {devices/lab_pin.sym} 1300 -480 3 0 {name=p13 sig_type=std_logic lab=di_tg_ctrl_n}
C {devices/ipin.sym} 1160 -480 3 0 {name=p8 lab=di_tg_ctrl}
C {devices/ipin.sym} 1160 -920 1 0 {name=p9 lab=di_tg_ctrl_n}
C {devices/iopin.sym} 1400 -920 3 0 {name=p3 lab=VDD}
C {sg13g2_pr/ntap1_ring.sym} 1400 -870 0 0 {name=R1
model=ntap1
spiceprefix=X
w=29.86e-6
l=11.02e-6
rw=0.3e-6
lvs_ignore=short}
C {devices/iopin.sym} 1400 -480 1 0 {name=p7 lab=VSS}
C {sg13g2_pr/ptap1_ring.sym} 1400 -530 2 1 {name=R2
model=ptap1
spiceprefix=X
w=29.86e-6
l=5.38e-6
rw=0.3e-6
lvs_ignore=short}
C {devices/iopin.sym} 1420 -740 0 0 {name=p1 lab=nwell}
C {devices/iopin.sym} 1420 -660 0 0 {name=p5 lab=psub}
