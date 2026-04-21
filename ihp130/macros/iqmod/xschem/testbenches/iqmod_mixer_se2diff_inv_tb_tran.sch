v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1520 -1000 2320 -600 {flags=graph
y1=-0.0013
y2=1.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=9.9495184e-08
x2=1.0670094e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="\\"Input; vin\\"
\\"Output; vout\\""
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3}
T {Testbench for transient analysis - LV Inverter} 640 -1690 0 0 1 1 {}
N 1380 -660 1380 -620 {
lab=GND}
N 900 -800 900 -740 {
lab=vin}
N 900 -680 900 -620 {
lab=GND}
N 1180 -760 1180 -620 {
lab=GND}
N 1260 -800 1380 -800 {
lab=vout}
N 1380 -800 1380 -720 {
lab=vout}
N 740 -680 740 -620 {
lab=GND}
N 880 -800 900 -800 {
lab=vin}
N 1380 -800 1400 -800 {
lab=vout}
N 740 -800 740 -740 {
lab=VDD}
N 1180 -980 1180 -840 {
lab=VDD}
N 900 -800 1120 -800 {lab=vin}
C {devices/code_shown.sym} 140 -1170 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../verification/pex/iqmod_mixer_se2diff_inv_NF54_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control
save all

* Operating Point Analysis
op
remzerovec
write iqmod_mixer_se2diff_inv_tb_tran.raw
set appendwrite

* Transient Analysis
tran 100p 400n
write iqmod_mixer_se2diff_inv_tb_tran.raw

quit
.endc
"}
C {devices/gnd.sym} 1380 -620 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 740 -710 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 740 -620 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 1180 -620 0 0 {name=l4 lab=GND}
C {devices/launcher.sym} 1580 -1170 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {lab_pin.sym} 880 -800 0 0 {name=p2 sig_type=std_logic lab=vin}
C {devices/vsource.sym} 900 -710 0 0 {name=vin value="pulse(0, \{VDD\}, 0, 1n, 1n, 100n, 200n)"}
C {devices/capa.sym} 1380 -690 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 900 -620 0 0 {name=l5 lab=GND}
C {vdd.sym} 1180 -980 0 0 {name=l6 lab=VDD}
C {lab_pin.sym} 1400 -800 0 1 {name=p1 sig_type=std_logic lab=vout}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1580 -1050 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1580 -1110 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 740 -800 0 0 {name=l7 lab=VDD}
C {devices/code_shown.sym} 1840 -1160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mixer_se2diff_inv_NF54.sym} 1180 -1160 0 0 {name=x1
spice_ignore=true}
C {iqmod_mixer_se2diff_inv_NF54_pex.sym} 1180 -1340 0 0 {name=x2
spice_ignore=true}
C {iqmod_mixer_se2diff_inv_NF54_pex.sym} 1180 -800 0 0 {name=x3
}
