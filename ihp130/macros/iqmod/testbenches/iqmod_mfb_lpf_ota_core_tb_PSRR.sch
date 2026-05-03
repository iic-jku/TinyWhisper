v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1000 2440 -600 {flags=graph
y1=10
y2=84
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
node="\\"PSRR; vdd vout / db20()\\"
\\"PSRR+; vdd voutp / db20()\\"
\\"PSRR-; vdd voutn / db20()\\""
color="4 7 12"
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 1280 -980 1280 -880 1480 -880 1480 -980 1280 -980 {dash = 8}
T {Testbench for PSRR analysis - OTA Core} 670 -1720 0 0 1 1 {}
T {Capacitive Load} 1280 -830 0 0 0.25 0.25 {}
N 900 -1060 940 -1060 {lab=#net1}
N 900 -980 940 -980 {lab=#net1}
N 820 -1020 820 -980 {lab=#net1}
N 820 -920 820 -860 {lab=GND}
N 1350 -650 1380 -650 {
lab=voutp}
N 1350 -610 1380 -610 {
lab=voutn}
N 1020 -1140 1020 -1120 {lab=VDD}
N 1020 -920 1020 -860 {lab=GND}
N 1420 -1040 1460 -1040 {lab=voutn}
N 1320 -1000 1460 -1000 {lab=voutp}
N 1320 -1000 1320 -960 {lab=voutp}
N 1120 -1000 1320 -1000 {lab=voutp}
N 1320 -900 1320 -860 {lab=GND}
N 1420 -1040 1420 -960 {lab=voutn}
N 1120 -1040 1420 -1040 {lab=voutn}
N 1420 -900 1420 -860 {lab=GND}
N 1420 -700 1420 -660 {lab=vout}
N 1420 -600 1420 -560 {lab=GND}
N 820 -740 820 -720 {lab=VDD}
N 820 -660 820 -640 {lab=#net2}
N 820 -580 820 -560 {lab=GND}
N 900 -1020 900 -980 {lab=#net1}
N 900 -1060 900 -1020 {lab=#net1}
N 820 -1020 900 -1020 {lab=#net1}
N 1020 -1140 1040 -1140 {lab=VDD}
N 1020 -1160 1020 -1140 {lab=VDD}
N 1040 -1140 1040 -1120 {lab=VDD}
C {devices/code_shown.sym} 40 -1370 0 0 {name=NGSPICE
only_toplevel=true 
value="
.include ../../netlist/pex/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* save v(VDD) v(vout) v(voutp) v(voutn)
save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 0.1
let f_max = 1G
let fdc = 1

* Operating Point Analysis
op
remzerovec
write @schname\\\\.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write @schname\\\\.raw

* Plotting
let PSRR = v(VDD)/v(vout)
let PSRRp = v(VDD)/v(voutp)
let PSRRn = v(VDD)/v(voutn)
		
let PSRR_dB = vdb(PSRR)
let PSRRp_dB = vdb(PSRRp)
let PSRRn_dB = vdb(PSRRn)

plot PSRR_dB PSRRp_dB PSRRn_dB ylabel 'PSRR, PSRR+, PSRR-'

* Measurements
meas ac PSRRdc_dB find PSRR_dB when frequency = fdc
print PSRRdc_dB

meas ac PSRRpdc_dB find PSRRp_dB when frequency = fdc
print PSRRpdc_dB

meas ac PSRRndc_dB find PSRRn_dB when frequency = fdc
print PSRRndc_dB

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_ota_core_tb_PSRR.txt v(PSRR_dB)

*quit
.endc
"}
C {devices/launcher.sym} 1700 -1180 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1700 -1060 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1700 -1120 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1320 -860 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 1320 -930 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 1020 -1160 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 1020 -860 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1460 -1000 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1460 -1040 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/capa.sym} 1420 -930 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1420 -860 0 0 {name=l30 lab=GND}
C {devices/vsource.sym} 820 -950 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/gnd.sym} 820 -860 0 0 {name=l40 lab=GND}
C {devices/lab_pin.sym} 1420 -700 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1420 -630 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1420 -560 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1350 -610 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1350 -650 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {devices/gnd.sym} 820 -560 0 0 {name=l16 lab=GND}
C {devices/vdd.sym} 820 -740 0 0 {name=l17 lab=VDD}
C {devices/vsource.sym} 820 -610 0 0 {name=VDD value=\{VDD\}}
C {devices/vsource.sym} 820 -690 0 0 {name=VDD_NOISE value="dc 0 ac 1"}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2660 -440 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 2660 -140 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1020 -1020 0 0 {name=x4
spice_ignore=false}
C {devices/code_shown.sym} 1960 -1170 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt_mismatch
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
