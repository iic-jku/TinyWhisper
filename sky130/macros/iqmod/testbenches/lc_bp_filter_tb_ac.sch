v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -760 2460 -360 {flags=graph
y1=0
y2=0.01
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-35
x2=-35
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"CL Phase; ph(vout)\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 1660 -1180 2460 -780 {flags=graph
y1=-20
y2=1.7
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-35
x2=-35
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"CL Magnitude; vout vin / db20()\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
T {Testbench for AC analysis - LC Bandpass Filter} 620 -1720 0 0 1 1 {}
N 1460 -740 1460 -680 {lab=GND}
N 1160 -760 1160 -680 {lab=GND}
N 760 -860 760 -800 {lab=vin}
N 760 -740 760 -680 {lab=GND}
N 680 -860 760 -860 {lab=vin}
N 1260 -860 1340 -860 {lab=vout}
N 1340 -740 1340 -680 {lab=GND}
N 1340 -860 1340 -800 {lab=vout}
N 1460 -860 1540 -860 {lab=vout}
N 1460 -860 1460 -800 {lab=vout}
N 1340 -860 1460 -860 {lab=vout}
N 760 -860 840 -860 {lab=vin}
N 900 -860 980 -860 {lab=#net1}
N 980 -860 1060 -860 {lab=#net1}
N 980 -860 980 -800 {lab=#net1}
N 980 -740 980 -680 {lab=GND}
C {devices/code_shown.sym} 60 -1350 0 0 {name=NGSPICE
only_toplevel=true
lock=true
value="
.param temp=27
.param Rin=1k
.param Cin=10p
.param Rload=1k
.param Cload=1p
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 9.8e6
let f_max = 10.0e6
let fdc = 9.9e6

* Operating Point Analysis
op
remzerovec
write lc_bp_filter_tb_ac.raw
set appendwrite

* AC Analysis
ac dec 10001 $&const.f_min $&const.f_max
remzerovec
write lc_bp_filter_tb_ac.raw
set appendwrite

* Plotting
let Amag = v(vout)/v(vin)		
let Amag_dB = vdb(Amag)
let Aarg = 180/PI*cphase(Amag)

plot Amag_dB ylabel 'Magnitude'
plot Aarg ylabel 'Phase'
plot Amag_dB Aarg ylabel 'Magnitude, Phase'

* Measurements
meas ac Adc_cl_dB find Amag_dB when frequency = fdc
print Adc_cl_dB

let Amag_fc = Adc_cl_dB-3
meas ac fcl find frequency when Amag_dB = Amag_fc RISE=1
print fcl

meas ac fcu find frequency when Amag_dB = Amag_fc FALL=1
print fcu

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/lc_bp_filter_tb_ac.txt v(Amag_dB) v(Aarg)

quit
.endc
"}
C {devices/gnd.sym} 1460 -680 0 0 {name=l1 lab=GND}
C {devices/launcher.sym} 1720 -1360 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/capa.sym} 1460 -770 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1240 0 0 {name=h1
descr="Load waves"
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"

}
C {devices/launcher.sym} 1720 -1300 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1160 -680 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1540 -860 0 1 {name=p3 sig_type=std_logic lab=vout}
C {devices/lab_pin.sym} 680 -860 0 0 {name=l19 sig_type=std_logic lab=vin
}
C {devices/gnd.sym} 760 -680 0 0 {name=l39 lab=GND}
C {devices/vsource.sym} 760 -770 0 0 {name=vin value="dc 0 ac 1"
}
C {sky130_fd_pr/corner.sym} 1950 -1340 0 0 {name=CORNER only_toplevel=false corner=tt}
C {lc_bp_filter.sym} 1160 -860 0 0 {name=x1}
C {res.sym} 1340 -770 0 0 {name=R2
value=\{Rload\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1340 -680 0 0 {name=l3 lab=GND}
C {res.sym} 870 -860 1 0 {name=R1
value=\{Rin\}
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 980 -770 0 0 {name=C1
m=1
value=\{Cin\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 980 -680 0 0 {name=l4 lab=GND}
