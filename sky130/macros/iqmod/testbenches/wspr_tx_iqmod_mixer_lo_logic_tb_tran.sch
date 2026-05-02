v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1220 2440 -820 {flags=graph
y1=-0.058
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=2e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_LO
x1.buf_cross
x1.inv_cross
x1.buf_scale
x1.inv_scale"
color="4 7 12 18 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3}
B 2 1640 -800 2440 -400 {flags=graph
y1=-0.0095
y2=1.9
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=2e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_LO
vout_LO
vout_LO_inv"
color="4 7 12"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3}
T {Testbench for transient analysis - Parameterizable LO Logic} 420 -1710 0 0 1 1 {}
N 680 -800 680 -740 {
lab=GND}
N 680 -920 680 -860 {
lab=VDD}
N 1160 -1020 1160 -980 {lab=VDD}
N 880 -800 880 -740 {lab=GND}
N 1160 -860 1160 -740 {lab=GND}
N 1400 -380 1400 -340 {lab=GND}
N 1280 -940 1480 -940 {lab=vout_LO}
N 1280 -900 1480 -900 {lab=vout_LO_inv}
N 1400 -500 1400 -440 {lab=#net1}
N 820 -920 1040 -920 {lab=vin_LO}
N 880 -920 880 -860 {lab=vin_LO}
N 1180 -560 1180 -540 {lab=vout_LO}
N 1180 -460 1180 -440 {lab=vout_LO_inv}
N 1180 -580 1180 -560 {lab=vout_LO}
N 1180 -440 1180 -420 {lab=vout_LO_inv}
N 1160 -460 1160 -420 {lab=GND}
N 1160 -580 1160 -540 {lab=VDD}
N 1260 -500 1400 -500 {lab=#net1}
N 960 -500 1100 -500 {lab=#net2}
N 960 -500 960 -450 {lab=#net2}
N 960 -390 960 -340 {lab=GND}
C {devices/code_shown.sym} 60 -1370 0 0 {name=NGSPICE
only_toplevel=true 
value="
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param flo=10e6
.csparam flo=flo
.param Cload=1p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control
save all

* User Constants
let tstop = 2*1/flo
let tstep = 0.01*1/flo

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mixer_lo_logic_tb_tran.raw
set appendwrite

* Transient Analysis
tran $&tstep $&tstop
write wspr_tx_iqmod_mixer_lo_logic_tb_tran.raw

quit
.endc
"}
C {devices/vsource.sym} 680 -830 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 680 -740 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1700 -1390 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {lab_pin.sym} 820 -920 0 0 {name=p2 sig_type=std_logic lab=vin_LO}
C {devices/capa.sym} 1400 -410 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 880 -740 0 0 {name=l5 lab=GND}
C {vdd.sym} 1160 -1020 0 0 {name=l6 lab=VDD}
C {lab_pin.sym} 1480 -900 0 1 {name=p1 sig_type=std_logic lab=vout_LO_inv}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1270 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1700 -1330 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 680 -920 0 0 {name=l7 lab=VDD}
C {sky130_fd_pr/corner.sym} 1940 -1370 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/gnd.sym} 1160 -740 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1400 -340 0 0 {name=l1 lab=GND}
C {lab_pin.sym} 1480 -940 0 1 {name=p3 sig_type=std_logic lab=vout_LO}
C {wspr_tx_iqmod_mixer_lo_logic_gen.sym} 1160 -920 0 0 {name=x1 W_P=6.0 L_P=0.15 NF_P=2 W_N=2.0 L_N=0.15 NF_N=2 s=3}
C {devices/vsource.sym} 880 -830 0 0 {name=Vloi value="pulse(0 \{VDD\} 0 10p 10p \{0.25/flo\} \{1/flo\})"}
C {lab_pin.sym} 1180 -580 0 1 {name=p6 sig_type=std_logic lab=vout_LO}
C {devices/gnd.sym} 1160 -420 0 1 {name=l9 lab=GND}
C {vdd.sym} 1160 -580 0 0 {name=l11 lab=VDD}
C {devices/vsource.sym} 960 -420 0 1 {name=Vin value=\{Vcm\}}
C {devices/gnd.sym} 960 -340 0 0 {name=l8 lab=GND}
C {lab_pin.sym} 1180 -420 0 1 {name=p4 sig_type=std_logic lab=vout_LO_inv}
C {wspr_tx_iqmod_mixer_tg_gen.sym} 1180 -500 0 0 {name=x2 W_P=57.0 L_P=0.15 NF_P=19 W_N=19.0 L_N=0.15 NF_N=19 W_P_D=12.0 L_P_D=0.15 NF_P_D=4 W_N_D=4.0 L_N_D=0.15 NF_N_D=4}
