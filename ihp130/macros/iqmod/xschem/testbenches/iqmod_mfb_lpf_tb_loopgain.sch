v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 0 0 65 0 {}
L 4 1360 -160 1360 0 {}
L 4 1360 -160 2680 -160 {}
L 4 1360 -80 2680 -80 {}
L 4 1990 -80 1990 0 {}
L 4 1990 -160 1990 -80 {}
L 4 1700 -80 1700 0 {}
L 4 380 0 1000 0 {}
L 4 1000 -0 2680 -0 {}
L 4 0 -2080 2680 -2080 {}
L 4 0 -2080 0 -0 {}
L 4 2680 -2080 2680 -0 {}
P 4 5 2120 -1240 2120 -1140 2320 -1140 2320 -1240 2120 -1240 {dash = 8}
P 4 5 2120 -500 2120 -400 2320 -400 2320 -500 2120 -500 {dash = 8}
P 4 5 1060 -1680 2640 -1680 2640 -200 1060 -200 1060 -1680 {dash = 8}
P 5 38 140 -15 135 -10 125 0 135 10 147.5 22.5 155 30 147.5 30 140 30 135 30 130 25 125 20 115 10 105 20 100 25 95 30 90 30 82.5 30 75 30 82.5 22.5 95 10 105 0 95 -10 82.5 -22.5 75 -30 82.5 -30 90 -30 95 -30 100 -25 105 -20 115 -10 125 -20 130 -25 135 -30 140 -30 147.5 -30 155 -30 147.5 -22.5 140 -15 {fill=true
bezier=1}
T {Testbench for loop gain analysis - Third Order MFB Lowpass Filter} 540 -2060 0 0 1 1 {}
T {Capacitive Load} 2120 -1070 0 0 0.25 0.25 {}
T {Middlebrook’s Method} 1060 -1720 0 0 0.5 0.5 {}
T {2025-01-14} 2000 -60 0 0 0.8 0.8 {}
T {Simon Dorrer} 1370 -140 0 0 0.8 0.8 {}
T {Page 1 of 1} 1370 -60 0 0 0.8 0.8 {}
T {Rev. 1} 1710 -60 0 0 0.8 0.8 {}
T {SCHEM} 155 -25 0 0 1 1 {}
T {Capacitive Load} 2120 -330 0 0 0.25 0.25 {}
N 1860 -1880 1860 -1840 {lab=VDD}
N 1860 -1780 1860 -1740 {lab=GND}
N 2180 -1880 2180 -1840 {lab=filter_ota_en}
N 2180 -1780 2180 -1740 {lab=GND}
N 1900 -1440 1900 -1420 {lab=VDD}
N 2160 -1300 2300 -1300 {lab=voutp2}
N 2260 -1340 2300 -1340 {lab=voutn2}
N 2160 -1160 2160 -1100 {lab=GND}
N 2260 -1160 2260 -1100 {lab=GND}
N 2160 -1300 2160 -1220 {lab=voutp2}
N 2260 -1340 2260 -1220 {lab=voutn2}
N 2560 -1370 2560 -1350 {
lab=vout2}
N 2490 -1340 2520 -1340 {
lab=voutp2}
N 2490 -1300 2520 -1300 {
lab=voutn2}
N 2560 -1290 2560 -1270 {lab=GND}
N 1900 -1220 1900 -1180 {
lab=GND}
N 2000 -1340 2100 -1340 {lab=voutn2}
N 2000 -1300 2100 -1300 {lab=voutp2}
N 2100 -1300 2160 -1300 {lab=voutp2}
N 2100 -1340 2260 -1340 {lab=voutn2}
N 2100 -1300 2100 -1080 {lab=voutp2}
N 2100 -1560 2100 -1340 {lab=voutn2}
N 2100 -1640 2100 -1560 {lab=voutn2}
N 2560 -630 2560 -610 {
lab=vout3}
N 2490 -600 2520 -600 {
lab=voutp3}
N 2490 -560 2520 -560 {
lab=voutn3}
N 2560 -550 2560 -530 {lab=GND}
N 1140 -1320 1180 -1320 {lab=Vcm}
N 2320 -1590 2320 -1570 {
lab=vf2}
N 2250 -1560 2280 -1560 {
lab=vfp2}
N 2250 -1520 2280 -1520 {
lab=vfn2}
N 2320 -1510 2320 -1480 {
lab=GND}
N 2560 -1590 2560 -1570 {
lab=vr2}
N 2490 -1560 2520 -1560 {
lab=vrp2}
N 2490 -1520 2520 -1520 {
lab=vrn2}
N 2560 -1510 2560 -1480 {
lab=GND}
N 1700 -520 1720 -520 {
lab=#net1}
N 1680 -520 1700 -520 {
lab=#net1}
N 1700 -640 1720 -640 {
lab=#net2}
N 1680 -640 1700 -640 {
lab=#net2}
N 1700 -440 1700 -420 {lab=GND}
N 1700 -520 1700 -500 {lab=#net1}
N 1700 -660 1700 -640 {lab=#net2}
N 1700 -740 1700 -720 {lab=GND}
N 2020 -1780 2020 -1740 {lab=GND}
N 2020 -1880 2020 -1840 {lab=Vcm}
N 1740 -1360 1820 -1360 {lab=vfp2}
N 1600 -1360 1680 -1360 {lab=vrp2}
N 1600 -1400 1600 -1360 {lab=vrp2}
N 1600 -1560 1820 -1560 {lab=vrp2}
N 1880 -1560 2100 -1560 {lab=voutn2}
N 1560 -1400 1600 -1400 {lab=vrp2}
N 1460 -1400 1500 -1400 {lab=#net3}
N 1460 -1640 1500 -1640 {lab=#net3}
N 1560 -1640 2100 -1640 {lab=voutn2}
N 1740 -1280 1820 -1280 {lab=vfn2}
N 1600 -1280 1680 -1280 {lab=vrn2}
N 1600 -1240 1600 -1080 {lab=vrn2}
N 1880 -1080 2100 -1080 {lab=voutp2}
N 1600 -1080 1820 -1080 {lab=vrn2}
N 1560 -1240 1600 -1240 {lab=vrn2}
N 1460 -1240 1500 -1240 {lab=#net4}
N 1460 -1000 1500 -1000 {lab=#net4}
N 1560 -1000 2100 -1000 {lab=voutp2}
N 2100 -1080 2100 -1000 {lab=voutp2}
N 1420 -1400 1460 -1400 {lab=#net3}
N 1320 -1400 1360 -1400 {lab=#net5}
N 1280 -1400 1320 -1400 {lab=#net5}
N 1320 -1240 1360 -1240 {lab=#net6}
N 1420 -1240 1460 -1240 {lab=#net4}
N 1180 -1400 1220 -1400 {lab=Vcm}
N 1180 -1240 1220 -1240 {lab=Vcm}
N 1460 -1640 1460 -1400 {lab=#net3}
N 1460 -1240 1460 -1000 {lab=#net4}
N 1460 -1400 1460 -1350 {lab=#net3}
N 1460 -1290 1460 -1240 {lab=#net4}
N 1320 -1290 1320 -1240 {lab=#net6}
N 1320 -1400 1320 -1350 {lab=#net5}
N 1180 -1400 1180 -1320 {lab=Vcm}
N 1180 -1320 1180 -1240 {lab=Vcm}
N 1900 -700 1900 -680 {lab=VDD}
N 2160 -560 2300 -560 {lab=voutp3}
N 2260 -600 2300 -600 {lab=voutn3}
N 2160 -420 2160 -360 {lab=GND}
N 2260 -420 2260 -360 {lab=GND}
N 2160 -560 2160 -480 {lab=voutp3}
N 2260 -600 2260 -480 {lab=voutn3}
N 1900 -480 1900 -440 {
lab=GND}
N 2000 -600 2100 -600 {lab=voutn3}
N 2000 -560 2100 -560 {lab=voutp3}
N 2100 -560 2160 -560 {lab=voutp3}
N 2100 -600 2260 -600 {lab=voutn3}
N 2100 -560 2100 -340 {lab=voutp3}
N 2100 -820 2100 -600 {lab=voutn3}
N 2100 -900 2100 -820 {lab=voutn3}
N 1140 -580 1180 -580 {lab=Vcm}
N 1600 -820 1820 -820 {lab=#net7}
N 1880 -820 2100 -820 {lab=voutn3}
N 1560 -660 1600 -660 {lab=#net7}
N 1460 -660 1500 -660 {lab=#net8}
N 1460 -900 1500 -900 {lab=#net8}
N 1560 -900 2100 -900 {lab=voutn3}
N 1880 -340 2100 -340 {lab=voutp3}
N 1600 -340 1820 -340 {lab=#net9}
N 1560 -500 1600 -500 {lab=#net9}
N 1460 -500 1500 -500 {lab=#net10}
N 1460 -260 1500 -260 {lab=#net10}
N 1560 -260 2100 -260 {lab=voutp3}
N 2100 -340 2100 -260 {lab=voutp3}
N 1420 -660 1460 -660 {lab=#net8}
N 1320 -660 1360 -660 {lab=#net11}
N 1280 -660 1320 -660 {lab=#net11}
N 1320 -500 1360 -500 {lab=#net12}
N 1420 -500 1460 -500 {lab=#net10}
N 1180 -660 1220 -660 {lab=Vcm}
N 1180 -500 1220 -500 {lab=Vcm}
N 1460 -900 1460 -660 {lab=#net8}
N 1460 -500 1460 -260 {lab=#net10}
N 1460 -660 1460 -610 {lab=#net8}
N 1460 -550 1460 -500 {lab=#net10}
N 1320 -550 1320 -500 {lab=#net12}
N 1320 -660 1320 -610 {lab=#net11}
N 1180 -660 1180 -580 {lab=Vcm}
N 1180 -580 1180 -500 {lab=Vcm}
N 1780 -620 1820 -620 {lab=#net13}
N 1780 -640 1780 -620 {lab=#net13}
N 1780 -540 1820 -540 {lab=#net14}
N 1780 -540 1780 -520 {lab=#net14}
N 1600 -520 1620 -520 {lab=#net9}
N 1600 -820 1600 -660 {lab=#net7}
N 1600 -640 1620 -640 {lab=#net7}
N 1600 -660 1600 -640 {lab=#net7}
N 1600 -520 1600 -500 {lab=#net9}
N 1600 -500 1600 -340 {lab=#net9}
N 1600 -1560 1600 -1400 {lab=vrp2}
N 1600 -1280 1600 -1240 {lab=vrn2}
N 1280 -1240 1320 -1240 {lab=#net6}
N 1280 -500 1320 -500 {lab=#net12}
N 1900 -1440 1920 -1440 {lab=VDD}
N 1900 -1460 1900 -1440 {lab=VDD}
N 1920 -1440 1920 -1420 {lab=VDD}
N 1900 -700 1920 -700 {lab=VDD}
N 1900 -720 1900 -700 {lab=VDD}
N 1920 -700 1920 -680 {lab=VDD}
C {devices/code_shown.sym} 40 -1770 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../verification/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.param R1=238e3
.param R2=285e3
.param R3=473e3
.param R4=537e3
.param C1=0.97e-12
.param C2=0.63e-12
.param C3=100e-15
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* optran 0 0 0 1u 1m 0

save all

* User Constants
let f_min = 1
let f_max = 1G
let fdc = 10
* ===================================================

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_tb_loopgain.raw
set appendwrite
* ===================================================

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_tb_loopgain.raw
set appendwrite
* ===================================================

* Middlebrook's method
let Tv=-v(vr2)/v(vf2)
let Ti=-(i(Virp3) - i(Virn3))/(i(Vifp3) - i(Vifn3))
let Tmb =(Tv * Ti - 1)/(Tv + Ti + 2)

let Tmb_dB = vdb(Tmb)
let Tmb_arg = 180/PI*cphase(Tmb)

* DC loop gain	
meas ac Tmbdc_dB find Tmb_dB when frequency = fdc
print Tmbdc_dB

* Phase margin
meas ac fug find frequency when Tmb_dB=0
meas ac pm find Tmb_arg when frequency=fug
let pm = 180-abs(pm)
* let pm = abs(pm)
print pm
	
* Plotting
plot Tmb_dB Tmb_arg title 'Bode Plot (Middlebrook)' ylabel 'Magnitude (dB), Phase (Deg)'

let Tmb_re = real(Tmb)
let Tmb_im = imag(Tmb)	
plot Tmb_im vs Tmb_re retraceplot title 'Nyquist Plot (Middlebrook)' ylabel 'Imaginary Part' xlabel 'Real Part' 
* ===================================================

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_tb_loopgain.txt v(Tmb_dB) v(Tmb_arg) 
* ===================================================

*quit
.endc
"}
C {devices/vsource.sym} 1860 -1810 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1860 -1740 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1120 -1860 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1120 -1800 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 1860 -1880 0 0 {name=l7 lab=VDD}
C {devices/gnd.sym} 2180 -1740 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} 2180 -1880 2 0 {name=l35 sig_type=std_logic lab=filter_ota_en}
C {devices/vsource.sym} 2180 -1810 0 0 {name=Ven value=\{VDD\}}
C {devices/gnd.sym} 2160 -1100 0 0 {name=l26 lab=GND}
C {devices/capa.sym} 2160 -1190 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1900 -1460 0 0 {name=l27 lab=VDD}
C {devices/gnd.sym} 1900 -1180 0 1 {name=l29 lab=GND}
C {lab_pin.sym} 2300 -1300 0 1 {name=p1 sig_type=std_logic lab=voutp2}
C {lab_pin.sym} 2300 -1340 0 1 {name=p2 sig_type=std_logic lab=voutn2}
C {devices/capa.sym} 2260 -1190 0 0 {name=C5
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2260 -1100 0 0 {name=l36 lab=GND}
C {devices/lab_pin.sym} 2560 -1370 0 1 {name=l37 sig_type=std_logic lab=vout2}
C {devices/vcvs.sym} 2560 -1320 0 0 {name=E3 value=1}
C {devices/gnd.sym} 2560 -1270 0 0 {name=l42 lab=GND}
C {devices/lab_pin.sym} 2490 -1300 2 1 {name=l43 sig_type=std_logic lab=voutn2
}
C {devices/lab_pin.sym} 2490 -1340 0 0 {name=l44 sig_type=std_logic lab=voutp2
}
C {res.sym} 1530 -1640 1 0 {name=R4a
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1530 -1000 1 0 {name=R4b
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 1850 -1560 1 0 {name=C3a
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1850 -1080 1 1 {name=C3b
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1460 -1320 2 0 {name=C2
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 2300 -560 0 1 {name=p5 sig_type=std_logic lab=voutp3}
C {lab_pin.sym} 2300 -600 0 1 {name=p6 sig_type=std_logic lab=voutn3}
C {devices/lab_pin.sym} 2560 -630 0 1 {name=l57 sig_type=std_logic lab=vout3}
C {devices/vcvs.sym} 2560 -580 0 0 {name=E7 value=1}
C {devices/gnd.sym} 2560 -530 0 0 {name=l58 lab=GND}
C {devices/lab_pin.sym} 2490 -560 2 1 {name=l59 sig_type=std_logic lab=voutn3
}
C {devices/lab_pin.sym} 2490 -600 0 0 {name=l60 sig_type=std_logic lab=voutp3
}
C {devices/lab_pin.sym} 1140 -1320 0 0 {name=l65 sig_type=std_logic lab=Vcm}
C {devices/lab_pin.sym} 2320 -1590 0 1 {name=l48 sig_type=std_logic lab=vf2}
C {devices/vcvs.sym} 2320 -1540 0 0 {name=E8 value=0.5}
C {devices/gnd.sym} 2320 -1480 0 0 {name=l33 lab=GND}
C {devices/lab_pin.sym} 2250 -1520 2 1 {name=l45 sig_type=std_logic lab=vfn2
}
C {devices/lab_pin.sym} 2250 -1560 0 0 {name=l46 sig_type=std_logic lab=vfp2

}
C {devices/lab_pin.sym} 2560 -1590 0 1 {name=l47 sig_type=std_logic lab=vr2}
C {devices/vcvs.sym} 2560 -1540 0 0 {name=E9 value=0.5}
C {devices/gnd.sym} 2560 -1480 0 0 {name=l53 lab=GND}
C {devices/lab_pin.sym} 2490 -1520 2 1 {name=l54 sig_type=std_logic lab=vrn2
}
C {devices/lab_pin.sym} 2490 -1560 0 0 {name=l61 sig_type=std_logic lab=vrp2

}
C {devices/vsource.sym} 1710 -1360 1 1 {name=Vtestp2 value="dc 0 ac 1"}
C {lab_wire.sym} 1780 -1360 0 0 {name=p9 sig_type=std_logic lab=vfp2}
C {lab_wire.sym} 1640 -1360 0 0 {name=p13 sig_type=std_logic lab=vrp2}
C {devices/vsource.sym} 1710 -1280 1 0 {name=Vtestn2 value="dc 0 ac -1"}
C {lab_wire.sym} 1780 -1280 0 0 {name=p10 sig_type=std_logic lab=vfn2}
C {lab_wire.sym} 1640 -1280 0 0 {name=p11 sig_type=std_logic lab=vrn2}
C {ammeter.sym} 1650 -640 3 1 {name=Virp3 savecurrent=true spice_ignore=0}
C {ammeter.sym} 1750 -640 3 1 {name=Vifp3 savecurrent=true spice_ignore=0}
C {isource.sym} 1700 -470 2 1 {name=Itestn3 value="dc 0 ac -1"}
C {devices/gnd.sym} 1700 -420 0 0 {name=l62 lab=GND}
C {ammeter.sym} 1650 -520 3 0 {name=Virn3 savecurrent=true spice_ignore=0}
C {ammeter.sym} 1750 -520 3 0 {name=Vifn3 savecurrent=true spice_ignore=0}
C {isource.sym} 1700 -690 0 0 {name=Itestp3 value="dc 0 ac 1"}
C {devices/gnd.sym} 1700 -740 2 0 {name=l63 lab=GND}
C {devices/vsource.sym} 2020 -1810 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 2020 -1880 1 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 2020 -1740 0 0 {name=l40 lab=GND}
C {res.sym} 1530 -1400 1 1 {name=R3a
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1530 -1240 1 0 {name=R3b
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1390 -1400 1 1 {name=R2a
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1250 -1400 1 1 {name=R1a
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1390 -1240 1 0 {name=R2b
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1250 -1240 1 0 {name=R1b
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 1320 -1320 2 0 {name=C1
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2160 -360 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 2160 -450 0 0 {name=C3
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1900 -720 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 1900 -440 0 1 {name=l4 lab=GND}
C {devices/capa.sym} 2260 -450 0 0 {name=C6
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2260 -360 0 0 {name=l8 lab=GND}
C {res.sym} 1530 -900 1 0 {name=R1
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1530 -260 1 0 {name=R2
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 1850 -820 1 0 {name=C7
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1850 -340 1 1 {name=C8
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1460 -580 2 0 {name=C9
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1140 -580 0 0 {name=l9 sig_type=std_logic lab=Vcm}
C {res.sym} 1530 -660 1 1 {name=R3
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1530 -500 1 0 {name=R4
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1390 -660 1 1 {name=R5
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1250 -660 1 1 {name=R6
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1390 -500 1 0 {name=R7
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1250 -500 1 0 {name=R8
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 1320 -580 2 0 {name=C10
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2840 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2840 -140 0 0 {name=x3
spice_ignore=true}
C {devices/code_shown.sym} 1400 -1850 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 1900 -1320 0 0 {name=x1
}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 1900 -580 0 0 {name=x4
}
