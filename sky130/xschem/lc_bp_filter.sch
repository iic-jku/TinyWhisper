v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Third Order LC Bandpass Filter} 640 -1720 0 0 1.5 1.5 {}
T {Features of the third-order LC BP filter:
-) The filter is designed with the software Elsie.
-) The center frequency is set to fc = 9.9MHz
-) The bandwidth equals B = 10kHz.
-) The filter characteristic is Butterworth.} 960 -1300 2 0 0.6 0.6 {}
N 1020 -980 1020 -900 {lab=vin}
N 940 -980 1020 -980 {lab=vin}
N 1020 -840 1020 -760 {lab=VSS}
N 1020 -980 1100 -980 {lab=vin}
N 1100 -980 1100 -900 {lab=vin}
N 1100 -840 1100 -760 {lab=VSS}
N 1100 -980 1180 -980 {lab=vin}
N 1240 -980 1320 -980 {lab=vout}
N 1320 -980 1320 -900 {lab=vout}
N 1320 -840 1320 -760 {lab=VSS}
N 1320 -980 1400 -980 {lab=vout}
N 1400 -980 1400 -900 {lab=vout}
N 1400 -840 1400 -760 {lab=VSS}
N 1400 -980 1480 -980 {lab=vout}
N 1020 -760 1100 -760 {lab=VSS}
N 1100 -760 1320 -760 {lab=VSS}
N 1320 -760 1400 -760 {lab=VSS}
N 1210 -760 1210 -680 {lab=VSS}
C {devices/ipin.sym} 940 -980 0 0 {name=p8 lab=vin}
C {devices/opin.sym} 1480 -980 0 0 {name=p7 lab=vout}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1210 -680 1 0 {name=p2 lab=VSS}
C {capa.sym} 1100 -870 0 0 {name=C2
m=1
value=2.23n
footprint=1206
device="ceramic capacitor"}
C {ind.sym} 1020 -870 0 0 {name=L2
m=1
value=114.83n
footprint=1206
device=inductor}
C {capa.sym} 1210 -980 1 0 {name=C1
m=1
value=16.07p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1400 -870 0 0 {name=C3
m=1
value=2.23n
footprint=1206
device="ceramic capacitor"}
C {ind.sym} 1320 -870 0 0 {name=L3
m=1
value=114.83n
footprint=1206
device=inductor}
