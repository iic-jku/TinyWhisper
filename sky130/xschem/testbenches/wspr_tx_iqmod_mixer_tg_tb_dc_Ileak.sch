v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1620 -920 2420 -520 {flags=graph
y1=-1.3e-10
y2=2.2e-10
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.225
x2=1.725
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(vout_w_dummy)
color=7
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=4}
T {Testbench for Ileak analysis - Parameterizable Transmission Gate} 410 -1710 0 0 1 1 {}
T {TGs are OFF!} 1230 -1050 0 0 0.5 0.5 {}
N 960 -760 960 -720 {
lab=GND}
N 960 -860 960 -820 {
lab=vin_tg}
N 780 -760 780 -720 {
lab=GND}
N 780 -860 780 -820 {
lab=VDD}
N 920 -860 960 -860 {
lab=vin_tg}
N 1100 -980 1100 -900 {
lab=VDD}
N 1120 -960 1140 -960 {
lab=GND}
N 1120 -960 1120 -900 {
lab=GND}
N 1120 -740 1140 -740 {
lab=VDD}
N 1140 -960 1140 -950 {
lab=GND}
N 1140 -750 1140 -740 {
lab=VDD}
N 1120 -820 1120 -740 {
lab=VDD}
N 1100 -820 1100 -720 {
lab=GND}
N 960 -860 1040 -860 {lab=vin_tg}
N 1300 -860 1340 -860 {lab=vout_tg_w_dummy_off}
N 1300 -860 1300 -820 {
lab=vout_tg_w_dummy_off}
N 1300 -760 1300 -720 {
lab=GND}
N 1200 -860 1300 -860 {lab=vout_tg_w_dummy_off}
C {devices/vsource.sym} 780 -790 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 780 -720 0 0 {name=l6 lab=GND}
C {devices/vdd.sym} 780 -860 0 0 {name=l8 lab=VDD}
C {devices/vsource.sym} 960 -790 0 0 {name=vin value=\{Vcm\}
}
C {devices/lab_wire.sym} 920 -860 0 0 {name=p2 sig_type=std_logic lab=vin_tg}
C {devices/gnd.sym} 960 -720 0 0 {name=l1 lab=GND}
C {code_shown.sym} 60 -1210 0 0 {name=NGSPICE
only_toplevel=true
value="

.param VDD=1.8
.csparam VDD=VDD
.param Vcm=VDD/2
.csparam Vcm=Vcm
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

save all

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mixer_tg_tb_dc_Ileak.raw
set appendwrite
* =======================================

* DC Sweep Analysis LV with Dummy
dc vin 0 $&VDD 10m vout_w_dummy 0 $&VDD $&Vcm
write wspr_tx_iqmod_mixer_tg_tb_dc_Ileak.raw
set appendwrite

* Off-Leakage Current
let Ileak_w_dummy = i(vout_w_dummy)
plot Ileak_w_dummy
* =======================================

* Writing Data
set wr_singlescale
set wr_vecnames
let Ileak_w_dummy = dc1.Ileak_w_dummy
unset appendwrite
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_iqmod_mixer_tg_tb_dc_Ileak.txt v(Ileak_w_dummy) 
* =======================================

*quit
.endc"}
C {devices/launcher.sym} 1680 -1080 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1680 -960 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc"
}
C {devices/launcher.sym} 1680 -1020 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1100 -720 0 0 {name=l10 lab=GND}
C {devices/vdd.sym} 1100 -980 0 0 {name=l11 lab=VDD}
C {devices/gnd.sym} 1140 -950 0 0 {name=l13 lab=GND}
C {devices/vdd.sym} 1140 -750 0 0 {name=l14 lab=VDD}
C {devices/lab_wire.sym} 1340 -860 0 1 {name=p3 sig_type=std_logic lab=vout_tg_w_dummy_off}
C {devices/vsource.sym} 1300 -790 0 0 {name=vout_w_dummy value=\{Vcm\}
}
C {devices/gnd.sym} 1300 -720 0 0 {name=l12 lab=GND}
C {title-3.sym} 0 0 0 0 {name=l7 author="Simon Dorrer" rev=1.0 lock=true}
C {sky130_fd_pr/corner.sym} 1900 -1060 0 0 {name=CORNER only_toplevel=false corner=tt}
C {wspr_tx_iqmod_mixer_tg_gen.sym} 1120 -860 0 0 {name=x1 W_P=57.0 L_P=0.15 NF_P=19 W_N=19.0 L_N=0.15 NF_N=19 W_P_D=12.0 L_P_D=0.15 NF_P_D=4 W_N_D=4.0 L_N_D=0.15 NF_N_D=4}
