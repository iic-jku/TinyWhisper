v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1420 2440 -1020 {flags=graph
y1=-0.0078
y2=-0.0069
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.503e-06
x2=1e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
color=4
node=i(VDD)}
B 2 1640 -1000 2440 -600 {flags=graph
y1=0.41
y2=1.2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.503e-06
x2=1e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vinp
vinn
voutp
voutn"
color="4 18 21 12"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 1640 -580 2440 -180 {flags=graph
y1=-0.73
y2=0.78
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.503e-06
x2=1e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vin
vout_dm
vout_cm"
color="4 7 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 820 -1420 1620 -1020 {flags=graph
y1=-1.3e-05
y2=1.3e-05
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.503e-06
x2=1e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
color="4 21"
node="i(Vmeasp)
i(Vmeasn)"}
P 4 5 1200 -600 1200 -500 1400 -500 1400 -600 1200 -600 {dash = 8}
T {Testbench for transient analysis - OTA Core} 740 -1730 0 0 1 1 {}
T {Capacitive Load} 1200 -450 0 0 0.25 0.25 {}
T {Output CM voltage: vout_cm = (voutp + voutn)/2} 1310 -200 0 0 0.2 0.2 {}
T {Output DM voltage: vout_dm = voutp - voutn} 1350 -730 0 0 0.2 0.2 {}
N 860 -680 900 -680 {lab=vinp}
N 860 -600 900 -600 {lab=vinn}
N 1200 -900 1200 -860 {lab=VDD}
N 1200 -800 1200 -760 {lab=GND}
N 980 -540 980 -480 {lab=GND}
N 1240 -520 1240 -480 {lab=GND}
N 1340 -520 1340 -480 {lab=GND}
N 400 -650 400 -630 {lab=vin}
N 600 -680 640 -680 {lab=vinp}
N 600 -600 640 -600 {lab=vinn}
N 720 -640 720 -620 {lab=Vcm}
N 400 -650 440 -650 {lab=vin}
N 600 -640 720 -640 {lab=Vcm}
N 720 -560 720 -540 {lab=GND}
N 400 -570 400 -540 {lab=GND}
N 490 -570 490 -540 {lab=GND}
N 260 -570 260 -540 {lab=GND}
N 260 -650 260 -630 {lab=vin}
N 200 -650 260 -650 {lab=vin}
N 720 -660 720 -640 {lab=Vcm}
N 1080 -660 1200 -660 {lab=#net1}
N 1080 -620 1120 -620 {lab=#net2}
N 1240 -620 1240 -580 {lab=voutp}
N 1180 -620 1240 -620 {lab=voutp}
N 1340 -660 1340 -580 {lab=voutn}
N 1260 -660 1340 -660 {lab=voutn}
N 1440 -620 1440 -580 {lab=voutp}
N 1520 -660 1520 -580 {lab=voutn}
N 1440 -620 1540 -620 {lab=voutp}
N 1240 -620 1440 -620 {lab=voutp}
N 1340 -660 1520 -660 {lab=voutn}
N 1520 -660 1540 -660 {lab=voutn}
N 1440 -520 1440 -480 {lab=GND}
N 1520 -520 1520 -480 {lab=GND}
N 260 -650 400 -650 {lab=vin}
N 1520 -420 1520 -380 {lab=vout_cm}
N 1520 -320 1520 -240 {lab=GND}
N 1400 -260 1400 -240 {lab=GND}
N 1400 -330 1480 -330 {lab=#net3}
N 1400 -330 1400 -320 {lab=#net3}
N 1320 -270 1360 -270 {lab=GND}
N 1320 -270 1320 -240 {lab=GND}
N 1320 -310 1360 -310 {lab=voutn}
N 1320 -370 1480 -370 {lab=voutp}
N 1450 -850 1480 -850 {
lab=voutp}
N 1450 -810 1480 -810 {
lab=voutn}
N 1520 -900 1520 -860 {lab=vout_dm}
N 1520 -800 1520 -760 {lab=GND}
N 1000 -760 1000 -740 {lab=VDD}
N 980 -760 980 -740 {lab=VDD}
N 980 -760 1000 -760 {lab=VDD}
N 980 -780 980 -760 {lab=VDD}
C {devices/code.sym} 70 -1420 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.param fsig=400e3
.csparam fsig=fsig
.param Cload=10p
.param Rload=1k
.options savecurrents method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

* save vin vinp vinn voutp voutn vout_cm vout_dm
save all

* User Constants
let tstart = 1/fsig
let tstop = 4/fsig
let tstep = 0.05/fsig

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_ota_core_tb_tran.raw
set appendwrite

* Transient Analysis
* Sine Input
tran $&tstep $&tstop $&tstart
* Pulse Input
* tran 50n 2.05m 1.95m
write iqmod_mfb_lpf_ota_core_tb_tran.raw

* Plotting
plot vinp vinn voutp voutn
plot vin vout_dm vout_cm
* plot i(VDD)

* Measurements
meas tran vin_peak MAX v(vin)
meas tran vout_peak MAX v(vout_dm)

let Adm = vout_peak / vin_peak
let Adm_dB = vdb(Adm)
print Adm_dB

meas tran vout_pp_max MAX v(voutp)
meas tran vout_pp_min MIN v(voutp)
let vout_pp = vout_pp_max - vout_pp_min
print vout_pp

* Calculation of Power Consumption & Efficiency
let PDD_inst = VDD * -i(VDD)
meas tran PDD_int INTEG PDD_inst from=tstart to=tstop
let PDD = 1/(tstop - tstart) * PDD_int * 1e3
echo PDD = $&PDD mW

let Pout_inst = v(vout_dm) * (i(Vmeasp) - i(Vmeasn))
meas tran Pout_int INTEG Pout_inst from=tstart to=tstop
let Pout = 1/(tstop - tstart) * Pout_int * 1e3
echo Pout = $&Pout mW

let efficiency = Pout / PDD * 100
echo efficiency = $&efficiency %

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_tran.txt
+ v(vin) v(vout_dm) v(vout_cm) v(vinp) v(vinn) v(voutp) v(voutn)

*quit
.endc
"}
C {devices/launcher.sym} 1700 -1590 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1470 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1700 -1530 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1240 -480 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1200 -830 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1200 -760 0 0 {name=l3 lab=GND}
C {devices/capa.sym} 1240 -550 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"
}
C {vdd.sym} 1200 -900 0 0 {name=l7 lab=VDD}
C {vdd.sym} 980 -780 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 980 -480 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1540 -620 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1540 -660 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/lab_pin.sym} 860 -680 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 860 -600 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {devices/capa.sym} 1340 -550 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"
}
C {devices/gnd.sym} 1340 -480 0 0 {name=l30 lab=GND}
C {devices/vsource.sym} 260 -600 0 1 {name=vpulse value="pulse(\{-VDD\} \{VDD\} 0 10p 10p 500u 1m)"
spice_ignore=true}
C {devices/vsource.sym} 400 -600 0 1 {name=vsine value="sin(0 40m \{fsig\})"
}
C {devices/gnd.sym} 260 -540 0 0 {name=l17 lab=GND}
C {devices/vsource.sym} 720 -590 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 640 -680 2 0 {name=l18 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 640 -600 0 1 {name=l21 sig_type=std_logic lab=vinn
}
C {devices/lab_pin.sym} 200 -650 0 0 {name=l22 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 720 -660 2 0 {name=l25 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 400 -540 0 0 {name=l26 lab=GND}
C {devices/gnd.sym} 720 -540 0 0 {name=l27 lab=GND}
C {devices/gnd.sym} 490 -540 0 0 {name=l28 lab=GND}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {devices/code_shown.sym} 1960 -1590 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {vsource.sym} 1150 -620 3 1 {name=Vmeasp value=0 savecurrent=false}
C {vsource.sym} 1230 -660 3 1 {name=Vmeasn value=0 savecurrent=false}
C {res.sym} 1440 -550 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1
spice_ignore=true}
C {res.sym} 1520 -550 0 0 {name=R2
value=\{Rload\}
footprint=1206
device=resistor
m=1
spice_ignore=true}
C {devices/gnd.sym} 1440 -480 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1520 -480 0 0 {name=l6 lab=GND}
C {devices/code_shown.sym} 820 -1490 0 0 {name=SAVE only_toplevel=true
format="tcleval( @value )"
value=".include [file rootname [xschem get schname]].save
"}
C {devices/lab_pin.sym} 1520 -420 0 1 {name=l34 sig_type=std_logic lab=vout_cm}
C {devices/vcvs.sym} 1520 -350 0 0 {name=E8 value=0.5}
C {devices/gnd.sym} 1520 -240 0 0 {name=l35 lab=GND}
C {devices/vcvs.sym} 1400 -290 0 0 {name=E10 value=-1}
C {devices/gnd.sym} 1400 -240 0 0 {name=l45 lab=GND}
C {devices/gnd.sym} 1320 -240 0 0 {name=l46 lab=GND}
C {devices/lab_pin.sym} 1520 -900 0 1 {name=l12 sig_type=std_logic lab=vout_dm}
C {devices/vcvs.sym} 1520 -830 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1520 -760 0 0 {name=l14 lab=GND}
C {lab_pin.sym} 1450 -810 0 0 {name=p1 sig_type=std_logic lab=voutn}
C {lab_pin.sym} 1320 -310 0 0 {name=p2 sig_type=std_logic lab=voutn}
C {lab_pin.sym} 1450 -850 0 0 {name=p5 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1320 -370 0 0 {name=p6 sig_type=std_logic lab=voutp}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 980 -640 0 0 {name=x4
}
C {single2dm.sym} 520 -640 0 0 {name=x6 gain=1}
C {single2cm.sym} 520 -370 0 0 {name=x1 gain=1
spice_ignore=true}
