v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Inverter with Enable and with LV Transistors} 690 -1700 0 0 1 1 {}
T {Due to the mobility difference between holes and electrons, the size of PMOS is 2-3 times larger than that of NMOS for an inverter.
The sizing, however, depends very much on the application. If we don't care about the output rising time, we could just simply make (W/L)p=(W/L)n.

The following three cases are the most relevant:
1. (W/L)p=(W/L)n
2. (W/L)p=2(W/L)n
3. (W/L)p=3(W/L)n
Compare the propagation delay in these cases.} 240 -1410 0 0 0.5 0.5 {}
N 1180 -880 1180 -850 {
lab=#net1}
N 1180 -670 1180 -640 {
lab=#net2}
N 1180 -760 1180 -730 {
lab=vout}
N 1100 -760 1100 -700 {
lab=vin}
N 1060 -760 1100 -760 {
lab=vin}
N 1100 -820 1100 -760 {
lab=vin}
N 1180 -760 1280 -760 {
lab=vout}
N 1180 -790 1180 -760 {
lab=vout}
N 1180 -980 1180 -940 {lab=VDD}
N 1180 -910 1280 -910 {lab=VDD}
N 1280 -910 1280 -820 {lab=VDD}
N 1180 -820 1280 -820 {lab=VDD}
N 1180 -1020 1180 -980 {lab=VDD}
N 1180 -980 1280 -980 {lab=VDD}
N 1280 -980 1280 -910 {lab=VDD}
N 1180 -700 1280 -700 {lab=VSS}
N 1280 -700 1280 -540 {lab=VSS}
N 1180 -540 1280 -540 {lab=VSS}
N 1180 -580 1180 -540 {lab=VSS}
N 1180 -540 1180 -500 {lab=VSS}
N 1180 -610 1280 -610 {lab=VSS}
N 1280 -760 1320 -760 {lab=vout}
N 1100 -700 1140 -700 {lab=vin}
N 1100 -820 1140 -820 {lab=vin}
N 1060 -910 1140 -910 {lab=di_en}
N 1060 -610 1140 -610 {lab=VDD}
C {devices/ipin.sym} 1060 -760 0 0 {name=p10 lab=vin}
C {devices/iopin.sym} 1180 -1020 3 0 {name=p11 lab=VDD}
C {devices/iopin.sym} 1180 -500 1 0 {name=p1 lab=VSS}
C {devices/opin.sym} 1320 -760 0 0 {name=p2 lab=vout}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 1060 -910 0 0 {name=p3 lab=di_en}
C {lab_pin.sym} 1060 -610 0 0 {name=p18 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 1160 -820 0 0 {name=M2
W=36.0
L=1.0
nf=4
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 1160 -610 0 0 {name=M3
W=6.0
L=1.0
nf=2
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 1160 -910 0 0 {name=M4
W=18.0
L=1.0
nf=2
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 1160 -700 0 0 {name=M1
W=12.0
L=1.0
nf=4
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
