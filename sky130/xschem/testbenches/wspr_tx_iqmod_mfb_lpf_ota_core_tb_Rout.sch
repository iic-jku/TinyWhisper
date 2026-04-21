v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -800 2440 -400 {flags=graph
y1=-110
y2=-1.3e-06
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=9
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"CL Phase; ph(vout)\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1640 -1220 2440 -820 {flags=graph
y1=-3.7
y2=24
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
x2=9
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"CL Magnitude; vout vin / db20()\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
T {Testbench for AC Rout analysis - OTA Core} 630 -1720 0 0 1 1 {}
N 840 -600 840 -560 {lab=VDD}
N 840 -500 840 -460 {lab=GND}
N 1040 -600 1040 -560 {lab=ota_core_en}
N 1040 -500 1040 -460 {lab=GND}
N 1500 -560 1500 -540 {
lab=vout}
N 1430 -530 1460 -530 {
lab=voutp}
N 1430 -490 1460 -490 {
lab=voutn}
N 1500 -480 1500 -460 {lab=GND}
N 1340 -920 1340 -840 {lab=voutp}
N 1340 -780 1340 -720 {lab=GND}
N 1440 -780 1440 -720 {lab=GND}
N 1440 -960 1440 -840 {lab=voutn}
N 1080 -1060 1080 -1040 {lab=ota_core_en}
N 1060 -1080 1060 -1040 {lab=VDD}
N 1060 -840 1060 -780 {lab=GND}
N 1160 -920 1340 -920 {lab=voutp}
N 1440 -960 1500 -960 {lab=voutn}
N 1160 -960 1440 -960 {lab=voutn}
N 1340 -920 1500 -920 {lab=voutp}
N 900 -980 980 -980 {lab=vinp}
N 900 -900 980 -900 {lab=vinn}
N 900 -1350 920 -1350 {lab=vin}
N 920 -1350 920 -1330 {lab=vin}
N 1140 -1380 1180 -1380 {lab=vinp}
N 1140 -1300 1180 -1300 {lab=vinn}
N 1260 -1360 1260 -1320 {lab=Vcm}
N 920 -1350 980 -1350 {lab=vin}
N 1140 -1340 1260 -1340 {lab=Vcm}
N 1260 -1260 1260 -1240 {lab=GND}
N 920 -1270 920 -1240 {lab=GND}
N 1030 -1270 1030 -1240 {lab=GND}
C {devices/code_shown.sym} 40 -1370 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param W_long=18.0
.param W_short=12.0
.param a=3
.param L=1.0
.param NF_long=6
.param NF_short=4
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

save all

* User Constants
let f_min = 1
let f_max = 1G
let fdc = 10

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mfb_lpf_ota_core_tb_Rout.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write wspr_tx_iqmod_mfb_lpf_ota_core_tb_Rout.raw
set appendwrite

* Plotting
let Amag = v(vout)/v(vin)		
let Amag_dB = vdb(Amag)
let Aarg = 180/PI*cphase(Amag)

plot Amag_dB ylabel 'Magnitude'
plot Aarg ylabel 'Phase'
plot Amag_dB Aarg ylabel 'Magnitude, Phase'

* Measurements
meas ac Adc_cl_dB find Amag_dB when frequency = fdc
print Adc_cl_dB

let Amag_fc = Adc_cl_dB-3
* meas ac fcl find frequency when Amag_dB = Amag_fc RISE=1
* print fcl

meas ac fcu find frequency when Amag_dB = Amag_fc FALL=1
print fcu

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_iqmod_mfb_lpf_ota_core_tb_Rout.txt v(Amag_dB) v(Aarg)

*quit
.endc
"}
C {devices/vsource.sym} 840 -530 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 840 -460 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1700 -1400 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1280 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1700 -1340 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 840 -600 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 1500 -920 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1500 -960 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 900 -980 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 900 -900 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/gnd.sym} 1040 -460 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} 1040 -530 0 0 {name=Ven value=\{VDD\}}
C {devices/lab_pin.sym} 1500 -560 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1500 -510 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1500 -460 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1430 -490 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1430 -530 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {sky130_fd_pr/corner.sym} 1930 -1380 0 0 {name=CORNER only_toplevel=false corner=tt}
C {res.sym} 1340 -810 0 0 {name=R1
value=20k
footprint=1206
device=resistor
m=1}
C {res.sym} 1440 -810 0 0 {name=R2
value=20k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1440 -720 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1340 -720 0 0 {name=l16 lab=GND}
C {vdd.sym} 1060 -1080 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1060 -780 0 0 {name=l9 lab=GND}
C {devices/lab_pin.sym} 1080 -1060 2 0 {name=l24 sig_type=std_logic lab=ota_core_en}
C {devices/lab_pin.sym} 1040 -600 2 0 {name=l1 sig_type=std_logic lab=ota_core_en}
C {wspr_tx_iqmod_mfb_lpf_ota_core_gen.sym} 2660 -740 0 0 {name=x1 W_long=\{W_long\} W_short=\{W_short\} a=\{a\} L=\{L\} NF_long=\{NF_long\} NF_short=\{NF_short\}
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1060 -940 0 0 {name=x4
spice_ignore=false}
C {devices/lab_pin.sym} 1180 -1380 2 0 {name=l10 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1180 -1300 0 1 {name=l11 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 1260 -1290 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/vsource.sym} 920 -1300 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 900 -1350 0 0 {name=l18 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1260 -1360 2 0 {name=l20 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 920 -1240 0 0 {name=l21 lab=GND}
C {devices/gnd.sym} 1260 -1240 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 1030 -1240 0 0 {name=l25 lab=GND}
C {single2dm.sym} 1060 -1340 0 0 {name=x7}
