v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1420 2440 -1020 {flags=graph
y1=-0.0028
y2=-0.0026
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=0.005
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
color="4 21 10"
node="i(VDD)
\\"X1.X1.M1[ID]\\"; i(@m.x1.x1.xm1.msky130_fd_pr__pfet_01v8_lvt[id])
\\"X1.X1.M2[ID]\\"; i(@m.x1.x1.xm2.msky130_fd_pr__nfet_01v8_lvt[id])"}
B 2 1640 -1000 2440 -600 {flags=graph
y1=0.57
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=0.005
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vinp
vinn
voutp
voutn"
color="4 18 21 12"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 1640 -580 2440 -180 {flags=graph
y1=-0.63
y2=0.63
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=0.005
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vind
vout"
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
P 4 5 1300 -380 1300 -280 1500 -280 1500 -380 1300 -380 {dash = 8}
T {Testbench for transient analysis - OTA Core} 740 -1730 0 0 1 1 {}
T {Capacitive Load} 1300 -230 0 0 0.25 0.25 {}
N 920 -460 960 -460 {lab=vinp}
N 920 -380 960 -380 {lab=vinn}
N 1060 -540 1060 -520 {lab=ota_core_en}
N 1040 -920 1040 -880 {lab=VDD}
N 1040 -820 1040 -780 {lab=GND}
N 1200 -920 1200 -880 {lab=ota_core_en}
N 1200 -820 1200 -780 {lab=GND}
N 1440 -640 1440 -620 {
lab=vout}
N 1370 -610 1400 -610 {
lab=voutp}
N 1370 -570 1400 -570 {
lab=voutn}
N 1440 -560 1440 -540 {lab=GND}
N 1040 -560 1040 -520 {lab=VDD}
N 1040 -320 1040 -260 {lab=GND}
N 1440 -440 1480 -440 {lab=voutn}
N 1340 -400 1480 -400 {lab=voutp}
N 1340 -400 1340 -360 {lab=voutp}
N 1140 -400 1340 -400 {lab=voutp}
N 1340 -300 1340 -260 {lab=GND}
N 1440 -440 1440 -360 {lab=voutn}
N 1140 -440 1440 -440 {lab=voutn}
N 1440 -300 1440 -260 {lab=GND}
N 380 -430 380 -410 {lab=vin}
N 600 -460 640 -460 {lab=vinp}
N 600 -380 640 -380 {lab=vinn}
N 720 -440 720 -400 {lab=Vcm}
N 380 -430 440 -430 {lab=vin}
N 600 -420 720 -420 {lab=Vcm}
N 720 -340 720 -320 {lab=GND}
N 380 -350 380 -320 {lab=GND}
N 490 -350 490 -320 {lab=GND}
N 260 -350 260 -320 {lab=GND}
N 260 -430 260 -410 {lab=vin}
N 260 -430 380 -430 {lab=vin}
N 200 -430 260 -430 {lab=vin}
C {devices/code_shown.sym} 40 -1630 0 0 {name=NGSPICE
only_toplevel=true 
value="
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.param W_long=18.0
.param W_short=12.0
.param a=3
.param L=1.0
.param NF_long=6
.param NF_short=4
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* save vind vinp vinn voutp voutn vout
save all

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mfb_lpf_ota_core_tb_tran.raw
set appendwrite

* Transient Analysis
* Sine Input
tran 1u 5m
* Pulse Input
* tran 500n 1m
write wspr_tx_iqmod_mfb_lpf_ota_core_tb_tran.raw

* Plotting
plot vinp vinn voutp voutn
plot vind vout
* plot i(VDD)

* Measurements
meas tran vin_peak MAX v(vind)
meas tran vout_peak MAX v(vout)

let Adm = vout_peak / vin_peak
let Adm_dB = vdb(Adm)
print Adm_dB

meas tran vout_pp_max MAX v(voutp)
meas tran vout_pp_min MIN v(voutp)
let vout_pp = vout_pp_max - vout_pp_min
print vout_pp

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_iqmod_mfb_lpf_ota_core_tb_tran.txt v(vind) v(vout) v(vinp) v(vinn) v(voutp) v(voutn)

*quit
.endc
"}
C {devices/launcher.sym} 1700 -1590 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1470 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1700 -1530 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1340 -260 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1040 -850 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1040 -780 0 0 {name=l3 lab=GND}
C {devices/capa.sym} 1340 -330 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1040 -920 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1040 -560 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1040 -260 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1480 -400 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1480 -440 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 920 -460 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 920 -380 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/lab_pin.sym} 1060 -540 2 0 {name=l24 sig_type=std_logic lab=ota_core_en}
C {devices/capa.sym} 1440 -330 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1440 -260 0 0 {name=l30 lab=GND}
C {devices/gnd.sym} 1200 -780 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} 1440 -640 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1440 -590 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1440 -540 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1370 -570 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1370 -610 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {devices/lab_pin.sym} 1200 -920 2 0 {name=l13 sig_type=std_logic lab=ota_core_en}
C {devices/vsource.sym} 1200 -850 0 0 {name=Ven value=\{VDD\}}
C {devices/vsource.sym} 260 -380 0 1 {name=vpulse spice_ignore=True value="pulse(-1.5 1.5 0 10p 10p 100u 500u)"
}
C {devices/vsource.sym} 380 -380 0 1 {name=vsine spice_ignore=False value="sin(0 20m 1k)"
}
C {devices/gnd.sym} 260 -320 0 0 {name=l17 lab=GND}
C {devices/vsource.sym} 720 -370 0 0 {name=Vcm value=\{Vcm\}
}
C {sky130_fd_pr/corner.sym} 1960 -1570 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/lab_pin.sym} 640 -460 2 0 {name=l18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 640 -380 0 1 {name=l21 sig_type=std_logic lab=vinn
}
C {devices/lab_pin.sym} 200 -430 0 0 {name=l22 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 720 -440 2 0 {name=l25 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 380 -320 0 0 {name=l26 lab=GND}
C {devices/gnd.sym} 720 -320 0 0 {name=l27 lab=GND}
C {devices/gnd.sym} 490 -320 0 0 {name=l28 lab=GND}
C {single2dm.sym} 520 -420 0 0 {name=x7}
C {wspr_tx_iqmod_mfb_lpf_ota_core_gen.sym} 2660 -740 0 0 {name=x1 W_long=\{W_long\} W_short=\{W_short\} a=\{a\} L=\{L\} NF_long=\{NF_long\} NF_short=\{NF_short\}
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1040 -420 0 0 {name=x4
spice_ignore=false}
