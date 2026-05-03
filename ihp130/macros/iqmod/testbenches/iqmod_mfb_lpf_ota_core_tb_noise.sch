v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -720 2440 -320 {flags=graph
y1=-9.7
y2=-2.5
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=-1
x2=9
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
B 2 1640 -1140 2440 -740 {flags=graph
y1=-8.1
y2=-4.1
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=-1
x2=9
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
P 4 5 1260 -480 1260 -380 1460 -380 1460 -480 1260 -480 {dash = 8}
T {Testbench for noise analysis - OTA Core} 680 -1730 0 0 1 1 {}
T {Capacitive Load} 1260 -330 0 0 0.25 0.25 {}
N 880 -560 920 -560 {lab=vinp}
N 880 -480 920 -480 {lab=vinn}
N 1000 -1040 1000 -1000 {lab=VDD}
N 1000 -940 1000 -900 {lab=GND}
N 1400 -760 1400 -740 {
lab=vout}
N 1330 -730 1360 -730 {
lab=voutp}
N 1330 -690 1360 -690 {
lab=voutn}
N 1400 -680 1400 -660 {lab=GND}
N 1000 -640 1000 -620 {lab=VDD}
N 1000 -420 1000 -360 {lab=GND}
N 1400 -540 1440 -540 {lab=voutn}
N 1300 -500 1440 -500 {lab=voutp}
N 1300 -500 1300 -460 {lab=voutp}
N 1100 -500 1300 -500 {lab=voutp}
N 1300 -400 1300 -360 {lab=GND}
N 1400 -540 1400 -460 {lab=voutn}
N 1100 -540 1400 -540 {lab=voutn}
N 1400 -400 1400 -360 {lab=GND}
N 340 -530 360 -530 {lab=vin}
N 360 -530 360 -510 {lab=vin}
N 580 -560 620 -560 {lab=vinp}
N 580 -480 620 -480 {lab=vinn}
N 360 -530 420 -530 {lab=vin}
N 360 -450 360 -420 {lab=GND}
N 470 -450 470 -420 {lab=GND}
N 700 -520 700 -500 {lab=Vcm}
N 580 -520 700 -520 {lab=Vcm}
N 700 -440 700 -420 {lab=GND}
N 700 -540 700 -520 {lab=Vcm}
N 1000 -640 1020 -640 {lab=VDD}
N 1000 -660 1000 -640 {lab=VDD}
N 1020 -640 1020 -620 {lab=VDD}
C {devices/code_shown.sym} 40 -1490 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* optran 0 0 0 1u 1m 0

save all

set wr_vecnames
set wr_singlescale
set enable_noisy_r

* User Constants
let f_min = 0.1
let f_max = 1G

* Operating Point Analysis
op
remzerovec
write @schname\\\\.raw
set appendwrite

* Noise Analysis
noise v(vout) vin dec 101 $&const.f_min $&const.f_max 1

* Plotting
setplot noise1
plot inoise_spectrum ylog xlog ylabel 'Input Noise'
plot onoise_spectrum ylog xlog ylabel 'Output Noise'
write @schname\\\\.raw
set appendwrite

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_noise.txt v(inoise_spectrum) v(onoise_spectrum)

* Measurements
setplot noise2
print inoise_total
print onoise_total


*quit
.endc
"}
C {devices/gnd.sym} 1300 -360 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1000 -970 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1000 -900 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1700 -1300 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/capa.sym} 1300 -430 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1180 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw noise"
}
C {devices/launcher.sym} 1700 -1240 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 1000 -1040 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1000 -660 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1000 -360 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1440 -500 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1440 -540 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 880 -560 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 880 -480 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/capa.sym} 1400 -430 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1400 -360 0 0 {name=l30 lab=GND}
C {devices/vsource.sym} 700 -470 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 1400 -760 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1400 -710 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1400 -660 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1330 -690 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1330 -730 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {devices/vsource.sym} 360 -480 0 0 {name=vin value="dc 0 ac 1"
}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1000 -520 0 0 {name=x4
spice_ignore=false}
C {lab_pin.sym} 340 -530 2 1 {name=p5 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 620 -560 2 0 {name=l17 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 620 -480 0 1 {name=l18 sig_type=std_logic lab=vinn
}
C {devices/gnd.sym} 360 -420 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 470 -420 0 0 {name=l25 lab=GND}
C {devices/lab_pin.sym} 700 -540 2 0 {name=l20 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 700 -420 0 0 {name=l21 lab=GND}
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
C {single2dm.sym} 500 -520 0 0 {name=x6 gain=1}
