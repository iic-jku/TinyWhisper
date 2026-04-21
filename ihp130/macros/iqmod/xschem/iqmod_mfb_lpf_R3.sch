v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Resistor with Multiple Series Sections} 740 -1720 0 0 1 1 {}
N 1000 -1160 1020 -1160 {lab=VSS}
N 1080 -1160 1100 -1160 {lab=VSS}
N 1360 -1160 1380 -1160 {lab=VSS}
N 1440 -1160 1460 -1160 {lab=VSS}
N 1200 -700 1200 -680 {lab=psub}
N 1200 -700 1260 -700 {lab=psub}
N 1260 -700 1260 -680 {lab=psub}
N 1260 -620 1260 -600 {lab=VSS}
N 1000 -880 1040 -880 {lab=v_a}
N 1100 -880 1200 -880 {lab=#net1}
N 1260 -880 1360 -880 {lab=#net2}
N 1420 -880 1460 -880 {lab=v_b}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1000 -880 0 1 {name=p2 lab=v_a
}
C {devices/iopin.sym} 1460 -880 0 0 {name=p4 lab=v_b
}
C {sg13g2_pr/rhigh.sym} 1070 -880 3 0 {name=R1
w=0.5e-6
l=59.0e-6
model=rhigh
body=psub
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 1.6e-4 / @w + 1360.0 * ( (@b + 1)* @l + ( 1.081*( @w - 0.04e-6 ) + 0.18e-6 )*@b ) / ( @w - 0.04e-6 ) ) / @m  )"
}
C {sg13g2_pr/rhigh.sym} 1230 -880 3 0 {name=R2
w=0.5e-6
l=59.0e-6
model=rhigh
body=psub
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 1.6e-4 / @w + 1360.0 * ( (@b + 1)* @l + ( 1.081*( @w - 0.04e-6 ) + 0.18e-6 )*@b ) / ( @w - 0.04e-6 ) ) / @m  )"
}
C {sg13g2_pr/rhigh.sym} 1390 -880 3 0 {name=R3
w=0.5e-6
l=59.0e-6
model=rhigh
body=psub
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 1.6e-4 / @w + 1360.0 * ( (@b + 1)* @l + ( 1.081*( @w - 0.04e-6 ) + 0.18e-6 )*@b ) / ( @w - 0.04e-6 ) ) / @m  )"
}
C {devices/iopin.sym} 1260 -600 1 0 {name=p24 lab=VSS
}
C {sg13g2_pr/rhigh.sym} 1050 -1160 3 0 {name=Rdummy1
w=0.5e-6
l=59.0e-6
model=rhigh
body=psub
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 1.6e-4 / @w + 1360.0 * ( (@b + 1)* @l + ( 1.081*( @w - 0.04e-6 ) + 0.18e-6 )*@b ) / ( @w - 0.04e-6 ) ) / @m  )"
}
C {lab_pin.sym} 1000 -1160 2 1 {name=p11 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 1100 -1160 2 0 {name=p1 sig_type=std_logic lab=VSS
}
C {sg13g2_pr/rhigh.sym} 1410 -1160 3 0 {name=Rdummy2
w=0.5e-6
l=59.0e-6
model=rhigh
body=psub
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 1.6e-4 / @w + 1360.0 * ( (@b + 1)* @l + ( 1.081*( @w - 0.04e-6 ) + 0.18e-6 )*@b ) / ( @w - 0.04e-6 ) ) / @m  )"
}
C {lab_pin.sym} 1360 -1160 2 1 {name=p3 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} 1460 -1160 2 0 {name=p5 sig_type=std_logic lab=VSS
}
C {sg13g2_pr/ptap1_ring.sym} 1260 -650 2 1 {name=R4
model=ptap1
spiceprefix=X
w=62.22e-6
l=8.90e-6
rw=0.3e-6
lvs_ignore=short
}
C {devices/iopin.sym} 1200 -680 1 0 {name=p30 lab=psub}
