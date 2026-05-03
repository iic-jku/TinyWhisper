v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1620 -700 2420 -300 {flags=graph
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
node="\\"I Phase; ph(vout_I)\\"
\\"Q Phase; ph(vout_Q)\\""
color="4 21"
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1620 -1120 2420 -720 {flags=graph
y1=-270
y2=-0.45
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
node="\\"I Magnitude; vout_I vin / db20()\\"
\\"Q Magnitude; vout_Q vin / db20()\\""
color="4 21"
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 1060 -400 1060 -300 1260 -300 1260 -400 1060 -400 {dash = 8}
P 4 5 1060 -980 1060 -880 1260 -880 1260 -980 1060 -980 {dash = 8}
T {Testbench for AC analysis - Third Order MFB Lowpass Filter (in IQ Modulator)} 240 -1720 0 0 1 1 {}
T {I = '1'} 980 -1090 0 0 0.3 0.3 {}
T {Ix = '1'} 980 -990 0 0 0.3 0.3 {}
T {Qx = '1'} 980 -510 0 0 0.3 0.3 {}
T {Capacitive Load} 950 -315 0 0 0.25 0.25 {}
T {Q = '1'} 980 -410 0 0 0.3 0.3 {}
T {Capacitive Load} 950 -895 0 0 0.25 0.25 {}
N 820 -1540 820 -1500 {lab=VDD}
N 820 -1440 820 -1400 {lab=GND}
N 560 -1260 560 -1240 {lab=VDD}
N 560 -240 560 -220 {lab=GND}
N 180 -500 220 -500 {lab=vinn}
N 180 -360 220 -360 {lab=vinp}
N 180 -1120 220 -1120 {lab=vinp}
N 180 -980 220 -980 {lab=vinn}
N 200 -1510 220 -1510 {lab=vin}
N 220 -1510 220 -1490 {lab=vin}
N 440 -1540 480 -1540 {lab=vinp}
N 440 -1460 480 -1460 {lab=vinn}
N 220 -1510 280 -1510 {lab=vin}
N 220 -1430 220 -1400 {lab=GND}
N 330 -1430 330 -1400 {lab=GND}
N 560 -1500 560 -1480 {lab=Vcm}
N 440 -1500 560 -1500 {lab=Vcm}
N 560 -1420 560 -1400 {lab=GND}
N 560 -1520 560 -1500 {lab=Vcm}
N 900 -1060 1200 -1060 {lab=voutp_I}
N 900 -1000 1100 -1000 {lab=voutn_I}
N 1200 -480 1240 -480 {lab=voutn_Q}
N 900 -420 1100 -420 {lab=voutp_Q}
N 100 -840 220 -840 {lab=VDD}
N 300 -1260 300 -1240 {lab=VDD}
N 1430 -950 1460 -950 {
lab=voutp_I}
N 1430 -910 1460 -910 {
lab=voutn_I}
N 1500 -1000 1500 -960 {lab=vout_I}
N 1500 -900 1500 -860 {lab=GND}
N 1430 -370 1460 -370 {
lab=voutp_Q}
N 1430 -330 1460 -330 {
lab=voutn_Q}
N 1500 -420 1500 -380 {lab=vout_Q}
N 1500 -320 1500 -280 {lab=GND}
N 1100 -420 1240 -420 {lab=voutp_Q}
N 1100 -420 1100 -380 {lab=voutp_Q}
N 1100 -320 1100 -280 {lab=GND}
N 1200 -320 1200 -280 {lab=GND}
N 1200 -480 1200 -380 {lab=voutn_Q}
N 900 -480 1200 -480 {lab=voutn_Q}
N 1200 -1060 1240 -1060 {lab=voutp_I}
N 1100 -1000 1240 -1000 {lab=voutn_I}
N 1100 -1000 1100 -960 {lab=voutn_I}
N 1100 -900 1100 -860 {lab=GND}
N 1200 -900 1200 -860 {lab=GND}
N 1200 -1060 1200 -960 {lab=voutp_I}
N 100 -640 220 -640 {lab=VDD}
N 100 -720 100 -640 {lab=VDD}
N 100 -760 220 -760 {lab=VDD}
N 100 -840 100 -760 {lab=VDD}
N 100 -720 220 -720 {lab=VDD}
N 100 -760 100 -720 {lab=VDD}
N 180 -400 220 -400 {lab=#net1}
N 180 -540 220 -540 {lab=#net2}
N 180 -940 220 -940 {lab=#net3}
N 180 -1080 220 -1080 {lab=#net4}
N 100 -1160 100 -840 {lab=VDD}
N 100 -1160 220 -1160 {lab=VDD}
N 100 -1260 100 -1160 {lab=VDD}
N 100 -320 220 -320 {lab=VDD}
N 100 -640 100 -320 {lab=VDD}
C {devices/code.sym} 1630 -1500 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_top_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu reltol=1e-3 abstol=1e-12 gmin=1e-12 rshunt=1e12
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
write @schname\\\\.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write @schname\\\\.raw
set appendwrite

* Plotting
let Amag = v(vout_I)/v(vin)		
let Amag_dB = vdb(Amag)
let Aarg = 180/PI*cphase(Amag)

plot Amag_dB ylabel 'Magnitude'
plot Aarg ylabel 'Phase'
plot Amag_dB Aarg ylabel 'Magnitude, Phase'

* Measurements
meas ac Adc_cl_dB find Amag_dB when frequency = fdc
print Adc_cl_dB

let Amag_fc = Adc_cl_dB-3
meas ac fcu find frequency when Amag_dB = Amag_fc FALL=1
print fcu

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_top_tb_ac.txt v(Amag_dB) v(Aarg)

*quit
.endc
"}
C {devices/vsource.sym} 820 -1470 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 820 -1400 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1680 -1300 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1680 -1180 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1680 -1240 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 820 -1540 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 180 -1120 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 180 -980 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 560 -1450 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/vsource.sym} 220 -1460 0 0 {name=vin value="dc 0 ac 1"
}
C {vdd.sym} 560 -1260 0 0 {name=l4 lab=VDD}
C {devices/gnd.sym} 560 -220 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 180 -360 0 0 {name=l6 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 180 -500 0 0 {name=l8 sig_type=std_logic lab=vinn
}
C {devices/code_shown.sym} 1960 -1290 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {lab_pin.sym} 200 -1510 2 1 {name=p5 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 480 -1540 2 0 {name=l18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 480 -1460 0 1 {name=l20 sig_type=std_logic lab=vinn
}
C {devices/gnd.sym} 220 -1400 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 330 -1400 0 0 {name=l25 lab=GND}
C {devices/lab_pin.sym} 560 -1520 2 0 {name=l21 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 560 -1400 0 0 {name=l23 lab=GND}
C {iqmod_top.sym} 2920 -1560 0 0 {name=x1
spice_ignore=true}
C {iqmod_top_pex.sym} 2920 -520 0 0 {name=x2
spice_ignore=true}
C {vdd.sym} 100 -1260 0 0 {name=l10 lab=VDD}
C {vdd.sym} 300 -1260 0 0 {name=l11 lab=VDD}
C {devices/lab_pin.sym} 1500 -1000 0 1 {name=l13 sig_type=std_logic lab=vout_I}
C {devices/vcvs.sym} 1500 -930 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1500 -860 0 0 {name=l15 lab=GND}
C {devices/lab_pin.sym} 1430 -910 2 1 {name=l16 sig_type=std_logic lab=voutn_I
}
C {devices/lab_pin.sym} 1430 -950 0 0 {name=l17 sig_type=std_logic lab=voutp_I
}
C {devices/lab_pin.sym} 1500 -420 0 1 {name=l31 sig_type=std_logic lab=vout_Q}
C {devices/vcvs.sym} 1500 -350 0 0 {name=E2 value=1}
C {devices/gnd.sym} 1500 -280 0 0 {name=l32 lab=GND}
C {devices/lab_pin.sym} 1430 -330 2 1 {name=l33 sig_type=std_logic lab=voutn_Q
}
C {devices/lab_pin.sym} 1430 -370 0 0 {name=l34 sig_type=std_logic lab=voutp_Q
}
C {devices/gnd.sym} 1100 -280 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 1100 -350 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1240 -420 0 1 {name=p3 sig_type=std_logic lab=voutp_Q}
C {lab_pin.sym} 1240 -480 0 1 {name=p4 sig_type=std_logic lab=voutn_Q}
C {devices/capa.sym} 1200 -350 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1200 -280 0 0 {name=l30 lab=GND}
C {devices/gnd.sym} 1100 -860 0 0 {name=l12 lab=GND}
C {devices/capa.sym} 1100 -930 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1240 -1060 0 1 {name=p1 sig_type=std_logic lab=voutp_I}
C {lab_pin.sym} 1240 -1000 0 1 {name=p2 sig_type=std_logic lab=voutn_I}
C {devices/capa.sym} 1200 -930 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1200 -860 0 0 {name=l24 lab=GND}
C {noconn.sym} 180 -400 0 0 {name=l9}
C {noconn.sym} 180 -540 0 0 {name=l26}
C {noconn.sym} 180 -940 0 0 {name=l27}
C {noconn.sym} 180 -1080 0 0 {name=l28}
C {iqmod_top_pex.sym} 560 -740 0 0 {name=x3
}
C {single2dm.sym} 360 -1500 0 0 {name=x6 gain=1}
