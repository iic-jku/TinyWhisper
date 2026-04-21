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
-) Python script called 3rd_order_mfb_lpf_designer.py in /python/filter_designer} 200 -1350 0 0 0.5 0.5 {}
N 1660 -1060 1660 -740 {lab=voutn}
N 1520 -1060 1660 -1060 {lab=voutn}
N 1320 -1060 1460 -1060 {lab=vinp_ota}
N 1660 -1140 1660 -1060 {lab=voutn}
N 1520 -380 1660 -380 {lab=voutp}
N 1320 -380 1460 -380 {lab=vinn_ota}
N 1100 -1140 1100 -840 {lab=vinp_stage2}
N 1320 -760 1400 -760 {lab=vinp_ota}
N 1320 -600 1320 -380 {lab=vinn_ota}
N 1320 -680 1400 -680 {lab=vinn_ota}
N 1100 -840 1100 -750 {lab=vinp_stage2}
N 760 -840 760 -750 {lab=vinp_stage1}
N 760 -690 760 -600 {lab=vinn_stage1}
N 1100 -690 1100 -600 {lab=vinn_stage2}
N 1660 -700 1660 -380 {lab=voutp}
N 1320 -840 1320 -760 {lab=vinp_ota}
N 1660 -380 1660 -300 {lab=voutp}
N 1100 -600 1100 -300 {lab=vinn_stage2}
N 1820 -740 1900 -740 {lab=voutp}
N 1820 -700 1900 -700 {lab=voutn}
N 1660 -740 1740 -740 {lab=voutn}
N 1660 -700 1740 -700 {lab=voutp}
N 1740 -740 1820 -700 {lab=voutn}
N 1740 -700 1820 -740 {lab=voutp}
N 640 -690 640 -600 {lab=vinn_stage1}
N 640 -840 640 -750 {lab=vinp_stage1}
N 640 -840 760 -840 {lab=vinp_stage1}
N 640 -600 760 -600 {lab=vinn_stage1}
N 980 -840 1100 -840 {lab=vinp_stage2}
N 980 -600 1100 -600 {lab=vinn_stage2}
N 980 -840 980 -750 {lab=vinp_stage2}
N 980 -690 980 -600 {lab=vinn_stage2}
N 1580 -740 1660 -740 {lab=voutn}
N 1580 -700 1660 -700 {lab=voutp}
N 420 -840 480 -840 {lab=vinp}
N 580 -840 640 -840 {lab=vinp_stage1}
N 420 -600 480 -600 {lab=vinn}
N 580 -600 640 -600 {lab=vinn_stage1}
N 760 -840 820 -840 {lab=vinp_stage1}
N 920 -840 980 -840 {lab=vinp_stage2}
N 920 -600 980 -600 {lab=vinn_stage2}
N 760 -600 820 -600 {lab=vinn_stage1}
N 1100 -840 1160 -840 {lab=vinp_stage2}
N 1260 -840 1320 -840 {lab=vinp_ota}
N 1320 -1060 1320 -840 {lab=vinp_ota}
N 1100 -600 1160 -600 {lab=vinn_stage2}
N 1260 -600 1320 -600 {lab=vinn_ota}
N 1320 -680 1320 -600 {lab=vinn_ota}
N 1100 -300 1160 -300 {lab=vinn_stage2}
N 1260 -300 1660 -300 {lab=voutp}
N 1100 -1140 1160 -1140 {lab=vinp_stage2}
N 1260 -1140 1660 -1140 {lab=voutn}
N 510 -800 510 -780 {lab=VSS}
N 890 -800 890 -780 {lab=VSS}
N 1190 -800 1190 -780 {lab=VSS}
N 1190 -1100 1190 -1080 {lab=VSS}
N 510 -660 510 -640 {lab=VSS}
N 890 -660 890 -640 {lab=VSS}
N 1190 -660 1190 -640 {lab=VSS}
N 1190 -360 1190 -340 {lab=VSS}
N 1500 -840 1500 -820 {lab=di_filter_en}
N 1480 -840 1480 -820 {lab=VDD}
N 1480 -620 1480 -600 {lab=VSS}
N 1520 -620 1520 -600 {lab=psub}
N 1230 -360 1230 -340 {lab=psub}
N 1230 -660 1230 -640 {lab=psub}
N 1230 -800 1230 -780 {lab=psub}
N 850 -800 850 -780 {lab=psub}
N 850 -660 850 -640 {lab=psub}
N 550 -660 550 -640 {lab=psub}
N 550 -800 550 -780 {lab=psub}
N 1230 -1100 1230 -1080 {lab=psub}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 1480 -720 0 0 {name=x1
}
C {devices/iopin.sym} 1480 -840 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 1480 -600 1 0 {name=p2 lab=VSS}
C {devices/ipin.sym} 420 -840 0 0 {name=p8 lab=vinp}
C {devices/ipin.sym} 420 -600 2 1 {name=p26 lab=vinn}
C {devices/opin.sym} 1900 -740 0 0 {name=p7 lab=voutp}
C {devices/opin.sym} 1900 -700 0 0 {name=p14 lab=voutn}
C {devices/lab_wire.sym} 1320 -760 0 1 {name=l5 sig_type=std_logic lab=vinp_ota}
C {devices/lab_wire.sym} 1320 -680 2 0 {name=l2 sig_type=std_logic lab=vinn_ota}
C {devices/lab_wire.sym} 760 -840 0 0 {name=l3 sig_type=std_logic lab=vinp_stage1}
C {devices/lab_wire.sym} 1100 -840 0 0 {name=l4 sig_type=std_logic lab=vinp_stage2}
C {devices/lab_wire.sym} 760 -600 2 1 {name=l6 sig_type=std_logic lab=vinn_stage1}
C {devices/lab_wire.sym} 1100 -600 2 1 {name=l7 sig_type=std_logic lab=vinn_stage2}
C {sg13g2_pr/cap_cmim.sym} 640 -720 0 1 {name=C1a
model=cap_cmim
w=8.0e-6
l=8.0e-6
m=5
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 760 -720 2 1 {name=C1b
model=cap_cmim
w=8.0e-6
l=8.0e-6
m=5
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 980 -720 0 1 {name=C2a
model=cap_cmim
w=8.0e-6
l=8.0e-6
m=3
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 1100 -720 2 1 {name=C2b
model=cap_cmim
w=8.0e-6
l=8.0e-6
m=3
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 1490 -1060 1 1 {name=C3a
model=cap_cmim
w=8.0e-6
l=8.0e-6
m=1
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} 1490 -380 1 0 {name=C3b
model=cap_cmim
w=8.0e-6
l=8.0e-6
m=1
spiceprefix=X}
C {iqmod_mfb_lpf_R1.sym} 530 -840 0 0 {name=x2}
C {iqmod_mfb_lpf_R1.sym} 530 -600 2 1 {name=x3}
C {iqmod_mfb_lpf_R2.sym} 870 -840 0 1 {name=x4}
C {iqmod_mfb_lpf_R2.sym} 870 -600 2 0 {name=x5}
C {iqmod_mfb_lpf_R3.sym} 1210 -840 0 0 {name=x6}
C {iqmod_mfb_lpf_R3.sym} 1210 -600 2 1 {name=x7}
C {iqmod_mfb_lpf_R4.sym} 1210 -1140 0 0 {name=x8}
C {iqmod_mfb_lpf_R4.sym} 1210 -300 2 1 {name=x9}
C {devices/ipin.sym} 1500 -840 3 1 {name=p42 lab=di_filter_en}
C {lab_pin.sym} 510 -780 3 0 {name=p3 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 890 -780 3 0 {name=p4 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1190 -780 3 0 {name=p5 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1190 -1080 3 0 {name=p6 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 510 -660 3 1 {name=p9 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 890 -660 3 1 {name=p10 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1190 -660 3 1 {name=p11 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1190 -360 3 1 {name=p12 sig_type=std_logic lab=VSS}
C {lab_pin.sym} 1230 -360 1 0 {name=p13 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1230 -660 3 1 {name=p15 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1230 -780 3 0 {name=p16 sig_type=std_logic lab=psub}
C {lab_pin.sym} 850 -780 3 0 {name=p17 sig_type=std_logic lab=psub}
C {lab_pin.sym} 850 -660 3 1 {name=p18 sig_type=std_logic lab=psub}
C {lab_pin.sym} 550 -660 1 0 {name=p19 sig_type=std_logic lab=psub}
C {lab_pin.sym} 550 -780 1 1 {name=p20 sig_type=std_logic lab=psub}
C {lab_pin.sym} 1230 -1080 1 1 {name=p21 sig_type=std_logic lab=psub}
C {devices/iopin.sym} 1520 -600 1 0 {name=p23 lab=psub}
