v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1580 -1380 2380 -980 {flags=graph
y1=190000
y2=570000
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-2
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
P 4 5 2140 -560 2140 -460 2340 -460 2340 -560 2140 -560 {dash = 8}
T {Testbench for Differential Zin analysis - Third Order MFB Lowpass Filter} 360 -1720 0 0 1 1 {}
T {Capacitive Load} 2140 -410 0 0 0.25 0.25 {}
N 1200 -1140 1200 -1100 {lab=VDD}
N 1200 -1040 1200 -1000 {lab=GND}
N 1340 -1140 1340 -1100 {lab=filter_ota_en}
N 1340 -1040 1340 -1000 {lab=GND}
N 2180 -480 2180 -440 {lab=GND}
N 2280 -480 2280 -440 {lab=GND}
N 1600 -700 1620 -700 {lab=#net1}
N 1600 -620 1620 -620 {lab=#net2}
N 1860 -880 1860 -860 {lab=filter_ota_en}
N 1820 -880 1820 -860 {lab=VDD}
N 2280 -680 2320 -680 {lab=voutp_dm}
N 2180 -640 2320 -640 {lab=voutn_dm}
N 1840 -460 1840 -440 {lab=GND}
N 2180 -640 2180 -540 {lab=voutn_dm}
N 2280 -680 2280 -540 {lab=voutp_dm}
N 1520 -700 1540 -700 {lab=vinp}
N 1520 -620 1540 -620 {lab=vinn}
N 2060 -680 2280 -680 {lab=voutp_dm}
N 2060 -640 2180 -640 {lab=voutn_dm}
N 960 -670 980 -670 {lab=vin_dm}
N 980 -670 980 -650 {lab=vin_dm}
N 1200 -700 1240 -700 {lab=vinp}
N 1200 -620 1240 -620 {lab=vinn}
N 1320 -680 1320 -640 {lab=Vcm}
N 980 -670 1040 -670 {lab=vin_dm}
N 1200 -660 1320 -660 {lab=Vcm}
N 1320 -580 1320 -560 {lab=GND}
N 980 -590 980 -560 {lab=GND}
N 1090 -590 1090 -560 {lab=GND}
C {devices/code_shown.sym} 60 -1390 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/wspr_tx_iqmod_mfb_lpf_pex.spice
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
*.param W_long=18.0
*.param W_short=12.0
*.param a=3
*.param L=1.0
*.param NF_long=6
*.param NF_short=4
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* optran 0 0 0 1u 1m 0

save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 10m
let f_max = 1G
let fdc = 10

* Operating Point Analysis
op
remzerovec
write wspr_tx_iqmod_mfb_lpf_tb_Zin_dm.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write wspr_tx_iqmod_mfb_lpf_tb_Zin_dm.raw

* Plotting Differential Mode Zin
* let Zin_dm = (v(vinp) - v(vinn)) / (i(Vmeasp) - i(Vmeasn))
* let Zin_dm = (v(vinp) - v(vinn)) / (i(Vmeasp) + i(Vmeasn))
let Zin_dm = (v(vinp) - v(vinn)) / i(Vmeasp)
* let Zin_dm = ((v(vinp) + v(vinn)) / 2) / i(Vmeasp)
plot Zin_dm ylabel 'DM Zin'

* Measurements
meas ac Zindc_dm find Zin_dm when frequency = 1
print Zindc_dm

meas ac Zindc_dm find Zin_dm when frequency = fdc
print Zindc_dm

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_iqmod_mfb_lpf_tb_Zin_dm.txt v(Zin_dm)

*quit
.endc
"}
C {devices/launcher.sym} 1640 -1540 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1640 -1420 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1640 -1480 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 2180 -440 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1200 -1070 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1200 -1000 0 0 {name=l3 lab=GND}
C {devices/capa.sym} 2180 -510 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1200 -1140 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 2320 -680 0 1 {name=p3 sig_type=std_logic lab=voutp_dm}
C {lab_pin.sym} 2320 -640 0 1 {name=p4 sig_type=std_logic lab=voutn_dm}
C {devices/capa.sym} 2280 -510 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2280 -440 0 0 {name=l30 lab=GND}
C {devices/gnd.sym} 1340 -1000 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} 1340 -1070 0 0 {name=Ven value=\{VDD\}}
C {ammeter.sym} 1570 -700 3 0 {name=Vmeasp savecurrent=true spice_ignore=0}
C {lab_pin.sym} 960 -670 2 1 {name=p5 sig_type=std_logic lab=vin_dm}
C {ammeter.sym} 1570 -620 3 1 {name=Vmeasn savecurrent=true spice_ignore=0}
C {devices/lab_pin.sym} 1340 -1140 2 0 {name=l4 sig_type=std_logic lab=filter_ota_en}
C {vdd.sym} 1820 -880 0 0 {name=l8 lab=VDD}
C {devices/lab_pin.sym} 1860 -880 2 0 {name=l9 sig_type=std_logic lab=filter_ota_en}
C {devices/gnd.sym} 1840 -440 0 0 {name=l18 lab=GND}
C {devices/lab_pin.sym} 1240 -700 0 1 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1240 -620 0 1 {name=l13 sig_type=std_logic lab=vinn
}
C {devices/vsource.sym} 1320 -610 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/vsource.sym} 980 -620 0 0 {name=vin_dm value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 1520 -700 0 0 {name=l17 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1520 -620 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {sky130_fd_pr/corner.sym} 1890 -1520 0 0 {name=CORNER only_toplevel=false corner=tt}
C {wspr_tx_iqmod_mfb_lpf_gen.sym} 2820 -1200 0 0 {name=x1
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {wspr_tx_iqmod_mfb_lpf.sym} 1840 -660 0 0 {name=x4
spice_ignore=false}
C {devices/lab_pin.sym} 1320 -680 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 980 -560 0 0 {name=l14 lab=GND}
C {devices/gnd.sym} 1320 -560 0 0 {name=l40 lab=GND}
C {devices/gnd.sym} 1090 -560 0 0 {name=l20 lab=GND}
C {single2dm.sym} 1120 -660 0 0 {name=x7}
