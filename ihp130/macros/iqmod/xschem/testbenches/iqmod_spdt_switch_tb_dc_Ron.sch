v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1200 2440 -800 {flags=graph
y1=45
y2=210
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=1.5
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="\\"r_on_ca; vout_a_spdt_ca vin_spdt - i(vds_x1) /\\""
color=4
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=2
linewidth_mult=4}
B 2 1640 -760 2440 -360 {flags=graph
y1=45
y2=210
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=1.5
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="\\"r_on_cb; vout_b_spdt_cb vin_spdt - i(vds_x2) /\\""
color=4
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=2
linewidth_mult=4}
T {SPDT Switch:
di_spdt_ctrl = 1: v_c connected to v_a, v_b = HIGH-Z
di_spdt_ctrl = 0: v_c connected to v_b, v_a = HIGH-Z} 830 -1080 0 0 0.4 0.4 {}
T {Testbench for Ron analysis - SPDT Switch} 660 -1730 0 0 1 1 {}
N 960 -580 960 -560 {
lab=VDD}
N 1000 -580 1000 -560 {
lab=vin_spdt}
N 960 -920 960 -900 {
lab=VDD}
N 1000 -920 1000 -900 {
lab=vin_spdt}
N 1280 -920 1320 -920 {
lab=vin_spdt}
N 980 -780 980 -740 {
lab=vout_a_spdt_ca}
N 1280 -740 1320 -740 {
lab=vout_a_spdt_ca}
N 1020 -440 1020 -420 {
lab=vout_b_spdt_cb}
N 1280 -420 1320 -420 {
lab=vout_b_spdt_cb}
N 960 -780 960 -740 {
lab=GND}
N 960 -440 960 -400 {
lab=GND}
N 1280 -580 1280 -530 {
lab=vin_spdt}
N 1280 -470 1280 -420 {
lab=vout_b_spdt_cb}
N 1280 -800 1280 -740 {
lab=vout_a_spdt_ca}
N 1280 -920 1280 -860 {
lab=vin_spdt}
N 1280 -580 1320 -580 {
lab=vin_spdt}
N 980 -740 1280 -740 {
lab=vout_a_spdt_ca}
N 1000 -920 1280 -920 {
lab=vin_spdt}
N 1000 -580 1280 -580 {
lab=vin_spdt}
N 1020 -420 1280 -420 {
lab=vout_b_spdt_cb}
N 1060 -840 1160 -840 {
lab=VDD}
N 1160 -860 1160 -840 {lab=VDD}
N 1060 -500 1160 -500 {lab=GND}
N 1160 -500 1160 -480 {lab=GND}
N 1080 -1240 1080 -1200 {
lab=GND}
N 1080 -1340 1080 -1300 {
lab=vin_spdt}
N 960 -1340 960 -1300 {lab=VDD}
N 960 -1240 960 -1200 {lab=GND}
C {devices/vdd.sym} 960 -580 0 0 {name=l10 lab=VDD}
C {devices/gnd.sym} 960 -400 0 0 {name=l13 lab=GND}
C {devices/vdd.sym} 960 -920 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 960 -740 0 0 {name=l4 lab=GND}
C {devices/lab_wire.sym} 1320 -920 0 1 {name=p2 sig_type=std_logic lab=vin_spdt}
C {devices/title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/lab_wire.sym} 1320 -740 2 0 {name=p6 sig_type=std_logic lab=vout_a_spdt_ca}
C {devices/lab_wire.sym} 1320 -420 0 1 {name=p7 sig_type=std_logic lab=vout_b_spdt_cb}
C {devices/vsource.sym} 1280 -830 0 0 {name=vds_x1 value=1mV
}
C {devices/vsource.sym} 1280 -500 0 0 {name=vds_x2 value=1mV
}
C {devices/lab_wire.sym} 1320 -580 0 1 {name=p1 sig_type=std_logic lab=vin_spdt}
C {code_shown.sym} 80 -1350 0 0 {name=NGSPICE
only_toplevel=true
value="
.include ../../verification/pex/iqmod_spdt_switch_pex.spice
.param VDD=1.5
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control
save all

* Operating Point Analysis
op
remzerovec
write iqmod_spdt_switch_tb_dc_Ron.raw
set appendwrite

* DC Sweep Analysis
dc vin 0 $&VDD 10m
write iqmod_spdt_switch_tb_dc_Ron.raw

* On-Resistance v_c to v_a
let r_on_ca = (v(vout_a_spdt_ca)-v(vin_spdt))/I(vds_x1)
plot r_on_ca xlabel 'Vin in V' ylabel 'Ron in Ohm'

* On-Resistance v_c to v_b
let r_on_cb = (v(vout_b_spdt_cb)-v(vin_spdt))/I(vds_x2)
plot r_on_cb xlabel 'Vin in V' ylabel 'Ron in Ohm'

*quit
.endc"}
C {devices/launcher.sym} 1710 -1370 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1710 -1310 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/vdd.sym} 1160 -860 0 0 {name=l5 lab=VDD}
C {devices/gnd.sym} 1160 -480 0 0 {name=l7 lab=GND}
C {iqmod_spdt_switch_pex.sym} 1000 -840 0 0 {name=x1}
C {iqmod_spdt_switch_pex.sym} 1000 -500 0 0 {name=x2}
C {devices/code_shown.sym} 1980 -1370 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {devices/vsource.sym} 1080 -1270 0 0 {name=vin value=\{Vcm\}
}
C {devices/gnd.sym} 1080 -1200 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} 1080 -1340 0 1 {name=p3 sig_type=std_logic lab=vin_spdt}
C {devices/vsource.sym} 960 -1270 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 960 -1200 0 0 {name=l6 lab=GND}
C {vdd.sym} 960 -1340 0 0 {name=l8 lab=VDD}
C {devices/launcher.sym} 1710 -1250 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc"
}
C {iqmod_spdt_switch_pex.sym} 400 -500 0 0 {name=x3
spice_ignore=true}
C {iqmod_spdt_switch.sym} 400 -700 0 0 {name=x4
spice_ignore=true}
