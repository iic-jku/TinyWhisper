v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Coupled Resonator LC Bandpass Filter} 500 -1720 0 0 1.5 1.5 {}
T {Rin = 1k, Rload = 1k:} 90 -1130 0 0 1 1 {}
N 1080 -960 1080 -880 {lab=#net1}
N 1000 -960 1080 -960 {lab=#net1}
N 1080 -820 1080 -740 {lab=VSS}
N 1080 -960 1160 -960 {lab=#net1}
N 1160 -960 1160 -880 {lab=#net1}
N 1160 -820 1160 -740 {lab=VSS}
N 1160 -960 1240 -960 {lab=#net1}
N 1300 -960 1380 -960 {lab=#net2}
N 1380 -960 1380 -880 {lab=#net2}
N 1380 -820 1380 -740 {lab=VSS}
N 1380 -960 1460 -960 {lab=#net2}
N 1460 -960 1460 -880 {lab=#net2}
N 1460 -820 1460 -740 {lab=VSS}
N 1460 -960 1540 -960 {lab=#net2}
N 1080 -740 1160 -740 {lab=VSS}
N 1270 -740 1380 -740 {lab=VSS}
N 1380 -740 1460 -740 {lab=VSS}
N 1270 -740 1270 -660 {lab=VSS}
N 1160 -740 1270 -740 {lab=VSS}
N 860 -960 940 -960 {lab=vin}
N 1600 -960 1680 -960 {lab=vout}
C {devices/ipin.sym} 860 -960 0 0 {name=p8 lab=vin
}
C {devices/opin.sym} 1680 -960 0 0 {name=p7 lab=vout
}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1270 -660 1 0 {name=p2 lab=VSS
}
C {capa.sym} 1160 -850 0 0 {name=C1
m=1
value=13.46p
footprint=1206
device="ceramic capacitor"
}
C {ind.sym} 1080 -850 0 0 {name=L2
m=1
value=2.12u
footprint=1206
device=inductor
}
C {capa.sym} 1270 -960 1 0 {name=C12
m=1
value=385f
footprint=1206
device="ceramic capacitor"
}
C {capa.sym} 1460 -850 0 0 {name=C2
m=1
value=13.46p
footprint=1206
device="ceramic capacitor"
}
C {ind.sym} 1380 -850 0 0 {name=L3
m=1
value=2.12u
footprint=1206
device=inductor
}
C {capa.sym} 970 -960 1 0 {name=C1L
m=1
value=1.4p
footprint=1206
device="ceramic capacitor"
}
C {capa.sym} 1570 -960 1 0 {name=C2L
m=1
value=1.4p
footprint=1206
device="ceramic capacitor"
}
