v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 0 0 65 0 {}
L 4 1400 -160 1400 0 {}
L 4 1400 -160 2720 -160 {}
L 4 1400 -80 2720 -80 {}
L 4 2030 -80 2030 0 {}
L 4 2030 -160 2030 -80 {}
L 4 1740 -80 1740 0 {}
L 4 -0 -2200 2720 -2200 {}
L 4 2720 -2200 2720 -0 {}
L 4 380 -0 2720 0 {}
L 4 -0 -2200 -0 -0 {}
P 4 5 1050 -1600 1270 -1600 1270 -1500 1050 -1500 1050 -1600 {dash = 8}
P 4 5 1050 -920 1270 -920 1270 -820 1050 -820 1050 -920 {dash = 8}
P 4 5 990 -240 1210 -240 1210 -140 990 -140 990 -240 {dash = 8}
P 4 5 40 -2040 1320 -2040 1320 -1420 40 -1420 40 -2040 {dash = 8}
P 4 5 40 -1360 1320 -1360 1320 -740 40 -740 40 -1360 {dash = 8}
P 4 5 40 -680 1320 -680 1320 -60 40 -60 40 -680 {dash = 8}
P 5 38 140 -15 135 -10 125 0 135 10 147.5 22.5 155 30 147.5 30 140 30 135 30 130 25 125 20 115 10 105 20 100 25 95 30 90 30 82.5 30 75 30 82.5 22.5 95 10 105 0 95 -10 82.5 -22.5 75 -30 82.5 -30 90 -30 95 -30 100 -25 105 -20 115 -10 125 -20 130 -25 135 -30 140 -30 147.5 -30 155 -30 147.5 -22.5 140 -15 {fill=true
bezier=1}
T {Capacitive Load} 1050 -1450 0 0 0.25 0.25 {}
T {Template Testbench for AC analysis - OTA Core} 550 -2180 0 0 1.2 1.2 {}
T {Capacitive Load} 1050 -770 0 0 0.25 0.25 {}
T {Output CM voltage: vout_cm = (voutp_cm + voutn_cm)/2} 970 -1150 0 0 0.2 0.2 {}
T {Open-Loop Analysis (Aol, fcu)} 40 -2070 0 0 0.4 0.4 {}
T {Common-Mode Analysis (CMRR)} 40 -1390 0 0 0.4 0.4 {}
T {Capacitive Load} 990 -90 0 0 0.25 0.25 {}
T {Power Supply Rejection Ratio Analysis (PSRR)} 40 -710 0 0 0.4 0.4 {}
T {2025-08-18} 2040 -60 0 0 0.8 0.8 {}
T {Simon Dorrer} 1410 -140 0 0 0.8 0.8 {}
T {Page of} 1410 -60 0 0 0.8 0.8 {}
T {Rev. 1.0} 1750 -60 0 0 0.8 0.8 {}
T {SCHEM} 155 -25 0 0 1 1 {}
N 680 -1740 720 -1740 {lab=vinp1}
N 680 -1660 720 -1660 {lab=vinn1}
N 1420 -1960 1420 -1920 {lab=VDD}
N 1420 -1860 1420 -1820 {lab=GND}
N 1180 -1720 1220 -1720 {lab=voutn1}
N 1080 -1680 1220 -1680 {lab=voutp1}
N 1080 -1680 1080 -1580 {lab=voutp1}
N 1080 -1520 1080 -1480 {lab=GND}
N 1180 -1720 1180 -1580 {lab=voutn1}
N 1180 -1520 1180 -1480 {lab=GND}
N 1600 -1860 1600 -1820 {
lab=GND}
N 1600 -1960 1600 -1920 {
lab=VSS}
N 680 -1060 720 -1060 {lab=vinp2}
N 680 -980 720 -980 {lab=vinn2}
N 1080 -840 1080 -800 {lab=GND}
N 1180 -840 1180 -800 {lab=GND}
N 1220 -1260 1220 -1180 {lab=GND}
N 1100 -1200 1100 -1180 {lab=GND}
N 1100 -1270 1180 -1270 {lab=#net1}
N 1100 -1270 1100 -1260 {lab=#net1}
N 1020 -1210 1060 -1210 {lab=GND}
N 1020 -1210 1020 -1180 {lab=GND}
N 1020 -1250 1060 -1250 {lab=voutn2}
N 1020 -1310 1180 -1310 {lab=voutp2}
N 1220 -1960 1220 -1940 {lab=vout1}
N 1220 -1880 1220 -1860 {lab=GND}
N 1160 -1930 1180 -1930 {lab=voutp1}
N 1160 -1890 1180 -1890 {lab=voutn1}
N 1220 -1340 1220 -1320 {lab=vout2}
N 680 -380 720 -380 {lab=Vcm3}
N 680 -300 720 -300 {lab=Vcm3}
N 1020 -160 1020 -120 {lab=GND}
N 1120 -160 1120 -120 {lab=GND}
N 680 -340 680 -300 {lab=Vcm3}
N 680 -380 680 -340 {lab=Vcm3}
N 600 -340 680 -340 {lab=Vcm3}
N 1160 -600 1160 -580 {lab=vout3}
N 1160 -520 1160 -500 {lab=GND}
N 1100 -570 1120 -570 {lab=voutp3}
N 1100 -530 1120 -530 {lab=voutn3}
N 1120 -360 1160 -360 {lab=voutn3}
N 1020 -320 1160 -320 {lab=voutp3}
N 1080 -1000 1220 -1000 {lab=voutp2}
N 1180 -1040 1220 -1040 {lab=voutn2}
N 1080 -1000 1080 -900 {lab=voutp2}
N 1180 -1040 1180 -900 {lab=voutn2}
N 800 -1840 800 -1820 {lab=VDD}
N 1020 -320 1020 -220 {lab=voutp3}
N 1120 -360 1120 -220 {lab=voutn3}
N 1840 -1960 1840 -1920 {lab=Vcm1}
N 1840 -1860 1840 -1820 {lab=GND}
N 2020 -1960 2020 -1920 {lab=Vcm2}
N 2020 -1860 2020 -1820 {lab=GND}
N 2200 -1960 2200 -1920 {lab=Vcm3}
N 2200 -1860 2200 -1820 {lab=GND}
N 800 -1560 800 -1480 {lab=GND}
N 900 -1720 1180 -1720 {lab=voutn1}
N 900 -1680 1080 -1680 {lab=voutp1}
N 380 -300 380 -280 {lab=vdd_noise}
N 380 -220 380 -200 {lab=#net2}
N 380 -140 380 -120 {lab=GND}
N 800 -880 800 -800 {lab=GND}
N 900 -1040 1180 -1040 {lab=voutn2}
N 900 -1000 1080 -1000 {lab=voutp2}
N 800 -200 800 -120 {lab=GND}
N 900 -360 1120 -360 {lab=voutn3}
N 900 -320 1020 -320 {lab=voutp3}
N 100 -1710 120 -1710 {lab=vin}
N 120 -1710 120 -1690 {lab=vin}
N 340 -1740 380 -1740 {lab=vinp1}
N 340 -1660 380 -1660 {lab=vinn1}
N 230 -950 230 -930 {lab=GND}
N 340 -1060 380 -1060 {lab=vinp2}
N 340 -980 380 -980 {lab=vinn2}
N 340 -1020 380 -1020 {lab=Vcm2}
N 140 -1030 180 -1030 {lab=vin}
N 120 -1710 180 -1710 {lab=vin}
N 120 -1630 120 -1600 {lab=GND}
N 230 -1630 230 -1600 {lab=GND}
N 340 -1700 380 -1700 {lab=Vcm1}
N 800 -1820 820 -1820 {lab=VDD}
N 820 -1820 820 -1800 {lab=VDD}
N 800 -1820 800 -1800 {lab=VDD}
N 800 -1160 800 -1140 {lab=VDD}
N 800 -1140 820 -1140 {lab=VDD}
N 820 -1140 820 -1120 {lab=VDD}
N 800 -1140 800 -1120 {lab=VDD}
N 800 -480 800 -440 {lab=vdd_noise}
N 820 -460 820 -440 {lab=VDD}
N 840 -1600 840 -1560 {lab=GND}
N 800 -1560 840 -1560 {lab=GND}
N 800 -1600 800 -1560 {lab=GND}
N 840 -920 840 -880 {lab=GND}
N 800 -880 840 -880 {lab=GND}
N 800 -920 800 -880 {lab=GND}
N 840 -240 840 -200 {lab=GND}
N 800 -200 840 -200 {lab=GND}
N 800 -240 800 -200 {lab=GND}
C {devices/code_shown.sym} 1420 -1390 0 0 {name=NGSPICE
simulator=ngspice
only_toplevel=false
value="
.include CACE\{DUT_path\}
.temp CACE\{temp\}
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15 SEED=CACE[CACE\{seed=12345\} + CACE\{iterations=0\}]
* Flag unsafe operating conditions (exceeds models' specified limits)
.option warn=1
.control

* optran 0 0 0 1u 1m 0

* save v(vin) v(vout1) v(vout2) v(vout3) v(vdd_noise) v(vin_dm) v(vin_cm)
save all

set num_threads=16

* AC Analysis
ac dec 101 1 1G

* Open-loop gain
let Aol=v(vout1)/v(vin)
let Aol_dB = vdb(Aol)

* Common-mode gain
let Acm=v(vout2)/v(vin)
let Acm_dB = vdb(Acm)

* Common Mode Rejection Ratio (CMRR)
* let CMRR = v(vout1)/v(vout2)
let CMRR = v(Aol)/v(Acm)
let CMRR_dB = vdb(CMRR)
* let CMRR_dB = Aol_dB - Acm_dB

* PSRR
let PSRR = v(vdd_noise)/v(vout3)
let PSRR_dB = vdb(PSRR)

* Measurements
* 10Hz open-loop gain
meas ac Adc_ol_dB find Aol_dB when frequency = 10

* Upper 3dB cut-off frequency
let Amag_fc = Adc_ol_dB-3
meas ac fcu find frequency when Aol_dB = Amag_fc FALL=1

* 10Hz CMRR
meas ac CMRR_dc_dB find CMRR_dB when frequency = 10

* 10Hz PSRR
meas ac PSRR_dc_dB find PSRR_dB when frequency = 10

echo $&Adc_ol_dB $&fcu $&CMRR_dc_dB $&PSRR_dc_dB > CACE\{simpath\}/CACE\{filename\}_CACE\{N\}.data

.endc
"}
C {devices/vsource.sym} 1420 -1890 0 0 {name=VDD value=CACE\{vdd\}}
C {devices/capa.sym} 1080 -1550 0 0 {name=C1
m=1
value=CACE\{cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1220 -1680 0 1 {name=p3 sig_type=std_logic lab=voutp1}
C {lab_pin.sym} 1220 -1720 0 1 {name=p4 sig_type=std_logic lab=voutn1}
C {devices/lab_pin.sym} 680 -1740 0 0 {name=l1 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 680 -1660 0 0 {name=l19 sig_type=std_logic lab=vinn1
}
C {devices/capa.sym} 1180 -1550 0 0 {name=C2
m=1
value=CACE\{cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1220 -1960 0 1 {name=l12 sig_type=std_logic lab=vout1}
C {devices/vcvs.sym} 1220 -1910 0 0 {name=E1 value=1}
C {devices/lab_pin.sym} 1160 -1890 2 1 {name=l15 sig_type=std_logic lab=voutn1
}
C {devices/lab_pin.sym} 1160 -1930 0 0 {name=l23 sig_type=std_logic lab=voutp1}
C {devices/vsource.sym} 120 -1660 0 0 {name=vin value="dc 0 ac 1"
}
C {devices/vsource.sym} 1600 -1890 0 0 {name=VSS value=0 savecurrent=false}
C {devices/gnd.sym} 1600 -1820 0 0 {name=l16 lab=GND}
C {devices/lab_wire.sym} 1600 -1960 0 0 {name=p1 sig_type=std_logic lab=VSS}
C {devices/gnd.sym} 1420 -1820 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 1220 -1860 0 0 {name=l6 lab=GND}
C {devices/gnd.sym} 1180 -1480 0 0 {name=l7 lab=GND}
C {devices/gnd.sym} 1080 -1480 0 0 {name=l8 lab=GND}
C {vdd.sym} 1420 -1960 0 0 {name=l21 lab=VDD}
C {devices/capa.sym} 1080 -870 0 0 {name=C3
m=1
value=CACE\{cload\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1220 -1000 0 1 {name=p2 sig_type=std_logic lab=voutp2}
C {lab_pin.sym} 1220 -1040 0 1 {name=p5 sig_type=std_logic lab=voutn2}
C {devices/lab_pin.sym} 680 -1060 0 0 {name=l27 sig_type=std_logic lab=vinp2}
C {devices/lab_pin.sym} 680 -980 0 0 {name=l28 sig_type=std_logic lab=vinn2}
C {devices/capa.sym} 1180 -870 0 0 {name=C4
m=1
value=CACE\{cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1180 -800 0 0 {name=l31 lab=GND}
C {devices/gnd.sym} 1080 -800 0 0 {name=l32 lab=GND}
C {devices/lab_pin.sym} 1220 -1340 0 1 {name=l34 sig_type=std_logic lab=vout2}
C {devices/vcvs.sym} 1220 -1290 0 0 {name=E8 value=0.5}
C {devices/gnd.sym} 1220 -1180 0 0 {name=l36 lab=GND}
C {devices/lab_pin.sym} 1020 -1250 2 1 {name=l39 sig_type=std_logic lab=voutn2
}
C {devices/lab_pin.sym} 1020 -1310 0 0 {name=l40 sig_type=std_logic lab=voutp2
}
C {devices/vcvs.sym} 1100 -1230 0 0 {name=E10 value=-1}
C {devices/gnd.sym} 1100 -1180 0 0 {name=l45 lab=GND}
C {devices/gnd.sym} 1020 -1180 0 0 {name=l46 lab=GND}
C {devices/gnd.sym} 1020 -120 0 0 {name=l20 lab=GND}
C {lab_pin.sym} 1160 -320 0 1 {name=p6 sig_type=std_logic lab=voutp3}
C {lab_pin.sym} 1160 -360 0 1 {name=p7 sig_type=std_logic lab=voutn3}
C {devices/gnd.sym} 1120 -120 0 0 {name=l43 lab=GND}
C {devices/lab_pin.sym} 600 -340 0 0 {name=l47 sig_type=std_logic lab=Vcm3}
C {devices/lab_pin.sym} 1160 -600 0 1 {name=l14 sig_type=std_logic lab=vout3}
C {devices/lab_pin.sym} 1100 -530 2 1 {name=l48 sig_type=std_logic lab=voutn3
}
C {devices/lab_pin.sym} 1100 -570 0 0 {name=l49 sig_type=std_logic lab=voutp3}
C {devices/gnd.sym} 1160 -500 0 0 {name=l50 lab=GND}
C {devices/capa.sym} 1020 -190 0 0 {name=C5
m=1
value=CACE\{cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1120 -190 0 0 {name=C6
m=1
value=CACE\{cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/vcvs.sym} 1160 -550 0 0 {name=E9 value=1}
C {devices/lab_pin.sym} 800 -480 0 0 {name=l44 sig_type=std_logic lab=vdd_noise}
C {devices/gnd.sym} 800 -1480 0 0 {name=l5 lab=GND}
C {vdd.sym} 800 -1840 0 0 {name=l9 lab=VDD}
C {devices/vsource.sym} 1840 -1890 0 0 {name=Vcm1 value=CACE\{vcm\}
}
C {devices/lab_pin.sym} 1840 -1960 2 0 {name=l72 sig_type=std_logic lab=Vcm1}
C {devices/gnd.sym} 1840 -1820 0 0 {name=l73 lab=GND}
C {devices/vsource.sym} 2020 -1890 0 0 {name=Vcm2 value=CACE\{vcm\}
}
C {devices/lab_pin.sym} 2020 -1960 2 0 {name=l74 sig_type=std_logic lab=Vcm2}
C {devices/gnd.sym} 2020 -1820 0 0 {name=l75 lab=GND}
C {devices/vsource.sym} 2200 -1890 0 0 {name=Vcm3 value=CACE\{vcm\}
}
C {devices/lab_pin.sym} 2200 -1960 2 0 {name=l76 sig_type=std_logic lab=Vcm3}
C {devices/gnd.sym} 2200 -1820 0 0 {name=l77 lab=GND}
C {devices/gnd.sym} 380 -120 0 0 {name=l52 lab=GND}
C {devices/vsource.sym} 380 -170 0 0 {name=VDD_PSRR value=CACE\{vdd\}}
C {devices/vsource.sym} 380 -250 0 0 {name=VDD_NOISE value="dc 0 ac 1"}
C {devices/lab_pin.sym} 380 -300 1 0 {name=l41 sig_type=std_logic lab=vdd_noise}
C {devices/gnd.sym} 800 -800 0 0 {name=l53 lab=GND}
C {devices/gnd.sym} 800 -120 0 0 {name=l30 lab=GND}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 800 -1700 0 0 {name=x1
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 800 -1020 0 0 {name=x2
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 800 -340 0 0 {name=x3
spice_ignore=false}
C {devices/lab_pin.sym} 380 -1740 2 0 {name=l33 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 380 -1660 2 0 {name=l37 sig_type=std_logic lab=vinn1}
C {devices/lab_pin.sym} 100 -1710 0 0 {name=l42 sig_type=std_logic lab=vin}
C {devices/gnd.sym} 120 -1600 0 0 {name=l57 lab=GND}
C {devices/gnd.sym} 230 -1600 0 0 {name=l59 lab=GND}
C {devices/lab_pin.sym} 380 -1060 2 0 {name=l60 sig_type=std_logic lab=vinp2}
C {devices/lab_pin.sym} 380 -980 2 0 {name=l61 sig_type=std_logic lab=vinn2}
C {devices/lab_pin.sym} 140 -1030 0 0 {name=l62 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 380 -1020 2 0 {name=l63 sig_type=std_logic lab=Vcm2}
C {devices/gnd.sym} 230 -930 0 0 {name=l64 lab=GND}
C {devices/lab_pin.sym} 380 -1700 2 0 {name=l56 sig_type=std_logic lab=Vcm1}
C {devices/code_shown.sym} 1420 -1590 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_CACE\{corner\}
.lib cornerMOShv.lib mos_CACE\{corner\}
"}
C {vdd.sym} 800 -1160 0 0 {name=l3 lab=VDD}
C {vdd.sym} 820 -460 0 0 {name=l4 lab=VDD}
C {single2dm.sym} 260 -1700 0 0 {name=x4 gain=1}
C {single2cm.sym} 260 -1020 0 0 {name=x5 gain=1}
