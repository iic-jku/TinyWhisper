v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -860 2440 -460 {flags=graph
y1=1400
y2=7900
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.023119605
x2=1.4768804
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
color=7
node="\\"r_w_dummy_on; vout_tg_w_dummy_on vin_tg - i(vds_x3) /\\""
linewidth_mult=4}
T {Testbench for Ron analysis - Parameterizable Transmission Gate} 420 -1720 0 0 1 1 {}
T {TGs are ON!} 1240 -710 0 0 0.5 0.5 {}
N 980 -780 980 -700 {
lab=vin_tg}
N 980 -640 980 -580 {
lab=GND}
N 820 -640 820 -580 {
lab=GND}
N 820 -760 820 -700 {
lab=VDD}
N 940 -960 980 -960 {
lab=vin_tg}
N 1060 -960 1100 -960 {
lab=vin_tg}
N 1260 -960 1360 -960 {
lab=vout_tg_w_dummy_on}
N 1160 -1020 1160 -1000 {
lab=VDD}
N 1180 -1020 1180 -1000 {
lab=VDD}
N 1360 -960 1400 -960 {
lab=vout_tg_w_dummy_on}
N 980 -960 1060 -960 {
lab=vin_tg}
N 1160 -1020 1180 -1020 {lab=VDD}
N 1160 -1040 1160 -1020 {lab=VDD}
N 1160 -900 1160 -880 {lab=GND}
N 1180 -920 1180 -900 {lab=GND}
N 1160 -900 1180 -900 {lab=GND}
N 1160 -920 1160 -900 {lab=GND}
N 1220 -780 1360 -780 {lab=vout_tg_w_dummy_on}
N 1360 -960 1360 -780 {
lab=vout_tg_w_dummy_on}
N 1060 -780 1160 -780 {lab=vin_tg}
N 1060 -960 1060 -780 {
lab=vin_tg}
N 980 -960 980 -780 {lab=vin_tg}
C {devices/vsource.sym} 820 -670 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 820 -580 0 0 {name=l6 lab=GND}
C {devices/vdd.sym} 820 -760 0 0 {name=l8 lab=VDD}
C {devices/vsource.sym} 980 -670 0 0 {name=vin value=0
}
C {devices/lab_wire.sym} 940 -960 0 0 {name=p2 sig_type=std_logic lab=vin_tg}
C {devices/gnd.sym} 980 -580 0 0 {name=l1 lab=GND}
C {devices/launcher.sym} 1700 -1030 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1700 -910 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc"
}
C {devices/launcher.sym} 1700 -970 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {code_shown.sym} 40 -1010 0 0 {name=NGSPICE
only_toplevel=true
value="
.param VDD=1.8
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

save all

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mixer_tg_tb_dc_Ron.raw
set appendwrite

* DC Sweep Analysis
dc vin 0 $&VDD 0.01
write wspr_tx_iqmod_mixer_tg_tb_dc_Ron.raw

* On-Resistance
* LV with Dummy
let r_w_dummy_on = (v(vout_tg_w_dummy_on)-v(vin_tg))/I(vds_x3)
plot r_w_dummy_on xlabel 'Vin in V' ylabel 'Ron with Dummy in Ohm'

* Writing Data
unset appendwrite
set wr_singlescale
set wr_vecnames
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_iqmod_mixer_tg_tb_dc_Ron.txt v(r_w_dummy_on)

*quit
.endc"}
C {devices/lab_wire.sym} 1400 -960 0 1 {name=p3 sig_type=std_logic lab=vout_tg_w_dummy_on}
C {devices/gnd.sym} 1160 -880 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 1160 -1040 0 0 {name=l5 lab=VDD}
C {devices/vsource.sym} 1190 -780 3 0 {name=vds_x3 value=1mV
}
C {title-3.sym} 0 0 0 0 {name=l7 author="Simon Dorrer" rev=1.0 lock=true}
C {sky130_fd_pr/corner.sym} 1940 -1010 0 0 {name=CORNER only_toplevel=false corner=tt}
C {wspr_tx_iqmod_mixer_tg_gen.sym} 1180 -960 0 0 {name=x1 W_P=57.0 L_P=0.15 NF_P=19 W_N=19.0 L_N=0.15 NF_N=19 W_P_D=12.0 L_P_D=0.15 NF_P_D=4 W_N_D=4.0 L_N_D=0.15 NF_N_D=4}
