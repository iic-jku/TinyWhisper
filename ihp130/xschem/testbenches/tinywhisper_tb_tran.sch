v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 60 -1860 860 -1460 {flags=graph
y1=-0.56
y2=2.1
ypos1=0.1
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=-0.0022004113
x2=-0.00018598484
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="clock
reset_n
spi_si
spi_sclk
spi_sram_ce
uart_tx"
color="4 21 12 12 12 17"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 900 -1860 1700 -1460 {flags=graph
y1=-0.56
y2=2.1
ypos1=0.4
ypos2=2.4
divy=5
subdivy=1
unity=1
x1=-0.0022004113
x2=-0.00018598484
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="i2c_sda
i2c_sda_oe
i2c_scl
gpio_0
gpio_1
gpio_2
gpio_3"
color="4 4 4 21 21 21 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 1740 -1860 2540 -1460 {flags=graph
y1=-0.56
y2=2.1
ypos1=-0.11072601
ypos2=2.1957989
divy=5
subdivy=1
unity=1
x1=-0.0022004113
x2=-0.00018598484
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="ds_I_oe
ds_I_p
ds_I_n
ds_Q_n
ds_Q_p
ds_Q_oe"
color="4 4 4 21 21 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 2580 -1860 3380 -1460 {flags=graph
y1=-0.56
y2=2.1
ypos1=0.21018722
ypos2=2.3445009
divy=5
subdivy=1
unity=1
x1=-0.0022004113
x2=-0.00018598484
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="lo_I_oe
lo_I
lo_Ix
lo_Qx
lo_Q
lo_Q_oe"
color="4 4 4 21 21 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1
hilight_wave=4}
B 2 60 -2280 860 -1880 {flags=graph
y1=-0.12
y2=-0.044
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0022004113
x2=-0.00018598484
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
B 2 900 -2280 1700 -1880 {flags=graph
y1=-0.11
y2=1.4
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.0022004113
x2=-0.00018598484
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vout_RF
vout_RF_filt"
color="4 7"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
T {Testbench for transient analysis - WSPR Transmitter} 950 -2390 0 0 1 1 {}
N 2460 -2080 2460 -2040 {lab=VDD}
N 2460 -1980 2460 -1940 {lab=GND}
N 1800 -1980 1800 -1940 {lab=GND}
N 1800 -2100 1800 -2040 {lab=clock}
N 2120 -1980 2120 -1940 {lab=GND}
N 2120 -2100 2120 -2040 {lab=reset_n}
N 2980 -840 2980 -800 {lab=vout_RF}
N 3140 -700 3140 -620 {lab=GND}
N 3300 -680 3300 -620 {lab=GND}
N 3300 -800 3300 -740 {lab=vout_RF_filt}
N 2980 -800 2980 -740 {lab=vout_RF}
N 2980 -680 2980 -620 {lab=GND}
N 160 -460 160 -280 {lab=GND}
N 160 -980 200 -980 {lab=GND}
N 160 -720 200 -720 {lab=GND}
N 160 -980 160 -720 {lab=GND}
N 160 -460 200 -460 {lab=GND}
N 160 -720 160 -460 {lab=GND}
N 120 -1180 200 -1180 {lab=clock}
N 120 -1120 200 -1120 {lab=reset_n}
N 120 -940 200 -940 {lab=spi_si}
N 120 -900 200 -900 {lab=spi_sclk}
N 120 -860 200 -860 {lab=spi_sram_ce}
N 120 -680 200 -680 {lab=i2c_sda}
N 120 -640 200 -640 {lab=i2c_sda_oe}
N 120 -600 200 -600 {lab=i2c_scl}
N 120 -420 200 -420 {lab=uart_tx}
N 540 -1360 600 -1360 {lab=GND}
N 600 -1360 600 -1300 {lab=GND}
N 540 -1360 540 -1300 {lab=GND}
N 480 -1360 540 -1360 {lab=GND}
N 480 -1360 480 -1300 {lab=GND}
N 420 -1360 480 -1360 {lab=GND}
N 420 -1360 420 -1300 {lab=GND}
N 160 -1360 420 -1360 {lab=GND}
N 160 -1360 160 -980 {lab=GND}
N 420 -300 420 -260 {lab=gpio_0}
N 480 -300 480 -260 {lab=gpio_1}
N 540 -300 540 -260 {lab=gpio_2}
N 600 -300 600 -260 {lab=gpio_3}
N 920 -1320 920 -1300 {lab=VDD}
N 2500 -1320 2500 -1300 {lab=VDD}
N 1540 -300 1540 -280 {lab=GND}
N 1860 -300 1860 -260 {lab=ds_Q_oe}
N 1900 -300 1900 -260 {lab=ds_Q_p}
N 1940 -300 1940 -260 {lab=ds_Q_n}
N 1980 -300 1980 -260 {lab=lo_Q_oe}
N 2020 -300 2020 -260 {lab=lo_Q}
N 2060 -300 2060 -260 {lab=lo_Qx}
N 1880 -300 1880 -280 {lab=GND}
N 2140 -280 2180 -280 {lab=GND}
N 2120 -300 2120 -280 {lab=GND}
N 2040 -280 2120 -280 {lab=GND}
N 2140 -300 2140 -280 {lab=GND}
N 2120 -280 2140 -280 {lab=GND}
N 2040 -300 2040 -280 {lab=GND}
N 2000 -280 2040 -280 {lab=GND}
N 2000 -300 2000 -280 {lab=GND}
N 1920 -280 2000 -280 {lab=GND}
N 1920 -300 1920 -280 {lab=GND}
N 1880 -280 1920 -280 {lab=GND}
N 1880 -1320 1880 -1300 {lab=GND}
N 2140 -1320 2180 -1320 {lab=GND}
N 1920 -1320 1920 -1300 {lab=GND}
N 1880 -1320 1920 -1320 {lab=GND}
N 2000 -1320 2000 -1300 {lab=GND}
N 1920 -1320 2000 -1320 {lab=GND}
N 2040 -1320 2040 -1300 {lab=GND}
N 2000 -1320 2040 -1320 {lab=GND}
N 2120 -1320 2120 -1300 {lab=GND}
N 2040 -1320 2120 -1320 {lab=GND}
N 2140 -1320 2140 -1300 {lab=GND}
N 2120 -1320 2140 -1320 {lab=GND}
N 1860 -1340 1860 -1300 {lab=ds_I_oe}
N 1900 -1340 1900 -1300 {lab=ds_I_p}
N 1940 -1340 1940 -1300 {lab=ds_I_n}
N 1980 -1340 1980 -1300 {lab=lo_I_oe}
N 2020 -1340 2020 -1300 {lab=lo_I}
N 2060 -1340 2060 -1300 {lab=lo_Ix}
N 2880 -480 2920 -480 {lab=vout_RF}
N 2920 -540 2920 -480 {lab=vout_RF}
N 2880 -1120 2920 -1120 {lab=vout_RF}
N 2880 -1060 2920 -1060 {lab=vout_RF}
N 2920 -1120 2920 -1060 {lab=vout_RF}
N 2880 -540 2920 -540 {lab=vout_RF}
N 2920 -800 2920 -540 {lab=vout_RF}
N 2920 -800 2980 -800 {lab=vout_RF}
N 2920 -1060 2920 -800 {lab=vout_RF}
N 2980 -800 3040 -800 {lab=vout_RF}
N 3240 -800 3300 -800 {lab=vout_RF_filt}
N 3300 -840 3300 -800 {lab=vout_RF_filt}
C {devices/code.sym} 2870 -2060 0 0 {name=NGSPICE
only_toplevel=true 
value="
* Gate-Level Analog Mixed Signal Simulation (.xspice)
.include /foss/designs/TinyWhisper/ihp130/macros/riscv/xspice/riscv_top/riscv_top.xspice
.param VDD=1.5
.param temp=27
.param Cload=10p
.param Rload=1k
.param fclk=56e6
.csparam fclk=fclk
.param fsig=124.600e3
.csparam fsig=fsig
.param flo=fclk/2
.csparam flo=flo
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-12 gmin=1e-12
.control

set num_threads=32

save all

* User Constants
* Increase tstop --> more FFT bins
* Decrease tstep --> higher fs/2 in FFT
let fmin = 0.1 * flo
let fmax = 5 * flo
let tstart = 1/fsig
let tstop = 2/fsig
let tstep = 0.1/flo

* Transient Operating Point Analysis
optran 0 0 0 $&tstep $&tstart 0
* op
remzerovec
write tinywhisper_top_tb_tran.raw
set appendwrite

* Transient Analysis
tran $&tstep $&tstop $&tstart
write tinywhisper_top_tb_tran.raw

* Plotting
plot vout_RF vout_RF_filt

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/tinywhisper_top_tb_tran.txt v(clock) v(reset_n) v(vout_RF) v(vout_RF_filt)

* FFT vout_RF_filt
setplot tran1
linearize vout_RF_filt
set specwindow=hanning
fft vout_RF_filt
setplot sp2

let N = length(vout_RF_filt)
let fres = frequency[n-1]/n
let fmin_idx = ceil(const.fmin/fres)
let fmax_idx = ceil(const.fmax/fres)
let vout_RF_filt_spec = mag(vout_RF_filt)
let vout_RF_filt_spec_slice = vout_RF_filt_spec[fmin_idx,fmax_idx]
let freq = frequency[fmin_idx,fmax_idx]
meas sp vout_RF_filt_max max vout_RF_filt_spec_slice
let vout_RF_filt_spec_db = 20*log10(vout_RF_filt_spec_slice/vout_RF_filt_max)
plot vout_RF_filt_spec_db vs freq

* Write Data
setscale freq
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/tinywhisper_top_tb_tran_fft_filt.txt v(vout_RF_filt_spec_db)

* Calc HD2, HD3
* let sig_idx = ceil(const.f_sig/fres)
* let hd2_idx = 2*sig_idx
* let hd3_idx = 3*sig_idx
* let sig_pwr = iod_spec[sig_idx-1]^2+iod_spec[sig_idx]^2+iod_spec[sig_idx+1]^2
* let hd2_pwr = iod_spec[hd2_idx-1]^2+iod_spec[hd2_idx]^2+iod_spec[hd2_idx+1]^2
* let hd3_pwr = iod_spec[hd3_idx-1]^2+iod_spec[hd3_idx]^2+iod_spec[hd3_idx+1]^2
* let hd2 = sqrt(hd2_pwr/sig_pwr)
* let hd3 = sqrt(hd3_pwr/sig_pwr)
* let hd2_dB = 20*log10(hd2)
* let hd3_dB = 20*log10(hd3)
* print hd2_dB
* print hd3_dB

*quit
.endc
"}
C {tinywhisper.sym} 1540 -800 0 0 {name=x1}
C {devices/launcher.sym} 2640 -2050 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 2640 -1930 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 2640 -1990 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {devices/code_shown.sym} 3080 -2050 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {devices/vsource.sym} 2460 -2010 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 2460 -1940 0 0 {name=l3 lab=GND}
C {vdd.sym} 2460 -2080 0 0 {name=l7 lab=VDD}
C {devices/lab_wire.sym} 1800 -2100 0 0 {name=p17 sig_type=std_logic lab=clock}
C {devices/gnd.sym} 1800 -1940 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 1800 -2010 0 0 {name=vclk value="pulse(0 \{VDD\} 0 10p 10p \{0.5/fclk\} \{1/fclk\})"
}
C {devices/lab_wire.sym} 2120 -2100 0 0 {name=p18 sig_type=std_logic lab=reset_n}
C {devices/gnd.sym} 2120 -1940 0 0 {name=l10 lab=GND}
C {devices/vsource.sym} 2120 -2010 0 0 {name=vrst value="pulse(\{VDD\} 0 \{2/fclk\} 10p 10p \{2/fclk\} 1 1)"
}
C {devices/lab_wire.sym} 3300 -840 0 1 {name=l37 sig_type=std_logic lab=vout_RF_filt}
C {devices/lab_wire.sym} 2980 -840 0 1 {name=l21 sig_type=std_logic lab=vout_RF}
C {devices/gnd.sym} 3140 -620 0 0 {name=l36 lab=GND}
C {res.sym} 3300 -710 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 3300 -620 0 0 {name=l42 lab=GND}
C {devices/capa.sym} 2980 -710 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2980 -620 0 0 {name=l43 lab=GND}
C {coupled_resonator_lc_bpf_1k_1k.sym} 3140 -800 0 0 {name=x3}
C {devices/lab_wire.sym} 120 -1120 0 0 {name=p1 sig_type=std_logic lab=reset_n}
C {devices/lab_wire.sym} 120 -1180 0 0 {name=p2 sig_type=std_logic lab=clock}
C {devices/lab_wire.sym} 120 -600 0 0 {name=p7 sig_type=std_logic lab=i2c_scl}
C {devices/lab_wire.sym} 120 -640 0 0 {name=p8 sig_type=std_logic lab=i2c_sda_oe}
C {devices/lab_wire.sym} 120 -680 0 0 {name=p9 sig_type=std_logic lab=i2c_sda}
C {devices/lab_wire.sym} 120 -420 0 0 {name=p10 sig_type=std_logic lab=uart_tx}
C {devices/lab_wire.sym} 120 -860 0 0 {name=p11 sig_type=std_logic lab=spi_sram_ce}
C {devices/lab_wire.sym} 120 -900 0 0 {name=p12 sig_type=std_logic lab=spi_sclk}
C {devices/lab_wire.sym} 120 -940 0 0 {name=p13 sig_type=std_logic lab=spi_si}
C {devices/gnd.sym} 160 -280 0 0 {name=l5 lab=GND}
C {devices/lab_wire.sym} 420 -260 3 0 {name=p3 sig_type=std_logic lab=gpio_0}
C {devices/lab_wire.sym} 480 -260 3 0 {name=p4 sig_type=std_logic lab=gpio_1}
C {devices/lab_wire.sym} 540 -260 3 0 {name=p5 sig_type=std_logic lab=gpio_2}
C {devices/lab_wire.sym} 600 -260 3 0 {name=p6 sig_type=std_logic lab=gpio_3}
C {devices/lab_wire.sym} 1860 -1340 3 1 {name=p15 sig_type=std_logic lab=ds_I_oe}
C {devices/lab_wire.sym} 1900 -1340 3 1 {name=p16 sig_type=std_logic lab=ds_I_p}
C {devices/lab_wire.sym} 1940 -1340 3 1 {name=p19 sig_type=std_logic lab=ds_I_n}
C {devices/lab_wire.sym} 1980 -1340 3 1 {name=p20 sig_type=std_logic lab=lo_I_oe}
C {devices/lab_wire.sym} 2020 -1340 3 1 {name=p21 sig_type=std_logic lab=lo_I}
C {devices/lab_wire.sym} 2060 -1340 3 1 {name=p22 sig_type=std_logic lab=lo_Ix}
C {devices/lab_wire.sym} 1860 -260 3 0 {name=p31 sig_type=std_logic lab=ds_Q_oe}
C {devices/lab_wire.sym} 1900 -260 3 0 {name=p32 sig_type=std_logic lab=ds_Q_p}
C {devices/lab_wire.sym} 1980 -260 3 0 {name=p23 sig_type=std_logic lab=lo_Q_oe}
C {devices/lab_wire.sym} 2020 -260 3 0 {name=p24 sig_type=std_logic lab=lo_Q}
C {devices/lab_wire.sym} 2060 -260 3 0 {name=p25 sig_type=std_logic lab=lo_Qx}
C {vdd.sym} 920 -1320 0 0 {name=l1 lab=VDD}
C {vdd.sym} 2500 -1320 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 1540 -280 0 0 {name=l4 lab=GND}
C {devices/lab_wire.sym} 1940 -260 3 0 {name=p14 sig_type=std_logic lab=ds_Q_n}
C {devices/gnd.sym} 2180 -280 0 0 {name=l6 lab=GND}
C {devices/gnd.sym} 2180 -1320 0 0 {name=l8 lab=GND}
C {title-2.sym} 0 0 0 0 {name=l9 author="Simon Dorrer" rev=1.0 lock=true}
