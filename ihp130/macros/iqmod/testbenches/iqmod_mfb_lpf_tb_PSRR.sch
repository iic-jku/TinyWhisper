v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -1140 2460 -740 {flags=graph
y1=-24
y2=140
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
node="\\"PSRR; vdd vout / db20()\\"
\\"PSRR+; vdd voutp / db20()\\"
\\"PSRR-; vdd voutn / db20()\\""
color="4 7 12"
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 1380 -1080 1380 -980 1580 -980 1580 -1080 1380 -1080 {dash = 8}
T {Testbench for PSRR analysis - Third Order MFB Lowpass Filter} 430 -1720 0 0 1 1 {}
T {Capacitive Load} 1380 -910 0 0 0.25 0.25 {}
N 740 -1160 740 -1080 {lab=#net1}
N 1450 -670 1480 -670 {
lab=voutp}
N 1450 -630 1480 -630 {
lab=voutn}
N 1420 -1000 1420 -940 {lab=GND}
N 1520 -1000 1520 -940 {lab=GND}
N 1520 -720 1520 -680 {lab=vout}
N 1520 -620 1520 -580 {lab=GND}
N 740 -760 740 -740 {lab=VDD}
N 740 -680 740 -660 {lab=#net2}
N 740 -600 740 -580 {lab=GND}
N 800 -1160 800 -1120 {lab=#net1}
N 800 -1200 800 -1160 {lab=#net1}
N 1060 -960 1060 -940 {lab=GND}
N 1520 -1180 1560 -1180 {lab=voutp}
N 1420 -1140 1560 -1140 {lab=voutn}
N 740 -1020 740 -940 {lab=GND}
N 1420 -1140 1420 -1060 {lab=voutn}
N 1040 -1400 1040 -1380 {lab=VDD}
N 1520 -1180 1520 -1060 {lab=voutp}
N 1280 -1180 1520 -1180 {lab=voutp}
N 1280 -1140 1420 -1140 {lab=voutn}
N 800 -1200 840 -1200 {lab=#net1}
N 800 -1120 840 -1120 {lab=#net1}
N 740 -1160 800 -1160 {lab=#net1}
N 1040 -1380 1080 -1380 {lab=VDD}
N 1080 -1380 1080 -1360 {lab=VDD}
N 1040 -1380 1040 -1360 {lab=VDD}
C {devices/code_shown.sym} 40 -1430 0 0 {name=NGSPICE
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

save v(VDD) v(vout) v(voutp) v(voutn)

* User Constants
let f_min = 10m
let f_max = 1G
let fdc = 1

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_tb_PSRR.raw
set appendwrite

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_tb_PSRR.raw

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
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mfb_lpf_tb_PSRR.txt v(PSRR_dB)

*quit
.endc
"}
C {devices/launcher.sym} 1720 -1320 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1200 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 1720 -1260 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1420 -940 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 1420 -1030 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1060 -940 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1560 -1180 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 1560 -1140 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/capa.sym} 1520 -1030 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1520 -940 0 0 {name=l30 lab=GND}
C {devices/vsource.sym} 740 -1050 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/gnd.sym} 740 -940 0 0 {name=l40 lab=GND}
C {devices/lab_pin.sym} 1520 -720 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 1520 -650 0 0 {name=E1 value=1}
C {devices/gnd.sym} 1520 -580 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 1450 -630 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 1450 -670 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {devices/gnd.sym} 740 -580 0 0 {name=l16 lab=GND}
C {devices/vdd.sym} 740 -760 0 0 {name=l17 lab=VDD}
C {devices/vsource.sym} 740 -630 0 0 {name=VDD value=\{VDD\}}
C {devices/vsource.sym} 740 -710 0 0 {name=VDD_NOISE value="dc 0 ac 1"}
C {devices/vdd.sym} 1040 -1400 0 0 {name=l4 lab=VDD}
C {iqmod_mfb_lpf.sym} 2820 -720 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_pex.sym} 2820 -240 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf.sym} 1060 -1160 0 0 {name=x4
spice_ignore=false}
C {devices/code_shown.sym} 2000 -1310 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt_mismatch
.lib cornerMOShv.lib mos_tt_mismatch
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
