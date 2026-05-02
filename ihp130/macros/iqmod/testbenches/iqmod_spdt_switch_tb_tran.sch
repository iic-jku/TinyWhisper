v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1220 2440 -820 {flags=graph
y1=-0.0014
y2=1.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.8933475e-08
x2=3.9670893e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_spdt
vout_a_spdt_ca
vout_b_spdt_ca"
color="4 5 6"
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=2
linewidth_mult=4}
B 2 1640 -800 2440 -400 {flags=graph
y1=-0.00036
y2=1.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.8933475e-08
x2=3.9670893e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_spdt
vout_b_spdt_cb
vout_a_spdt_cb"
color="4 5 6"
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=2
linewidth_mult=4
}
T {Testbench for transient analysis - SPDT Switch} 620 -1690 0 0 1 1 {}
T {di_spdt_ctrl = 1: v_c connected to v_a, v_b = HIGH-Z
di_spdt_ctrl = 0: v_c connected to v_b, v_a = HIGH-Z} 930 -1210 0 0 0.4 0.4 {}
N 1040 -520 1040 -480 {
lab=GND}
N 1040 -660 1040 -640 {
lab=VDD}
N 1080 -660 1080 -640 {
lab=vin_spdt}
N 1040 -1080 1040 -1060 {
lab=VDD}
N 1080 -1080 1080 -1060 {
lab=vin_spdt}
N 1040 -940 1040 -900 {
lab=GND}
N 1080 -1080 1380 -1080 {
lab=vin_spdt}
N 1100 -940 1100 -920 {
lab=vout_b_spdt_ca}
N 1060 -940 1060 -900 {
lab=vout_a_spdt_ca}
N 1100 -520 1100 -500 {
lab=vout_b_spdt_cb}
N 1060 -520 1060 -480 {
lab=vout_a_spdt_cb}
N 1080 -660 1380 -660 {
lab=vin_spdt}
N 1140 -1000 1240 -1000 {
lab=VDD}
N 800 -520 800 -480 {
lab=GND}
N 800 -620 800 -580 {
lab=VDD}
N 1080 -1380 1080 -1340 {
lab=GND}
N 1180 -900 1380 -900 {
lab=vout_a_spdt_ca}
N 1280 -920 1280 -860 {
lab=vout_b_spdt_ca}
N 1100 -900 1100 -860 {
lab=vout_a_spdt_ca}
N 1100 -800 1100 -760 {
lab=GND}
N 1280 -800 1280 -760 {
lab=GND}
N 1240 -1020 1240 -1000 {lab=VDD}
N 1140 -580 1240 -580 {lab=GND}
N 1240 -580 1240 -560 {lab=GND}
N 1040 -1480 1080 -1480 {lab=vin_spdt}
N 1080 -1480 1080 -1440 {lab=vin_spdt}
N 1080 -1480 1180 -1480 {lab=vin_spdt}
N 1180 -1480 1180 -1440 {lab=vin_spdt}
N 1180 -1380 1180 -1340 {lab=GND}
N 1360 -920 1380 -920 {lab=vout_b_spdt_ca}
N 1180 -900 1180 -860 {lab=vout_a_spdt_ca}
N 1100 -900 1180 -900 {
lab=vout_a_spdt_ca}
N 1360 -920 1360 -860 {lab=vout_b_spdt_ca}
N 1280 -920 1360 -920 {lab=vout_b_spdt_ca}
N 1180 -800 1180 -760 {lab=GND}
N 1360 -800 1360 -760 {lab=GND}
N 1180 -480 1380 -480 {
lab=vout_a_spdt_cb}
N 1280 -500 1280 -440 {
lab=vout_b_spdt_cb}
N 1100 -480 1100 -440 {
lab=vout_a_spdt_cb}
N 1100 -380 1100 -340 {
lab=GND}
N 1280 -380 1280 -340 {
lab=GND}
N 1360 -500 1380 -500 {lab=vout_b_spdt_cb}
N 1180 -480 1180 -440 {lab=vout_a_spdt_cb}
N 1100 -480 1180 -480 {
lab=vout_a_spdt_cb}
N 1360 -500 1360 -440 {lab=vout_b_spdt_cb}
N 1280 -500 1360 -500 {lab=vout_b_spdt_cb}
N 1180 -380 1180 -340 {lab=GND}
N 1360 -380 1360 -340 {lab=GND}
N 1100 -920 1280 -920 {lab=vout_b_spdt_ca}
N 1060 -900 1100 -900 {lab=vout_a_spdt_ca}
N 1060 -480 1100 -480 {lab=vout_a_spdt_cb}
N 1100 -500 1280 -500 {lab=vout_b_spdt_cb}
C {devices/vdd.sym} 1040 -660 0 0 {name=l10 lab=VDD}
C {devices/gnd.sym} 1040 -480 0 0 {name=l13 lab=GND}
C {devices/vdd.sym} 1040 -1080 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 1040 -900 0 0 {name=l4 lab=GND}
C {devices/lab_wire.sym} 1380 -920 0 1 {name=p1 sig_type=std_logic lab=vout_b_spdt_ca}
C {devices/lab_wire.sym} 1380 -1080 0 1 {name=p2 sig_type=std_logic lab=vin_spdt}
C {devices/title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/lab_wire.sym} 1380 -900 2 0 {name=p6 sig_type=std_logic lab=vout_a_spdt_ca}
C {devices/lab_wire.sym} 1380 -500 0 1 {name=p7 sig_type=std_logic lab=vout_b_spdt_cb}
C {devices/lab_wire.sym} 1380 -480 2 0 {name=p4 sig_type=std_logic lab=vout_a_spdt_cb}
C {devices/launcher.sym} 1700 -1380 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1700 -1320 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/lab_wire.sym} 1380 -660 0 1 {name=p5 sig_type=std_logic lab=vin_spdt}
C {devices/vdd.sym} 1240 -1020 0 0 {name=l5 lab=VDD}
C {devices/gnd.sym} 1240 -560 0 0 {name=l7 lab=GND}
C {devices/capa.sym} 1100 -830 0 0 {name=C1
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {code_shown.sym} 100 -1350 0 0 {name=NGSPICE
only_toplevel=true
value="
.include ../../netlist/pex/iqmod_spdt_switch_pex.spice
.param VDD=1.5
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.param fsig=50e6
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control
save all

* Operating Point Analysis
op
remzerovec
write iqmod_spdt_switch_tb_tran.raw
set appendwrite

* Transient Analysis
tran 1n 100n
write iqmod_spdt_switch_tb_tran.raw

plot vout_b_spdt_ca vout_a_spdt_ca vin_spdt
plot vout_b_spdt_cb vout_a_spdt_cb vin_spdt

*quit
.endc"}
C {devices/vsource.sym} 800 -550 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 800 -480 0 0 {name=l6 lab=GND}
C {devices/vdd.sym} 800 -620 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1080 -1340 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} 1040 -1480 0 0 {name=p3 sig_type=std_logic lab=vin_spdt}
C {devices/vsource.sym} 1080 -1410 0 1 {name=vsine value="sin(\{Vcm\} \{VDD/2\} 1k)"
spice_ignore=true}
C {devices/capa.sym} 1280 -830 0 0 {name=C2
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1100 -760 0 0 {name=l11 lab=GND}
C {devices/gnd.sym} 1280 -760 0 0 {name=l12 lab=GND}
C {iqmod_spdt_switch_pex.sym} 1080 -1000 0 0 {name=x1}
C {iqmod_spdt_switch_pex.sym} 1080 -580 0 0 {name=x2}
C {devices/code_shown.sym} 2020 -1390 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {devices/launcher.sym} 1700 -1260 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/gnd.sym} 1180 -1340 0 0 {name=l14 lab=GND}
C {devices/vsource.sym} 1180 -1410 0 0 {name=vpulse value="pulse(0 \{VDD\} 0 10p 10p \{0.50/fsig\} \{1/fsig\})"}
C {res.sym} 1180 -830 0 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {res.sym} 1360 -830 0 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1360 -760 0 0 {name=l9 lab=GND}
C {devices/gnd.sym} 1180 -760 0 0 {name=l17 lab=GND}
C {devices/capa.sym} 1100 -410 0 0 {name=C3
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1280 -410 0 0 {name=C4
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1100 -340 0 0 {name=l15 lab=GND}
C {devices/gnd.sym} 1280 -340 0 0 {name=l16 lab=GND}
C {res.sym} 1180 -410 0 0 {name=R3
value=100k
footprint=1206
device=resistor
m=1}
C {res.sym} 1360 -410 0 0 {name=R4
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1360 -340 0 0 {name=l18 lab=GND}
C {devices/gnd.sym} 1180 -340 0 0 {name=l19 lab=GND}
C {iqmod_spdt_switch_pex.sym} 400 -580 0 0 {name=x3
spice_ignore=true}
C {iqmod_spdt_switch.sym} 400 -780 0 0 {name=x4
spice_ignore=true}
