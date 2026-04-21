v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -600 2460 -200 {flags=graph
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
B 2 1660 -1020 2460 -620 {flags=graph
y1=-250
y2=-6.1
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
T {Testbench for AC CL analysis - Third Order MFB Lowpass Filter (in IQ Modulator)} 240 -1720 0 0 1 1 {}
N 1560 -1280 1560 -1240 {lab=VDD}
N 1560 -1180 1560 -1140 {lab=GND}
N 1560 -780 1560 -700 {lab=vout}
N 1560 -640 1560 -560 {lab=GND}
N 1340 -1280 1340 -1260 {lab=VDD}
N 1340 -300 1340 -280 {lab=GND}
N 660 -1180 740 -1180 {lab=VDD}
N 660 -1280 660 -1180 {lab=VDD}
N 1520 -780 1560 -780 {lab=vout}
N 1560 -780 1600 -780 {lab=vout}
N 700 -520 740 -520 {lab=vinp}
N 700 -460 740 -460 {lab=vinn}
N 700 -1100 740 -1100 {lab=vinp}
N 700 -1040 740 -1040 {lab=vinn}
N 660 -900 740 -900 {lab=VDD}
N 660 -940 660 -900 {lab=VDD}
N 660 -840 740 -840 {lab=GND}
N 660 -840 660 -800 {lab=GND}
N 660 -720 740 -720 {lab=GND}
N 660 -660 660 -620 {lab=GND}
N 660 -660 740 -660 {lab=GND}
N 660 -720 660 -660 {lab=GND}
N 1540 -1530 1560 -1530 {lab=vin}
N 1560 -1530 1560 -1510 {lab=vin}
N 1780 -1560 1820 -1560 {lab=vinp}
N 1780 -1480 1820 -1480 {lab=vinn}
N 1560 -1530 1620 -1530 {lab=vin}
N 1560 -1450 1560 -1420 {lab=GND}
N 1670 -1450 1670 -1420 {lab=GND}
N 1900 -1520 1900 -1500 {lab=Vcm}
N 1780 -1520 1900 -1520 {lab=Vcm}
N 1900 -1440 1900 -1420 {lab=GND}
N 1900 -1540 1900 -1520 {lab=Vcm}
C {devices/code_shown.sym} 40 -1510 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/wspr_tx_iqmod_top_pex.spice
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 1
let f_max = 1G
let fdc = 10

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_top_tb_ac.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write wspr_tx_iqmod_top_tb_ac.raw
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

*quit
.endc
"}
C {devices/vsource.sym} 1560 -1210 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1560 -1140 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1720 -1200 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/capa.sym} 1560 -670 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1080 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1720 -1140 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 1560 -1280 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 700 -1100 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 700 -1040 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/lab_pin.sym} 1600 -780 0 1 {name=l12 sig_type=std_logic lab=vout}
C {sky130_fd_pr/corner.sym} 1950 -1180 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/gnd.sym} 1560 -560 0 0 {name=l1 lab=GND}
C {vdd.sym} 1340 -1280 0 0 {name=l4 lab=VDD}
C {devices/gnd.sym} 1340 -280 0 0 {name=l14 lab=GND}
C {vdd.sym} 660 -1280 0 0 {name=l15 lab=VDD}
C {devices/lab_pin.sym} 700 -520 0 0 {name=l6 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 700 -460 0 0 {name=l8 sig_type=std_logic lab=vinn
}
C {vdd.sym} 660 -940 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 660 -620 0 0 {name=l16 lab=GND}
C {devices/gnd.sym} 660 -800 0 0 {name=l17 lab=GND}
C {wspr_tx_iqmod_top.sym} 1120 -780 0 0 {name=x1
spice_ignore=false}
C {wspr_tx_iqmod_top_pex.sym} 3000 -540 0 0 {name=x2
spice_ignore=true}
C {devices/vsource.sym} 1900 -1470 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/vsource.sym} 1560 -1480 0 0 {name=vin value="dc 0 ac 1"
}
C {lab_pin.sym} 1540 -1530 2 1 {name=p5 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1820 -1560 2 0 {name=l18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1820 -1480 0 1 {name=l20 sig_type=std_logic lab=vinn
}
C {devices/gnd.sym} 1560 -1420 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 1670 -1420 0 0 {name=l25 lab=GND}
C {single2dm.sym} 1700 -1520 0 0 {name=x7}
C {devices/lab_pin.sym} 1900 -1540 2 0 {name=l21 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 1900 -1420 0 0 {name=l23 lab=GND}
