v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Single Pole, Double Throw (SPDT) Switch with two TG} 590 -1660 0 0 1 1 {}
T {di_spdt_ctrl = 1, di_spdt_ctrl_n = 0: v_c connected to v_a, v_b = HIGH-Z
di_spdt_ctrl = 0, di_spdt_ctrl_n = 1: v_c connected to v_b, v_a = HIGH-Z} 900 -1420 0 0 0.4 0.4 {}
N 1280 -600 1280 -500 {
lab=v_c}
N 1500 -720 1500 -640 {
lab=VDD}
N 880 -600 1000 -600 {
lab=v_a}
N 1160 -600 1280 -600 {
lab=v_c}
N 1560 -600 1680 -600 {
lab=v_b}
N 1480 -560 1480 -500 {
lab=spdt_ctrl_buf}
N 1500 -560 1500 -480 {
lab=VSS}
N 1280 -600 1400 -600 {
lab=v_c}
N 1060 -720 1060 -640 {
lab=VDD}
N 1060 -560 1060 -480 {
lab=VSS}
N 1080 -560 1080 -500 {
lab=do_spdt_ctrl_n}
N 1060 -1080 1060 -1060 {lab=VSS}
N 1060 -1180 1060 -1160 {lab=VDD}
N 1480 -1080 1480 -1060 {lab=VSS}
N 1480 -1180 1480 -1160 {lab=VDD}
N 880 -1120 1000 -1120 {lab=di_spdt_ctrl}
N 1140 -1120 1280 -1120 {lab=do_spdt_ctrl_n}
N 1280 -1120 1420 -1120 {lab=do_spdt_ctrl_n}
N 1560 -1120 1680 -1120 {lab=spdt_ctrl_buf}
N 1280 -980 1680 -980 {lab=do_spdt_ctrl_n}
N 1280 -1120 1280 -980 {lab=do_spdt_ctrl_n}
N 1080 -1180 1080 -1140 {lab=nwell}
N 1500 -1100 1500 -1060 {lab=psub}
N 1100 -580 1100 -570 {lab=psub}
N 1100 -630 1100 -620 {lab=nwell}
N 1080 -1100 1080 -1060 {lab=psub}
N 1500 -1180 1500 -1140 {lab=nwell}
N 1460 -580 1460 -570 {lab=psub}
N 1460 -630 1460 -620 {lab=nwell}
N 1080 -700 1080 -640 {lab=spdt_ctrl_buf}
N 1080 -700 1100 -700 {lab=spdt_ctrl_buf}
N 1100 -720 1100 -700 {lab=spdt_ctrl_buf}
N 1460 -720 1460 -700 {lab=do_spdt_ctrl_n}
N 1460 -700 1480 -700 {lab=do_spdt_ctrl_n}
N 1480 -700 1480 -640 {lab=do_spdt_ctrl_n}
N 1080 -500 1100 -500 {lab=do_spdt_ctrl_n}
N 1100 -500 1100 -480 {lab=do_spdt_ctrl_n}
N 1460 -500 1480 -500 {lab=spdt_ctrl_buf}
N 1460 -500 1460 -480 {lab=spdt_ctrl_buf}
C {devices/iopin.sym} 880 -600 0 1 {name=p2 lab=v_a}
C {devices/iopin.sym} 1680 -600 0 0 {name=p4 lab=v_b}
C {devices/iopin.sym} 1280 -500 1 0 {name=p1 lab=v_c}
C {devices/lab_pin.sym} 1500 -480 1 1 {name=p6 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1500 -720 3 1 {name=p16 sig_type=std_logic lab=VDD}
C {devices/title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {devices/iopin.sym} 1060 -1180 3 0 {name=p10 lab=VDD}
C {devices/iopin.sym} 1060 -1060 1 0 {name=p11 lab=VSS}
C {devices/ipin.sym} 880 -1120 0 0 {name=p3 lab=di_spdt_ctrl}
C {devices/lab_pin.sym} 1060 -480 3 0 {name=p9 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1060 -720 1 0 {name=p12 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1480 -1180 1 0 {name=p13 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 1480 -1060 3 0 {name=p14 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 1680 -1120 2 0 {name=p15 sig_type=std_logic lab=spdt_ctrl_buf}
C {lab_pin.sym} 1100 -480 3 0 {name=p5 sig_type=std_logic lab=do_spdt_ctrl_n}
C {lab_pin.sym} 1460 -720 3 1 {name=p7 sig_type=std_logic lab=do_spdt_ctrl_n}
C {devices/lab_pin.sym} 1100 -720 1 0 {name=p8 sig_type=std_logic lab=spdt_ctrl_buf}
C {devices/lab_pin.sym} 1460 -480 1 1 {name=p17 sig_type=std_logic lab=spdt_ctrl_buf}
C {iqmod_mfb_lpf_ota_core_spdt_switch_inv.sym} 1060 -1120 0 0 {name=x1}
C {iqmod_mfb_lpf_ota_core_spdt_switch_inv.sym} 1480 -1120 0 0 {name=x2}
C {iqmod_mfb_lpf_ota_core_spdt_switch_tg.sym} 1080 -600 0 0 {name=x3}
C {iqmod_mfb_lpf_ota_core_spdt_switch_tg.sym} 1480 -600 0 1 {name=x4}
C {lab_pin.sym} 1500 -1060 3 0 {name=p43 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1100 -570 2 0 {name=p37 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1100 -630 0 1 {name=p66 sig_type=std_logic lab=nwell}
C {lab_pin.sym} 1500 -1180 3 1 {name=p19 sig_type=std_logic lab=nwell}
C {lab_wire.sym} 1460 -570 2 1 {name=p20 sig_type=std_logic lab=psub}
C {lab_wire.sym} 1460 -630 0 0 {name=p21 sig_type=std_logic lab=nwell}
C {devices/opin.sym} 1680 -980 0 0 {name=p22 lab=do_spdt_ctrl_n}
C {devices/iopin.sym} 1080 -1180 3 0 {name=p18 lab=nwell}
C {devices/iopin.sym} 1080 -1060 1 0 {name=p23 lab=psub}
