v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1580 -1380 2380 -980 {flags=graph,unlocked
y1=470000
y2=480000
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-2
x2=2
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
linewidth_mult=4
legend=1}
P 4 5 1500 -600 1500 -500 1700 -500 1700 -600 1500 -600 {dash = 8}
T {Testbench for Common-Mode Zin analysis - Third Order MFB Lowpass Filter} 260 -1720 0 0 1 1 {}
T {Capacitive Load} 1500 -440 0 0 0.25 0.25 {}
N 1540 -520 1540 -480 {lab=GND}
N 1640 -520 1640 -480 {lab=GND}
N 880 -740 880 -660 {lab=#net1}
N 840 -740 880 -740 {lab=#net1}
N 880 -740 980 -740 {lab=#net1}
N 880 -660 980 -660 {lab=#net1}
N 1540 -680 1680 -680 {lab=voutn_cm}
N 1640 -720 1680 -720 {lab=voutp_cm}
N 1200 -500 1200 -480 {lab=GND}
N 720 -740 720 -700 {lab=vin_cm}
N 680 -740 720 -740 {lab=vin_cm}
N 720 -520 720 -480 {lab=GND}
N 720 -640 720 -580 {lab=#net2}
N 1540 -680 1540 -580 {lab=voutn_cm}
N 1640 -720 1640 -580 {lab=voutp_cm}
N 1020 -1200 1020 -1160 {lab=VDD}
N 1020 -1100 1020 -1060 {lab=GND}
N 1180 -1200 1180 -1160 {lab=Vcm}
N 1180 -1100 1180 -1060 {lab=GND}
N 1420 -720 1640 -720 {lab=voutp_cm}
N 1420 -680 1540 -680 {lab=voutn_cm}
N 720 -740 780 -740 {lab=vin_cm}
N 1180 -940 1180 -920 {lab=VDD}
N 1180 -920 1220 -920 {lab=VDD}
N 1220 -920 1220 -900 {lab=VDD}
N 1180 -920 1180 -900 {lab=VDD}
C {devices/code_shown.sym} 60 -1150 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
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
write @schname\\\\.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write @schname\\\\.raw

* Plotting Common Mode Zin
let Zin_cm = v(vin_cm) / i(Vmeas_cm)
plot Zin_cm ylabel 'CM Zin'

* Measurements
meas ac Zindc_cm find Zin_cm when frequency = fdc
print Zindc_cm

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_tb_Zin_cm.txt v(Zin_cm)

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
C {devices/gnd.sym} 1540 -480 0 0 {name=l16 lab=GND}
C {devices/capa.sym} 1540 -550 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1680 -720 0 1 {name=p1 sig_type=std_logic lab=voutp_cm}
C {lab_pin.sym} 1680 -680 0 1 {name=p2 sig_type=std_logic lab=voutn_cm}
C {devices/capa.sym} 1640 -550 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1640 -480 0 0 {name=l27 lab=GND}
C {devices/vsource.sym} 720 -670 0 0 {name=vin_cm value="0 AC 1"
}
C {devices/gnd.sym} 720 -480 0 0 {name=l13 lab=GND}
C {lab_pin.sym} 680 -740 2 1 {name=p6 sig_type=std_logic lab=vin_cm}
C {ammeter.sym} 810 -740 3 0 {name=Vmeas_cm savecurrent=true spice_ignore=0}
C {devices/vsource.sym} 720 -550 0 0 {name=Vcm_cm value=\{Vcm\}
}
C {devices/gnd.sym} 1200 -480 0 0 {name=l14 lab=GND}
C {devices/vsource.sym} 1020 -1130 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1020 -1060 0 0 {name=l3 lab=GND}
C {vdd.sym} 1020 -1200 0 0 {name=l7 lab=VDD}
C {devices/vsource.sym} 1180 -1130 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 1180 -1200 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 1180 -1060 0 0 {name=l40 lab=GND}
C {iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf.sym} 1200 -700 0 0 {name=x4
spice_ignore=false}
C {devices/code_shown.sym} 1940 -1530 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {vdd.sym} 1180 -940 0 0 {name=l8 lab=VDD}
