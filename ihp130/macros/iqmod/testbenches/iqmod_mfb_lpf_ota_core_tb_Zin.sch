v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -800 2460 -400 {flags=graph,unlocked
y1=41
y2=52000000
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
node="\\"CM Zin; v(vin_cm) i(Vmeas_cm) /\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1660 -1220 2460 -820 {flags=graph
y1=84
y2=87000000
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
node="\\"DM Zin; v(vin_dm) i(Vmeasp) i(Vmeasn) + /\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 1340 -980 1340 -880 1540 -880 1540 -980 1340 -980 {dash = 8}
P 4 5 1340 -540 1340 -440 1540 -440 1540 -540 1340 -540 {dash = 8}
T {Testbench for Zin analysis - OTA Core} 670 -1710 0 0 1 1 {}
T {Capacitive Load} 1340 -830 0 0 0.25 0.25 {}
T {Capacitive Load} 1340 -390 0 0 0.25 0.25 {}
N 800 -1480 800 -1440 {lab=VDD}
N 800 -1380 800 -1340 {lab=GND}
N 1140 -1140 1140 -1120 {lab=VDD}
N 1140 -920 1140 -860 {lab=GND}
N 1480 -1040 1520 -1040 {lab=voutn_dm}
N 1380 -1000 1520 -1000 {lab=voutp_dm}
N 1380 -1000 1380 -960 {lab=voutp_dm}
N 1380 -900 1380 -860 {lab=GND}
N 1480 -1040 1480 -960 {lab=voutn_dm}
N 1480 -900 1480 -860 {lab=GND}
N 1240 -1000 1380 -1000 {lab=voutp_dm}
N 1240 -1040 1480 -1040 {lab=voutn_dm}
N 1140 -700 1140 -680 {lab=VDD}
N 1140 -480 1140 -420 {lab=GND}
N 1480 -600 1520 -600 {lab=voutn_cm}
N 1380 -560 1520 -560 {lab=voutp_cm}
N 1380 -560 1380 -520 {lab=voutp_cm}
N 1380 -460 1380 -420 {lab=GND}
N 1480 -600 1480 -520 {lab=voutn_cm}
N 1480 -460 1480 -420 {lab=GND}
N 1240 -560 1380 -560 {lab=voutp_cm}
N 1240 -600 1480 -600 {lab=voutn_cm}
N 800 -440 800 -420 {lab=GND}
N 800 -540 800 -500 {lab=#net1}
N 760 -620 800 -620 {lab=vin_cm}
N 800 -620 800 -600 {lab=vin_cm}
N 940 -620 940 -540 {lab=#net2}
N 940 -540 1060 -540 {lab=#net2}
N 940 -620 1060 -620 {lab=#net2}
N 960 -1060 980 -1060 {lab=vinp}
N 960 -980 980 -980 {lab=vinn}
N 1040 -980 1060 -980 {lab=#net3}
N 1040 -1060 1060 -1060 {lab=#net4}
N 800 -620 840 -620 {lab=vin_cm}
N 900 -620 940 -620 {lab=#net2}
N 980 -1450 1000 -1450 {lab=vin_dm}
N 1000 -1450 1000 -1430 {lab=vin_dm}
N 1220 -1480 1260 -1480 {lab=vinp}
N 1220 -1400 1260 -1400 {lab=vinn}
N 1000 -1450 1060 -1450 {lab=vin_dm}
N 1000 -1370 1000 -1340 {lab=GND}
N 1110 -1370 1110 -1340 {lab=GND}
N 1340 -1440 1340 -1420 {lab=Vcm}
N 1220 -1440 1340 -1440 {lab=Vcm}
N 1340 -1360 1340 -1340 {lab=GND}
N 1340 -1460 1340 -1440 {lab=Vcm}
N 1140 -1140 1160 -1140 {lab=VDD}
N 1140 -1160 1140 -1140 {lab=VDD}
N 1160 -1140 1160 -1120 {lab=VDD}
N 1140 -700 1160 -700 {lab=VDD}
N 1140 -720 1140 -700 {lab=VDD}
N 1160 -700 1160 -680 {lab=VDD}
C {devices/code_shown.sym} 40 -1250 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* save v(vinp) v(vinn) i(Vmeasp) i(Vmeasn) v(vin_cm) i(Vmeas_cm)
save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 0.1
let f_max = 1G
let fdc = 10

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_ota_core_tb_Zin.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_ota_core_tb_Zin.raw

* Plotting Differential Mode Zin
* let Zin_dm = (v(vinp) - v(vinn)) / (i(Vmeasp) - i(Vmeasn))
* let Zin_dm = (v(vinp) - v(vinn)) / (i(Vmeasp) + i(Vmeasn))
let Zin_dm = (v(vinp) - v(vinn)) / i(Vmeasp)
plot Zin_dm ylabel 'DM Zin'

* Plotting Common Mode Zin
let Zin_cm = v(vin_cm) / i(Vmeas_cm)
plot Zin_cm ylabel 'CM Zin'

* Measurements
meas ac Zindc_dm find Zin_dm when frequency = fdc
print Zindc_dm

meas ac Zindc_cm find Zin_cm when frequency = fdc
print Zindc_cm

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_Zin.txt v(Zin_dm) v(Zin_cm)

*quit
.endc
"}
C {devices/launcher.sym} 1720 -1380 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1260 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1720 -1320 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1380 -860 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 800 -1410 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 800 -1340 0 0 {name=l3 lab=GND}
C {devices/capa.sym} 1380 -930 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 800 -1480 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1140 -1160 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1140 -860 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1520 -1000 0 1 {name=p3 sig_type=std_logic lab=voutp_dm}
C {lab_pin.sym} 1520 -1040 0 1 {name=p4 sig_type=std_logic lab=voutn_dm}
C {devices/capa.sym} 1480 -930 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1480 -860 0 0 {name=l30 lab=GND}
C {devices/gnd.sym} 1380 -420 0 0 {name=l16 lab=GND}
C {devices/capa.sym} 1380 -490 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1140 -720 0 0 {name=l17 lab=VDD}
C {devices/gnd.sym} 1140 -420 0 0 {name=l18 lab=GND}
C {lab_pin.sym} 1520 -560 0 1 {name=p1 sig_type=std_logic lab=voutp_cm}
C {lab_pin.sym} 1520 -600 0 1 {name=p2 sig_type=std_logic lab=voutn_cm}
C {devices/capa.sym} 1480 -490 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1480 -420 0 0 {name=l27 lab=GND}
C {devices/vsource.sym} 800 -570 0 0 {name=vin_cm value="dc 0 ac 1"
}
C {devices/gnd.sym} 800 -420 0 0 {name=l13 lab=GND}
C {ammeter.sym} 1010 -1060 3 0 {name=Vmeasp savecurrent=true spice_ignore=0}
C {lab_pin.sym} 760 -620 2 1 {name=p6 sig_type=std_logic lab=vin_cm}
C {ammeter.sym} 1010 -980 3 1 {name=Vmeasn savecurrent=true spice_ignore=0}
C {ammeter.sym} 870 -620 3 0 {name=Vmeas_cm savecurrent=true spice_ignore=0}
C {devices/vsource.sym} 800 -470 0 0 {name=Vcm_cm value=\{Vcm\}
}
C {lab_pin.sym} 980 -1450 2 1 {name=p5 sig_type=std_logic lab=vin_dm}
C {devices/vsource.sym} 1000 -1400 0 0 {name=vin_dm value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 960 -1060 0 0 {name=l19 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 960 -980 0 0 {name=l20 sig_type=std_logic lab=vinn
}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1140 -1020 0 0 {name=x4
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1140 -580 0 0 {name=x5
spice_ignore=false}
C {devices/lab_pin.sym} 1260 -1480 2 0 {name=l10 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1260 -1400 0 1 {name=l5 sig_type=std_logic lab=vinn
}
C {devices/gnd.sym} 1000 -1340 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 1110 -1340 0 0 {name=l25 lab=GND}
C {devices/vsource.sym} 1340 -1390 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 1340 -1460 2 0 {name=l11 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 1340 -1340 0 0 {name=l12 lab=GND}
C {devices/code_shown.sym} 1960 -1370 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {single2dm.sym} 1140 -1440 0 0 {name=x6 gain=1}
