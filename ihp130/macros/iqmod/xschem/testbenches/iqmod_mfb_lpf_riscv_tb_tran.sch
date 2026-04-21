v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1740 -2220 2540 -1820 {flags=graph
y1=-0.0077
y2=-0.0069
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
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
B 2 2580 -2220 3380 -1820 {flags=graph
y1=-3.1e-06
y2=3e-06
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
color="4 21"
node="i(Vmeasp)
i(Vmeasn)"}
B 2 1740 -1800 2540 -1400 {flags=graph
y1=0.5
y2=1
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="x4.vinp_stage1
x4.vinn_stage1
x4.vinp_stage2
x4.vinn_stage2
x4.vinp_ota
x4.vinn_ota"
color="4 7 18 17 9 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 60 -2220 860 -1820 {flags=graph
y1=-0.56
y2=2.1
ypos1=-0.56
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="clock
reset_n
analog_en
spi_si
spi_sclk
spi_sram_ce
uart_tx"
color="4 21 12 17 17 17 5"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 60 -1800 860 -1400 {flags=graph
y1=-0.56
y2=2.1
ypos1=-0.56
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
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
B 2 900 -2220 1700 -1820 {flags=graph
y1=-0.56
y2=2.1
ypos1=-0.56
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="I_ae
ds_I_oe
ds_I_p
ds_I_n
ds_Q_n
ds_Q_p
ds_Q_oe
Q_ae"
color="4 4 4 4 21 21 21 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 900 -1800 1700 -1400 {flags=graph
y1=-0.56
y2=2.1
ypos1=-0.56
ypos2=2.1
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
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
digital=1}
B 2 2580 -1800 3380 -1400 {flags=graph
y1=-0.67
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vinp
vinn
voutp
voutn
vout"
color="4 18 21 12 4"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 3470 -1800 4270 -1400 {flags=graph
y1=-0.67
y2=0.67
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=8e-06
x2=3.2e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=vout
color=4
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
P 4 5 2980 -400 2980 -300 3180 -300 3180 -400 2980 -400 {dash = 8}
T {Testbench for transient analysis - RISC-V & Third Order MFB Lowpass Filter} 770 -2410 0 0 1 1 {}
T {Capacitive Load} 2980 -250 0 0 0.25 0.25 {}
N 2640 -240 2640 -220 {lab=GND}
N 2380 -480 2420 -480 {lab=vinp}
N 2380 -400 2420 -400 {lab=vinn}
N 2440 -1080 2440 -1040 {lab=VDD}
N 2440 -980 2440 -940 {lab=GND}
N 3300 -640 3300 -620 {
lab=vout}
N 3230 -610 3260 -610 {
lab=voutp}
N 3230 -570 3260 -570 {
lab=voutn}
N 3300 -560 3300 -540 {lab=GND}
N 3020 -320 3020 -280 {lab=GND}
N 3120 -320 3120 -280 {lab=GND}
N 2860 -460 2980 -460 {lab=#net1}
N 2860 -420 2900 -420 {lab=#net2}
N 3020 -420 3020 -380 {lab=voutp}
N 2960 -420 3020 -420 {lab=voutp}
N 3120 -460 3120 -380 {lab=voutn}
N 3040 -460 3120 -460 {lab=voutn}
N 3220 -420 3220 -380 {lab=voutp}
N 3300 -460 3300 -380 {lab=voutn}
N 3220 -420 3320 -420 {lab=voutp}
N 3020 -420 3220 -420 {lab=voutp}
N 3120 -460 3300 -460 {lab=voutn}
N 3300 -460 3320 -460 {lab=voutn}
N 3220 -320 3220 -280 {lab=GND}
N 3300 -320 3300 -280 {lab=GND}
N 2620 -680 2620 -640 {lab=VDD}
N 2720 -980 2720 -940 {lab=GND}
N 2720 -1100 2720 -1040 {lab=clock}
N 1160 -1260 1160 -1240 {lab=VDD}
N 1160 -240 1160 -220 {lab=GND}
N 3100 -980 3100 -940 {lab=GND}
N 3100 -1100 3100 -1040 {lab=reset_n}
N 620 -240 620 -200 {lab=gpio_0}
N 680 -240 680 -200 {lab=gpio_1}
N 740 -240 740 -200 {lab=gpio_2}
N 800 -240 800 -200 {lab=gpio_3}
N 180 -400 180 -220 {lab=GND}
N 180 -920 220 -920 {lab=GND}
N 180 -660 220 -660 {lab=GND}
N 180 -920 180 -660 {lab=GND}
N 180 -400 220 -400 {lab=GND}
N 180 -660 180 -400 {lab=GND}
N 800 -1280 800 -1240 {lab=GND}
N 740 -1280 800 -1280 {lab=GND}
N 180 -1280 180 -920 {lab=GND}
N 620 -1280 620 -1240 {lab=GND}
N 180 -1280 620 -1280 {lab=GND}
N 680 -1280 680 -1240 {lab=GND}
N 620 -1280 680 -1280 {lab=GND}
N 740 -1280 740 -1240 {lab=GND}
N 680 -1280 740 -1280 {lab=GND}
N 140 -1120 220 -1120 {lab=clock}
N 140 -1060 220 -1060 {lab=reset_n}
N 140 -880 220 -880 {lab=spi_si}
N 140 -840 220 -840 {lab=spi_sclk}
N 140 -800 220 -800 {lab=spi_sram_ce}
N 140 -620 220 -620 {lab=i2c_sda}
N 140 -580 220 -580 {lab=i2c_sda_oe}
N 140 -540 220 -540 {lab=i2c_scl}
N 140 -360 220 -360 {lab=uart_tx}
N 2100 -1160 2180 -1160 {lab=I_ae}
N 2100 -1120 2180 -1120 {lab=ds_I_oe}
N 2100 -1040 2180 -1040 {lab=ds_I_p}
N 2100 -960 2180 -960 {lab=ds_I_n}
N 2100 -320 2180 -320 {lab=Q_ae}
N 2100 -360 2180 -360 {lab=ds_Q_oe}
N 2100 -440 2180 -440 {lab=ds_Q_p}
N 2100 -520 2180 -520 {lab=ds_Q_n}
N 2100 -920 2180 -920 {lab=lo_I_oe}
N 2100 -840 2180 -840 {lab=lo_I}
N 2100 -760 2180 -760 {lab=lo_Ix}
N 2100 -560 2180 -560 {lab=lo_Q_oe}
N 2100 -640 2180 -640 {lab=lo_Q}
N 2100 -720 2180 -720 {lab=lo_Qx}
N 2140 -400 2140 -220 {lab=GND}
N 2100 -1080 2140 -1080 {lab=GND}
N 2100 -400 2140 -400 {lab=GND}
N 2140 -480 2140 -400 {lab=GND}
N 2100 -480 2140 -480 {lab=GND}
N 2140 -600 2140 -480 {lab=GND}
N 2100 -600 2140 -600 {lab=GND}
N 2140 -680 2140 -600 {lab=GND}
N 2100 -680 2140 -680 {lab=GND}
N 2140 -800 2140 -680 {lab=GND}
N 2100 -800 2140 -800 {lab=GND}
N 2140 -880 2140 -800 {lab=GND}
N 2100 -880 2140 -880 {lab=GND}
N 2140 -1000 2140 -880 {lab=GND}
N 2100 -1000 2140 -1000 {lab=GND}
N 2140 -1080 2140 -1000 {lab=GND}
N 2020 -1240 2180 -1240 {lab=analog_en}
N 2660 -680 2660 -640 {lab=analog_en}
N 2940 -820 2980 -820 {lab=vinp}
N 3040 -820 3080 -820 {lab=ds_I_p}
N 2940 -720 2980 -720 {lab=vinn}
N 3040 -720 3080 -720 {lab=ds_I_n}
C {devices/code.sym} 3090 -1320 0 0 {name=NGSPICE
only_toplevel=true
value="
*.include ../../spice/iqmod_mfb_lpf_pex.spice
.include /foss/designs/TinyWhisper/ihp130/macros/riscv/xspice/riscv_top/riscv_top.xspice
.param VDD=1.5
.csparam VDD=VDD
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.param Rload=1k
.param fclk=56e6
.csparam fclk=fclk
.param fsig = 125e3
.csparam fsig = fsig
.param flo=fclk/2
.csparam flo=flo
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-12 gmin=1e-12
.control

set num_threads=16

save all

* User Constants
* Increase tstop --> more FFT bins
* Decrease tstep --> higher fs/2 in FFT
let fmin = 0.1 * fsig
let fmax = 5 * fsig
let tstart = 1/fsig
let tstop = 4/fsig
let tstep = 0.1/flo

* Transient Operating Point Analysis
optran 0 0 0 $&tstep $&tstart 0
* op
remzerovec
write iqmod_mfb_lpf_riscv_tb_tran.raw
set appendwrite

* Transient Analysis
tran $&tstep $&tstop $&tstart
write iqmod_mfb_lpf_riscv_tb_tran.raw

* Measurements
meas tran vin_peak MAX v(vin)
meas tran vout_peak MAX v(vout)

let Adm = vout_peak / vin_peak
let Adm_dB = vdb(Adm)
print Adm_dB

meas tran vout_pp_max MAX v(voutp)
meas tran vout_pp_min MIN v(voutp)
let vout_pp = vout_pp_max - vout_pp_min
print vout_pp

* Calculation of Power Consumption & Efficiency
let PDD_inst = VDD * -i(VDD)
meas tran PDD_int INTEG PDD_inst from=tstart to=tstop
let PDD = 1/(tstop - tstart) * PDD_int * 1e3
echo PDD = $&PDD mW

let Pout_inst = v(vout) * (i(Vmeasp) - i(Vmeasn))
meas tran Pout_int INTEG Pout_inst from=tstart to=tstop
let Pout = 1/(tstop - tstart) * Pout_int * 1e3
echo Pout = $&Pout mW

let efficiency = Pout / PDD * 100
echo efficiency = $&efficiency %

* Plotting
plot vinp vinn x4.vinp_stage1 x4.vinn_stage1 x4.vinp_stage2 x4.vinn_stage2 voutp voutn
plot voutp voutn vout analog_en

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_riscv_tb_tran.txt v(vin) v(vinp) v(vinn) v(voutp) v(voutn) v(vout)

* FFT vout
setplot tran1
linearize vout
set specwindow=hanning
fft vout
setplot sp2

let N = length(vout)
let fres = frequency[n-1]/n
let fmin_idx = ceil(const.fmin/fres)
let fmax_idx = ceil(const.fmax/fres)
let vout_spec = mag(vout)
let vout_spec_slice = vout_spec[fmin_idx,fmax_idx]
let freq = frequency[fmin_idx,fmax_idx]
meas sp vout_max max vout_spec_slice
let vout_spec_db = 20*log10(vout_spec_slice/vout_max)
plot vout_spec_db vs freq

* Write Data
setscale freq
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_riscv_tb_tran_fft.txt v(vout_spec_db)


*quit
.endc
"}
C {devices/vsource.sym} 2440 -1010 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 2440 -940 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 2500 -1330 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {title-2.sym} 0 0 0 0 {name=l2 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/launcher.sym} 2500 -1210 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 2500 -1270 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 2440 -1080 0 0 {name=l7 lab=VDD}
C {vdd.sym} 2620 -680 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 2640 -220 0 0 {name=l9 lab=GND}
C {devices/lab_pin.sym} 3300 -640 0 1 {name=l12 sig_type=std_logic lab=vout}
C {devices/vcvs.sym} 3300 -590 0 0 {name=E1 value=1}
C {devices/gnd.sym} 3300 -540 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 3230 -570 2 1 {name=l15 sig_type=std_logic lab=voutn
}
C {devices/lab_pin.sym} 3230 -610 0 0 {name=l23 sig_type=std_logic lab=voutp
}
C {iqmod_mfb_lpf.sym} 3680 -240 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_pex.sym} 3680 -700 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf.sym} 2640 -440 0 0 {name=x4
spice_ignore=false}
C {devices/code_shown.sym} 2720 -1330 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {devices/gnd.sym} 3020 -280 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 3020 -350 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"
}
C {lab_pin.sym} 3320 -420 0 1 {name=p3 sig_type=std_logic lab=voutp}
C {lab_pin.sym} 3320 -460 0 1 {name=p4 sig_type=std_logic lab=voutn}
C {devices/capa.sym} 3120 -350 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"
}
C {devices/gnd.sym} 3120 -280 0 0 {name=l30 lab=GND}
C {vsource.sym} 2930 -420 3 1 {name=Vmeasp value=0 savecurrent=false}
C {vsource.sym} 3010 -460 3 1 {name=Vmeasn value=0 savecurrent=false}
C {res.sym} 3220 -350 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1
spice_ignore=true}
C {res.sym} 3300 -350 0 0 {name=R2
value=\{Rload\}
footprint=1206
device=resistor
m=1
spice_ignore=true}
C {devices/gnd.sym} 3220 -280 0 0 {name=l6 lab=GND}
C {devices/gnd.sym} 3300 -280 0 0 {name=l10 lab=GND}
C {devices/lab_wire.sym} 2720 -1100 0 0 {name=p17 sig_type=std_logic lab=clock}
C {devices/gnd.sym} 2720 -940 0 0 {name=l13 lab=GND}
C {devices/vsource.sym} 2720 -1010 0 0 {name=vclk value="pulse(0 \{VDD\} 0 10p 10p \{0.5/fclk\} \{1/fclk\})"
}
C {devices/lab_wire.sym} 3100 -1100 0 0 {name=p18 sig_type=std_logic lab=reset_n}
C {devices/gnd.sym} 3100 -940 0 0 {name=l16 lab=GND}
C {devices/vsource.sym} 3100 -1010 0 0 {name=vrst value="pulse(\{VDD\} 0 \{2/fclk\} 10p 10p \{2/fclk\} 1 1)"
}
C {vdd.sym} 1160 -1260 0 0 {name=l17 lab=VDD}
C {devices/gnd.sym} 1160 -220 0 0 {name=l18 lab=GND}
C {devices/lab_wire.sym} 140 -1060 0 0 {name=p1 sig_type=std_logic lab=reset_n}
C {devices/lab_wire.sym} 140 -1120 0 0 {name=p2 sig_type=std_logic lab=clock}
C {devices/lab_wire.sym} 620 -200 3 0 {name=p5 sig_type=std_logic lab=gpio_0}
C {devices/lab_wire.sym} 680 -200 3 0 {name=p6 sig_type=std_logic lab=gpio_1}
C {devices/lab_wire.sym} 740 -200 3 0 {name=p7 sig_type=std_logic lab=gpio_2}
C {devices/lab_wire.sym} 800 -200 3 0 {name=p8 sig_type=std_logic lab=gpio_3}
C {devices/lab_wire.sym} 140 -540 0 0 {name=p9 sig_type=std_logic lab=i2c_scl}
C {devices/lab_wire.sym} 140 -580 0 0 {name=p10 sig_type=std_logic lab=i2c_sda_oe}
C {devices/lab_wire.sym} 140 -620 0 0 {name=p11 sig_type=std_logic lab=i2c_sda}
C {devices/lab_wire.sym} 140 -360 0 0 {name=p12 sig_type=std_logic lab=uart_tx}
C {devices/lab_wire.sym} 140 -800 0 0 {name=p13 sig_type=std_logic lab=spi_sram_ce}
C {devices/lab_wire.sym} 140 -840 0 0 {name=p14 sig_type=std_logic lab=spi_sclk}
C {devices/lab_wire.sym} 140 -880 0 0 {name=p15 sig_type=std_logic lab=spi_si}
C {devices/gnd.sym} 180 -220 0 0 {name=l20 lab=GND}
C {devices/lab_wire.sym} 2180 -1160 0 1 {name=p16 sig_type=std_logic lab=I_ae}
C {devices/lab_wire.sym} 2180 -1120 0 1 {name=p19 sig_type=std_logic lab=ds_I_oe}
C {devices/lab_wire.sym} 2180 -1040 0 1 {name=p20 sig_type=std_logic lab=ds_I_p}
C {devices/lab_wire.sym} 2180 -960 0 1 {name=p21 sig_type=std_logic lab=ds_I_n}
C {devices/lab_wire.sym} 2180 -920 0 1 {name=p22 sig_type=std_logic lab=lo_I_oe}
C {devices/lab_wire.sym} 2180 -840 0 1 {name=p23 sig_type=std_logic lab=lo_I}
C {devices/lab_wire.sym} 2180 -760 0 1 {name=p24 sig_type=std_logic lab=lo_Ix}
C {devices/lab_wire.sym} 2180 -320 0 1 {name=p30 sig_type=std_logic lab=Q_ae}
C {devices/lab_wire.sym} 2180 -360 0 1 {name=p31 sig_type=std_logic lab=ds_Q_oe}
C {devices/lab_wire.sym} 2180 -440 0 1 {name=p32 sig_type=std_logic lab=ds_Q_p}
C {devices/lab_wire.sym} 2180 -520 0 1 {name=p33 sig_type=std_logic lab=ds_Q_n}
C {devices/lab_wire.sym} 2180 -560 0 1 {name=p25 sig_type=std_logic lab=lo_Q_oe}
C {devices/lab_wire.sym} 2180 -640 0 1 {name=p26 sig_type=std_logic lab=lo_Q}
C {devices/lab_wire.sym} 2180 -720 0 1 {name=p27 sig_type=std_logic lab=lo_Qx}
C {devices/gnd.sym} 2140 -220 0 0 {name=l21 lab=GND}
C {riscv_top.sym} 1160 -740 0 0 {name=x1}
C {devices/lab_wire.sym} 2180 -1240 0 1 {name=p28 sig_type=std_logic lab=analog_en}
C {devices/lab_wire.sym} 2660 -680 1 0 {name=p29 sig_type=std_logic lab=analog_en}
C {devices/lab_pin.sym} 2940 -820 0 0 {name=l4 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 2940 -720 0 0 {name=l5 sig_type=std_logic lab=vinn
}
C {ammeter.sym} 3010 -820 1 0 {name=Vmeas1p savecurrent=true spice_ignore=0}
C {ammeter.sym} 3010 -720 1 0 {name=Vmeasn1 savecurrent=true spice_ignore=0}
C {devices/lab_pin.sym} 3080 -820 0 1 {name=l11 sig_type=std_logic lab=ds_I_p}
C {devices/lab_pin.sym} 3080 -720 0 1 {name=l19 sig_type=std_logic lab=ds_I_n
}
C {devices/lab_pin.sym} 2380 -480 0 0 {name=l22 sig_type=std_logic lab=vinp}
C {devices/lab_pin.sym} 2380 -400 0 0 {name=l24 sig_type=std_logic lab=vinn
}
