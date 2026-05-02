v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Third Order Multiple Feedback (MFB) Lowpass Filter} 220 -1720 0 0 1.5 1.5 {}
T {Features of the third-order MFB filter:
-) The -3dB cutoff frequency is nominally set to fc = 400kHz.
-) This allows the use of untrimmed filters with an assumed RC-product frequency variation of +-30%.
-) We select a 3rd-order filter based on the argument that the DS-modulator in the DAC is second order. 
So to suppress the rising quantization noise with a slope of 40dB/dec, we opt for a 3rd-order filter with a filter slope of 60dB/dec.} 1900 -1400 2 0 0.5 0.5 {}
T {RC values:
-) Python script called filter_design.py in TinyWhisper/python/filter_design
-) Online calculator for a 3rd-order multiple-feedback structure: http://sim.okawa-denshi.jp/en/MultipleFB3Lowkeisan.htm} 200 -1350 0 0 0.5 0.5 {}
T {di_filter_ota_en = 1... enable
di_filter_ota_en = 0... disable} 1660 -890 0 0 0.25 0.25 {}
N 1400 -820 1400 -800 {lab=VDD}
N 1400 -840 1400 -820 {lab=VDD}
N 1420 -820 1420 -800 {lab=di_filter_ota_en}
N 1420 -820 1440 -820 {lab=di_filter_ota_en}
N 1440 -840 1440 -820 {lab=di_filter_ota_en}
N 1400 -600 1400 -560 {lab=VSS}
N 1580 -1040 1580 -720 {lab=voutn}
N 1440 -1040 1580 -1040 {lab=voutn}
N 1240 -1040 1380 -1040 {lab=vinp_ota}
N 1020 -820 1100 -820 {lab=#net1}
N 940 -820 1020 -820 {lab=#net1}
N 800 -820 880 -820 {lab=#net2}
N 720 -820 800 -820 {lab=#net2}
N 720 -580 800 -580 {lab=#net3}
N 800 -580 880 -580 {lab=#net3}
N 940 -580 1020 -580 {lab=#net4}
N 580 -820 660 -820 {lab=vinp}
N 580 -580 660 -580 {lab=vinn}
N 1020 -580 1100 -580 {lab=#net4}
N 1580 -1120 1580 -1040 {lab=voutn}
N 1160 -1120 1580 -1120 {lab=voutn}
N 1020 -1120 1100 -1120 {lab=#net1}
N 1440 -360 1580 -360 {lab=voutp}
N 1240 -360 1380 -360 {lab=vinn_ota}
N 1020 -1120 1020 -820 {lab=#net1}
N 1240 -740 1320 -740 {lab=vinp_ota}
N 1240 -820 1240 -740 {lab=vinp_ota}
N 1160 -820 1240 -820 {lab=vinp_ota}
N 1240 -660 1240 -580 {lab=vinn_ota}
N 1240 -660 1320 -660 {lab=vinn_ota}
N 1020 -820 1020 -730 {lab=#net1}
N 800 -820 800 -730 {lab=#net2}
N 800 -670 800 -580 {lab=#net3}
N 1020 -670 1020 -580 {lab=#net4}
N 1160 -580 1240 -580 {lab=vinn_ota}
N 1500 -720 1580 -720 {lab=voutn}
N 1500 -680 1580 -680 {lab=voutp}
N 1580 -680 1580 -360 {lab=voutp}
N 1240 -1040 1240 -820 {lab=vinp_ota}
N 1240 -580 1240 -360 {lab=vinn_ota}
N 1580 -360 1580 -280 {lab=voutp}
N 1020 -580 1020 -280 {lab=#net4}
N 1020 -280 1100 -280 {lab=#net4}
N 1160 -280 1580 -280 {lab=voutp}
N 1740 -720 1820 -720 {lab=voutp}
N 1740 -680 1820 -680 {lab=voutn}
N 1580 -720 1660 -720 {lab=voutn}
N 1580 -680 1660 -680 {lab=voutp}
N 1660 -720 1740 -680 {lab=voutn}
N 1660 -680 1740 -720 {lab=voutp}
N 1240 -820 1260 -820 {lab=vinp_ota}
N 1240 -580 1260 -580 {lab=vinn_ota}
C {devices/iopin.sym} 1400 -840 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1400 -560 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 1440 -840 1 0 {name=p5 lab=di_filter_ota_en}
C {devices/ipin.sym} 580 -820 0 0 {name=p8 lab=vinp}
C {devices/ipin.sym} 580 -580 2 1 {name=p26 lab=vinn}
C {devices/opin.sym} 1820 -720 0 0 {name=p7 lab=voutp}
C {devices/opin.sym} 1820 -680 0 0 {name=p14 lab=voutn}
C {capa.sym} 800 -700 0 1 {name=C1
m=1
value=1.4p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1020 -700 0 1 {name=C2
m=1
value=0.80p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1410 -1040 3 0 {name=C3a
m=1
value=0.1p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1410 -360 3 1 {name=C3b
m=1
value=0.1p
footprint=1206
device="ceramic capacitor"}
C {res.sym} 690 -820 1 0 {name=R1a
value=287k
footprint=1206
device=resistor
m=1}
C {res.sym} 690 -580 1 0 {name=R1b
value=287k
footprint=1206
device=resistor
m=1}
C {res.sym} 910 -820 1 0 {name=R2a
value=301k
footprint=1206
device=resistor
m=1}
C {res.sym} 910 -580 1 0 {name=R2b
value=301k
footprint=1206
device=resistor
m=1}
C {res.sym} 1130 -820 1 0 {name=R3a
value=909k
footprint=1206
device=resistor
m=1}
C {res.sym} 1130 -580 1 0 {name=R3b
value=909k
footprint=1206
device=resistor
m=1}
C {res.sym} 1130 -1120 1 0 {name=R4a
value=590k
footprint=1206
device=resistor
m=1}
C {res.sym} 1130 -280 1 0 {name=R4b
value=590k
footprint=1206
device=resistor
m=1}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/lab_pin.sym} 1260 -820 0 1 {name=l5 sig_type=std_logic lab=vinp_ota}
C {devices/lab_pin.sym} 1260 -580 0 1 {name=l2 sig_type=std_logic lab=vinn_ota}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1400 -700 0 0 {name=x1}
