v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 1920 -880 {}
P 4 5 1920 -880 2340 -880 2340 -600 1920 -600 1920 -880 {dash = 8}
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
di_filter_ota_en = 0... disable} 1540 -890 0 0 0.25 0.25 {}
T {Decoupling Capacitors} 1930 -870 0 0 0.5 0.5 {}
N 1280 -820 1280 -800 {lab=VDD}
N 1280 -840 1280 -820 {lab=VDD}
N 1300 -820 1300 -800 {lab=di_filter_ota_en}
N 1300 -820 1320 -820 {lab=di_filter_ota_en}
N 1320 -840 1320 -820 {lab=di_filter_ota_en}
N 1280 -600 1280 -560 {lab=VSS}
N 1460 -1040 1460 -720 {lab=voutn}
N 1320 -1040 1460 -1040 {lab=voutn}
N 1120 -1040 1260 -1040 {lab=vinp_ota}
N 900 -820 980 -820 {lab=vinp_stage2}
N 700 -820 780 -820 {lab=vinp_stage2}
N 560 -820 640 -820 {lab=vinp_stage1}
N 560 -580 640 -580 {lab=vinn_stage1}
N 700 -580 780 -580 {lab=vinn_stage2}
N 220 -820 300 -820 {lab=vinp}
N 220 -580 300 -580 {lab=vinn}
N 900 -580 980 -580 {lab=vinn_stage2}
N 1460 -1120 1460 -1040 {lab=voutn}
N 1040 -1120 1460 -1120 {lab=voutn}
N 900 -1120 980 -1120 {lab=vinp_stage2}
N 1320 -360 1460 -360 {lab=voutp}
N 1120 -360 1260 -360 {lab=vinn_ota}
N 900 -1120 900 -820 {lab=vinp_stage2}
N 1120 -740 1200 -740 {lab=vinp_ota}
N 1120 -820 1120 -740 {lab=vinp_ota}
N 1040 -820 1120 -820 {lab=vinp_ota}
N 1120 -660 1120 -580 {lab=vinn_ota}
N 1120 -660 1200 -660 {lab=vinn_ota}
N 900 -820 900 -730 {lab=vinp_stage2}
N 560 -820 560 -730 {lab=vinp_stage1}
N 560 -670 560 -580 {lab=vinn_stage1}
N 900 -670 900 -580 {lab=vinn_stage2}
N 1040 -580 1120 -580 {lab=vinn_ota}
N 1380 -720 1460 -720 {lab=voutn}
N 1380 -680 1460 -680 {lab=voutp}
N 1460 -680 1460 -360 {lab=voutp}
N 1120 -1040 1120 -820 {lab=vinp_ota}
N 1120 -580 1120 -360 {lab=vinn_ota}
N 1460 -360 1460 -280 {lab=voutp}
N 900 -580 900 -280 {lab=vinn_stage2}
N 900 -280 980 -280 {lab=vinn_stage2}
N 1040 -280 1460 -280 {lab=voutp}
N 1620 -720 1700 -720 {lab=voutp}
N 1620 -680 1700 -680 {lab=voutn}
N 1460 -720 1540 -720 {lab=voutn}
N 1460 -680 1540 -680 {lab=voutp}
N 1540 -720 1620 -680 {lab=voutn}
N 1540 -680 1620 -720 {lab=voutp}
N 1120 -820 1140 -820 {lab=vinp_ota}
N 1120 -580 1140 -580 {lab=vinn_ota}
N 330 -800 330 -780 {lab=VSS}
N 330 -620 330 -600 {lab=VSS}
N 670 -800 670 -780 {lab=VSS}
N 1010 -800 1010 -780 {lab=VSS}
N 670 -620 670 -600 {lab=VSS}
N 1010 -620 1010 -600 {lab=VSS}
N 1010 -1100 1010 -1080 {lab=VSS}
N 1010 -320 1010 -300 {lab=VSS}
N 560 -840 560 -820 {lab=vinp_stage1}
N 940 -840 940 -820 {lab=vinp_stage2}
N 940 -580 940 -560 {lab=vinn_stage2}
N 560 -580 560 -560 {lab=vinn_stage1}
N 2000 -760 2000 -740 {lab=VDD}
N 2220 -760 2220 -740 {lab=VDD}
N 2220 -680 2220 -660 {lab=VSS}
N 2000 -680 2000 -660 {lab=VSS}
N 440 -670 440 -580 {lab=vinn_stage1}
N 440 -820 440 -730 {lab=vinp_stage1}
N 440 -820 560 -820 {lab=vinp_stage1}
N 440 -580 560 -580 {lab=vinn_stage1}
N 360 -580 440 -580 {lab=vinn_stage1}
N 360 -820 440 -820 {lab=vinp_stage1}
N 780 -820 900 -820 {lab=vinp_stage2}
N 780 -580 900 -580 {lab=vinn_stage2}
N 780 -820 780 -730 {lab=vinp_stage2}
N 780 -670 780 -580 {lab=vinn_stage2}
C {devices/iopin.sym} 1280 -840 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1280 -560 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 1320 -840 1 0 {name=p5 lab=di_filter_ota_en}
C {devices/ipin.sym} 220 -820 0 0 {name=p8 lab=vinp}
C {devices/ipin.sym} 220 -580 2 1 {name=p26 lab=vinn}
C {devices/opin.sym} 1700 -720 0 0 {name=p7 lab=voutp}
C {devices/opin.sym} 1700 -680 0 0 {name=p14 lab=voutn}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/lab_pin.sym} 1140 -820 0 1 {name=l5 sig_type=std_logic lab=vinp_ota}
C {devices/lab_pin.sym} 1140 -580 0 1 {name=l2 sig_type=std_logic lab=vinn_ota}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1290 -1040 3 0 {name=C3a model=cap_mim_m3_1 W=3 L=3 MF=5 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1290 -360 3 0 {name=C3b model=cap_mim_m3_1 W=3 L=3 MF=5 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 560 -700 0 0 {name=C1b model=cap_mim_m3_1 W=3 L=3 MF=35 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 900 -700 0 0 {name=C2b model=cap_mim_m3_1 W=3 L=3 MF=21 spiceprefix=X}
C {lab_pin.sym} 330 -780 1 1 {name=p3 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 330 -620 3 1 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 670 -780 1 1 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1010 -780 1 1 {name=p9 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 670 -620 3 1 {name=p10 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1010 -620 3 1 {name=p11 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1010 -1080 1 1 {name=p12 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1010 -320 3 1 {name=p13 sig_type=std_logic lab=VSS}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 330 -820 3 0 {name=R1a
L=36
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 670 -820 3 0 {name=R2a
L=38
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1010 -820 3 0 {name=R3a
L=126
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1010 -1120 3 0 {name=R4a
L=76
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 330 -580 3 1 {name=R1b
L=36
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 670 -580 3 1 {name=R2b
L=38
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1010 -580 3 1 {name=R3b
L=126
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1010 -280 3 1 {name=R4b
L=76
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 560 -840 3 1 {name=l3 sig_type=std_logic lab=vinp_stage1}
C {devices/lab_pin.sym} 940 -840 3 1 {name=l4 sig_type=std_logic lab=vinp_stage2}
C {devices/lab_pin.sym} 560 -560 1 1 {name=l6 sig_type=std_logic lab=vinn_stage1}
C {devices/lab_pin.sym} 940 -560 1 1 {name=l7 sig_type=std_logic lab=vinn_stage2}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2220 -710 0 0 {name=CDEC2 model=cap_mim_m3_1 W=3 L=3 MF=11 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2000 -710 0 0 {name=CDEC1 model=cap_mim_m3_1 W=3 L=3 MF=11 spiceprefix=X}
C {lab_pin.sym} 2000 -660 1 1 {name=p15 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 2220 -660 1 1 {name=p16 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 2000 -760 3 1 {name=p23 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 2220 -760 3 1 {name=p24 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/cap_mim_m3_1.sym} 440 -700 2 0 {name=C1a model=cap_mim_m3_1 W=3 L=3 MF=35 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 780 -700 2 0 {name=C2a model=cap_mim_m3_1 W=3 L=3 MF=21 spiceprefix=X}
C {wspr_tx_iqmod_mfb_lpf_ota_core_gen.sym} 1280 -700 0 0 {name=x1 W_long=18.0 W_short=12.0 a=3 L=1.0 NF_long=6 NF_short=4}
