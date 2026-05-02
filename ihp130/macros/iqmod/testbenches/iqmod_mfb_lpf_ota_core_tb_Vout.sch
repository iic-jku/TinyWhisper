v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -720 2460 -320 {flags=graph
y1=0
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.5
x2=1.5
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vinp
vinn
voutp
voutn"
color="4 7 12 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 1660 -1160 2460 -760 {flags=graph
y1=-0.032
y2=-0.023
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.5
x2=1.5
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
P 4 5 1310 -880 1310 -780 1510 -780 1510 -880 1310 -880 {dash = 8}
T {Testbench for Output Voltage Swing analysis - OTA Core} 520 -1730 0 0 1 1 {}
T {Capacitive Load} 1310 -670 0 0 0.25 0.25 {}
N 1440 -480 1440 -440 {lab=VDD}
N 1440 -380 1440 -340 {lab=GND}
N 1440 -940 1480 -940 {lab=voutn}
N 1340 -900 1480 -900 {lab=voutp}
N 1340 -900 1340 -860 {lab=voutp}
N 1440 -940 1440 -860 {lab=voutn}
N 1180 -940 1440 -940 {lab=voutn}
N 1180 -900 1340 -900 {lab=voutp}
N 1340 -800 1340 -700 {lab=GND}
N 1440 -800 1440 -700 {lab=GND}
N 1080 -1040 1080 -1020 {lab=VDD}
N 1080 -820 1080 -700 {lab=GND}
N 960 -880 1000 -880 {lab=vinn}
N 960 -960 1000 -960 {lab=vinp}
N 920 -1390 940 -1390 {lab=vin}
N 940 -1390 940 -1370 {lab=vin}
N 1160 -1420 1200 -1420 {lab=vinp}
N 1160 -1340 1200 -1340 {lab=vinn}
N 1280 -1380 1280 -1360 {lab=Vcm}
N 940 -1390 1000 -1390 {lab=vin}
N 1160 -1380 1280 -1380 {lab=Vcm}
N 1280 -1300 1280 -1280 {lab=GND}
N 940 -1310 940 -1280 {lab=GND}
N 1050 -1310 1050 -1280 {lab=GND}
N 1280 -1400 1280 -1380 {lab=Vcm}
N 1080 -1040 1100 -1040 {lab=VDD}
N 1080 -1120 1080 -1040 {lab=VDD}
N 1100 -1040 1100 -1020 {lab=VDD}
C {devices/code_shown.sym} 40 -1290 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-12 gmin=1e-12
.control

save all

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_ota_core_tb_Vout.raw
set appendwrite

* DC Sweep
dc Vgsp -$&VDD $&VDD 1m
remzerovec
write iqmod_mfb_lpf_ota_core_tb_Vout.raw
set appendwrite

* Plotting
plot vinp voutp voutn

* Measurement
meas dc Vgsp_at_Vcm when voutp=voutn
print Vgsp_at_Vcm

meas dc vout_pp_max MAX v(voutp)
meas dc vout_pp_min MIN v(voutp)
let vout_pp = vout_pp_max - vout_pp_min
print vout_pp

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_Vout.txt v(vinp) v(voutp) v(voutn)

*quit
.endc
"}
C {devices/launcher.sym} 1720 -1340 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1220 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc"
}
C {devices/launcher.sym} 1720 -1280 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/vsource.sym} 1440 -410 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1440 -340 0 0 {name=l3 lab=GND}
C {vdd.sym} 1440 -480 0 0 {name=l7 lab=VDD}
C {devices/vsource.sym} 940 -1340 0 0 {name=Vgsp value=0
}
C {devices/lab_pin.sym} 960 -960 0 0 {name=l5 sig_type=std_logic lab=vinp}
C {devices/gnd.sym} 1340 -700 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1480 -900 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1480 -940 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/gnd.sym} 1440 -700 0 0 {name=l30 lab=GND}
C {devices/capa.sym} 1440 -830 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1340 -830 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1080 -1120 0 0 {name=l12 lab=VDD}
C {devices/gnd.sym} 1080 -700 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 960 -880 0 0 {name=l11 sig_type=std_logic lab=vinn}
C {devices/vsource.sym} 1280 -1330 0 0 {name=Vcm value=\{Vcm\}
}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1080 -920 0 0 {name=x4
spice_ignore=false}
C {devices/lab_pin.sym} 1200 -1420 2 0 {name=l10 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1200 -1340 0 1 {name=l1 sig_type=std_logic lab=vinn
}
C {devices/lab_pin.sym} 920 -1390 0 0 {name=l8 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1280 -1400 2 0 {name=l20 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 940 -1280 0 0 {name=l21 lab=GND}
C {devices/gnd.sym} 1280 -1280 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 1050 -1280 0 0 {name=l25 lab=GND}
C {devices/code_shown.sym} 1960 -1330 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {single2dm.sym} 1080 -1380 0 0 {name=x6 gain=1}
