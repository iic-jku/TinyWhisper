v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1560 -1320 2360 -920 {flags=graph
y1=3.5e-05
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=0.01
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_tg
vout_tg_on"
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
linewidth_mult=4}
B 2 1560 -880 2360 -480 {flags=graph
y1=3.5e-05
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=0.01
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_tg
vout_tg_off"
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
linewidth_mult=4}
T {Testbench for transient analysis - Transmission Gate} 560 -1690 0 0 1 1 {}
T {TG is ON!} 1200 -1260 0 0 0.5 0.5 {}
T {TG is OFF!} 1200 -935 0 0 0.5 0.5 {}
N 860 -960 860 -920 {
lab=vin_tg}
N 1120 -920 1120 -840 {
lab=VDD}
N 980 -960 980 -800 {
lab=vin_tg}
N 980 -1120 980 -960 {
lab=vin_tg}
N 860 -960 980 -960 {
lab=vin_tg}
N 1320 -800 1360 -800 {
lab=vout_tg_off}
N 1120 -1200 1120 -1160 {
lab=VDD}
N 1160 -900 1160 -890 {
lab=GND}
N 1140 -900 1160 -900 {
lab=GND}
N 1140 -900 1140 -840 {
lab=GND}
N 1140 -680 1160 -680 {
lab=VDD}
N 1160 -690 1160 -680 {
lab=VDD}
N 1320 -1120 1360 -1120 {
lab=vout_tg_on}
N 1120 -1200 1140 -1200 {
lab=VDD}
N 1120 -1240 1120 -1200 {
lab=VDD}
N 1140 -1200 1140 -1160 {
lab=VDD}
N 1120 -1040 1120 -1000 {
lab=GND}
N 1140 -1080 1140 -1040 {
lab=GND}
N 1120 -1040 1140 -1040 {
lab=GND}
N 1120 -1080 1120 -1040 {
lab=GND}
N 1140 -760 1140 -680 {
lab=VDD}
N 1120 -760 1120 -660 {
lab=GND}
N 860 -860 860 -820 {
lab=GND}
N 820 -960 860 -960 {
lab=vin_tg}
N 580 -960 580 -920 {
lab=VDD}
N 580 -860 580 -820 {
lab=GND}
N 1320 -1120 1320 -1080 {
lab=vout_tg_on}
N 1220 -1120 1320 -1120 {
lab=vout_tg_on}
N 1320 -1020 1320 -1000 {
lab=GND}
N 1320 -680 1320 -660 {
lab=GND}
N 1320 -800 1320 -740 {
lab=vout_tg_off}
N 1220 -800 1320 -800 {
lab=vout_tg_off}
N 980 -800 1060 -800 {lab=vin_tg}
N 980 -1120 1060 -1120 {lab=vin_tg}
C {devices/lab_wire.sym} 1360 -1120 0 1 {name=p1 sig_type=std_logic lab=vout_tg_on}
C {devices/vsource.sym} 580 -890 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 580 -820 0 0 {name=l6 lab=GND}
C {devices/vdd.sym} 580 -960 0 0 {name=l8 lab=VDD}
C {devices/vsource.sym} 860 -890 0 1 {name=vin value="sin(\{Vcm\} \{Vcm\} 1k)"
}
C {devices/gnd.sym} 1120 -1000 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} 1120 -1240 0 0 {name=l4 lab=VDD}
C {devices/lab_wire.sym} 820 -960 0 0 {name=p2 sig_type=std_logic lab=vin_tg}
C {devices/gnd.sym} 860 -820 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} 1360 -800 0 1 {name=p3 sig_type=std_logic lab=vout_tg_off}
C {devices/gnd.sym} 1120 -660 0 0 {name=l9 lab=GND}
C {devices/vdd.sym} 1120 -920 0 0 {name=l11 lab=VDD}
C {devices/gnd.sym} 1160 -890 0 0 {name=l12 lab=GND}
C {devices/vdd.sym} 1160 -690 0 0 {name=l14 lab=VDD}
C {devices/title-3.sym} 0 0 0 0 {name=l3 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1620 -1490 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1620 -1370 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1620 -1430 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {code_shown.sym} 60 -750 0 0 {name=NGSPICE
only_toplevel=true
value="
.include ../../netlist/pex/iqmod_mixer_tg_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

save all

* Operating Point Analysis
op
remzerovec
write @schname\\\\.raw
set appendwrite

* Transient Analysis
tran 10u 10ms
write @schname\\\\.raw

plot vin_tg vout_tg_on
plot vin_tg vout_tg_off

* Writing Data
unset appendwrite
set wr_singlescale
set wr_vecnames
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mixer_tg_tb_tran.txt v(vin_tg) v(vout_tg_on) v(vout_tg_off)


*quit
.endc"}
C {devices/capa.sym} 1320 -1050 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1320 -710 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1320 -660 0 0 {name=l5 lab=GND}
C {devices/gnd.sym} 1320 -1000 0 0 {name=l7 lab=GND}
C {devices/code_shown.sym} 1940 -1480 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mixer_tg.sym} 660 -1460 0 0 {name=x1
spice_ignore = true}
C {iqmod_mixer_tg_pex.sym} 660 -1260 0 0 {name=x2
spice_ignore=true}
C {iqmod_mixer_tg_pex.sym} 1140 -1120 0 0 {name=x3
}
C {iqmod_mixer_tg_pex.sym} 1140 -800 0 0 {name=x4
}
