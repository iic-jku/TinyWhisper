v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 1460 -960 {}
P 4 5 420 -1020 980 -1020 980 -380 420 -380 420 -1020 {dash = 8}
P 4 5 1000 -1020 1000 -380 1480 -380 1480 -1020 1000 -1020 {dash = 8}
P 4 5 1500 -380 1500 -1020 2120 -1020 2120 -380 1500 -380 {dash = 8}
T {Parameterizable LO Logic with Inverters} 680 -1680 0 0 1 1 {}
T {Scaling Inverter Chain} 1500 -370 0 0 0.4 0.4 {}
T {Cross-Coupling of Edges} 1000 -370 0 0 0.4 0.4 {}
T {Features of the LO logic:
-) First, vin_LO is buffered and inverted.
-) Second, the edges of the buffered and inverted signals are locked with a cross-coupled inverter pair.
-) Finally, the drive strength for the transmission gates is guaranteed by a scaling inverter chain of factor 3.
More information on such scaling chains can be found here: https://cse14-iiith.vlabs.ac.in/exp/chain-of-inverters/theory.html} 1820 -1250 2 0 0.5 0.5 {}
T {Buffering / Inverting Input} 420 -370 0 0 0.4 0.4 {}
N 500 -940 500 -920 {lab=VDD}
N 500 -840 500 -820 {lab=VSS}
N 760 -560 760 -540 {lab=VDD}
N 760 -460 760 -440 {lab=VSS}
N 360 -690 400 -690 {lab=vin_LO}
N 1160 -700 1180 -700 {lab=VDD}
N 1060 -700 1080 -700 {lab=VSS}
N 1300 -680 1320 -680 {lab=VDD}
N 1400 -680 1420 -680 {lab=VSS}
N 1580 -560 1580 -540 {lab=VDD}
N 1580 -460 1580 -440 {lab=VSS}
N 1580 -940 1580 -920 {lab=VDD}
N 1580 -840 1580 -820 {lab=VSS}
N 1880 -940 1880 -920 {lab=VDD}
N 1880 -840 1880 -820 {lab=VSS}
N 1880 -560 1880 -540 {lab=VDD}
N 1880 -460 1880 -440 {lab=VSS}
N 760 -940 760 -920 {lab=VDD}
N 760 -840 760 -820 {lab=VSS}
N 580 -880 700 -880 {lab=#net1}
N 400 -880 440 -880 {lab=vin_LO}
N 840 -880 960 -880 {lab=buf_cross}
N 400 -880 400 -690 {lab=vin_LO}
N 400 -690 400 -500 {lab=vin_LO}
N 960 -880 1520 -880 {lab=buf_cross}
N 1120 -880 1120 -760 {lab=buf_cross}
N 1360 -880 1360 -760 {lab=buf_cross}
N 840 -500 1520 -500 {lab=inv_cross}
N 1360 -620 1360 -500 {lab=inv_cross}
N 1120 -620 1120 -500 {lab=inv_cross}
N 1660 -880 1820 -880 {lab=buf_scale}
N 1660 -500 1820 -500 {lab=inv_scale}
N 1960 -880 2160 -880 {lab=vout_LO}
N 1960 -500 2160 -500 {lab=vout_LO_inv}
N 1360 -900 1360 -880 {lab=buf_cross}
N 1360 -500 1360 -480 {lab=inv_cross}
N 1740 -900 1740 -880 {lab=buf_scale}
N 1740 -520 1740 -500 {lab=inv_scale}
N 400 -500 440 -500 {lab=vin_LO}
N 500 -560 500 -540 {lab=VDD}
N 500 -560 520 -560 {lab=VDD}
N 520 -560 520 -540 {lab=VDD}
N 500 -460 500 -440 {lab=VSS}
N 520 -460 520 -440 {lab=VSS}
N 500 -440 520 -440 {lab=VSS}
N 600 -500 700 -500 {lab=#net2}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/ipin.sym} 360 -690 0 0 {name=p3 lab=vin_LO}
C {lab_pin.sym} 760 -560 1 0 {name=p14 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -440 3 0 {name=p17 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1060 -700 0 0 {name=p21 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1180 -700 2 0 {name=p22 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1300 -680 0 0 {name=p23 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1420 -680 2 0 {name=p24 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1580 -940 1 0 {name=p25 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1580 -820 3 0 {name=p27 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1580 -440 3 0 {name=p28 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1580 -560 1 0 {name=p29 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1880 -940 1 0 {name=p30 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1880 -820 3 0 {name=p31 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1880 -560 1 0 {name=p34 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1880 -440 3 0 {name=p36 sig_type=std_logic lab=VSS}
C {devices/iopin.sym} 500 -940 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 500 -820 1 0 {name=p2 lab=VSS}
C {devices/opin.sym} 2160 -880 0 0 {name=p7 lab=vout_LO}
C {devices/opin.sym} 2160 -500 0 0 {name=p4 lab=vout_LO_inv}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 500 -880 0 0 {name=x1 W_P=W_P L_P=L_P NF_P=NF_P W_N=W_N L_N=L_N NF_N=NF_N}
C {lab_pin.sym} 760 -940 1 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 760 -820 3 0 {name=p6 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 760 -500 0 0 {name=x4 W_P=W_P L_P=L_P NF_P=NF_P W_N=W_N L_N=L_N NF_N=NF_N}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 760 -880 0 0 {name=x2 W_P=W_P L_P=L_P NF_P=NF_P W_N=W_N L_N=L_N NF_N=NF_N}
C {lab_pin.sym} 1360 -900 1 0 {name=p8 sig_type=std_logic lab=buf_cross}
C {lab_pin.sym} 1360 -480 3 0 {name=p9 sig_type=std_logic lab=inv_cross}
C {lab_pin.sym} 1740 -900 1 0 {name=p10 sig_type=std_logic lab=buf_scale}
C {lab_pin.sym} 1740 -520 1 0 {name=p11 sig_type=std_logic lab=inv_scale}
C {lab_pin.sym} 500 -560 1 0 {name=p12 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 500 -440 3 0 {name=p13 sig_type=std_logic lab=VSS}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 1880 -500 0 0 {name=x10 W_P=\{s*W_P\} L_P=L_P NF_P=\{s*NF_P\} W_N=\{s*W_N\} L_N=L_N NF_N=\{s*NF_N\}}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 1580 -880 0 0 {name=x7 W_P=W_P L_P=L_P NF_P=NF_P W_N=W_N L_N=L_N NF_N=NF_N}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 1580 -500 0 0 {name=x9 W_P=W_P L_P=L_P NF_P=NF_P W_N=W_N L_N=L_N NF_N=NF_N}
C {wspr_tx_iqmod_mixer_lo_logic_inv_gen.sym} 1880 -880 0 0 {name=x8 W_P=\{s*W_P\} L_P=L_P NF_P=\{s*NF_P\} W_N=\{s*W_N\} L_N=L_N NF_N=\{s*NF_N\}}
C {wspr_tx_iqmod_mixer_lo_logic_tg_gen.sym} 520 -500 0 0 {name=x3 W_P=W_P L_P=L_P NF_P=NF_P W_N=W_N L_N=L_N NF_N=NF_N}
C {wspr_tx_iqmod_mixer_lo_logic_inv_weak_gen.sym} 1120 -700 1 0 {name=x5 W_P=3.0 L_P=0.15 NF_P=1 W_N=1.0 L_N=0.15 NF_N=1}
C {wspr_tx_iqmod_mixer_lo_logic_inv_weak_gen.sym} 1360 -680 3 0 {name=x6 W_P=3.0 L_P=0.15 NF_P=1 W_N=1.0 L_N=0.15 NF_N=1}
