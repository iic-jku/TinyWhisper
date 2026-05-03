v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 1810 -80 1810 0 {}
L 4 1810 -160 1810 -80 {}
L 4 1810 -160 2500 -160 {}
L 4 1810 -80 2500 -80 {}
B 2 1660 -1440 2460 -1040 {flags=graph
y1=-0.028
y2=2.632
ypos1=-0.028
ypos2=2.632
divy=5
subdivy=1
unity=1
x1=1.018731e-05
x2=1.0188643e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="LO_I
LO_Q
LO_IX
LO_QX"
color="4 7 12 21"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0
digital=1}
B 2 1660 -1020 2460 -620 {flags=graph
y1=1.1e-12
y2=1.5
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.018731e-05
x2=1.0188643e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="vinp1_IF
vinn1_IF
vinp2_IF
vinn2_IF
vout_RF"
color="4 7 12 21 18"
dataset=-1
unitx=1
logx=0
logy=0
linewidth_mult=3
autoload=0}
B 2 1660 -600 2460 -200 {flags=graph
y1=-2.6e-09
y2=0.48
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.018731e-05
x2=1.0188643e-05
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
B 2 2540 -1440 3340 -1040 {flags=graph
y1=-0.098
y2=-0.064
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1.018731e-05
x2=1.0188643e-05
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
B 4 0 -1840 2500 0 {fill = false
lock = true}
T {Testbench for transient analysis - Passive Voltage-Mode Mixer} 440 -1810 0 0 1 1 {}
T {Simon Dorrer} 1830 -150 0 0 0.8 0.8 {}
N 1380 -140 1380 -80 {lab=GND}
N 560 -980 560 -940 {lab=GND}
N 520 -1200 520 -1180 {lab=VDD}
N 480 -980 480 -940 {lab=LO_I}
N 380 -940 480 -940 {lab=LO_I}
N 380 -1060 420 -1060 {lab=vinn1_IF}
N 380 -1100 420 -1100 {lab=vinp1_IF}
N 520 -980 520 -900 {lab=LO_IX}
N 380 -900 520 -900 {lab=LO_IX}
N 1380 -260 1380 -200 {lab=VDD}
N 560 -580 560 -540 {lab=GND}
N 520 -800 520 -780 {lab=VDD}
N 480 -580 480 -540 {lab=LO_Q}
N 380 -540 480 -540 {lab=LO_Q}
N 380 -660 420 -660 {lab=vinn2_IF}
N 380 -700 420 -700 {lab=vinp2_IF}
N 520 -580 520 -500 {lab=LO_QX}
N 380 -500 520 -500 {lab=LO_QX}
N 820 -880 820 -680 {lab=vout_RF}
N 820 -1080 820 -880 {lab=vout_RF}
N 1260 -140 1260 -80 {lab=GND}
N 1260 -260 1260 -200 {lab=Vcm}
N 380 -180 380 -160 {lab=LO_Q}
N 380 -100 380 -80 {lab=GND}
N 820 -180 820 -160 {lab=LO_QX}
N 820 -100 820 -80 {lab=GND}
N 820 -360 820 -340 {lab=LO_IX}
N 820 -280 820 -260 {lab=GND}
N 380 -360 380 -340 {lab=LO_I}
N 380 -280 380 -260 {lab=GND}
N 900 -920 900 -880 {lab=vout_RF}
N 1080 -780 1080 -700 {lab=GND}
N 1180 -880 1260 -880 {lab=vout_RF_filt}
N 1260 -760 1260 -700 {lab=GND}
N 1260 -880 1260 -820 {lab=vout_RF_filt}
N 820 -880 900 -880 {lab=vout_RF}
N 900 -880 900 -820 {lab=vout_RF}
N 900 -760 900 -700 {lab=GND}
N 900 -880 980 -880 {lab=vout_RF}
N 380 -1490 400 -1490 {lab=vin1}
N 400 -1490 400 -1470 {lab=vin1}
N 620 -1520 660 -1520 {lab=vinp1_IF}
N 620 -1440 660 -1440 {lab=vinn1_IF}
N 400 -1490 460 -1490 {lab=vin1}
N 400 -1410 400 -1380 {lab=GND}
N 510 -1410 510 -1380 {lab=GND}
N 620 -1480 660 -1480 {lab=Vcm}
N 1020 -1490 1040 -1490 {lab=vin2}
N 1040 -1490 1040 -1470 {lab=vin2}
N 1260 -1520 1300 -1520 {lab=vinp2_IF}
N 1260 -1440 1300 -1440 {lab=vinn2_IF}
N 1040 -1490 1100 -1490 {lab=vin2}
N 1040 -1410 1040 -1380 {lab=GND}
N 1150 -1410 1150 -1380 {lab=GND}
N 1260 -1480 1300 -1480 {lab=Vcm}
N 1260 -880 1340 -880 {lab=vout_RF_filt}
N 620 -700 700 -700 {lab=vout_RF}
N 620 -660 700 -660 {lab=vout_RF}
N 700 -680 700 -660 {lab=vout_RF}
N 620 -1100 700 -1100 {lab=vout_RF}
N 620 -1060 700 -1060 {lab=vout_RF}
N 700 -1080 820 -1080 {lab=vout_RF}
N 700 -1100 700 -1080 {lab=vout_RF}
N 700 -1080 700 -1060 {lab=vout_RF}
N 700 -680 820 -680 {lab=vout_RF}
N 700 -700 700 -680 {lab=vout_RF}
C {devices/code.sym} 70 -1600 0 0 {name=NGSPICE
only_toplevel=true
value="
.include ../../netlist/pex/iqmod_mixer_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.param Rload=1k
.param fsig=124.600e3
.csparam fsig=fsig
.param flo=28e6
.csparam flo=flo
.options savecurrents klu method=gear reltol=1e-3 abstol=1e-12 gmin=1e-12
.control

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

* Operating Point Analysis
* op
* remzerovec
* write @schname\\\\.raw
* set appendwrite

* Transient Analysis
tran $&tstep $&tstop $&tstart
write @schname\\\\.raw

* Plotting
plot vinp1_IF vinn1_IF vinp2_IF vinn2_IF
plot LO_I LO_IX LO_Q LO_QX
plot vout_RF vout_RF_filt

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mixer_tb_tran.txt v(vinp1_IF) v(vinn1_IF) v(vinp2_IF) v(vinn2_IF) v(LO_I) v(LO_IX) v(LO_Q) v(LO_QX) v(vout_RF) v(vout_RF_filt)

* FFT vout_RF
* setplot tran1
* linearize vout_RF
* set specwindow=hanning
* fft vout_RF
* setplot sp2

* let N = length(vout_RF)
* let fres = frequency[n-1]/n
* let fmin_idx = ceil(const.fmin/fres)
* let fmax_idx = ceil(const.fmax/fres)
* let vout_RF_spec = mag(vout_RF)
* let vout_RF_spec_slice = vout_RF_spec[fmin_idx,fmax_idx]
* let freq = frequency[fmin_idx,fmax_idx]
* meas sp vout_RF_max max vout_RF_spec_slice
* let vout_RF_spec_db = 20*log10(vout_RF_spec_slice/vout_RF_max)
* plot vout_RF_spec_db vs freq

* Write Data
* setscale freq
* unset appendwrite
* set wr_vecnames
* set wr_singlescale
* wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mixer_tb_tran_fft.txt v(vout_RF_spec_db)

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
wrdata $PROJECT_PATH/scripts/plot_simulations/data/iqmod_mixer_tb_tran_fft_filt.txt v(vout_RF_filt_spec_db)

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
C {devices/vsource.sym} 1380 -170 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 1380 -80 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 1720 -1600 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 1720 -1480 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw tran"
}
C {devices/launcher.sym} 1720 -1540 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 1380 -260 0 0 {name=l7 lab=VDD}
C {vdd.sym} 520 -1200 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 560 -940 0 0 {name=l4 lab=GND}
C {iqmod_mixer.sym} 1380 -1180 0 0 {name=x6
spice_ignore=true}
C {devices/gnd.sym} 380 -260 0 0 {name=l14 lab=GND}
C {devices/lab_wire.sym} 380 -360 0 1 {name=l15 sig_type=std_logic lab=LO_I}
C {devices/gnd.sym} 820 -260 0 0 {name=l9 lab=GND}
C {devices/lab_wire.sym} 820 -360 0 1 {name=l10 sig_type=std_logic lab=LO_IX}
C {devices/vsource.sym} 380 -310 0 0 {name=Vloi value="pulse(0 \{VDD\} 0 10p 10p \{0.25/flo\} \{1/flo\})"}
C {devices/lab_wire.sym} 380 -940 0 0 {name=l11 sig_type=std_logic lab=LO_I}
C {devices/lab_wire.sym} 380 -900 0 0 {name=l12 sig_type=std_logic lab=LO_IX}
C {devices/lab_pin.sym} 380 -1100 0 0 {name=l18 sig_type=std_logic lab=vinp1_IF}
C {devices/lab_pin.sym} 380 -1060 0 0 {name=l19 sig_type=std_logic lab=vinn1_IF
}
C {devices/vsource.sym} 1040 -1440 0 1 {name=vsine spice_ignore=False value="sin(0 \{VDD\} \{fsig\})"
}
C {devices/vsource.sym} 820 -310 0 0 {name=Vloix value="pulse(0 \{VDD\} \{0.50/flo\} 10p 10p \{0.25/flo\} \{1/flo\})"}
C {vdd.sym} 520 -800 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} 560 -540 0 0 {name=l20 lab=GND}
C {devices/lab_pin.sym} 380 -700 0 0 {name=l25 sig_type=std_logic lab=vinp2_IF}
C {devices/lab_pin.sym} 380 -660 0 0 {name=l26 sig_type=std_logic lab=vinn2_IF
}
C {devices/lab_wire.sym} 380 -540 0 0 {name=l8 sig_type=std_logic lab=LO_Q}
C {devices/lab_wire.sym} 380 -500 0 0 {name=l22 sig_type=std_logic lab=LO_QX
}
C {devices/gnd.sym} 380 -80 0 0 {name=l23 lab=GND}
C {devices/lab_wire.sym} 380 -180 0 1 {name=l24 sig_type=std_logic lab=LO_Q}
C {devices/gnd.sym} 820 -80 0 0 {name=l27 lab=GND}
C {devices/lab_wire.sym} 820 -180 0 1 {name=l28 sig_type=std_logic lab=LO_QX}
C {devices/vsource.sym} 820 -130 0 0 {name=Vloqx value="pulse(0 \{VDD\} \{0.75/flo\} 10p 10p \{0.25/flo\} \{1/flo\})"}
C {devices/lab_pin.sym} 1300 -1520 0 1 {name=l29 sig_type=std_logic lab=vinp2_IF}
C {devices/lab_pin.sym} 1300 -1440 0 1 {name=l30 sig_type=std_logic lab=vinn2_IF
}
C {devices/vsource.sym} 400 -1440 0 1 {name=vcosine spice_ignore=False value="sin(0 \{VDD\} \{fsig\} 0 0 90)"
}
C {devices/vsource.sym} 1260 -170 0 0 {name=Vcm value=\{Vcm\}
}
C {devices/lab_pin.sym} 1260 -260 1 0 {name=l34 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 1260 -80 0 0 {name=l40 lab=GND}
C {devices/vsource.sym} 380 -130 0 0 {name=Vloq value="pulse(0 \{VDD\} \{0.25/flo\} 10p 10p \{0.25/flo\} \{1/flo\})"}
C {devices/lab_wire.sym} 1340 -880 0 1 {name=l37 sig_type=std_logic lab=vout_RF_filt}
C {devices/lab_wire.sym} 900 -920 0 1 {name=l21 sig_type=std_logic lab=vout_RF}
C {devices/gnd.sym} 1080 -700 0 0 {name=l36 lab=GND}
C {res.sym} 1260 -790 0 0 {name=R1
value=\{Rload\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1260 -700 0 0 {name=l42 lab=GND}
C {devices/gnd.sym} 900 -700 0 0 {name=l43 lab=GND}
C {devices/lab_pin.sym} 380 -1490 0 0 {name=l45 sig_type=std_logic lab=vin1}
C {devices/lab_pin.sym} 660 -1480 2 0 {name=l46 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 400 -1380 0 0 {name=l47 lab=GND}
C {devices/gnd.sym} 510 -1380 0 0 {name=l49 lab=GND}
C {devices/lab_pin.sym} 1020 -1490 0 0 {name=l17 sig_type=std_logic lab=vin2}
C {devices/lab_pin.sym} 1300 -1480 2 0 {name=l38 sig_type=std_logic lab=Vcm}
C {devices/gnd.sym} 1040 -1380 0 0 {name=l39 lab=GND}
C {devices/gnd.sym} 1150 -1380 0 0 {name=l41 lab=GND}
C {devices/lab_pin.sym} 660 -1520 0 1 {name=l5 sig_type=std_logic lab=vinp1_IF}
C {devices/lab_pin.sym} 660 -1440 0 1 {name=l13 sig_type=std_logic lab=vinn1_IF
}
C {devices/code_shown.sym} 1980 -1600 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
C {devices/capa.sym} 900 -790 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {coupled_resonator_lc_bpf_1k_1k.sym} 1080 -880 0 0 {name=x3}
C {iqmod_mixer_pex.sym} 1040 -1180 0 0 {name=x5
spice_ignore=true}
C {iqmod_mixer_pex.sym} 520 -1080 0 0 {name=x1
}
C {iqmod_mixer_pex.sym} 520 -680 0 0 {name=x2
}
C {single2dm.sym} 540 -1480 0 0 {name=x4 gain=1}
C {single2dm.sym} 1180 -1480 0 0 {name=x7 gain=1}
