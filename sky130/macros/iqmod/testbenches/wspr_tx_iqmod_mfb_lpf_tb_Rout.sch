v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -760 2440 -360 {flags=graph
y1=-180
y2=180
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
B 2 1640 -1180 2440 -780 {flags=graph
y1=-210
y2=-10
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
T {Testbench for AC Rout analysis - Third Order MFB Lowpass Filter} 410 -1720 0 0 1 1 {}
N 1040 -700 1040 -680 {lab=GND}
N 1060 -1120 1060 -1100 {lab=filter_ota_en}
N 840 -560 840 -520 {lab=VDD}
N 840 -460 840 -420 {lab=GND}
N 1040 -560 1040 -520 {lab=filter_ota_en}
N 1040 -460 1040 -420 {lab=GND}
N 1500 -520 1500 -500 {
lab=vout}
N 1430 -490 1460 -490 {
lab=voutp}
N 1430 -450 1460 -450 {
lab=voutn}
N 1500 -440 1500 -420 {lab=GND}
N 1020 -1120 1020 -1100 {lab=VDD}
N 780 -940 820 -940 {lab=vinp}
N 780 -860 820 -860 {lab=vinn}
N 1340 -880 1340 -800 {lab=voutn}
N 1340 -740 1340 -680 {lab=GND}
N 1440 -740 1440 -680 {lab=GND}
N 1440 -920 1440 -800 {lab=voutp}
N 1260 -880 1300 -880 {lab=voutn}
N 1260 -920 1400 -920 {lab=voutp}
N 1400 -920 1500 -920 {lab=voutp}
N 1300 -880 1500 -880 {lab=voutn}
N 860 -1410 880 -1410 {lab=vin}
N 880 -1410 880 -1390 {lab=vin}
N 1100 -1440 1140 -1440 {lab=vinp}
N 1100 -1360 1140 -1360 {lab=vinn}
N 1220 -1420 1220 -1380 {lab=Vcm}
N 880 -1410 940 -1410 {lab=vin}
N 1100 -1400 1220 -1400 {lab=Vcm}
N 1220 -1320 1220 -1300 {lab=GND}
N 880 -1330 880 -1300 {lab=GND}
N 990 -1330 990 -1300 {lab=GND}
C {devices/code_shown.sym} 40 -1350 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/wspr_tx_iqmod_mfb_lpf_pex.spice
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
*.param W_long=18.0
*.param W_short=12.0
*.param a=3
*.param L=1.0
*.param NF_long=6
*.param NF_short=4
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
write wspr_tx_iqmod_mfb_lpf_tb_Rout.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write wspr_tx_iqmod_mfb_lpf_tb_Rout.raw
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
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_iqmod_mfb_lpf_tb_Rout.txt v(Amag_dB) v(Aarg)

*quit
.endc
"}
C {devices/vsource.sym} 840 -490 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 840 -420 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1700 -1360 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1240 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1700 -1300 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 840 -560 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1020 -1120 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1040 -680 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1500 -920 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1500 -880 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 780 -940 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 780 -860 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/lab_pin.sym} 1060 -1120 2 0 {name=l24 sig_type=std_logic lab=filter_ota_en}
C {devices/gnd.sym} 1040 -420 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} 1040 -560 2 0 {name=l35 sig_type=std_logic lab=filter_ota_en}
C {devices/vsource.sym} 1040 -490 0 0 {name=Ven value=\{VDD\}}
C {devices/lab_pin.sym} 1500 -520 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1500 -470 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1500 -420 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1430 -450 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1430 -490 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {sky130_fd_pr/corner.sym} 1930 -1340 0 0 {name=CORNER only_toplevel=false corner=tt}
C {res.sym} 1340 -770 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 1440 -770 0 0 {name=R2
value=1k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1440 -680 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1340 -680 0 0 {name=l16 lab=GND}
C {wspr_tx_iqmod_mfb_lpf_gen.sym} 2820 -1200 0 0 {name=x1
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf.sym} 1040 -900 0 0 {name=x4
spice_ignore=false}
C {devices/lab_pin.sym} 1140 -1440 0 1 {name=l10 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1140 -1360 0 1 {name=l11 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 1220 -1350 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 860 -1410 0 0 {name=l17 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1220 -1420 2 0 {name=l18 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 880 -1300 0 0 {name=l20 lab=GND}
C {devices/gnd.sym} 1220 -1300 0 0 {name=l21 lab=GND}
C {devices/gnd.sym} 990 -1300 0 0 {name=l22 lab=GND}
C {devices/vsource.sym} 880 -1360 0 0 {name=vin value="dc 0 ac 1"
}
C {single2dm.sym} 1020 -1400 0 0 {name=x7}
