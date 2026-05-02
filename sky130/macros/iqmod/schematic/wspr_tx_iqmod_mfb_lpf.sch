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
N 1020 -820 1100 -820 {lab=vinp_stage2}
N 820 -820 900 -820 {lab=vinp_stage2}
N 680 -820 760 -820 {lab=vinp_stage1}
N 680 -580 760 -580 {lab=vinn_stage1}
N 820 -580 900 -580 {lab=vinn_stage2}
N 340 -820 420 -820 {lab=vinp}
N 340 -580 420 -580 {lab=vinn}
N 1020 -580 1100 -580 {lab=vinn_stage2}
N 1580 -1120 1580 -1040 {lab=voutn}
N 1160 -1120 1580 -1120 {lab=voutn}
N 1020 -1120 1100 -1120 {lab=vinp_stage2}
N 1440 -360 1580 -360 {lab=voutp}
N 1240 -360 1380 -360 {lab=vinn_ota}
N 1020 -1120 1020 -820 {lab=vinp_stage2}
N 1240 -740 1320 -740 {lab=vinp_ota}
N 1240 -820 1240 -740 {lab=vinp_ota}
N 1160 -820 1240 -820 {lab=vinp_ota}
N 1240 -660 1240 -580 {lab=vinn_ota}
N 1240 -660 1320 -660 {lab=vinn_ota}
N 1020 -820 1020 -730 {lab=vinp_stage2}
N 680 -820 680 -730 {lab=vinp_stage1}
N 680 -670 680 -580 {lab=vinn_stage1}
N 1020 -670 1020 -580 {lab=vinn_stage2}
N 1160 -580 1240 -580 {lab=vinn_ota}
N 1500 -720 1580 -720 {lab=voutn}
N 1500 -680 1580 -680 {lab=voutp}
N 1580 -680 1580 -360 {lab=voutp}
N 1240 -1040 1240 -820 {lab=vinp_ota}
N 1240 -580 1240 -360 {lab=vinn_ota}
N 1580 -360 1580 -280 {lab=voutp}
N 1020 -580 1020 -280 {lab=vinn_stage2}
N 1020 -280 1100 -280 {lab=vinn_stage2}
N 1160 -280 1580 -280 {lab=voutp}
N 1740 -720 1820 -720 {lab=voutp}
N 1740 -680 1820 -680 {lab=voutn}
N 1580 -720 1660 -720 {lab=voutn}
N 1580 -680 1660 -680 {lab=voutp}
N 1660 -720 1740 -680 {lab=voutn}
N 1660 -680 1740 -720 {lab=voutp}
N 1240 -820 1260 -820 {lab=vinp_ota}
N 1240 -580 1260 -580 {lab=vinn_ota}
N 450 -800 450 -780 {lab=VSS}
N 450 -620 450 -600 {lab=VSS}
N 790 -800 790 -780 {lab=VSS}
N 1130 -800 1130 -780 {lab=VSS}
N 790 -620 790 -600 {lab=VSS}
N 1130 -620 1130 -600 {lab=VSS}
N 1130 -1100 1130 -1080 {lab=VSS}
N 1130 -320 1130 -300 {lab=VSS}
N 680 -840 680 -820 {lab=vinp_stage1}
N 1060 -840 1060 -820 {lab=vinp_stage2}
N 1060 -580 1060 -560 {lab=vinn_stage2}
N 680 -580 680 -560 {lab=vinn_stage1}
N 560 -670 560 -580 {lab=vinn_stage1}
N 560 -820 560 -730 {lab=vinp_stage1}
N 560 -820 680 -820 {lab=vinp_stage1}
N 560 -580 680 -580 {lab=vinn_stage1}
N 480 -580 560 -580 {lab=vinn_stage1}
N 480 -820 560 -820 {lab=vinp_stage1}
N 900 -820 1020 -820 {lab=vinp_stage2}
N 900 -580 1020 -580 {lab=vinn_stage2}
N 900 -820 900 -730 {lab=vinp_stage2}
N 900 -670 900 -580 {lab=vinn_stage2}
C {devices/iopin.sym} 1400 -840 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1400 -560 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 1440 -840 1 0 {name=p5 lab=di_filter_ota_en}
C {devices/ipin.sym} 340 -820 0 0 {name=p8 lab=vinp}
C {devices/ipin.sym} 340 -580 2 1 {name=p26 lab=vinn}
C {devices/opin.sym} 1820 -720 0 0 {name=p7 lab=voutp}
C {devices/opin.sym} 1820 -680 0 0 {name=p14 lab=voutn}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/lab_pin.sym} 1260 -820 0 1 {name=l5 sig_type=std_logic lab=vinp_ota}
C {devices/lab_pin.sym} 1260 -580 0 1 {name=l2 sig_type=std_logic lab=vinn_ota}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1410 -1040 3 0 {name=C3a model=cap_mim_m3_1 W=3 L=3 MF=5 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1410 -360 3 0 {name=C3b model=cap_mim_m3_1 W=3 L=3 MF=5 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 680 -700 0 0 {name=C1b model=cap_mim_m3_1 W=3 L=3 MF=35 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1020 -700 0 0 {name=C2b model=cap_mim_m3_1 W=3 L=3 MF=21 spiceprefix=X}
C {lab_pin.sym} 450 -780 1 1 {name=p3 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 450 -620 3 1 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 790 -780 1 1 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1130 -780 1 1 {name=p9 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 790 -620 3 1 {name=p10 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1130 -620 3 1 {name=p11 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1130 -1080 1 1 {name=p12 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1130 -320 3 1 {name=p13 sig_type=std_logic lab=VSS}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 450 -820 3 0 {name=R1a
L=36
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 790 -820 3 0 {name=R2a
L=38
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1130 -820 3 0 {name=R3a
L=126
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1130 -1120 3 0 {name=R4a
L=76
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 450 -580 3 1 {name=R1b
L=36
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 790 -580 3 1 {name=R2b
L=38
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1130 -580 3 1 {name=R3b
L=126
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_xhigh_po_0p35.sym} 1130 -280 3 1 {name=R4b
L=76
model=res_xhigh_po_0p35
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 680 -840 3 1 {name=l3 sig_type=std_logic lab=vinp_stage1}
C {devices/lab_pin.sym} 1060 -840 3 1 {name=l4 sig_type=std_logic lab=vinp_stage2}
C {devices/lab_pin.sym} 680 -560 1 1 {name=l6 sig_type=std_logic lab=vinn_stage1}
C {devices/lab_pin.sym} 1060 -560 1 1 {name=l7 sig_type=std_logic lab=vinn_stage2}
C {sky130_fd_pr/cap_mim_m3_1.sym} 560 -700 2 0 {name=C1a model=cap_mim_m3_1 W=3 L=3 MF=35 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 900 -700 2 0 {name=C2a model=cap_mim_m3_1 W=3 L=3 MF=21 spiceprefix=X}
C {wspr_tx_iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1400 -700 0 0 {name=x1}
