v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1180 2440 -780 {flags=graph
y1=-8.5688677e-11
y2=1.7696127e-10
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
node="\\"Ileak CB; i(vout_x1)\\""
color=4
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=2
linewidth_mult=4}
B 2 1640 -700 2440 -300 {flags=graph
y1=-9.7e-11
y2=6.1e-10
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
node="\\"Ileak CA; i(vout_x2)\\""
color=4
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=2
linewidth_mult=4}
T {SPDT Switch:
di_spdt_ctrl = 1: v_c connected to v_a, v_b = HIGH-Z
di_spdt_ctrl = 0: v_c connected to v_b, v_a = HIGH-Z} 800 -1190 0 0 0.4 0.4 {}
T {Testbench for Ileak analysis - SPDT Switch} 660 -1730 0 0 1 1 {}
T {di_spdt_ctrl = 1:} 1640 -1220 0 0 0.4 0.4 {}
T {di_spdt_ctrl = 0:} 1640 -740 0 0 0.4 0.4 {}
N 940 -580 940 -560 {
lab=VDD}
N 980 -580 980 -560 {
lab=vin_spdt}
N 940 -1020 940 -1000 {
lab=VDD}
N 980 -1020 980 -1000 {
lab=vin_spdt}
N 1000 -880 1000 -840 {
lab=vout_b_spdt_ca}
N 1140 -840 1200 -840 {
lab=vout_b_spdt_ca}
N 1140 -760 1140 -740 {
lab=GND}
N 980 -1020 1200 -1020 {
lab=vin_spdt}
N 960 -440 960 -400 {
lab=vout_a_spdt_cb}
N 1140 -320 1140 -300 {
lab=GND}
N 1140 -400 1200 -400 {
lab=vout_a_spdt_cb}
N 980 -580 1200 -580 {
lab=vin_spdt}
N 1040 -940 1140 -940 {
lab=VDD}
N 1040 -500 1140 -500 {
lab=GND}
N 1140 -400 1140 -380 {
lab=vout_a_spdt_cb}
N 960 -400 1140 -400 {
lab=vout_a_spdt_cb}
N 1140 -840 1140 -820 {
lab=vout_b_spdt_ca}
N 1000 -840 1140 -840 {
lab=vout_b_spdt_ca}
N 1060 -1300 1060 -1260 {
lab=GND}
N 1060 -1400 1060 -1360 {
lab=vin_spdt}
N 1140 -500 1140 -480 {lab=GND}
N 1140 -960 1140 -940 {lab=VDD}
N 940 -440 940 -420 {lab=GND}
N 940 -880 940 -860 {lab=GND}
N 940 -1400 940 -1360 {lab=VDD}
N 940 -1300 940 -1260 {lab=GND}
C {devices/vdd.sym} 940 -580 0 0 {name=l10 lab=VDD}
C {devices/gnd.sym} 940 -420 0 1 {name=l13 lab=GND}
C {devices/vdd.sym} 940 -1020 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 940 -860 0 1 {name=l4 lab=GND}
C {devices/lab_wire.sym} 1200 -1020 0 1 {name=p2 sig_type=std_logic lab=vin_spdt}
C {devices/gnd.sym} 1140 -480 0 0 {name=l9 lab=GND}
C {devices/vdd.sym} 1140 -960 0 0 {name=l5 lab=VDD}
C {devices/lab_wire.sym} 1200 -840 2 0 {name=p6 sig_type=std_logic lab=vout_b_spdt_ca}
C {devices/lab_wire.sym} 1200 -400 0 1 {name=p7 sig_type=std_logic lab=vout_a_spdt_cb}
C {devices/vsource.sym} 1140 -790 0 0 {name=vout_x1 value=\{Vcm\}
}
C {devices/vsource.sym} 1140 -350 0 0 {name=vout_x2 value=\{Vcm\}
}
C {devices/lab_wire.sym} 1200 -580 0 1 {name=p1 sig_type=std_logic lab=vin_spdt}
C {devices/gnd.sym} 1140 -740 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} 1140 -300 0 0 {name=l11 lab=GND}
C {code_shown.sym} 60 -1450 0 0 {name=NGSPICE
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
write iqmod_spdt_switch_tb_dc_Ileak.raw
set appendwrite

* DC Sweep Analysis x1
dc vin 0 $&VDD 10m vout_x1 0 $&VDD 0.25
write iqmod_spdt_switch_tb_dc_Ileak.raw
set appendwrite

*Off-Leakage Current v_c to v_b
let Ileak_cb = I(vout_x1)
plot Ileak_cb

* DC Sweep Analysis x2
dc vin 0 $&VDD 10m vout_x2 0 $&VDD 0.25
write iqmod_spdt_switch_tb_dc_Ileak.raw

*Off-Leakage Current v_c to v_a
let Ileak_ca = I(vout_x2)
plot Ileak_ca

*quit
.endc"}
C {devices/launcher.sym} 1700 -1400 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1700 -1340 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/vsource.sym} 1060 -1330 0 0 {name=vin value=\{Vcm\}
}
C {devices/gnd.sym} 1060 -1260 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} 1060 -1400 0 1 {name=p3 sig_type=std_logic lab=vin_spdt}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/vsource.sym} 940 -1330 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 940 -1260 0 0 {name=l6 lab=GND}
C {vdd.sym} 940 -1400 0 0 {name=l8 lab=VDD}
C {iqmod_spdt_switch_pex.sym} 980 -940 0 0 {name=x1}
C {iqmod_spdt_switch_pex.sym} 980 -500 0 0 {name=x2}
C {devices/launcher.sym} 1700 -1280 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc"
}
C {devices/code_shown.sym} 1980 -1390 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_spdt_switch_pex.sym} 400 -500 0 0 {name=x3
spice_ignore=true}
C {iqmod_spdt_switch.sym} 400 -700 0 0 {name=x4
spice_ignore=true}
