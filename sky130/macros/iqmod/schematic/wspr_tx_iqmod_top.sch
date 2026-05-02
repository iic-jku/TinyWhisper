v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 4 1720 -1080 2120 -400 {fill = false
dash = 16}
T {Tiny Whisper (Analog Front-End)} 660 -1730 0 0 1.5 1.5 {}
T {afe_en = 1... enable
afe_en = 0... disable} 330 -1380 0 0 0.25 0.25 {}
T {Decoupling Capacitors} 1730 -1070 0 0 0.4 0.4 {}
N 1280 -900 1320 -900 {lab=ua[0]}
N 460 -1220 500 -1220 {lab=ua[4]}
N 460 -1160 500 -1160 {lab=ua[3]}
N 460 -1300 500 -1300 {lab=ui_in[4]}
N 1100 -420 1100 -400 {lab=VGND}
N 1100 -1400 1100 -1380 {lab=VDPWR}
N 460 -640 500 -640 {lab=ua[2]}
N 460 -580 500 -580 {lab=ua[1]}
N 460 -840 500 -840 {lab=ui_in[1]}
N 460 -780 500 -780 {lab=ui_in[0]}
N 460 -1020 500 -1020 {lab=ui_in[3]}
N 460 -960 500 -960 {lab=ui_in[2]}
N 1840 -960 1840 -940 {lab=VDPWR}
N 1840 -880 1840 -860 {lab=VGND}
N 2040 -960 2040 -940 {lab=VDPWR}
N 2040 -880 2040 -860 {lab=VGND}
N 1940 -700 1940 -660 {lab=VDPWR}
N 1880 -620 1910 -620 {lab=VGND}
N 1880 -620 1880 -520 {lab=VGND}
N 1880 -520 2000 -520 {lab=VGND}
N 2000 -620 2000 -520 {lab=VGND}
N 1970 -620 2000 -620 {lab=VGND}
N 1940 -520 1940 -480 {lab=VGND}
N 1940 -620 1940 -520 {lab=VGND}
C {devices/iopin.sym} 1100 -1400 3 0 {name=p1 lab=VDPWR}
C {devices/opin.sym} 1320 -900 0 0 {name=p7 lab=ua[0]}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1100 -400 1 0 {name=p3 lab=VGND}
C {devices/ipin.sym} 460 -1300 2 1 {name=p21 lab=ui_in[4]}
C {devices/ipin.sym} 460 -640 2 1 {name=p2 lab=ua[2]}
C {devices/ipin.sym} 460 -1020 2 1 {name=p14 lab=ui_in[3]}
C {devices/ipin.sym} 460 -960 0 0 {name=p15 lab=ui_in[2]}
C {devices/ipin.sym} 460 -840 2 1 {name=p16 lab=ui_in[1]}
C {devices/ipin.sym} 460 -780 0 0 {name=p17 lab=ui_in[0]}
C {devices/ipin.sym} 460 -580 2 1 {name=p4 lab=ua[1]}
C {devices/ipin.sym} 460 -1220 2 1 {name=p8 lab=ua[4]}
C {devices/ipin.sym} 460 -1160 2 1 {name=p9 lab=ua[3]}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1840 -910 2 0 {name=C1 model=cap_mim_m3_1 W=30.0 L=30.0 MF=1 spiceprefix=X}
C {lab_pin.sym} 1840 -960 1 0 {name=p23 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 1840 -860 3 0 {name=p24 sig_type=std_logic lab=VGND}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2040 -910 2 0 {name=C2 model=cap_mim_m3_1 W=30.0 L=30.0 MF=1 spiceprefix=X}
C {lab_pin.sym} 2040 -960 1 0 {name=p5 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 2040 -860 3 0 {name=p6 sig_type=std_logic lab=VGND}
C {lab_pin.sym} 1940 -700 1 0 {name=p10 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 1940 -480 3 0 {name=p11 sig_type=std_logic lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 1940 -640 1 0 {name=M1
W=25.0
L=20.0
nf=1 
mult=8
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {wspr_tx_iqmod.sym} 880 -900 0 0 {name=x1}
