v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -660 2440 -260 {flags=graph
y1=-8.6
y2=-3.8
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=-0.82390874
x2=8.9978734
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"Output Noise; onoise_spectrum\\""
color=4
dataset=-1
unitx=1
logx=1
logy=1
linewidth_mult=4}
B 2 1640 -1080 2440 -680 {flags=graph
y1=-6.4
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=-0.82390874
x2=8.9978734
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"Input Noise; inoise_spectrum\\""
color=4
dataset=-1
unitx=1
logx=1
logy=1
linewidth_mult=4}
P 4 5 1360 -720 1360 -620 1560 -620 1560 -720 1360 -720 {dash = 8}
T {Testbench for noise analysis - Third Order MFB Lowpass Filter} 400 -1730 0 0 1 1 {}
T {Capacitive Load} 1360 -550 0 0 0.25 0.25 {}
N 1040 -600 1040 -580 {lab=GND}
N 780 -840 820 -840 {lab=vinp}
N 780 -760 820 -760 {lab=vinn}
N 1400 -780 1540 -780 {lab=voutn}
N 1500 -820 1540 -820 {lab=voutp}
N 1400 -640 1400 -580 {lab=GND}
N 1500 -640 1500 -580 {lab=GND}
N 1400 -780 1400 -700 {lab=voutn}
N 1500 -820 1500 -700 {lab=voutp}
N 1040 -460 1040 -420 {lab=VDD}
N 1040 -360 1040 -320 {lab=GND}
N 1500 -420 1500 -400 {
lab=vout}
N 1430 -390 1460 -390 {
lab=voutp}
N 1430 -350 1460 -350 {
lab=voutn}
N 1500 -340 1500 -320 {lab=GND}
N 1260 -820 1500 -820 {lab=voutp}
N 1260 -780 1400 -780 {lab=voutn}
N 840 -1320 860 -1320 {lab=vin}
N 860 -1320 860 -1300 {lab=vin}
N 1080 -1350 1120 -1350 {lab=vinp}
N 1080 -1270 1120 -1270 {lab=vinn}
N 1200 -1310 1200 -1290 {lab=Vcm}
N 860 -1320 920 -1320 {lab=vin}
N 1080 -1310 1200 -1310 {lab=Vcm}
N 1200 -1230 1200 -1210 {lab=GND}
N 860 -1240 860 -1210 {lab=GND}
N 970 -1240 970 -1210 {lab=GND}
N 1200 -1330 1200 -1310 {lab=Vcm}
N 1020 -1040 1020 -1020 {lab=VDD}
N 1020 -1020 1060 -1020 {lab=VDD}
N 1060 -1020 1060 -1000 {lab=VDD}
N 1020 -1020 1020 -1000 {lab=VDD}
C {devices/code_shown.sym} 60 -1230 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/iqmod_mfb_lpf_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* optran 0 0 0 1u 1m 0

save all

set enable_noisy_r

* User Constants
let f_min = 1
let f_max = 1G

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_tb_noise.raw
set appendwrite

* Noise Analysis
noise v(vout) vin dec 101 $&const.f_min $&const.f_max 1

* Plotting
setplot noise1
plot inoise_spectrum ylog xlog ylabel 'Input Noise'
plot onoise_spectrum ylog xlog ylabel 'Output Noise'
write iqmod_mfb_lpf_tb_noise.raw

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_tb_noise.txt
+ v(inoise_spectrum) v(onoise_spectrum)

* Measurements
setplot noise2
print inoise_total
print onoise_total

*quit
.endc
"}
C {devices/gnd.sym} 1400 -580 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1040 -390 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1040 -320 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1700 -1240 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/capa.sym} 1400 -670 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1120 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw noise"
}
C {devices/launcher.sym} 1700 -1180 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 1040 -460 0 0 {name=l7 lab=VDD}
C {devices/gnd.sym} 1040 -580 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1540 -820 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1540 -780 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 780 -840 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 780 -760 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/capa.sym} 1500 -670 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1500 -580 0 0 {name=l30 lab=GND}
C {devices/lab_pin.sym} 1500 -420 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1500 -370 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1500 -320 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1430 -350 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1430 -390 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf.sym} 1040 -800 0 0 {name=x4
spice_ignore=false}
C {lab_pin.sym} 840 -1320 2 1 {name=p5 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1120 -1350 0 1 {name=l4 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1120 -1270 0 1 {name=l13 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 1200 -1260 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/vsource.sym} 860 -1270 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 1200 -1330 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 860 -1210 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 1200 -1210 0 0 {name=l40 lab=GND}
C {devices/gnd.sym} 970 -1210 0 0 {name=l20 lab=GND}
C {single2dm.sym} 1000 -1310 0 0 {name=x7}
C {devices/code_shown.sym} 1980 -1230 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {vdd.sym} 1020 -1040 0 0 {name=l8 lab=VDD}
