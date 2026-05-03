v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1430 2440 -1030 {flags=graph
y1=0
y2=1.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=3.5674685e-08
x2=3.594972e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin_LO
x3.vse
x3.vcrossn
x3.vcrossp
x3.vscale1p
x3.vscale1n
x3.vscale2p
x3.vscale2n"
color="4 7 12 18 21 17 9 4"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3}
B 2 1640 -1010 2440 -610 {flags=graph
y1=-0.034
y2=1.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=3.5674685e-08
x2=3.594972e-08
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
B 2 1640 -580 2440 -180 {flags=graph
y1=-0.035
y2=0.0012
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=3.5674685e-08
x2=3.594972e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=i(VDD)
color=4
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3}
T {Testbench for transient analysis - Single-Ended to Differential Converter} 280 -1710 0 0 1 1 {}
N 680 -800 680 -740 {
lab=GND}
N 680 -920 680 -860 {
lab=VDD}
N 880 -800 880 -740 {lab=GND}
N 1360 -380 1360 -340 {lab=GND}
N 1360 -500 1360 -440 {lab=#net1}
N 880 -920 880 -860 {lab=vin_LO}
N 1180 -460 1180 -420 {lab=vout_LO_inv}
N 1180 -580 1180 -540 {lab=vout_LO}
N 1160 -460 1160 -420 {lab=GND}
N 1160 -580 1160 -540 {lab=VDD}
N 960 -500 1100 -500 {lab=#net2}
N 960 -500 960 -450 {lab=#net2}
N 960 -390 960 -340 {lab=GND}
N 820 -920 880 -920 {lab=vin_LO}
N 1260 -500 1360 -500 {lab=#net1}
N 1360 -500 1480 -500 {lab=#net1}
N 1480 -500 1480 -440 {lab=#net1}
N 1480 -380 1480 -340 {lab=GND}
N 880 -920 980 -920 {lab=vin_LO}
N 1340 -940 1480 -940 {lab=vout_LO}
N 1340 -900 1480 -900 {lab=vout_LO_inv}
N 1160 -860 1160 -740 {lab=GND}
N 1160 -1020 1160 -980 {lab=VDD}
C {devices/code_shown.sym} 60 -1370 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mixer_se2diff_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param flo=28e6
.csparam flo=flo
.param Rload=1k
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control
save all

* User Constants
let tstop = 2*1/flo
let tstep = 0.01*1/flo

* Operating Point Analysis
op
remzerovec
write @schname\\\\.raw
set appendwrite

* Transient Analysis
tran $&tstep $&tstop
write @schname\\\\.raw

quit
.endc
"}
C {devices/vsource.sym} 680 -830 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 680 -740 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1700 -1600 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {lab_pin.sym} 820 -920 0 0 {name=p2 sig_type=std_logic lab=vin_LO}
C {devices/capa.sym} 1360 -410 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 880 -740 0 0 {name=l5 lab=GND}
C {lab_pin.sym} 1480 -900 0 1 {name=p1 sig_type=std_logic lab=vout_LO_inv}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1480 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1700 -1540 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 680 -920 0 0 {name=l7 lab=VDD}
C {devices/gnd.sym} 1160 -740 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1360 -340 0 0 {name=l1 lab=GND}
C {lab_pin.sym} 1480 -940 0 1 {name=p3 sig_type=std_logic lab=vout_LO}
C {devices/vsource.sym} 880 -830 0 0 {name=Vloi value="pulse(0 \{VDD\} 0 10p 10p \{0.25/flo\} \{1/flo\})"}
C {lab_pin.sym} 1180 -580 0 1 {name=p6 sig_type=std_logic lab=vout_LO}
C {devices/gnd.sym} 1160 -420 0 1 {name=l9 lab=GND}
C {vdd.sym} 1160 -580 0 0 {name=l11 lab=VDD}
C {devices/vsource.sym} 960 -420 0 1 {name=Vin value=\{Vcm\}}
C {devices/gnd.sym} 960 -340 0 0 {name=l8 lab=GND}
C {lab_pin.sym} 1180 -420 0 1 {name=p4 sig_type=std_logic lab=vout_LO_inv}
C {devices/code_shown.sym} 1980 -1600 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mixer_se2diff.sym} 1160 -1440 0 0 {name=x1
spice_ignore=true}
C {iqmod_mixer_se2diff_pex.sym} 1160 -1240 0 0 {name=x2
spice_ignore=true}
C {iqmod_mixer_tg.sym} 220 -420 0 0 {name=x4
spice_ignore=true}
C {iqmod_mixer_tg_pex.sym} 600 -420 0 0 {name=x5
spice_ignore=true}
C {iqmod_mixer_tg.sym} 1180 -500 0 0 {name=x6}
C {res.sym} 1480 -410 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1
spice_ignore=true}
C {devices/gnd.sym} 1480 -340 0 0 {name=l42 lab=GND}
C {vdd.sym} 1160 -1020 0 0 {name=l6 lab=VDD}
C {iqmod_mixer_se2diff_pex.sym} 1160 -920 0 0 {name=x3
}
