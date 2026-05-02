v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1600 -1000 2400 -600 {flags=graph
y1=-0.00013
y2=1.9
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=4e-07
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
T {Testbench for transient analysis - Parameterizable LV Inverter} 420 -1710 0 0 1 1 {}
N 1420 -660 1420 -620 {
lab=GND}
N 940 -800 940 -740 {
lab=vin}
N 940 -680 940 -620 {
lab=GND}
N 1220 -760 1220 -620 {
lab=GND}
N 1300 -800 1420 -800 {
lab=vout}
N 1420 -800 1420 -720 {
lab=vout}
N 1000 -800 1160 -800 {
lab=vin}
N 780 -680 780 -620 {
lab=GND}
N 920 -800 940 -800 {
lab=vin}
N 1420 -800 1440 -800 {
lab=vout}
N 780 -800 780 -740 {
lab=VDD}
N 1220 -980 1220 -840 {
lab=VDD}
N 940 -800 1000 -800 {lab=vin}
C {devices/code_shown.sym} 120 -1170 0 0 {name=NGSPICE
only_toplevel=true 
value="
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param Cload=1p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control
save all

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_tb_tran.raw
set appendwrite

* Transient Analysis
tran 100p 400n
write wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_tb_tran.raw

quit
.endc
"}
C {devices/gnd.sym} 1420 -620 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 780 -710 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 780 -620 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 1220 -620 0 0 {name=l4 lab=GND}
C {devices/launcher.sym} 1660 -1170 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {lab_pin.sym} 920 -800 0 0 {name=p2 sig_type=std_logic lab=vin}
C {devices/vsource.sym} 940 -710 0 0 {name=vin value="pulse(0, \{VDD\}, 0, 1n, 1n, 100n, 200n)"}
C {devices/capa.sym} 1420 -690 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 940 -620 0 0 {name=l5 lab=GND}
C {vdd.sym} 1220 -980 0 0 {name=l6 lab=VDD}
C {lab_pin.sym} 1440 -800 0 1 {name=p1 sig_type=std_logic lab=vout}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1660 -1110 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 780 -800 0 0 {name=l7 lab=VDD}
C {sky130_fd_pr/corner.sym} 1900 -1150 0 0 {name=CORNER only_toplevel=false corner=tt}
C {wspr_tx_iqmod_mfb_lpf_ota_core_inv_lv_gen.sym} 1220 -800 0 0 {name=x1 W_P=3.0 L_P=0.35 NF_P=1 W_N=1.0 L_N=0.35 NF_N=1}
C {devices/launcher.sym} 1660 -1050 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
