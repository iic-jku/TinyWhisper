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
di_tg_ctrl = 0, di_tg_ctrl_n = 1: v_a = X, v_b = HIGH-Z} 880 -320 0 0 0.5 0.5 {}
N 1200 -520 1200 -480 {
lab=di_tg_ctrl}
N 1200 -920 1200 -880 {
lab=di_tg_ctrl_n}
N 1230 -840 1240 -840 {
lab=v_b}
N 1240 -840 1240 -780 {
lab=v_b}
N 1380 -780 1500 -780 {
lab=v_b}
N 1300 -840 1310 -840 {
lab=v_b}
N 1300 -840 1300 -780 {
lab=v_b}
N 1240 -780 1300 -780 {
lab=v_b}
N 1370 -840 1380 -840 {
lab=v_b}
N 1380 -840 1380 -780 {
lab=v_b}
N 1300 -780 1380 -780 {
lab=v_b}
N 1340 -920 1340 -880 {
lab=di_tg_ctrl}
N 1160 -840 1170 -840 {
lab=v_a}
N 1160 -840 1160 -780 {
lab=v_a}
N 1160 -560 1170 -560 {
lab=v_a}
N 1160 -620 1160 -560 {
lab=v_a}
N 1300 -560 1310 -560 {
lab=v_b}
N 1300 -620 1300 -560 {
lab=v_b}
N 1240 -620 1300 -620 {
lab=v_b}
N 1240 -620 1240 -560 {
lab=v_b}
N 1230 -560 1240 -560 {
lab=v_b}
N 1380 -620 1500 -620 {
lab=v_b}
N 1340 -520 1340 -480 {
lab=di_tg_ctrl_n}
N 1200 -840 1200 -740 {
lab=VDD}
N 1340 -740 1440 -740 {
lab=VDD}
N 1440 -920 1440 -740 {
lab=VDD}
N 1340 -840 1340 -740 {
lab=VDD}
N 1200 -740 1340 -740 {
lab=VDD}
N 1200 -660 1200 -560 {
lab=VSS}
N 1340 -660 1440 -660 {
lab=VSS}
N 1440 -660 1440 -480 {
lab=VSS}
N 1340 -660 1340 -560 {
lab=VSS}
N 1200 -660 1340 -660 {
lab=VSS}
N 900 -700 900 -620 {
lab=v_a}
N 860 -700 900 -700 {
lab=v_a}
N 900 -780 900 -700 {
lab=v_a}
N 1500 -700 1500 -620 {
lab=v_b}
N 1500 -700 1540 -700 {
lab=v_b}
N 1500 -780 1500 -700 {
lab=v_b}
N 1370 -560 1380 -560 {lab=v_b}
N 1380 -620 1380 -560 {lab=v_b}
N 1300 -620 1380 -620 {
lab=v_b}
N 1020 -840 1030 -840 {
lab=v_a}
N 1020 -840 1020 -780 {
lab=v_a}
N 1090 -840 1100 -840 {
lab=v_a}
N 1100 -840 1100 -780 {
lab=v_a}
N 1020 -780 1100 -780 {
lab=v_a}
N 1060 -920 1060 -880 {
lab=di_tg_ctrl}
N 1100 -780 1160 -780 {lab=v_a}
N 1060 -840 1060 -740 {lab=VDD}
N 1060 -740 1200 -740 {lab=VDD}
N 900 -780 1020 -780 {
lab=v_a}
N 1020 -560 1030 -560 {
lab=v_a}
N 1020 -620 1020 -560 {
lab=v_a}
N 1060 -520 1060 -480 {
lab=di_tg_ctrl_n}
N 1060 -660 1060 -560 {
lab=VSS}
N 1090 -560 1100 -560 {lab=v_a}
N 1100 -620 1100 -560 {lab=v_a}
N 1020 -620 1100 -620 {
lab=v_a}
N 1100 -620 1160 -620 {lab=v_a}
N 1060 -660 1200 -660 {lab=VSS}
N 900 -620 1020 -620 {lab=v_a}
C {devices/title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 860 -700 0 1 {name=p2 lab=v_a}
C {devices/iopin.sym} 1540 -700 0 0 {name=p4 lab=v_b}
C {devices/lab_pin.sym} 1340 -920 1 0 {name=p12 sig_type=std_logic lab=di_tg_ctrl}
C {devices/lab_pin.sym} 1340 -480 3 0 {name=p13 sig_type=std_logic lab=di_tg_ctrl_n}
C {devices/iopin.sym} 1440 -920 3 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 1440 -480 1 0 {name=p7 lab=VSS}
C {devices/ipin.sym} 1200 -480 3 0 {name=p8 lab=di_tg_ctrl}
C {devices/ipin.sym} 1200 -920 1 0 {name=p9 lab=di_tg_ctrl_n}
C {sky130_fd_pr/pfet_01v8.sym} 1200 -860 1 0 {name=M2
W=57.0
L=0.15
nf=19
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
C {sky130_fd_pr/pfet_01v8.sym} 1340 -860 1 0 {name=Mdummy4
W=12.0
L=0.15
nf=4
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
C {sky130_fd_pr/nfet_01v8.sym} 1200 -540 3 0 {name=M1
W=19.0
L=0.15
nf=19
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
C {sky130_fd_pr/nfet_01v8.sym} 1340 -540 3 0 {name=Mdummy2
W=4.0
L=0.15
nf=4
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
C {devices/lab_pin.sym} 1060 -920 1 0 {name=p1 sig_type=std_logic lab=di_tg_ctrl}
C {sky130_fd_pr/pfet_01v8.sym} 1060 -860 1 0 {name=Mdummy3
W=12.0
L=0.15
nf=4
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
C {devices/lab_pin.sym} 1060 -480 3 0 {name=p5 sig_type=std_logic lab=di_tg_ctrl_n}
C {sky130_fd_pr/nfet_01v8.sym} 1060 -540 3 0 {name=Mdummy1
W=4.0
L=0.15
nf=4
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
