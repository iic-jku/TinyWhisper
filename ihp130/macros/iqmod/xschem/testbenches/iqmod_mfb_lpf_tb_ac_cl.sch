v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -660 2460 -260 {flags=graph
y1=-170
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
B 2 1660 -1080 2460 -680 {flags=graph
y1=-170
y2=-1.7
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
P 4 5 1380 -720 1380 -620 1580 -620 1580 -720 1380 -720 {dash = 8}
T {Testbench for AC CL analysis - Third Order MFB Lowpass Filter} 440 -1720 0 0 1 1 {}
T {Capacitive Load} 1380 -550 0 0 0.25 0.25 {}
N 1060 -600 1060 -580 {lab=GND}
N 1420 -780 1560 -780 {lab=voutn}
N 1520 -820 1560 -820 {lab=voutp}
N 1420 -640 1420 -580 {lab=GND}
N 1520 -640 1520 -580 {lab=GND}
N 1420 -780 1420 -700 {lab=voutn}
N 1520 -820 1520 -700 {lab=voutp}
N 1440 -1360 1440 -1320 {lab=VDD}
N 1440 -1260 1440 -1220 {lab=GND}
N 1520 -420 1520 -400 {
lab=vout}
N 1450 -390 1480 -390 {
lab=voutp}
N 1450 -350 1480 -350 {
lab=voutn}
N 1520 -340 1520 -320 {lab=GND}
N 1280 -820 1520 -820 {lab=voutp}
N 1280 -780 1420 -780 {lab=voutn}
N 800 -840 840 -840 {lab=vinp}
N 800 -760 840 -760 {lab=vinn}
N 860 -1320 880 -1320 {lab=vin}
N 880 -1320 880 -1300 {lab=vin}
N 1100 -1350 1140 -1350 {lab=vinp}
N 1100 -1270 1140 -1270 {lab=vinn}
N 1220 -1310 1220 -1290 {lab=Vcm}
N 880 -1320 940 -1320 {lab=vin}
N 1100 -1310 1220 -1310 {lab=Vcm}
N 1220 -1230 1220 -1210 {lab=GND}
N 880 -1240 880 -1210 {lab=GND}
N 990 -1240 990 -1210 {lab=GND}
N 1220 -1330 1220 -1310 {lab=Vcm}
N 1040 -1020 1040 -1000 {lab=VDD}
N 1040 -1020 1080 -1020 {lab=VDD}
N 1040 -1040 1040 -1020 {lab=VDD}
N 1080 -1020 1080 -1000 {lab=VDD}
C {devices/code_shown.sym} 40 -1390 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../verification/pex/iqmod_mfb_lpf_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-12 gmin=1e-12 rshunt=1e12
.control

* optran 0 0 0 1u 1m 0

save all
* save v(voutp) v(voutn) v(vout) v(vin)

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 1
let f_max = 1G
let fdc = 10

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_tb_ac_cl.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_tb_ac_cl.raw
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
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_tb_ac_cl.txt v(Amag_dB) v(Aarg)

*quit
.endc
"}
C {devices/gnd.sym} 1420 -580 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1440 -1290 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1440 -1220 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1720 -1260 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/capa.sym} 1420 -670 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1140 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1720 -1200 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 1440 -1360 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1040 -1040 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1060 -580 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1560 -820 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1560 -780 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 800 -840 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 800 -760 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/capa.sym} 1520 -670 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1520 -580 0 0 {name=l30 lab=GND}
C {devices/lab_pin.sym} 1520 -420 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1520 -370 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1520 -320 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1450 -350 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1450 -390 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {lab_pin.sym} 860 -1320 2 1 {name=p5 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1140 -1350 0 1 {name=l4 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1140 -1270 0 1 {name=l13 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 1220 -1260 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/vsource.sym} 880 -1270 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 1220 -1330 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 880 -1210 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 1220 -1210 0 0 {name=l40 lab=GND}
C {devices/gnd.sym} 990 -1210 0 0 {name=l20 lab=GND}
C {single2dm.sym} 1020 -1310 0 0 {name=x7}
C {devices/code_shown.sym} 2020 -1250 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mfb_lpf_pex.sym} 1060 -800 0 0 {name=x4
}
