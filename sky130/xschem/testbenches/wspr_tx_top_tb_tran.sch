v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1640 -1420 2440 -1020 {flags=graph
y1=-3.16e-05
y2=-3.06e-05
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.0011618927
x2=0.0031763192
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
y1=-0.56
y2=2.1
ypos1=0.1
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=0.0011618927
x2=0.0031763192
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=clock
color=4
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 1640 -580 2440 -180 {flags=graph
y1=-0.098
y2=0.098
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0.0011618927
x2=0.0031763192
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=vout_RF
color=4
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
T {Testbench for transient analysis - WSPR Transmitter} 380 -1730 0 0 1 1 {}
T {External 56MHz Clock Generation} 1120 -1330 0 0 0.3 0.3 {}
T {--> done with crystal oscillator on Eval. Board} 1120 -1150 0 0 0.2 0.2 {}
T {ToDo} 170 -500 0 0 0.4 0.4 {}
T {ToDo} 170 -330 0 0 0.4 0.4 {}
N 1180 -1560 1180 -1520 {lab=VDD}
N 1180 -1460 1180 -1420 {lab=GND}
N 1360 -1560 1360 -1520 {lab=filter_ota_en}
N 1360 -1460 1360 -1420 {lab=GND}
N 640 -260 640 -240 {lab=GND}
N 640 -720 640 -700 {lab=VDD}
N 1180 -1280 1180 -1260 {lab=clock}
N 1180 -1200 1180 -1180 {lab=GND}
N 240 -640 260 -640 {lab=clock}
N 1280 -380 1280 -240 {lab=GND}
N 1020 -480 1100 -480 {lab=vout_RF}
N 1100 -520 1100 -480 {lab=vout_RF}
N 1100 -480 1180 -480 {lab=vout_RF}
N 1380 -480 1460 -480 {lab=vout_RF_filt}
N 180 -600 260 -600 {lab=VDD}
N 180 -720 180 -600 {lab=VDD}
C {devices/code_shown.sym} 40 -1610 0 0 {name=NGSPICE
only_toplevel=true 
value="
* Gate-Level Analog Mixed Signal Simulation (.xspice)
* .include ../../xspice/wspr_transmitter_board/wspr_transmitter_board.xspice
.param VDD=1.8
.param Vcm=VDD/2
.param temp=27
.param Cload=1p
.param fclk=56e6
.csparam fclk=fclk
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

optran 0 0 0 1u 1m 0

save all

* User Constants
let tstop = 2m
let tstep = 1/fclk

* Operating Point Analysis
op
remzerovec
write wspr_tx_top_tb_tran.raw
set appendwrite

* Transient Analysis
tran $&tstep $&tstop
write wspr_tx_top_tb_tran.raw

* Plotting
plot clock reset_n vout_RF

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/wspr_tx_top_tb_tran.txt v(clock) v(reset_n) v(vout_RF)

*quit
.endc
"}
C {devices/vsource.sym} 1180 -1490 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1180 -1420 0 0 {name=l3 lab=GND}
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
C {vdd.sym} 1180 -1560 0 0 {name=l7 lab=VDD}
C {devices/gnd.sym} 1360 -1420 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} 1360 -1560 2 0 {name=l35 sig_type=std_logic lab=filter_ota_en}
C {vsource.sym} 1360 -1490 0 0 {name=Ven value=\{VDD\}}
C {sky130_fd_pr/corner.sym} 1950 -1560 0 0 {name=CORNER only_toplevel=false corner=tt}
C {wspr_tx_top.sym} 640 -480 0 0 {name=x1}
C {vdd.sym} 640 -720 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 640 -240 0 0 {name=l4 lab=GND}
C {devices/lab_wire.sym} 1100 -520 0 1 {name=l5 sig_type=std_logic lab=vout_RF}
C {vdd.sym} 180 -720 0 0 {name=l8 lab=VDD}
C {devices/lab_wire.sym} 1180 -1280 0 0 {name=p17 sig_type=std_logic lab=clock}
C {devices/gnd.sym} 1180 -1180 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 1180 -1230 0 0 {name=vclk value="pulse(0 1.5 0 10p 10p \{0.5/fclk\} \{1/fclk\})"
}
C {devices/lab_wire.sym} 240 -640 0 0 {name=p1 sig_type=std_logic lab=clock}
C {lc_bp_filter.sym} 1280 -480 0 0 {name=x2}
C {devices/gnd.sym} 1280 -240 0 0 {name=l9 lab=GND}
C {devices/lab_wire.sym} 1460 -480 0 1 {name=l10 sig_type=std_logic lab=vout_RF_filt}
