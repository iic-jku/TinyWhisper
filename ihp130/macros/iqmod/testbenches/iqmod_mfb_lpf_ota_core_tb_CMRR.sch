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
y1=1.2
y2=70
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
y1=-42
y2=28
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
P 4 5 1360 -1180 1360 -1080 1560 -1080 1560 -1180 1360 -1180 {dash = 8}
P 4 5 1360 -460 1360 -360 1560 -360 1560 -460 1360 -460 {dash = 8}
T {Testbench for CMRR analysis - OTA Core} 670 -1740 0 0 1 1 {}
T {Capacitive Load} 1360 -1030 0 0 0.25 0.25 {}
T {Capacitive Load} 1360 -510 0 0 0.25 0.25 {}
T {Output CM voltage: vout_cm = (voutp_cm + voutn_cm)/2} 1300 -670 0 0 0.2 0.2 {}
T {Output DM voltage: vout_dm = voutp_dm - voutn_dm} 1300 -1410 0 0 0.2 0.2 {}
N 1040 -1260 1080 -1260 {lab=vinp1}
N 1040 -1180 1080 -1180 {lab=vinn1}
N 540 -1230 560 -1230 {lab=vin}
N 900 -1580 900 -1540 {lab=VDD}
N 900 -1480 900 -1440 {lab=GND}
N 1430 -1530 1460 -1530 {
lab=voutp_dm}
N 1430 -1490 1460 -1490 {
lab=voutn_dm}
N 1160 -1340 1160 -1320 {lab=VDD}
N 1160 -1120 1160 -1060 {lab=GND}
N 1500 -1240 1540 -1240 {lab=voutn_dm}
N 1400 -1200 1540 -1200 {lab=voutp_dm}
N 1400 -1200 1400 -1160 {lab=voutp_dm}
N 1400 -1100 1400 -1060 {lab=GND}
N 1500 -1240 1500 -1160 {lab=voutn_dm}
N 1500 -1100 1500 -1060 {lab=GND}
N 1500 -1580 1500 -1540 {lab=vout_dm}
N 1500 -1480 1500 -1440 {lab=GND}
N 1260 -1200 1400 -1200 {lab=voutp_dm}
N 1260 -1240 1500 -1240 {lab=voutn_dm}
N 1040 -540 1080 -540 {lab=vinp2}
N 1040 -460 1080 -460 {lab=vinn2}
N 1160 -620 1160 -600 {lab=VDD}
N 1160 -400 1160 -340 {lab=GND}
N 1500 -520 1540 -520 {lab=voutn_cm}
N 1400 -480 1540 -480 {lab=voutp_cm}
N 1400 -480 1400 -440 {lab=voutp_cm}
N 1400 -380 1400 -340 {lab=GND}
N 1500 -520 1500 -440 {lab=voutn_cm}
N 1500 -380 1500 -340 {lab=GND}
N 1260 -480 1400 -480 {lab=voutp_cm}
N 1260 -520 1500 -520 {lab=voutn_cm}
N 1500 -900 1500 -860 {lab=vout_cm}
N 1500 -800 1500 -720 {lab=GND}
N 1380 -740 1380 -720 {lab=GND}
N 1380 -810 1460 -810 {lab=#net1}
N 1380 -810 1380 -800 {lab=#net1}
N 1300 -750 1340 -750 {lab=GND}
N 1300 -750 1300 -720 {lab=GND}
N 1300 -790 1340 -790 {lab=voutn_cm}
N 1300 -850 1460 -850 {lab=voutp_cm}
N 560 -1230 560 -1210 {lab=vin}
N 780 -1260 820 -1260 {lab=vinp1}
N 780 -1180 820 -1180 {lab=vinn1}
N 900 -1220 900 -1200 {lab=Vcm}
N 670 -430 670 -410 {lab=GND}
N 780 -540 820 -540 {lab=vinp2}
N 780 -460 820 -460 {lab=vinn2}
N 780 -500 820 -500 {lab=Vcm}
N 580 -510 620 -510 {lab=vin}
N 560 -1230 620 -1230 {lab=vin}
N 780 -1220 900 -1220 {lab=Vcm}
N 900 -1140 900 -1120 {lab=GND}
N 560 -1150 560 -1120 {lab=GND}
N 670 -1150 670 -1120 {lab=GND}
N 900 -1240 900 -1220 {lab=Vcm}
N 1180 -1340 1180 -1320 {lab=VDD}
N 1160 -1340 1180 -1340 {lab=VDD}
N 1160 -1360 1160 -1340 {lab=VDD}
N 1180 -620 1180 -600 {lab=VDD}
N 1160 -620 1180 -620 {lab=VDD}
N 1160 -640 1160 -620 {lab=VDD}
C {devices/code_shown.sym} 40 -1390 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
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
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_CMRR.txt
+ v(Adm_dB) v(Adm_arg) v(Acm_dB) v(Acm_arg) v(CMRR_dB) v(CMRR_arg)

*quit
.endc
"}
C {devices/launcher.sym} 1720 -1600 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1480 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1720 -1540 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1400 -1060 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 900 -1510 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 900 -1440 0 0 {name=l3 lab=GND}
C {devices/capa.sym} 1400 -1130 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 900 -1580 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1160 -1360 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1160 -1060 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1540 -1200 0 1 {name=p3 sig_type=std_logic lab=voutp_dm}
C {lab_pin.sym} 1540 -1240 0 1 {name=p4 sig_type=std_logic lab=voutn_dm}
C {devices/lab_pin.sym} 820 -1260 2 0 {name=l10 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 820 -1180 2 0 {name=l11 sig_type=std_logic lab=vinn1}
C {devices/lab_pin.sym} 540 -1230 0 0 {name=l13 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1040 -1260 0 0 {name=l5 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 1040 -1180 0 0 {name=l19 sig_type=std_logic lab=vinn1
}
C {devices/capa.sym} 1500 -1130 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1500 -1060 0 0 {name=l30 lab=GND}
C {devices/vsource.sym} 900 -1170 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 900 -1240 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 560 -1120 0 0 {name=l39 lab=GND}
C {devices/gnd.sym} 900 -1120 0 0 {name=l40 lab=GND}
C {devices/gnd.sym} 670 -1120 0 0 {name=l41 lab=GND}
C {devices/lab_pin.sym} 1500 -1580 0 1 {name=l12 sig_type=std_logic lab=vout_dm}
C {devices/vcvs.sym} 1500 -1510 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1500 -1440 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1430 -1490 2 1 {name=l15 sig_type=std_logic lab=voutn_dm
}
C {devices/lab_pin.sym} 1430 -1530 0 0 {name=l23 sig_type=std_logic lab=voutp_dm}
C {devices/vsource.sym} 560 -1180 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/gnd.sym} 1400 -340 0 0 {name=l16 lab=GND}
C {devices/capa.sym} 1400 -410 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1160 -640 0 0 {name=l17 lab=VDD}
C {devices/gnd.sym} 1160 -340 0 0 {name=l18 lab=GND}
C {lab_pin.sym} 1540 -480 0 1 {name=p1 sig_type=std_logic lab=voutp_cm}
C {lab_pin.sym} 1540 -520 0 1 {name=p2 sig_type=std_logic lab=voutn_cm}
C {devices/lab_pin.sym} 1040 -540 0 0 {name=l25 sig_type=std_logic lab=vinp2}
C {devices/lab_pin.sym} 1040 -460 0 0 {name=l26 sig_type=std_logic lab=vinn2
}
C {devices/capa.sym} 1500 -410 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1500 -340 0 0 {name=l27 lab=GND}
C {devices/lab_pin.sym} 1500 -900 0 1 {name=l34 sig_type=std_logic lab=vout_cm}
C {devices/vcvs.sym} 1500 -830 0 0 {name=E8 value=0.5}
C {devices/gnd.sym} 1500 -720 0 0 {name=l35 lab=GND}
C {devices/lab_pin.sym} 1300 -790 2 1 {name=l36 sig_type=std_logic lab=voutn_cm
}
C {devices/lab_pin.sym} 1300 -850 0 0 {name=l37 sig_type=std_logic lab=voutp_cm
}
C {devices/vcvs.sym} 1380 -770 0 0 {name=E10 value=-1}
C {devices/gnd.sym} 1380 -720 0 0 {name=l45 lab=GND}
C {devices/gnd.sym} 1300 -720 0 0 {name=l46 lab=GND}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {devices/lab_pin.sym} 820 -540 2 0 {name=l29 sig_type=std_logic lab=vinp2}
C {devices/lab_pin.sym} 820 -460 2 0 {name=l31 sig_type=std_logic lab=vinn2}
C {devices/lab_pin.sym} 580 -510 0 0 {name=l32 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 820 -500 2 0 {name=l42 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 670 -410 0 0 {name=l47 lab=GND}
C {devices/code_shown.sym} 1960 -1590 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt_mismatch
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 1160 -1220 0 0 {name=x1
}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 1160 -500 0 0 {name=x4
}
C {single2dm.sym} 700 -1220 0 0 {name=x6 gain=1}
C {single2cm.sym} 700 -500 0 0 {name=x7 gain=1}
