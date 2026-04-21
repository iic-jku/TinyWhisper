v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -800 2440 -400 {flags=graph
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
B 2 1640 -1220 2440 -820 {flags=graph
y1=-140
y2=25
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
P 4 5 1320 -860 1320 -760 1520 -760 1520 -860 1320 -860 {dash = 8}
T {Testbench for AC Rin analysis - Third Order MFB Lowpass Filter} 440 -1720 0 0 1 1 {}
T {Capacitive Load} 1320 -690 0 0 0.25 0.25 {}
N 860 -600 860 -560 {lab=VDD}
N 860 -500 860 -460 {lab=GND}
N 1500 -560 1500 -540 {
lab=vout}
N 1430 -530 1460 -530 {
lab=voutp}
N 1430 -490 1460 -490 {
lab=voutn}
N 1500 -480 1500 -460 {lab=GND}
N 1360 -920 1500 -920 {lab=voutp}
N 1460 -960 1500 -960 {lab=voutn}
N 1360 -780 1360 -720 {lab=GND}
N 1460 -780 1460 -720 {lab=GND}
N 1360 -920 1360 -840 {lab=voutp}
N 1460 -960 1460 -840 {lab=voutn}
N 960 -980 1000 -980 {lab=#net1}
N 860 -980 900 -980 {lab=vinp}
N 860 -900 900 -900 {lab=vinn}
N 960 -900 1000 -900 {lab=#net2}
N 1080 -1060 1080 -1040 {lab=VDD}
N 1080 -840 1080 -780 {lab=GND}
N 1180 -920 1360 -920 {lab=voutp}
N 1180 -960 1460 -960 {lab=voutn}
N 920 -1350 940 -1350 {lab=vin}
N 940 -1350 940 -1330 {lab=vin}
N 1160 -1380 1200 -1380 {lab=vinp}
N 1160 -1300 1200 -1300 {lab=vinn}
N 1280 -1340 1280 -1320 {lab=Vcm}
N 940 -1350 1000 -1350 {lab=vin}
N 1160 -1340 1280 -1340 {lab=Vcm}
N 1280 -1260 1280 -1240 {lab=GND}
N 940 -1270 940 -1240 {lab=GND}
N 1050 -1270 1050 -1240 {lab=GND}
N 1280 -1360 1280 -1340 {lab=Vcm}
N 1080 -1060 1100 -1060 {lab=VDD}
N 1080 -1080 1080 -1060 {lab=VDD}
N 1100 -1060 1100 -1040 {lab=VDD}
C {devices/code_shown.sym} 40 -1310 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Rin=36Meg
.param Cload=10p
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
write iqmod_mfb_lpf_ota_core_tb_Rin.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_ota_core_tb_Rin.raw
set appendwrite

* Plotting
let Amag = v(vout)/v(vin)		
let Amag_dB = vdb(Amag)
let Aarg = 180/PI*cphase(Amag)

plot Amag_dB ylabel 'Magnitude'
plot Aarg ylabel 'Phase'
plot Amag_dB Aarg ylabel 'Magnitude, Phase'

* Measurements
meas ac Adc_ol_dB find Amag_dB when frequency = fdc
print Adc_ol_dB

let Amag_fc = Adc_ol_dB-3
* meas ac fcl find frequency when Amag_dB = Amag_fc RISE=1
* print fcl

meas ac fcu find frequency when Amag_dB = Amag_fc FALL=1
print fcu

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_Rin.txt v(Amag_dB) v(Aarg)

*quit
.endc
"}
C {devices/vsource.sym} 860 -530 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 860 -460 0 0 {name=l3 lab=GND}
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
C {vdd.sym} 860 -600 0 0 {name=l7 lab=VDD}
C {devices/lab_pin.sym} 1200 -1380 2 0 {name=l10 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1200 -1300 0 1 {name=l11 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 1280 -1290 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 1500 -560 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1500 -510 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1500 -460 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1430 -490 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1430 -530 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {devices/vsource.sym} 940 -1300 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 860 -980 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 860 -900 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {res.sym} 930 -980 1 0 {name=R1
value=\{Rin\}
footprint=1206
device=resistor
m=1}
C {res.sym} 930 -900 1 0 {name=R2
value=\{Rin\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1360 -720 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 1360 -810 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1500 -920 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1500 -960 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/capa.sym} 1460 -810 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1460 -720 0 0 {name=l30 lab=GND}
C {vdd.sym} 1080 -1080 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 1080 -780 0 0 {name=l16 lab=GND}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1080 -940 0 0 {name=x4
spice_ignore=false}
C {devices/lab_pin.sym} 920 -1350 0 0 {name=l18 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1280 -1360 2 0 {name=l20 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 940 -1240 0 0 {name=l21 lab=GND}
C {devices/gnd.sym} 1280 -1240 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 1050 -1240 0 0 {name=l25 lab=GND}
C {single2dm.sym} 1080 -1340 0 0 {name=x7}
C {devices/code_shown.sym} 1960 -1390 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
