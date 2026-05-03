v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -860 2440 -460 {flags=graph
y1=4.7
y2=13
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.023119605
x2=1.4768804
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
color=7
node="\\"r_w_dummy_on; vout_tg_w_dummy_on vin_tg - i(vds_x3) /\\""
linewidth_mult=4}
T {TGs are ON!} 1240 -710 0 0 0.5 0.5 {}
T {Testbench for transient analysis - Transmission Gate} 560 -1690 0 0 1 1 {}
N 980 -640 980 -580 {
lab=GND}
N 820 -640 820 -580 {
lab=GND}
N 820 -760 820 -700 {
lab=VDD}
N 940 -960 980 -960 {
lab=vin_tg}
N 1060 -960 1100 -960 {
lab=vin_tg}
N 1260 -960 1360 -960 {
lab=vout_tg_w_dummy_on}
N 1160 -1020 1160 -1000 {
lab=VDD}
N 1180 -1020 1180 -1000 {
lab=VDD}
N 1360 -960 1400 -960 {
lab=vout_tg_w_dummy_on}
N 980 -960 1060 -960 {
lab=vin_tg}
N 1160 -1020 1180 -1020 {lab=VDD}
N 1160 -1040 1160 -1020 {lab=VDD}
N 1160 -900 1160 -880 {lab=GND}
N 1180 -920 1180 -900 {lab=GND}
N 1160 -900 1180 -900 {lab=GND}
N 1160 -920 1160 -900 {lab=GND}
N 1220 -780 1360 -780 {lab=vout_tg_w_dummy_on}
N 1360 -960 1360 -780 {
lab=vout_tg_w_dummy_on}
N 1060 -780 1160 -780 {lab=vin_tg}
N 1060 -960 1060 -780 {
lab=vin_tg}
N 980 -960 980 -700 {lab=vin_tg}
C {devices/vsource.sym} 820 -670 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 820 -580 0 0 {name=l6 lab=GND}
C {devices/vdd.sym} 820 -760 0 0 {name=l8 lab=VDD}
C {devices/vsource.sym} 980 -670 0 0 {name=vin value=0
}
C {devices/lab_wire.sym} 940 -960 0 0 {name=p2 sig_type=std_logic lab=vin_tg}
C {devices/gnd.sym} 980 -580 0 0 {name=l1 lab=GND}
C {devices/launcher.sym} 1700 -1030 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1700 -910 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw dc"
}
C {devices/launcher.sym} 1700 -970 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {code_shown.sym} 40 -1010 0 0 {name=NGSPICE
only_toplevel=true
value="
.include ../../netlist/pex/iqmod_mixer_tg_pex.spice
.param VDD=1.5
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.options savecurrents method=gear reltol=1e-3 abstol=1e-15 gmin=1e-15
.control

save all

* Operating Point Analysis
op
remzerovec
write @schname\\\\.raw
set appendwrite

* DC Sweep Analysis
dc vin 0 $&VDD 0.01
write @schname\\\\.raw

* On-Resistance
* LV with Dummy
let r_w_dummy_on = (v(vout_tg_w_dummy_on)-v(vin_tg))/I(vds_x3)
plot r_w_dummy_on xlabel 'Vin in V' ylabel 'Ron with Dummy in Ohm'

* Writing Data
unset appendwrite
set wr_singlescale
set wr_vecnames
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mixer_tg_tb_dc_Ron.txt v(r_w_dummy_on)

*quit
.endc"}
C {devices/lab_wire.sym} 1400 -960 0 1 {name=p3 sig_type=std_logic lab=vout_tg_w_dummy_on}
C {devices/gnd.sym} 1160 -880 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 1160 -1040 0 0 {name=l5 lab=VDD}
C {devices/vsource.sym} 1190 -780 3 0 {name=vds_x3 value=1mV
}
C {title-3.sym} 0 0 0 0 {name=l7 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/code_shown.sym} 2000 -1020 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {iqmod_mixer_tg.sym} 1180 -1420 0 0 {name=x1
spice_ignore = true}
C {iqmod_mixer_tg_pex.sym} 1180 -1220 0 0 {name=x2
spice_ignore=true}
C {iqmod_mixer_tg_pex.sym} 1180 -960 0 0 {name=x3
}
