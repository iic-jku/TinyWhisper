v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1660 -760 2460 -360 {flags=graph
y1=-180
y2=180
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=7.4313638
x2=7.4627606
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
y1=-22
y2=-6
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=7.4313638
x2=7.4627606
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
N 1180 -820 1180 -740 {lab=GND}
N 860 -920 860 -860 {lab=vin}
N 860 -800 860 -740 {lab=GND}
N 780 -920 860 -920 {lab=vin}
N 1280 -920 1360 -920 {lab=vout}
N 1360 -800 1360 -740 {lab=GND}
N 1360 -920 1360 -860 {lab=vout}
N 860 -920 940 -920 {lab=vin}
N 1000 -920 1080 -920 {lab=#net1}
N 1360 -920 1440 -920 {lab=vout}
C {devices/code_shown.sym} 60 -1350 0 0 {name=NGSPICE
only_toplevel=true
lock=true
value="
.param temp=27
.param Rin=1k
.param Rload=1k
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

save all

set wr_vecnames
set wr_singlescale

* User Constants
let f_min = 27.0e6
let f_max = 29.0e6
let fdc = 28e6

* Operating Point Analysis
op
remzerovec
write coupled_resonator_lc_bpf_tb_ac.raw
set appendwrite

* AC Analysis
ac dec 10001 $&const.f_min $&const.f_max
remzerovec
write coupled_resonator_lc_bpf_tb_ac.raw
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

quit
.endc
"}
C {devices/launcher.sym} 1720 -1360 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-3.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 1720 -1240 0 0 {name=h1
descr="Load waves"
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"

}
C {devices/launcher.sym} 1720 -1300 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/gnd.sym} 1180 -740 0 0 {name=l9 lab=GND}
C {lab_pin.sym} 1440 -920 0 1 {name=p3 sig_type=std_logic lab=vout}
C {devices/lab_pin.sym} 780 -920 0 0 {name=l19 sig_type=std_logic lab=vin
}
C {devices/gnd.sym} 860 -740 0 0 {name=l39 lab=GND}
C {devices/vsource.sym} 860 -830 0 0 {name=vin value="dc 0 ac 1"
}
C {res.sym} 1360 -830 0 0 {name=R2
value=\{Rload\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1360 -740 0 0 {name=l3 lab=GND}
C {res.sym} 970 -920 1 0 {name=R1
value=\{Rin\}
footprint=1206
device=resistor
m=1}
C {devices/code_shown.sym} 1960 -1350 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {coupled_resonator_lc_bpf_1k_1k.sym} 1180 -920 0 0 {name=x1}
