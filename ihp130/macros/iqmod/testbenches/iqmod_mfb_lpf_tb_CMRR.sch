v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -1020 2460 -620 {flags=graph
y1=-180
y2=180
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1
x2=9
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"DM Phase; ph(vout_dm)\\"
\\"CM Phase; ph(vout_cm)\\""
color="4 7"
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1660 -600 2460 -200 {flags=graph
y1=-120
y2=57
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-1
x2=9
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"CMRR; vout_dm vout_cm / db20()\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1660 -1440 2460 -1040 {flags=graph
y1=-270
y2=-0.45
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-1
x2=9
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"DM Gain; vout_dm vin / db20()\\"
\\"CM Gain; vout_cm vin / db20()\\""
color="4 7"
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 1320 -1080 1320 -980 1520 -980 1520 -1080 1320 -1080 {dash = 8}
P 4 5 1320 -340 1320 -240 1520 -240 1520 -340 1320 -340 {dash = 8}
T {Testbench for CMRR analysis - Third Order MFB Lowpass Filter} 410 -1740 0 0 1 1 {}
T {Capacitive Load} 1320 -930 0 0 0.25 0.25 {}
T {Capacitive Load} 1320 -390 0 0 0.25 0.25 {}
T {Output CM voltage: vout_cm = (voutp_cm + voutn_cm)/2} 1260 -550 0 0 0.2 0.2 {}
T {Output DM voltage: vout_dm = voutp_dm - voutn_dm} 1260 -1310 0 0 0.2 0.2 {}
N 180 -1130 200 -1130 {lab=vin}
N 1390 -1430 1420 -1430 {
lab=voutp_dm}
N 1390 -1390 1420 -1390 {
lab=voutn_dm}
N 1460 -1140 1500 -1140 {lab=voutp_dm}
N 1360 -1100 1500 -1100 {lab=voutn_dm}
N 1360 -1100 1360 -1060 {lab=voutn_dm}
N 1360 -1000 1360 -960 {lab=GND}
N 1460 -1140 1460 -1060 {lab=voutp_dm}
N 1460 -1000 1460 -960 {lab=GND}
N 1460 -1480 1460 -1440 {lab=vout_dm}
N 1460 -1380 1460 -1340 {lab=GND}
N 1220 -1100 1360 -1100 {lab=voutn_dm}
N 1220 -1140 1460 -1140 {lab=voutp_dm}
N 740 -420 780 -420 {lab=vinp2}
N 740 -340 780 -340 {lab=vinn2}
N 1460 -400 1500 -400 {lab=voutp_cm}
N 1360 -360 1500 -360 {lab=voutn_cm}
N 1360 -360 1360 -320 {lab=voutn_cm}
N 1360 -260 1360 -220 {lab=GND}
N 1460 -400 1460 -320 {lab=voutp_cm}
N 1460 -260 1460 -220 {lab=GND}
N 1220 -360 1360 -360 {lab=voutn_cm}
N 1220 -400 1460 -400 {lab=voutp_cm}
N 1460 -780 1460 -740 {lab=vout_cm}
N 1460 -680 1460 -600 {lab=GND}
N 1340 -620 1340 -600 {lab=GND}
N 1340 -690 1420 -690 {lab=#net1}
N 1340 -690 1340 -680 {lab=#net1}
N 1260 -630 1300 -630 {lab=GND}
N 1260 -630 1260 -600 {lab=GND}
N 1260 -670 1300 -670 {lab=voutn_cm}
N 1260 -730 1420 -730 {lab=voutp_cm}
N 200 -1130 200 -1110 {lab=vin}
N 420 -1160 460 -1160 {lab=vinp1}
N 420 -1080 460 -1080 {lab=vinn1}
N 540 -1120 540 -1100 {lab=Vcm}
N 310 -310 310 -290 {lab=GND}
N 420 -420 460 -420 {lab=vinp2}
N 420 -340 460 -340 {lab=vinn2}
N 420 -380 460 -380 {lab=Vcm}
N 220 -390 260 -390 {lab=vin}
N 200 -1130 260 -1130 {lab=vin}
N 420 -1120 540 -1120 {lab=Vcm}
N 540 -1040 540 -1020 {lab=GND}
N 200 -1050 200 -1020 {lab=GND}
N 310 -1050 310 -1020 {lab=GND}
N 1000 -920 1000 -880 {lab=GND}
N 980 -1340 980 -1320 {lab=VDD}
N 740 -1160 780 -1160 {lab=vinp1}
N 740 -1080 780 -1080 {lab=vinn1}
N 540 -1480 540 -1440 {lab=VDD}
N 540 -1380 540 -1340 {lab=GND}
N 980 -600 980 -580 {lab=VDD}
N 1000 -180 1000 -140 {lab=GND}
N 540 -1140 540 -1120 {lab=Vcm}
N 980 -1340 1020 -1340 {lab=VDD}
N 980 -1360 980 -1340 {lab=VDD}
N 1020 -1340 1020 -1320 {lab=VDD}
N 980 -600 1020 -600 {lab=VDD}
N 980 -620 980 -600 {lab=VDD}
N 1020 -600 1020 -580 {lab=VDD}
C {devices/code.sym} 70 -1580 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.param vphi=0.5
.param f_min = 10m
.csparam f_min = f_min
.param f_max = 1G
.csparam f_max = f_max
.param fdc = 10
.csparam fdc = fdc
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-12 gmin=1e-12 rshunt=1e12
.control

* save v(vout_dm) v(vout_cm) v(vin)
save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 0.1
let f_max = 1G
let fdc = 1

* Operating Point Analysis
op
remzerovec
write @schname\\\\.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write @schname\\\\.raw

* Plotting Differential Mode Gain
let Adm = v(vout_dm)/v(vin)		
let Adm_dB = vdb(Adm)
let Adm_arg = 180/PI*cphase(Adm)
plot Adm_dB Adm_arg ylabel 'Magnitude, Phase'

* Plotting Common Mode Gain
let Acm = v(vout_cm)/v(vin)		
let Acm_dB = vdb(Acm)
let Acm_arg = 180/PI*cphase(Acm)
plot Acm_dB Acm_arg ylabel 'Magnitude, Phase'

* Plotting Common Mode Rejection Ratio
* let CMRR = v(vout_dm)/v(vout_cm)
let CMRR = v(Adm)/v(Acm)
let CMRR_dB = vdb(CMRR)
* let CMRR_dB = Adm_dB - Acm_dB
let CMRR_arg = 180/PI*cphase(CMRR)
plot CMRR_dB CMRR_arg ylabel 'Magnitude, Phase'

* Measurements
meas ac CMRRdc_dB find CMRR_dB when frequency = fdc
print CMRRdc_dB

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_tb_CMRR.txt v(Adm_dB) v(Adm_arg) v(Acm_dB) v(Acm_arg) v(CMRR_dB) v(CMRR_arg)

*quit
.endc
"}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {devices/launcher.sym} 1720 -1600 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1720 -1480 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1720 -1540 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1360 -960 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 1360 -1030 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 980 -1360 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1000 -880 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1500 -1140 0 1 {name=p3 sig_type=std_logic lab=voutp_dm}
C {lab_pin.sym} 1500 -1100 0 1 {name=p4 sig_type=std_logic lab=voutn_dm}
C {devices/lab_pin.sym} 460 -1160 2 0 {name=l10 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 460 -1080 2 0 {name=l11 sig_type=std_logic lab=vinn1}
C {devices/lab_pin.sym} 180 -1130 0 0 {name=l13 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 740 -1160 0 0 {name=l5 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 740 -1080 0 0 {name=l19 sig_type=std_logic lab=vinn1
}
C {devices/capa.sym} 1460 -1030 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1460 -960 0 0 {name=l30 lab=GND}
C {devices/vsource.sym} 540 -1070 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 540 -1140 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 200 -1020 0 0 {name=l39 lab=GND}
C {devices/gnd.sym} 540 -1020 0 0 {name=l40 lab=GND}
C {devices/gnd.sym} 310 -1020 0 0 {name=l41 lab=GND}
C {devices/lab_pin.sym} 1460 -1480 0 1 {name=l12 sig_type=std_logic lab=vout_dm}
C {devices/vcvs.sym} 1460 -1410 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1460 -1340 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1390 -1390 2 1 {name=l15 sig_type=std_logic lab=voutn_dm
}
C {devices/lab_pin.sym} 1390 -1430 0 0 {name=l23 sig_type=std_logic lab=voutp_dm}
C {devices/vsource.sym} 200 -1080 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/gnd.sym} 1360 -220 0 0 {name=l16 lab=GND}
C {devices/capa.sym} 1360 -290 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1500 -400 0 1 {name=p1 sig_type=std_logic lab=voutp_cm}
C {lab_pin.sym} 1500 -360 0 1 {name=p2 sig_type=std_logic lab=voutn_cm}
C {devices/lab_pin.sym} 740 -420 0 0 {name=l25 sig_type=std_logic lab=vinp2}
C {devices/lab_pin.sym} 740 -340 0 0 {name=l26 sig_type=std_logic lab=vinn2
}
C {devices/capa.sym} 1460 -290 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1460 -220 0 0 {name=l27 lab=GND}
C {devices/lab_pin.sym} 1460 -780 0 1 {name=l34 sig_type=std_logic lab=vout_cm}
C {devices/vcvs.sym} 1460 -710 0 0 {name=E8 value=0.5}
C {devices/gnd.sym} 1460 -600 0 0 {name=l35 lab=GND}
C {devices/lab_pin.sym} 1260 -670 2 1 {name=l36 sig_type=std_logic lab=voutn_cm
}
C {devices/lab_pin.sym} 1260 -730 0 0 {name=l37 sig_type=std_logic lab=voutp_cm
}
C {devices/vcvs.sym} 1340 -650 0 0 {name=E10 value=-1}
C {devices/gnd.sym} 1340 -600 0 0 {name=l45 lab=GND}
C {devices/gnd.sym} 1260 -600 0 0 {name=l46 lab=GND}
C {devices/lab_pin.sym} 460 -420 2 0 {name=l29 sig_type=std_logic lab=vinp2}
C {devices/lab_pin.sym} 460 -340 2 0 {name=l31 sig_type=std_logic lab=vinn2}
C {devices/lab_pin.sym} 220 -390 0 0 {name=l32 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 460 -380 2 0 {name=l42 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 310 -290 0 0 {name=l47 lab=GND}
C {devices/vsource.sym} 540 -1410 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 540 -1340 0 0 {name=l3 lab=GND}
C {vdd.sym} 540 -1480 0 0 {name=l7 lab=VDD}
C {vdd.sym} 980 -620 0 0 {name=l17 lab=VDD}
C {devices/gnd.sym} 1000 -140 0 0 {name=l20 lab=GND}
C {devices/code_shown.sym} 2000 -1590 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt_mismatch
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mfb_lpf_pex.sym} 1000 -1120 0 0 {name=x1
}
C {iqmod_mfb_lpf_pex.sym} 1000 -380 0 0 {name=x4
}
C {single2dm.sym} 340 -1120 0 0 {name=x6 gain=1}
C {single2cm.sym} 340 -380 0 0 {name=x7 gain=1}
