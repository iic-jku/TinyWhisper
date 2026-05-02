v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Parameterizable Transmission Gate with Dummies} 580 -1690 0 0 1 1 {}
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
di_tg_ctrl = 0, di_tg_ctrl_n = 1: v_a = X, v_b = HIGH-Z} 830 -300 0 0 0.5 0.5 {}
N 1180 -500 1180 -460 {
lab=di_tg_ctrl}
N 1180 -900 1180 -860 {
lab=di_tg_ctrl_n}
N 1210 -820 1220 -820 {
lab=v_b}
N 1220 -820 1220 -760 {
lab=v_b}
N 1360 -760 1480 -760 {
lab=v_b}
N 1280 -820 1290 -820 {
lab=v_b}
N 1280 -820 1280 -760 {
lab=v_b}
N 1220 -760 1280 -760 {
lab=v_b}
N 1350 -820 1360 -820 {
lab=v_b}
N 1360 -820 1360 -760 {
lab=v_b}
N 1280 -760 1360 -760 {
lab=v_b}
N 1320 -900 1320 -860 {
lab=di_tg_ctrl}
N 1140 -820 1150 -820 {
lab=v_a}
N 1140 -820 1140 -760 {
lab=v_a}
N 1140 -540 1150 -540 {
lab=v_a}
N 1140 -600 1140 -540 {
lab=v_a}
N 1280 -540 1290 -540 {
lab=v_b}
N 1280 -600 1280 -540 {
lab=v_b}
N 1220 -600 1280 -600 {
lab=v_b}
N 1220 -600 1220 -540 {
lab=v_b}
N 1210 -540 1220 -540 {
lab=v_b}
N 1360 -600 1480 -600 {
lab=v_b}
N 1320 -500 1320 -460 {
lab=di_tg_ctrl_n}
N 1180 -820 1180 -720 {
lab=VDD}
N 1320 -720 1420 -720 {
lab=VDD}
N 1420 -900 1420 -720 {
lab=VDD}
N 1320 -820 1320 -720 {
lab=VDD}
N 1180 -720 1320 -720 {
lab=VDD}
N 1180 -640 1180 -540 {
lab=VSS}
N 1320 -640 1420 -640 {
lab=VSS}
N 1420 -640 1420 -460 {
lab=VSS}
N 1320 -640 1320 -540 {
lab=VSS}
N 1180 -640 1320 -640 {
lab=VSS}
N 880 -680 880 -600 {
lab=v_a}
N 840 -680 880 -680 {
lab=v_a}
N 880 -760 880 -680 {
lab=v_a}
N 1480 -680 1480 -600 {
lab=v_b}
N 1480 -680 1520 -680 {
lab=v_b}
N 1480 -760 1480 -680 {
lab=v_b}
N 1350 -540 1360 -540 {lab=v_b}
N 1360 -600 1360 -540 {lab=v_b}
N 1280 -600 1360 -600 {
lab=v_b}
N 1000 -820 1010 -820 {
lab=v_a}
N 1000 -820 1000 -760 {
lab=v_a}
N 1070 -820 1080 -820 {
lab=v_a}
N 1080 -820 1080 -760 {
lab=v_a}
N 1000 -760 1080 -760 {
lab=v_a}
N 1040 -900 1040 -860 {
lab=di_tg_ctrl}
N 1040 -820 1040 -720 {
lab=VDD}
N 1080 -760 1140 -760 {lab=v_a}
N 1040 -720 1180 -720 {lab=VDD}
N 880 -760 1000 -760 {
lab=v_a}
N 1000 -540 1010 -540 {
lab=v_a}
N 1000 -600 1000 -540 {
lab=v_a}
N 1040 -500 1040 -460 {
lab=di_tg_ctrl_n}
N 1040 -640 1040 -540 {
lab=VSS}
N 1070 -540 1080 -540 {lab=v_a}
N 1080 -600 1080 -540 {lab=v_a}
N 1000 -600 1080 -600 {
lab=v_a}
N 1080 -600 1140 -600 {lab=v_a}
N 880 -600 1000 -600 {lab=v_a}
N 1040 -640 1180 -640 {lab=VSS}
C {devices/title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 840 -680 0 1 {name=p2 lab=v_a}
C {devices/iopin.sym} 1520 -680 0 0 {name=p4 lab=v_b}
C {devices/lab_pin.sym} 1320 -900 1 0 {name=p12 sig_type=std_logic lab=di_tg_ctrl}
C {devices/lab_pin.sym} 1320 -460 3 0 {name=p13 sig_type=std_logic lab=di_tg_ctrl_n}
C {devices/iopin.sym} 1420 -900 3 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 1420 -460 1 0 {name=p7 lab=VSS}
C {devices/ipin.sym} 1180 -460 3 0 {name=p8 lab=di_tg_ctrl}
C {devices/ipin.sym} 1180 -900 1 0 {name=p9 lab=di_tg_ctrl_n}
C {sky130_fd_pr/pfet_01v8.sym} 1180 -840 1 0 {name=M2
W=W_P
L=L_P
nf=NF_P
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 1320 -840 1 0 {name=Mdummy4
W=\{W_P_D+3\}
L=L_P_D
nf=\{NF_P_D+1\}
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 1180 -520 3 0 {name=M1
W=W_N
L=L_N
nf=NF_N
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 1320 -520 3 0 {name=Mdummy2
W=\{W_N_D+1\}
L=L_N_D
nf=\{NF_N_D+1\}
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 1040 -900 1 0 {name=p1 sig_type=std_logic lab=di_tg_ctrl}
C {sky130_fd_pr/pfet_01v8.sym} 1040 -840 1 0 {name=Mdummy3
W=W_P_D
L=L_P_D
nf=NF_P_D
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 1040 -460 3 0 {name=p5 sig_type=std_logic lab=di_tg_ctrl_n}
C {sky130_fd_pr/nfet_01v8.sym} 1040 -520 3 0 {name=Mdummy1
W=W_N_D
L=L_N_D
nf=NF_N_D
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
