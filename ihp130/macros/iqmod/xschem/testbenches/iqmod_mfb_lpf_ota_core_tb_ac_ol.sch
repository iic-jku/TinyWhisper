v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -700 2440 -300 {flags=graph
y1=-180
y2=180
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1
x2=10
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"OL Phase; ph(vout)\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1640 -1120 2440 -720 {flags=graph
y1=-54
y2=28
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-1
x2=10
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"OL Magnitude; vout vin / db20()\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 1280 -620 1280 -520 1480 -520 1480 -620 1280 -620 {dash = 8}
T {Design Testbench for AC OL analysis - OTA Core} 600 -1730 0 0 1 1 {}
T {Capacitive Load} 1280 -470 0 0 0.25 0.25 {}
N 900 -700 940 -700 {lab=vinp}
N 900 -620 940 -620 {lab=vinn}
N 1220 -1400 1220 -1360 {lab=VDD}
N 1220 -1300 1220 -1260 {lab=GND}
N 1350 -870 1380 -870 {
lab=voutp}
N 1350 -830 1380 -830 {
lab=voutn}
N 1020 -780 1020 -760 {lab=VDD}
N 1020 -560 1020 -500 {lab=GND}
N 1420 -680 1460 -680 {lab=voutn}
N 1320 -640 1460 -640 {lab=voutp}
N 1320 -640 1320 -600 {lab=voutp}
N 1120 -640 1320 -640 {lab=voutp}
N 1320 -540 1320 -500 {lab=GND}
N 1420 -680 1420 -600 {lab=voutn}
N 1120 -680 1420 -680 {lab=voutn}
N 1420 -540 1420 -500 {lab=GND}
N 1420 -920 1420 -880 {lab=vout}
N 1420 -820 1420 -780 {lab=GND}
N 860 -1070 880 -1070 {lab=vin}
N 880 -1070 880 -1050 {lab=vin}
N 1100 -1100 1140 -1100 {lab=vinp}
N 1100 -1020 1140 -1020 {lab=vinn}
N 880 -1070 940 -1070 {lab=vin}
N 880 -990 880 -960 {lab=GND}
N 990 -990 990 -960 {lab=GND}
N 1220 -1060 1220 -1040 {lab=Vcm}
N 1100 -1060 1220 -1060 {lab=Vcm}
N 1220 -980 1220 -960 {lab=GND}
N 1220 -1080 1220 -1060 {lab=Vcm}
N 1020 -780 1040 -780 {lab=VDD}
N 1020 -800 1020 -780 {lab=VDD}
N 1040 -780 1040 -760 {lab=VDD}
C {devices/code_shown.sym} 60 -1450 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../verification/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
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
let f_min = 0.1
let f_max = 10G
let fdc = 1

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_ota_core_tb_ac_ol.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_ota_core_tb_ac_ol.raw

* Plotting
let Aol = v(vout)/v(vin)		
let Aol_dB = vdb(Aol)
let Aol_arg = 180/PI*cphase(Aol)

plot Aol_dB ylabel 'Magnitude'
plot Aol_arg ylabel 'Phase'
plot Aol_dB Aol_arg ylabel 'Magnitude, Phase'

* Measurements
* DC open-loop gain
meas ac Adc_ol_dB find Aol_dB when frequency = fdc
print Adc_ol_dB

* 3dB cut-off frequency
let Aol_fc = Adc_ol_dB - 3
meas ac fc find frequency when Aol_dB = Aol_fc
print fc

* Unity Gain Bandwidth (Aol=1 or Aol_dB = 0dB)
meas ac UGB when Aol_dB=0  fall=1
print UGB

* Phase Margin at Aol=1 or Aol_dB = 0dB
meas ac arg_0dB find Aol_arg when Aol_dB=0
let PM = 180-abs(arg_0dB)
print PM

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_ac_ol.txt v(Aol_dB) v(Aol_arg)

*quit
.endc
"}
C {devices/launcher.sym} 1700 -1280 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1160 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1700 -1220 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1320 -500 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1220 -1330 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1220 -1260 0 0 {name=l3 lab=GND}
C {devices/capa.sym} 1320 -570 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1220 -1400 0 0 {name=l7 lab=VDD}
C {vdd.sym} 1020 -800 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1020 -500 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1460 -640 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1460 -680 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/capa.sym} 1420 -570 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1420 -500 0 0 {name=l30 lab=GND}
C {devices/lab_pin.sym} 1420 -920 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1420 -850 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1420 -780 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1350 -830 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1350 -870 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {devices/vsource.sym} 880 -1020 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/lab_pin.sym} 900 -700 0 0 {name=l16 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 900 -620 0 0 {name=l19 sig_type=std_logic lab=vinn
}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {lab_pin.sym} 860 -1070 2 1 {name=p5 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 1140 -1100 2 0 {name=l10 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 1140 -1020 0 1 {name=l5 sig_type=std_logic lab=vinn
}
C {devices/gnd.sym} 880 -960 0 0 {name=l22 lab=GND}
C {devices/gnd.sym} 990 -960 0 0 {name=l25 lab=GND}
C {single2dm.sym} 1020 -1060 0 0 {name=x7}
C {devices/vsource.sym} 1220 -1010 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 1220 -1080 2 0 {name=l11 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 1220 -960 0 0 {name=l13 lab=GND}
C {devices/code_shown.sym} 1960 -1270 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 1020 -660 0 0 {name=x1
}
