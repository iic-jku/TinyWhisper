v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Coupled Resonator LC Bandpass Filter} 500 -1720 0 0 1.5 1.5 {}
T {Rin = 1k, Rload = 50R:} 80 -1210 0 0 1 1 {}
N 1080 -1060 1080 -980 {lab=#net1}
N 1000 -1060 1080 -1060 {lab=#net1}
N 1080 -920 1080 -840 {lab=VSS}
N 1080 -1060 1160 -1060 {lab=#net1}
N 1160 -1060 1160 -980 {lab=#net1}
N 1160 -920 1160 -840 {lab=VSS}
N 1160 -1060 1240 -1060 {lab=#net1}
N 1300 -1060 1380 -1060 {lab=#net2}
N 1380 -1060 1380 -980 {lab=#net2}
N 1380 -920 1380 -840 {lab=VSS}
N 1380 -1060 1460 -1060 {lab=#net2}
N 1460 -1060 1460 -980 {lab=#net2}
N 1460 -920 1460 -840 {lab=VSS}
N 1460 -1060 1540 -1060 {lab=#net2}
N 1080 -840 1160 -840 {lab=VSS}
N 1270 -840 1380 -840 {lab=VSS}
N 1380 -840 1460 -840 {lab=VSS}
N 1270 -840 1270 -760 {lab=VSS}
N 1160 -840 1270 -840 {lab=VSS}
N 860 -1060 940 -1060 {lab=vin}
N 1600 -1060 1680 -1060 {lab=vout}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 860 -1060 0 0 {name=p1 lab=vin
}
C {devices/opin.sym} 1680 -1060 0 0 {name=p3 lab=vout
}
C {devices/iopin.sym} 1270 -760 1 0 {name=p4 lab=VSS
}
C {capa.sym} 1160 -950 0 0 {name=C3
m=1
value=13.46p
footprint=1206
device="ceramic capacitor"
}
C {ind.sym} 1080 -950 0 0 {name=L4
m=1
value=2.12u
footprint=1206
device=inductor
}
C {capa.sym} 1270 -1060 1 0 {name=C4
m=1
value=385f
footprint=1206
device="ceramic capacitor"
}
C {capa.sym} 1460 -950 0 0 {name=C5
m=1
value=8.86p
footprint=1206
device="ceramic capacitor"
}
C {ind.sym} 1380 -950 0 0 {name=L5
m=1
value=2.12u
footprint=1206
device=inductor
}
C {capa.sym} 970 -1060 1 0 {name=C6
m=1
value=1.4p
footprint=1206
device="ceramic capacitor"
}
C {capa.sym} 1570 -1060 1 0 {name=C7
m=1
value=6.0p
footprint=1206
device="ceramic capacitor"
}
