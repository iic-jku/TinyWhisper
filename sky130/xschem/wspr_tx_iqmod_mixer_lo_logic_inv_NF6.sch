v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Inverter with Standard Vth Transistors} 690 -1700 0 0 1 1 {}
T {Due to the mobility difference between holes and electrons, the size of PMOS is 2-3 times larger than that of NMOS for an inverter.
The sizing, however, depends very much on the application. If we don't care about the output rising time, we could just simply make (W/L)p=(W/L)n.

The following three cases are the most relevant:
1. (W/L)p=(W/L)n
2. (W/L)p=2(W/L)n
3. (W/L)p=3(W/L)n
Compare the propagation delay in these cases.} 240 -1410 0 0 0.5 0.5 {}
N 1200 -700 1200 -670 {
lab=vout}
N 1120 -700 1120 -640 {
lab=vin}
N 1080 -700 1120 -700 {
lab=vin}
N 1120 -760 1120 -700 {
lab=vin}
N 1200 -700 1300 -700 {
lab=vout}
N 1200 -730 1200 -700 {
lab=vout}
N 1200 -950 1200 -910 {lab=VDD}
N 1200 -880 1300 -880 {lab=VDD}
N 1200 -760 1300 -760 {lab=VDD}
N 1200 -990 1200 -950 {lab=VDD}
N 1200 -950 1300 -950 {lab=VDD}
N 1300 -950 1300 -880 {lab=VDD}
N 1200 -640 1300 -640 {lab=VSS}
N 1200 -450 1300 -450 {lab=VSS}
N 1200 -490 1200 -450 {lab=VSS}
N 1200 -450 1200 -410 {lab=VSS}
N 1200 -520 1300 -520 {lab=VSS}
N 1300 -700 1340 -700 {lab=vout}
N 1120 -640 1160 -640 {lab=vin}
N 1120 -760 1160 -760 {lab=vin}
N 1080 -520 1160 -520 {lab=VSS}
N 1200 -850 1200 -790 {lab=VDD}
N 1200 -820 1300 -820 {lab=VDD}
N 1300 -880 1300 -820 {lab=VDD}
N 1300 -820 1300 -760 {lab=VDD}
N 1080 -880 1160 -880 {lab=VDD}
N 1080 -990 1080 -880 {lab=VDD}
N 1200 -610 1200 -550 {lab=VSS}
N 1200 -580 1300 -580 {lab=VSS}
N 1300 -640 1300 -580 {lab=VSS}
N 1300 -580 1300 -520 {lab=VSS}
N 1300 -520 1300 -450 {lab=VSS}
N 1080 -520 1080 -410 {lab=VSS}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 1080 -700 0 0 {name=p3 lab=vin}
C {devices/iopin.sym} 1200 -990 3 0 {name=p4 lab=VDD}
C {devices/iopin.sym} 1200 -410 1 0 {name=p5 lab=VSS}
C {devices/opin.sym} 1340 -700 0 0 {name=p6 lab=vout}
C {lab_pin.sym} 1080 -410 3 0 {name=p18 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1080 -990 1 0 {name=p7 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/pfet_01v8.sym} 1180 -760 0 0 {name=M1
W=18.0
L=0.15
nf=6
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
C {sky130_fd_pr/pfet_01v8.sym} 1180 -880 0 0 {name=M3
W=6.0
L=0.15
nf=2
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
C {sky130_fd_pr/nfet_01v8.sym} 1180 -640 0 0 {name=M2
W=6.0
L=0.15
nf=6
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
C {sky130_fd_pr/nfet_01v8.sym} 1180 -520 0 0 {name=M4
W=2.0
L=0.15
nf=2
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
