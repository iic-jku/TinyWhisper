v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 0 0 65 0 {}
L 4 3400 -160 3400 0 {}
L 4 3400 -160 4720 -160 {}
L 4 3400 -80 4720 -80 {}
L 4 4030 -80 4030 0 {}
L 4 4030 -160 4030 -80 {}
L 4 3740 -80 3740 0 {}
L 4 380 0 1000 0 {}
L 4 4720 -2960 4720 0 {}
L 4 0 -2960 0 -0 {}
L 4 1000 -0 4720 -0 {}
L 4 0 -2960 4720 -2960 {}
B 2 3400 -2160 4200 -1760 {flags=graph
y1=87
y2=230
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-1.8
x2=7.2
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"Rosenstark's Phase; ph(vr1) 180 +\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
B 2 3400 -2580 4200 -2180 {flags=graph
y1=-11.92
y2=29.68
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=-1.8
x2=7.2
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0
node="\\"Rosenstark's Magnitude; vr1 vin1 / db20()\\""
color=4
dataset=-1
unitx=1
logx=1
logy=0
linewidth_mult=4}
P 4 5 2520 -1240 2520 -1140 2720 -1140 2720 -1240 2520 -1240 {dash = 8}
P 4 5 2520 -500 2520 -400 2720 -400 2720 -500 2520 -500 {dash = 8}
P 4 1 1480 -1700 {}
P 4 5 3020 -2060 3020 -1960 3220 -1960 3220 -2060 3020 -2060 {dash = 8}
P 4 5 1460 -1700 3040 -1700 3040 -200 1460 -200 1460 -1700 {dash = 8}
P 4 1 1460 -2540 {}
P 4 1 1460 -2500 {}
P 4 5 1460 -2520 3280 -2520 3280 -1760 1460 -1760 1460 -2520 {dash = 8}
P 4 5 4160 -1240 4160 -1140 4360 -1140 4360 -1240 4160 -1240 {dash = 8}
P 4 5 4160 -500 4160 -400 4360 -400 4360 -500 4160 -500 {dash = 8}
P 4 5 3100 -1700 4680 -1700 4680 -200 3100 -200 3100 -1700 {dash = 8}
P 5 38 140 -15 135 -10 125 0 135 10 147.5 22.5 155 30 147.5 30 140 30 135 30 130 25 125 20 115 10 105 20 100 25 95 30 90 30 82.5 30 75 30 82.5 22.5 95 10 105 0 95 -10 82.5 -22.5 75 -30 82.5 -30 90 -30 95 -30 100 -25 105 -20 115 -10 125 -20 130 -25 135 -30 140 -30 147.5 -30 155 -30 147.5 -22.5 140 -15 {fill=true
bezier=1}
T {Testbench for loop gain analysis - Third Order MFB Lowpass Filter} 1020 -2910 0 0 1.5 1.5 {}
T {Rosenstark’s Method} 1460 -2560 0 0 0.5 0.5 {}
T {Middlebrook’s Method} 1460 -1740 0 0 0.5 0.5 {}
T {Tian’s Method} 3100 -1740 0 0 0.5 0.5 {}
T {2025-01-14} 4040 -60 0 0 0.8 0.8 {}
T {Simon Dorrer} 3410 -140 0 0 0.8 0.8 {}
T {Page 1 of 1} 3410 -60 0 0 0.8 0.8 {}
T {Rev. 1} 3750 -60 0 0 0.8 0.8 {}
T {SCHEM} 155 -25 0 0 1 1 {}
T {Capacitive Load} 2520 -1070 0 0 0.25 0.25 {}
T {Capacitive Load} 2520 -330 0 0 0.25 0.25 {}
T {Capacitive Load} 3020 -1890 0 0 0.25 0.25 {}
T {Capacitive Load} 4160 -1070 0 0 0.25 0.25 {}
T {Capacitive Load} 4160 -330 0 0 0.25 0.25 {}
N 1560 -2160 1560 -2100 {lab=vin1}
N 1540 -2160 1560 -2160 {lab=vin1}
N 1560 -2160 1640 -2160 {lab=vin1}
N 1640 -2120 1640 -2080 {lab=GND}
N 1640 -2080 1680 -2080 {lab=GND}
N 1680 -2110 1680 -2080 {
lab=GND}
N 1880 -2180 1880 -2140 {lab=Vcm1}
N 1880 -2280 1880 -2240 {lab=vinp1}
N 1760 -2090 1840 -2090 {lab=#net1}
N 1760 -2230 1840 -2230 {lab=#net1}
N 1680 -2230 1680 -2170 {lab=#net1}
N 1800 -2050 1840 -2050 {lab=GND}
N 1680 -2080 1680 -2050 {
lab=GND}
N 1800 -2190 1840 -2190 {lab=GND}
N 1800 -2190 1800 -2050 {lab=GND}
N 1680 -2050 1800 -2050 {lab=GND}
N 1760 -2230 1760 -2090 {lab=#net1}
N 1680 -2230 1760 -2230 {lab=#net1}
N 1880 -2140 1880 -2100 {lab=Vcm1}
N 1880 -2040 1880 -2000 {lab=vinn1}
N 1980 -2140 1980 -2100 {lab=Vcm1}
N 1880 -2140 1980 -2140 {
lab=Vcm1}
N 1980 -2040 1980 -2000 {lab=GND}
N 1680 -2050 1680 -2000 {lab=GND}
N 1560 -2040 1560 -2000 {lab=GND}
N 4270 -1920 4270 -1880 {lab=VDD}
N 4270 -1820 4270 -1780 {lab=GND}
N 3200 -2380 3200 -2360 {
lab=vout1}
N 3130 -2350 3160 -2350 {
lab=voutp1}
N 3130 -2310 3160 -2310 {
lab=voutn1}
N 3200 -2300 3200 -2280 {lab=GND}
N 2660 -2200 2660 -2180 {lab=#net2}
N 2660 -2280 2660 -2260 {lab=vinp1}
N 2640 -2280 2660 -2280 {lab=vinp1}
N 2600 -2180 2660 -2180 {lab=#net2}
N 2500 -2180 2540 -2180 {lab=vrp1}
N 2500 -2100 2540 -2100 {lab=vrn1}
N 2660 -2100 2660 -2080 {lab=#net3}
N 2600 -2100 2660 -2100 {lab=#net3}
N 2640 -2000 2660 -2000 {lab=vinn1}
N 2660 -2020 2660 -2000 {lab=vinn1}
N 1980 -2160 1980 -2140 {lab=Vcm1}
N 1980 -1940 1980 -1920 {
lab=vr1}
N 1910 -1910 1940 -1910 {
lab=vrp1}
N 1910 -1870 1940 -1870 {
lab=vrn1}
N 1980 -1860 1980 -1840 {lab=GND}
N 4580 -1370 4580 -1350 {
lab=vout4}
N 4510 -1340 4540 -1340 {
lab=voutp4}
N 4510 -1300 4540 -1300 {
lab=voutn4}
N 4580 -1290 4580 -1270 {lab=GND}
N 4580 -630 4580 -610 {
lab=vout5}
N 4510 -600 4540 -600 {
lab=voutp5}
N 4510 -560 4540 -560 {
lab=voutn5}
N 4580 -550 4580 -530 {lab=GND}
N 3720 -1380 3740 -1380 {lab=#net4}
N 3820 -1480 3820 -1460 {lab=GND}
N 3820 -1380 3820 -1360 {lab=vmeasp4}
N 3820 -1180 3820 -1160 {lab=GND}
N 3820 -1280 3820 -1260 {lab=vmeasn4}
N 3720 -1260 3740 -1260 {lab=#net5}
N 3820 -1260 3820 -1240 {lab=vmeasn4}
N 3820 -1400 3820 -1380 {lab=vmeasp4}
N 3820 -440 3820 -420 {lab=GND}
N 3820 -540 3820 -520 {lab=vmeasn5}
N 3720 -520 3740 -520 {lab=#net6}
N 3820 -520 3820 -500 {lab=vmeasn5}
N 3720 -640 3740 -640 {lab=#net7}
N 3820 -740 3820 -720 {lab=GND}
N 3820 -640 3840 -640 {lab=vmeasp5}
N 3820 -640 3820 -620 {lab=vmeasp5}
N 3820 -660 3820 -640 {lab=vmeasp5}
N 4580 -1590 4580 -1570 {
lab=vmeas4}
N 4510 -1560 4540 -1560 {
lab=vmeasp4}
N 4510 -1520 4540 -1520 {
lab=vmeasn4}
N 4580 -1510 4580 -1480 {
lab=GND}
N 4580 -850 4580 -830 {
lab=vmeas5}
N 4510 -820 4540 -820 {
lab=vmeasp5}
N 4510 -780 4540 -780 {
lab=vmeasn5}
N 4580 -770 4580 -740 {
lab=GND}
N 1540 -1640 1540 -1600 {lab=Vcm2}
N 1540 -1540 1540 -1500 {lab=GND}
N 3180 -1620 3180 -1580 {lab=Vcm3}
N 3180 -1520 3180 -1480 {lab=GND}
N 2300 -1440 2300 -1420 {lab=VDD}
N 2560 -1300 2700 -1300 {lab=voutp2}
N 2660 -1340 2700 -1340 {lab=voutn2}
N 2560 -1160 2560 -1100 {lab=GND}
N 2660 -1160 2660 -1100 {lab=GND}
N 2560 -1300 2560 -1220 {lab=voutp2}
N 2660 -1340 2660 -1220 {lab=voutn2}
N 2960 -1370 2960 -1350 {
lab=vout2}
N 2890 -1340 2920 -1340 {
lab=voutp2}
N 2890 -1300 2920 -1300 {
lab=voutn2}
N 2960 -1290 2960 -1270 {lab=GND}
N 2300 -1220 2300 -1180 {
lab=GND}
N 2400 -1340 2500 -1340 {lab=voutn2}
N 2400 -1300 2500 -1300 {lab=voutp2}
N 2500 -1300 2560 -1300 {lab=voutp2}
N 2500 -1340 2660 -1340 {lab=voutn2}
N 2500 -1300 2500 -1080 {lab=voutp2}
N 2500 -1560 2500 -1340 {lab=voutn2}
N 2500 -1640 2500 -1560 {lab=voutn2}
N 1540 -1320 1580 -1320 {lab=Vcm2}
N 2720 -1590 2720 -1570 {
lab=vf2}
N 2650 -1560 2680 -1560 {
lab=vfp2}
N 2650 -1520 2680 -1520 {
lab=vfn2}
N 2720 -1510 2720 -1480 {
lab=GND}
N 2960 -1590 2960 -1570 {
lab=vr2}
N 2890 -1560 2920 -1560 {
lab=vrp2}
N 2890 -1520 2920 -1520 {
lab=vrn2}
N 2960 -1510 2960 -1480 {
lab=GND}
N 2140 -1360 2220 -1360 {lab=vfp2}
N 2000 -1360 2080 -1360 {lab=vrp2}
N 2000 -1400 2000 -1360 {lab=vrp2}
N 2000 -1560 2220 -1560 {lab=vrp2}
N 2280 -1560 2500 -1560 {lab=voutn2}
N 1960 -1400 2000 -1400 {lab=vrp2}
N 1860 -1400 1900 -1400 {lab=#net8}
N 1860 -1640 1900 -1640 {lab=#net8}
N 1960 -1640 2500 -1640 {lab=voutn2}
N 2140 -1280 2220 -1280 {lab=vfn2}
N 2000 -1280 2080 -1280 {lab=vrn2}
N 2000 -1240 2000 -1080 {lab=vrn2}
N 2280 -1080 2500 -1080 {lab=voutp2}
N 2000 -1080 2220 -1080 {lab=vrn2}
N 1960 -1240 2000 -1240 {lab=vrn2}
N 1860 -1240 1900 -1240 {lab=#net9}
N 1860 -1000 1900 -1000 {lab=#net9}
N 1960 -1000 2500 -1000 {lab=voutp2}
N 2500 -1080 2500 -1000 {lab=voutp2}
N 1820 -1400 1860 -1400 {lab=#net8}
N 1720 -1400 1760 -1400 {lab=#net10}
N 1680 -1400 1720 -1400 {lab=#net10}
N 1720 -1240 1760 -1240 {lab=#net11}
N 1820 -1240 1860 -1240 {lab=#net9}
N 1580 -1400 1620 -1400 {lab=Vcm2}
N 1580 -1240 1620 -1240 {lab=Vcm2}
N 1860 -1640 1860 -1400 {lab=#net8}
N 1860 -1240 1860 -1000 {lab=#net9}
N 1860 -1400 1860 -1350 {lab=#net8}
N 1860 -1290 1860 -1240 {lab=#net9}
N 1720 -1290 1720 -1240 {lab=#net11}
N 1720 -1400 1720 -1350 {lab=#net10}
N 1580 -1400 1580 -1320 {lab=Vcm2}
N 1580 -1320 1580 -1240 {lab=Vcm2}
N 2960 -630 2960 -610 {
lab=vout3}
N 2890 -600 2920 -600 {
lab=voutp3}
N 2890 -560 2920 -560 {
lab=voutn3}
N 2960 -550 2960 -530 {lab=GND}
N 2100 -520 2120 -520 {
lab=#net12}
N 2080 -520 2100 -520 {
lab=#net12}
N 2100 -640 2120 -640 {
lab=#net13}
N 2080 -640 2100 -640 {
lab=#net13}
N 2100 -440 2100 -420 {lab=GND}
N 2100 -520 2100 -500 {lab=#net12}
N 2100 -660 2100 -640 {lab=#net13}
N 2100 -740 2100 -720 {lab=GND}
N 2560 -560 2700 -560 {lab=voutp3}
N 2660 -600 2700 -600 {lab=voutn3}
N 2560 -420 2560 -360 {lab=GND}
N 2660 -420 2660 -360 {lab=GND}
N 2560 -560 2560 -480 {lab=voutp3}
N 2660 -600 2660 -480 {lab=voutn3}
N 2300 -480 2300 -440 {
lab=GND}
N 2400 -600 2500 -600 {lab=voutn3}
N 2400 -560 2500 -560 {lab=voutp3}
N 2500 -560 2560 -560 {lab=voutp3}
N 2500 -600 2660 -600 {lab=voutn3}
N 2500 -560 2500 -340 {lab=voutp3}
N 2500 -820 2500 -600 {lab=voutn3}
N 2500 -900 2500 -820 {lab=voutn3}
N 1540 -580 1580 -580 {lab=Vcm2}
N 2000 -820 2220 -820 {lab=#net14}
N 2280 -820 2500 -820 {lab=voutn3}
N 1960 -660 2000 -660 {lab=#net14}
N 1860 -660 1900 -660 {lab=#net15}
N 1860 -900 1900 -900 {lab=#net15}
N 1960 -900 2500 -900 {lab=voutn3}
N 2280 -340 2500 -340 {lab=voutp3}
N 2000 -340 2220 -340 {lab=#net16}
N 1960 -500 2000 -500 {lab=#net16}
N 1860 -500 1900 -500 {lab=#net17}
N 1860 -260 1900 -260 {lab=#net17}
N 1960 -260 2500 -260 {lab=voutp3}
N 2500 -340 2500 -260 {lab=voutp3}
N 1820 -660 1860 -660 {lab=#net15}
N 1720 -660 1760 -660 {lab=#net18}
N 1680 -660 1720 -660 {lab=#net18}
N 1720 -500 1760 -500 {lab=#net19}
N 1820 -500 1860 -500 {lab=#net17}
N 1580 -660 1620 -660 {lab=Vcm2}
N 1580 -500 1620 -500 {lab=Vcm2}
N 1860 -900 1860 -660 {lab=#net15}
N 1860 -500 1860 -260 {lab=#net17}
N 1860 -660 1860 -610 {lab=#net15}
N 1860 -550 1860 -500 {lab=#net17}
N 1720 -550 1720 -500 {lab=#net19}
N 1720 -660 1720 -610 {lab=#net18}
N 1580 -660 1580 -580 {lab=Vcm2}
N 1580 -580 1580 -500 {lab=Vcm2}
N 2180 -620 2220 -620 {lab=#net20}
N 2180 -640 2180 -620 {lab=#net20}
N 2180 -540 2220 -540 {lab=#net21}
N 2180 -540 2180 -520 {lab=#net21}
N 2000 -520 2020 -520 {lab=#net16}
N 2000 -820 2000 -660 {lab=#net14}
N 2000 -640 2020 -640 {lab=#net14}
N 2000 -660 2000 -640 {lab=#net14}
N 2000 -520 2000 -500 {lab=#net16}
N 2000 -500 2000 -340 {lab=#net16}
N 2800 -2260 2800 -2240 {lab=VDD}
N 3060 -2120 3200 -2120 {lab=voutp1}
N 3160 -2160 3200 -2160 {lab=voutn1}
N 3060 -1980 3060 -1920 {lab=GND}
N 3160 -1980 3160 -1920 {lab=GND}
N 3060 -2120 3060 -2040 {lab=voutp1}
N 3160 -2160 3160 -2040 {lab=voutn1}
N 2800 -2040 2800 -2000 {
lab=GND}
N 2900 -2160 3000 -2160 {lab=voutn1}
N 2900 -2120 3000 -2120 {lab=voutp1}
N 3000 -2120 3060 -2120 {lab=voutp1}
N 3000 -2160 3160 -2160 {lab=voutn1}
N 3000 -2120 3000 -1900 {lab=voutp1}
N 3000 -2380 3000 -2160 {lab=voutn1}
N 3000 -2460 3000 -2380 {lab=voutn1}
N 2500 -2380 2720 -2380 {lab=vrp1}
N 2780 -2380 3000 -2380 {lab=voutn1}
N 2460 -2220 2500 -2220 {lab=vrp1}
N 2360 -2220 2400 -2220 {lab=#net22}
N 2360 -2460 2400 -2460 {lab=#net22}
N 2460 -2460 3000 -2460 {lab=voutn1}
N 2780 -1900 3000 -1900 {lab=voutp1}
N 2500 -1900 2720 -1900 {lab=vrn1}
N 2460 -2060 2500 -2060 {lab=vrn1}
N 2360 -2060 2400 -2060 {lab=#net23}
N 2360 -1820 2400 -1820 {lab=#net23}
N 2460 -1820 3000 -1820 {lab=voutp1}
N 3000 -1900 3000 -1820 {lab=voutp1}
N 2320 -2220 2360 -2220 {lab=#net22}
N 2220 -2220 2260 -2220 {lab=#net24}
N 2180 -2220 2220 -2220 {lab=#net24}
N 2220 -2060 2260 -2060 {lab=#net25}
N 2320 -2060 2360 -2060 {lab=#net23}
N 2080 -2220 2120 -2220 {lab=Vcm1}
N 2080 -2060 2120 -2060 {lab=Vcm1}
N 2360 -2460 2360 -2220 {lab=#net22}
N 2360 -2060 2360 -1820 {lab=#net23}
N 2360 -2220 2360 -2170 {lab=#net22}
N 2360 -2110 2360 -2060 {lab=#net23}
N 2220 -2110 2220 -2060 {lab=#net25}
N 2220 -2220 2220 -2170 {lab=#net24}
N 2080 -2220 2080 -2140 {lab=Vcm1}
N 2080 -2140 2080 -2060 {lab=Vcm1}
N 2500 -2380 2500 -2220 {lab=vrp1}
N 2500 -2060 2500 -1900 {lab=vrn1}
N 1980 -2140 2080 -2140 {
lab=Vcm1}
N 2660 -2180 2720 -2180 {lab=#net2}
N 2660 -2100 2720 -2100 {lab=#net3}
N 2500 -2220 2500 -2180 {lab=vrp1}
N 2500 -2100 2500 -2060 {lab=vrn1}
N 3940 -1440 3940 -1420 {lab=VDD}
N 4200 -1300 4340 -1300 {lab=voutp4}
N 4300 -1340 4340 -1340 {lab=voutn4}
N 4200 -1160 4200 -1100 {lab=GND}
N 4300 -1160 4300 -1100 {lab=GND}
N 4200 -1300 4200 -1220 {lab=voutp4}
N 4300 -1340 4300 -1220 {lab=voutn4}
N 3940 -1220 3940 -1180 {
lab=GND}
N 4040 -1340 4140 -1340 {lab=voutn4}
N 4040 -1300 4140 -1300 {lab=voutp4}
N 4140 -1300 4200 -1300 {lab=voutp4}
N 4140 -1340 4300 -1340 {lab=voutn4}
N 4140 -1300 4140 -1080 {lab=voutp4}
N 4140 -1560 4140 -1340 {lab=voutn4}
N 4140 -1640 4140 -1560 {lab=voutn4}
N 3180 -1320 3220 -1320 {lab=Vcm3}
N 3640 -1560 3860 -1560 {lab=#net26}
N 3920 -1560 4140 -1560 {lab=voutn4}
N 3600 -1400 3640 -1400 {lab=#net26}
N 3500 -1400 3540 -1400 {lab=#net27}
N 3500 -1640 3540 -1640 {lab=#net27}
N 3600 -1640 4140 -1640 {lab=voutn4}
N 3920 -1080 4140 -1080 {lab=voutp4}
N 3640 -1080 3860 -1080 {lab=#net28}
N 3600 -1240 3640 -1240 {lab=#net28}
N 3500 -1240 3540 -1240 {lab=#net29}
N 3500 -1000 3540 -1000 {lab=#net29}
N 3600 -1000 4140 -1000 {lab=voutp4}
N 4140 -1080 4140 -1000 {lab=voutp4}
N 3460 -1400 3500 -1400 {lab=#net27}
N 3360 -1400 3400 -1400 {lab=#net30}
N 3320 -1400 3360 -1400 {lab=#net30}
N 3360 -1240 3400 -1240 {lab=#net31}
N 3460 -1240 3500 -1240 {lab=#net29}
N 3220 -1400 3260 -1400 {lab=Vcm3}
N 3220 -1240 3260 -1240 {lab=Vcm3}
N 3500 -1640 3500 -1400 {lab=#net27}
N 3500 -1240 3500 -1000 {lab=#net29}
N 3500 -1400 3500 -1350 {lab=#net27}
N 3500 -1290 3500 -1240 {lab=#net29}
N 3360 -1290 3360 -1240 {lab=#net31}
N 3360 -1400 3360 -1350 {lab=#net30}
N 3220 -1400 3220 -1320 {lab=Vcm3}
N 3220 -1320 3220 -1240 {lab=Vcm3}
N 3640 -1560 3640 -1400 {lab=#net26}
N 3640 -1400 3640 -1380 {lab=#net26}
N 3640 -1260 3640 -1240 {lab=#net28}
N 3640 -1240 3640 -1080 {lab=#net28}
N 3940 -700 3940 -680 {lab=VDD}
N 4200 -560 4340 -560 {lab=voutp5}
N 4300 -600 4340 -600 {lab=voutn5}
N 4200 -420 4200 -360 {lab=GND}
N 4300 -420 4300 -360 {lab=GND}
N 4200 -560 4200 -480 {lab=voutp5}
N 4300 -600 4300 -480 {lab=voutn5}
N 3940 -480 3940 -440 {
lab=GND}
N 4040 -600 4140 -600 {lab=voutn5}
N 4040 -560 4140 -560 {lab=voutp5}
N 4140 -560 4200 -560 {lab=voutp5}
N 4140 -600 4300 -600 {lab=voutn5}
N 4140 -560 4140 -340 {lab=voutp5}
N 4140 -820 4140 -600 {lab=voutn5}
N 4140 -900 4140 -820 {lab=voutn5}
N 3180 -580 3220 -580 {lab=Vcm3}
N 3640 -820 3860 -820 {lab=#net32}
N 3920 -820 4140 -820 {lab=voutn5}
N 3600 -660 3640 -660 {lab=#net32}
N 3500 -660 3540 -660 {lab=#net33}
N 3500 -900 3540 -900 {lab=#net33}
N 3600 -900 4140 -900 {lab=voutn5}
N 3920 -340 4140 -340 {lab=voutp5}
N 3640 -340 3860 -340 {lab=#net34}
N 3600 -500 3640 -500 {lab=#net34}
N 3500 -500 3540 -500 {lab=#net35}
N 3500 -260 3540 -260 {lab=#net35}
N 3600 -260 4140 -260 {lab=voutp5}
N 4140 -340 4140 -260 {lab=voutp5}
N 3460 -660 3500 -660 {lab=#net33}
N 3360 -660 3400 -660 {lab=#net36}
N 3320 -660 3360 -660 {lab=#net36}
N 3360 -500 3400 -500 {lab=#net37}
N 3460 -500 3500 -500 {lab=#net35}
N 3220 -660 3260 -660 {lab=Vcm3}
N 3220 -500 3260 -500 {lab=Vcm3}
N 3500 -900 3500 -660 {lab=#net33}
N 3500 -500 3500 -260 {lab=#net35}
N 3500 -660 3500 -610 {lab=#net33}
N 3500 -550 3500 -500 {lab=#net35}
N 3360 -550 3360 -500 {lab=#net37}
N 3360 -660 3360 -610 {lab=#net36}
N 3220 -660 3220 -580 {lab=Vcm3}
N 3220 -580 3220 -500 {lab=Vcm3}
N 3640 -820 3640 -660 {lab=#net32}
N 3640 -500 3640 -340 {lab=#net34}
N 3800 -1260 3820 -1260 {lab=vmeasn4}
N 3820 -1260 3840 -1260 {lab=vmeasn4}
N 3820 -1380 3840 -1380 {lab=vmeasp4}
N 3800 -1380 3820 -1380 {lab=vmeasp4}
N 3640 -1380 3660 -1380 {lab=#net26}
N 3640 -1260 3660 -1260 {lab=#net28}
N 3840 -1360 3860 -1360 {lab=vmeasp4}
N 3840 -1380 3840 -1360 {lab=vmeasp4}
N 3840 -1280 3860 -1280 {lab=vmeasn4}
N 3840 -1280 3840 -1260 {lab=vmeasn4}
N 3820 -520 3840 -520 {lab=vmeasn5}
N 3800 -520 3820 -520 {lab=vmeasn5}
N 3800 -640 3820 -640 {lab=vmeasp5}
N 3640 -640 3660 -640 {lab=#net32}
N 3640 -660 3640 -640 {lab=#net32}
N 3640 -520 3660 -520 {lab=#net34}
N 3640 -520 3640 -500 {lab=#net34}
N 3840 -640 3840 -620 {lab=vmeasp5}
N 3840 -620 3860 -620 {lab=vmeasp5}
N 3840 -540 3840 -520 {lab=vmeasn5}
N 3840 -540 3860 -540 {lab=vmeasn5}
N 2000 -1560 2000 -1400 {lab=vrp2}
N 2000 -1280 2000 -1240 {lab=vrn2}
N 1680 -1240 1720 -1240 {lab=#net11}
N 1680 -500 1720 -500 {lab=#net19}
N 2180 -2060 2220 -2060 {lab=#net25}
N 2480 -2180 2500 -2180 {lab=vrp1}
N 2480 -2100 2500 -2100 {lab=vrn1}
N 3320 -1240 3360 -1240 {lab=#net31}
N 3320 -500 3360 -500 {lab=#net37}
N 2800 -2260 2820 -2260 {lab=VDD}
N 2800 -2280 2800 -2260 {lab=VDD}
N 2820 -2260 2820 -2240 {lab=VDD}
N 2300 -1440 2320 -1440 {lab=VDD}
N 2300 -1460 2300 -1440 {lab=VDD}
N 2320 -1440 2320 -1420 {lab=VDD}
N 2300 -700 2300 -680 {lab=VDD}
N 2300 -700 2320 -700 {lab=VDD}
N 2300 -720 2300 -700 {lab=VDD}
N 2320 -700 2320 -680 {lab=VDD}
N 3940 -1440 3960 -1440 {lab=VDD}
N 3940 -1460 3940 -1440 {lab=VDD}
N 3960 -1440 3960 -1420 {lab=VDD}
N 3940 -700 3960 -700 {lab=VDD}
N 3940 -720 3940 -700 {lab=VDD}
N 3960 -700 3960 -680 {lab=VDD}
C {devices/code_shown.sym} 40 -2590 0 0 {name=NGSPICE
only_toplevel=true 
value="
*.include ../../spice/iqmod_mfb_lpf_ota_core_hybrid_bm_pex.spice
.param VDD=1.5
.param Vcm=VDD/2
.param temp=27
.param Cload=10p
.param R1=238e3
.param R2=285e3
.param R3=473e3
.param R4=537e3
.param C1=0.97e-12
.param C2=0.63e-12
.param C3=100e-15
.options savecurrents klu method=gear reltol=1e-4 abstol=1e-15 gmin=1e-15
.control

* optran 0 0 0 1u 1m 0

save all

* User Constants
let f_min = 1
let f_max = 1G
let fdc = 10
* ===================================================

* Operating Point Analysis
op
remzerovec
write iqmod_mfb_lpf_tb_loopgain_all.raw
set appendwrite
* ===================================================

* AC Analysis
ac dec 101 $&const.f_min $&const.f_max
remzerovec
write iqmod_mfb_lpf_tb_loopgain_all.raw
set appendwrite
* ===================================================

* Rosenstark's method
let L = -v(vr1)/v(vin1)
let L_dB = vdb(L)
let L_arg = 180/PI*cphase(L)

* DC loop gain	
meas ac Ldc_dB find L_dB when frequency = fdc
print Ldc_dB

* Phase margin
meas ac fug find frequency when L_dB=0
meas ac pm find L_arg when frequency=fug
let pm = 180-abs(pm)
* let pm = abs(pm)
print pm
	
* Plotting
plot L_dB L_arg title 'Bode Plot (Rosenstark)' ylabel 'Magnitude (dB), Phase (Deg)'

let L_re = real(L)
let L_im = imag(L)	
plot L_im vs L_re retraceplot title 'Nyquist Plot (Rosenstark)' ylabel 'Imaginary Part' xlabel 'Real Part' 
* ===================================================

* Middlebrook's method
let Tv=-v(vr2)/v(vf2)
let Ti=-(i(Virp3) - i(Virn3))/(i(Vifp3) - i(Vifn3))
let Tmb =(Tv * Ti - 1)/(Tv + Ti + 2)

let Tmb_dB = vdb(Tmb)
let Tmb_arg = 180/PI*cphase(Tmb)

* DC loop gain	
meas ac Tmbdc_dB find Tmb_dB when frequency = fdc
print Tmbdc_dB

* Phase margin
meas ac fug find frequency when Tmb_dB=0
meas ac pm find Tmb_arg when frequency=fug
let pm = 180-abs(pm)
* let pm = abs(pm)
print pm
	
* Plotting
plot Tmb_dB Tmb_arg title 'Bode Plot (Middlebrook)' ylabel 'Magnitude (dB), Phase (Deg)'

let Tmb_re = real(Tmb)
let Tmb_im = imag(Tmb)	
plot Tmb_im vs Tmb_re retraceplot title 'Nyquist Plot (Middlebrook)' ylabel 'Imaginary Part' xlabel 'Real Part' 
* ===================================================

* Tian's Method
* vtest=0, itest=1:
let A=i(Vimeasp5)
let C=v(vmeas5)

* vtest=1, itest=0:
let B=i(Vimeasp4)
let D=v(vmeas4)

let Ttian=(A*D-B*C-A)/(2*(B*C-A*D)+A-D+1)

let Ttian_dB = vdb(Ttian)
let Ttian_arg = 180/PI*cphase(Ttian)

* DC loop gain	
meas ac Ttianbdc_dB find Ttian_dB when frequency = fdc
print Ttianbdc_dB

* Phase margin
meas ac fug find frequency when Ttian_dB=0
meas ac pm find Ttian_arg when frequency=fug
let pm = 180-abs(pm)
* let pm = abs(pm)
print pm

* Plotting
plot Ttian_dB Ttian_arg title 'Bode Plot (Tian)' ylabel 'Magnitude (dB), Phase (Deg)'

let Ttian_re = real(Ttian)
let Ttian_im = imag(Ttian)	
plot Ttian_im vs Ttian_re retraceplot title 'Nyquist Plot (Tian)' ylabel 'Imaginary Part' xlabel 'Real Part' 
* ===================================================

* Rosenstark vs. Middlebrook vs. Tian
plot L_dB Tmb_dB Ttian_dB title 'Rosenstark vs. Middlebrook vs. Tian' ylabel 'Magnitude (dB)'
plot L_arg Tmb_arg Ttian_arg title 'Rosenstark vs. Middlebrook vs. Tian' ylabel 'Phase (Deg)'

* plot L_im vs L_re Tmb_im vs Tmb_re Ttian_im vs Ttian_re retraceplot title 'Rosenstark vs. Middlebrook vs. Tian' ylabel 'Imaginary Part' xlabel 'Real Part'
plot Tmb_im vs Tmb_re Ttian_im vs Ttian_re retraceplot title 'Middlebrook vs. Tian' ylabel 'Imaginary Part' xlabel 'Real Part' 
* ===================================================

* Write Data
unset appendwrite
set wr_vecnames
set wr_singlescale
wrdata $PROJECT_PATH/python/plot_simulations/data/iqmod_mfb_lpf_tb_loopgain_all.txt v(L_dB) v(L_arg) v(Tmb_dB) v(Tmb_arg) v(Ttian_dB) v(Ttian_arg)
* ===================================================

*quit
.endc
"}
C {devices/vsource.sym} 4270 -1850 0 0 {name=VDD value=\{VDD\}}
C {devices/gnd.sym} 4270 -1780 0 0 {name=l3 lab=GND}
C {devices/launcher.sym} 3460 -2760 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem save; xschem netlist; xschem simulate"
}
C {devices/launcher.sym} 3460 -2640 0 0 {name=h1
descr="Load waves" 
tclcommand="xschem raw_read $netlist_dir/[file rootname [file tail [xschem get current_name]]].raw ac"
}
C {devices/launcher.sym} 3460 -2700 0 0 {name=h3
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vdd.sym} 4270 -1920 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 3200 -2120 0 1 {name=p3 sig_type=std_logic lab=voutp1}
C {lab_pin.sym} 3200 -2160 0 1 {name=p4 sig_type=std_logic lab=voutn1}
C {devices/lab_pin.sym} 1880 -2280 0 0 {name=l10 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 1880 -2000 0 0 {name=l11 sig_type=std_logic lab=vinn1
}
C {devices/lab_pin.sym} 1540 -2160 0 0 {name=l13 sig_type=std_logic lab=vin1}
C {devices/lab_pin.sym} 2640 -2280 0 0 {name=l5 sig_type=std_logic lab=vinp1}
C {devices/lab_pin.sym} 2640 -2000 0 0 {name=l19 sig_type=std_logic lab=vinn1
}
C {devices/vsource.sym} 1980 -2070 0 0 {name=Vcm1 value=\{Vcm\}
}
C {devices/vcvs.sym} 1880 -2070 0 0 {name=E4 value=0.5}
C {devices/vcvs.sym} 1880 -2210 0 0 {name=E5 value=0.5}
C {devices/lab_pin.sym} 1980 -2160 1 0 {name=l38 sig_type=std_logic lab=Vcm1}
C {devices/gnd.sym} 1560 -2000 0 0 {name=l39 lab=GND}
C {devices/gnd.sym} 1980 -2000 0 0 {name=l40 lab=GND}
C {devices/vcvs.sym} 1680 -2140 0 0 {name=E6 value=1}
C {devices/gnd.sym} 1680 -2000 0 0 {name=l41 lab=GND}
C {devices/lab_pin.sym} 3200 -2380 0 1 {name=l12 sig_type=std_logic lab=vout1}
C {devices/vcvs.sym} 3200 -2330 0 0 {name=E1 value=1}
C {devices/gnd.sym} 3200 -2280 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 3130 -2310 2 1 {name=l15 sig_type=std_logic lab=voutn1
}
C {devices/lab_pin.sym} 3130 -2350 0 0 {name=l23 sig_type=std_logic lab=voutp1
}
C {devices/vsource.sym} 1560 -2070 0 0 {name=vin1 value="dc 0 ac 1"
}
C {devices/capa.sym} 2660 -2230 0 0 {name=C8
m=1
value=1G
footprint=1206
device="ceramic capacitor"}
C {devices/ind.sym} 2570 -2180 1 0 {name=L28
m=1
value=1G
footprint=1206
device=inductor}
C {devices/ind.sym} 2570 -2100 1 0 {name=L16
m=1
value=1G
footprint=1206
device=inductor}
C {devices/capa.sym} 2660 -2050 0 0 {name=C3
m=1
value=1G
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1980 -1940 0 1 {name=l18 sig_type=std_logic lab=vr1}
C {devices/vcvs.sym} 1980 -1890 0 0 {name=E2 value=1}
C {devices/gnd.sym} 1980 -1840 0 0 {name=l20 lab=GND}
C {devices/lab_pin.sym} 1910 -1870 2 1 {name=l22 sig_type=std_logic lab=vrn1
}
C {devices/lab_pin.sym} 1910 -1910 0 0 {name=l25 sig_type=std_logic lab=vrp1

}
C {devices/lab_pin.sym} 2480 -2180 0 0 {name=l21 sig_type=std_logic lab=vrp1

}
C {devices/lab_pin.sym} 2480 -2100 2 1 {name=l17 sig_type=std_logic lab=vrn1
}
C {lab_pin.sym} 4340 -1300 0 1 {name=p7 sig_type=std_logic lab=voutp4}
C {lab_pin.sym} 4340 -1340 0 1 {name=p8 sig_type=std_logic lab=voutn4}
C {devices/lab_pin.sym} 4580 -1370 0 1 {name=l71 sig_type=std_logic lab=vout4}
C {devices/vcvs.sym} 4580 -1320 0 0 {name=E10 value=1}
C {devices/gnd.sym} 4580 -1270 0 0 {name=l72 lab=GND}
C {devices/lab_pin.sym} 4510 -1300 2 1 {name=l73 sig_type=std_logic lab=voutn4
}
C {devices/lab_pin.sym} 4510 -1340 0 0 {name=l74 sig_type=std_logic lab=voutp4
}
C {lab_pin.sym} 4340 -560 0 1 {name=p12 sig_type=std_logic lab=voutp5}
C {lab_pin.sym} 4340 -600 0 1 {name=p14 sig_type=std_logic lab=voutn5}
C {devices/lab_pin.sym} 4580 -630 0 1 {name=l81 sig_type=std_logic lab=vout5}
C {devices/vcvs.sym} 4580 -580 0 0 {name=E11 value=1}
C {devices/gnd.sym} 4580 -530 0 0 {name=l82 lab=GND}
C {devices/lab_pin.sym} 4510 -560 2 1 {name=l83 sig_type=std_logic lab=voutn5
}
C {devices/lab_pin.sym} 4510 -600 0 0 {name=l84 sig_type=std_logic lab=voutp5
}
C {devices/vsource.sym} 3770 -1380 1 1 {name=Vtestp4 value="dc 0 ac 1"}
C {ammeter.sym} 3690 -1380 3 0 {name=Vimeasp4 savecurrent=true spice_ignore=0}
C {isource.sym} 3820 -1430 0 0 {name=Itestp4 value="dc 0 ac 0"}
C {devices/gnd.sym} 3820 -1480 2 0 {name=l88 lab=GND}
C {ammeter.sym} 3690 -1260 3 0 {name=Vimeasn4 savecurrent=true spice_ignore=0}
C {devices/vsource.sym} 3770 -1260 1 0 {name=Vtestn4 value="dc 0 ac -1"}
C {lab_wire.sym} 3820 -1360 2 1 {name=p16 sig_type=std_logic lab=vmeasp4}
C {isource.sym} 3820 -1210 2 1 {name=Itestn4 value="dc 0 ac 0"}
C {devices/gnd.sym} 3820 -1160 0 0 {name=l89 lab=GND}
C {lab_wire.sym} 3820 -1280 0 0 {name=p15 sig_type=std_logic lab=vmeasn4}
C {ammeter.sym} 3690 -520 3 0 {name=Vimeasn5 savecurrent=true spice_ignore=0}
C {devices/vsource.sym} 3770 -520 1 0 {name=Vtestn5 value="dc 0 ac 0"}
C {isource.sym} 3820 -470 2 1 {name=Itestn5 value="dc 0 ac -1"}
C {devices/gnd.sym} 3820 -420 0 0 {name=l87 lab=GND}
C {lab_wire.sym} 3820 -540 0 0 {name=p17 sig_type=std_logic lab=vmeasn5}
C {devices/vsource.sym} 3770 -640 1 1 {name=Vtestp5 value="dc 0 ac 0"}
C {ammeter.sym} 3690 -640 3 0 {name=Vimeasp5 savecurrent=true spice_ignore=0}
C {isource.sym} 3820 -690 0 0 {name=Itestp5 value="dc 0 ac 1"}
C {devices/gnd.sym} 3820 -740 2 0 {name=l90 lab=GND}
C {lab_wire.sym} 3820 -620 2 1 {name=p18 sig_type=std_logic lab=vmeasp5}
C {devices/lab_pin.sym} 4580 -1590 0 1 {name=l91 sig_type=std_logic lab=vmeas4}
C {devices/vcvs.sym} 4580 -1540 0 0 {name=E12 value=0.5}
C {devices/gnd.sym} 4580 -1480 0 0 {name=l92 lab=GND}
C {devices/lab_pin.sym} 4510 -1520 2 1 {name=l93 sig_type=std_logic lab=vmeasn4
}
C {devices/lab_pin.sym} 4510 -1560 0 0 {name=l94 sig_type=std_logic lab=vmeasp4

}
C {devices/lab_pin.sym} 4580 -850 0 1 {name=l95 sig_type=std_logic lab=vmeas5}
C {devices/vcvs.sym} 4580 -800 0 0 {name=E13 value=0.5}
C {devices/gnd.sym} 4580 -740 0 0 {name=l96 lab=GND}
C {devices/lab_pin.sym} 4510 -780 2 1 {name=l97 sig_type=std_logic lab=vmeasn5
}
C {devices/lab_pin.sym} 4510 -820 0 0 {name=l98 sig_type=std_logic lab=vmeasp5
}
C {devices/vsource.sym} 1540 -1570 0 0 {name=Vcm2 value=\{Vcm\}
}
C {devices/gnd.sym} 1540 -1500 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 1540 -1640 0 1 {name=l99 sig_type=std_logic lab=Vcm2}
C {devices/vsource.sym} 3180 -1550 0 0 {name=Vcm3 value=\{Vcm\}
}
C {devices/gnd.sym} 3180 -1480 0 0 {name=l100 lab=GND}
C {devices/lab_pin.sym} 3180 -1620 0 1 {name=l101 sig_type=std_logic lab=Vcm3}
C {devices/gnd.sym} 2560 -1100 0 0 {name=l26 lab=GND}
C {devices/capa.sym} 2560 -1190 0 0 {name=C4
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 2300 -1460 0 0 {name=l27 lab=VDD}
C {devices/gnd.sym} 2300 -1180 0 1 {name=l29 lab=GND}
C {lab_pin.sym} 2700 -1300 0 1 {name=p1 sig_type=std_logic lab=voutp2}
C {lab_pin.sym} 2700 -1340 0 1 {name=p2 sig_type=std_logic lab=voutn2}
C {devices/capa.sym} 2660 -1190 0 0 {name=C5
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2660 -1100 0 0 {name=l36 lab=GND}
C {devices/lab_pin.sym} 2960 -1370 0 1 {name=l37 sig_type=std_logic lab=vout2}
C {devices/vcvs.sym} 2960 -1320 0 0 {name=E3 value=1}
C {devices/gnd.sym} 2960 -1270 0 0 {name=l42 lab=GND}
C {devices/lab_pin.sym} 2890 -1300 2 1 {name=l43 sig_type=std_logic lab=voutn2
}
C {devices/lab_pin.sym} 2890 -1340 0 0 {name=l44 sig_type=std_logic lab=voutp2
}
C {res.sym} 1930 -1640 1 0 {name=R4a
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1930 -1000 1 0 {name=R4b
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 2250 -1560 1 0 {name=C3a
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 2250 -1080 1 1 {name=C3b
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1860 -1320 2 0 {name=C6
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1540 -1320 0 0 {name=l65 sig_type=std_logic lab=Vcm2}
C {devices/lab_pin.sym} 2720 -1590 0 1 {name=l48 sig_type=std_logic lab=vf2}
C {devices/vcvs.sym} 2720 -1540 0 0 {name=E8 value=0.5}
C {devices/gnd.sym} 2720 -1480 0 0 {name=l33 lab=GND}
C {devices/lab_pin.sym} 2650 -1520 2 1 {name=l45 sig_type=std_logic lab=vfn2
}
C {devices/lab_pin.sym} 2650 -1560 0 0 {name=l46 sig_type=std_logic lab=vfp2

}
C {devices/lab_pin.sym} 2960 -1590 0 1 {name=l47 sig_type=std_logic lab=vr2}
C {devices/vcvs.sym} 2960 -1540 0 0 {name=E9 value=0.5}
C {devices/gnd.sym} 2960 -1480 0 0 {name=l53 lab=GND}
C {devices/lab_pin.sym} 2890 -1520 2 1 {name=l54 sig_type=std_logic lab=vrn2
}
C {devices/lab_pin.sym} 2890 -1560 0 0 {name=l61 sig_type=std_logic lab=vrp2

}
C {devices/vsource.sym} 2110 -1360 1 1 {name=Vtestp2 value="dc 0 ac 1"}
C {lab_wire.sym} 2180 -1360 0 0 {name=p9 sig_type=std_logic lab=vfp2}
C {lab_wire.sym} 2040 -1360 0 0 {name=p13 sig_type=std_logic lab=vrp2}
C {devices/vsource.sym} 2110 -1280 1 0 {name=Vtestn2 value="dc 0 ac -1"}
C {lab_wire.sym} 2180 -1280 0 0 {name=p10 sig_type=std_logic lab=vfn2}
C {lab_wire.sym} 2040 -1280 0 0 {name=p11 sig_type=std_logic lab=vrn2}
C {res.sym} 1930 -1400 1 1 {name=R3a
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1930 -1240 1 0 {name=R3b
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1790 -1400 1 1 {name=R1
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1650 -1400 1 1 {name=R1a
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1790 -1240 1 0 {name=R2
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1650 -1240 1 0 {name=R1b
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 1720 -1320 2 0 {name=C7
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 2700 -560 0 1 {name=p5 sig_type=std_logic lab=voutp3}
C {lab_pin.sym} 2700 -600 0 1 {name=p6 sig_type=std_logic lab=voutn3}
C {devices/lab_pin.sym} 2960 -630 0 1 {name=l57 sig_type=std_logic lab=vout3}
C {devices/vcvs.sym} 2960 -580 0 0 {name=E7 value=1}
C {devices/gnd.sym} 2960 -530 0 0 {name=l58 lab=GND}
C {devices/lab_pin.sym} 2890 -560 2 1 {name=l59 sig_type=std_logic lab=voutn3
}
C {devices/lab_pin.sym} 2890 -600 0 0 {name=l60 sig_type=std_logic lab=voutp3
}
C {ammeter.sym} 2050 -640 3 1 {name=Virp3 savecurrent=true spice_ignore=0}
C {ammeter.sym} 2150 -640 3 1 {name=Vifp3 savecurrent=true spice_ignore=0}
C {isource.sym} 2100 -470 2 1 {name=Itestn3 value="dc 0 ac -1"}
C {devices/gnd.sym} 2100 -420 0 0 {name=l62 lab=GND}
C {ammeter.sym} 2050 -520 3 0 {name=Virn3 savecurrent=true spice_ignore=0}
C {ammeter.sym} 2150 -520 3 0 {name=Vifn3 savecurrent=true spice_ignore=0}
C {isource.sym} 2100 -690 0 0 {name=Itestp3 value="dc 0 ac 1"}
C {devices/gnd.sym} 2100 -740 2 0 {name=l63 lab=GND}
C {devices/gnd.sym} 2560 -360 0 0 {name=l4 lab=GND}
C {devices/capa.sym} 2560 -450 0 0 {name=C9
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 2300 -720 0 0 {name=l31 lab=VDD}
C {devices/gnd.sym} 2300 -440 0 1 {name=l32 lab=GND}
C {devices/capa.sym} 2660 -450 0 0 {name=C10
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2660 -360 0 0 {name=l50 lab=GND}
C {res.sym} 1930 -900 1 0 {name=R3
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1930 -260 1 0 {name=R4
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 2250 -820 1 0 {name=C13
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 2250 -340 1 1 {name=C14
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1860 -580 2 0 {name=C15
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 1540 -580 0 0 {name=l51 sig_type=std_logic lab=Vcm2}
C {res.sym} 1930 -660 1 1 {name=R9
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1930 -500 1 0 {name=R10
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1790 -660 1 1 {name=R11
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1650 -660 1 1 {name=R12
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1790 -500 1 0 {name=R13
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 1650 -500 1 0 {name=R14
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 1720 -580 2 0 {name=C16
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 3060 -1920 0 0 {name=l9 lab=GND}
C {devices/capa.sym} 3060 -2010 0 0 {name=C1
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 2800 -2280 0 0 {name=l24 lab=VDD}
C {devices/gnd.sym} 2800 -2000 0 1 {name=l30 lab=GND}
C {devices/capa.sym} 3160 -2010 0 0 {name=C2
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 3160 -1920 0 0 {name=l55 lab=GND}
C {res.sym} 2430 -2460 1 0 {name=R15
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 2430 -1820 1 0 {name=R16
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 2750 -2380 1 0 {name=C17
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 2750 -1900 1 1 {name=C18
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 2360 -2140 2 0 {name=C29
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {res.sym} 2430 -2220 1 1 {name=R17
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 2430 -2060 1 0 {name=R18
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 2290 -2220 1 1 {name=R19
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 2150 -2220 1 1 {name=R20
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 2290 -2060 1 0 {name=R21
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 2150 -2060 1 0 {name=R22
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 2220 -2140 2 0 {name=C30
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 4200 -1100 0 0 {name=l68 lab=GND}
C {devices/capa.sym} 4200 -1190 0 0 {name=C11
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 3940 -1460 0 0 {name=l69 lab=VDD}
C {devices/gnd.sym} 3940 -1180 0 1 {name=l70 lab=GND}
C {devices/capa.sym} 4300 -1190 0 0 {name=C12
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 4300 -1100 0 0 {name=l85 lab=GND}
C {res.sym} 3570 -1640 1 0 {name=R5
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3570 -1000 1 0 {name=R6
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 3890 -1560 1 0 {name=C19
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 3890 -1080 1 1 {name=C20
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 3500 -1320 2 0 {name=C21
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 3180 -1320 0 0 {name=l102 sig_type=std_logic lab=Vcm3}
C {res.sym} 3570 -1400 1 1 {name=R23
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3570 -1240 1 0 {name=R24
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3430 -1400 1 1 {name=R25
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3290 -1400 1 1 {name=R26
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3430 -1240 1 0 {name=R27
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3290 -1240 1 0 {name=R28
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 3360 -1320 2 0 {name=C22
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 4200 -360 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 4200 -450 0 0 {name=C23
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {vdd.sym} 3940 -720 0 0 {name=l8 lab=VDD}
C {devices/gnd.sym} 3940 -440 0 1 {name=l56 lab=GND}
C {devices/capa.sym} 4300 -450 0 0 {name=C24
m=1
value=\{Cload\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 4300 -360 0 0 {name=l66 lab=GND}
C {res.sym} 3570 -900 1 0 {name=R7
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3570 -260 1 0 {name=R8
value=\{R4\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 3890 -820 1 0 {name=C25
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 3890 -340 1 1 {name=C26
m=1
value=\{C3\}
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 3500 -580 2 0 {name=C27
m=1
value=\{C2\}
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 3180 -580 0 0 {name=l67 sig_type=std_logic lab=Vcm3}
C {res.sym} 3570 -660 1 1 {name=R29
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3570 -500 1 0 {name=R30
value=\{R3\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3430 -660 1 1 {name=R31
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3290 -660 1 1 {name=R32
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3430 -500 1 0 {name=R33
value=\{R2\}
footprint=1206
device=resistor
m=1}
C {res.sym} 3290 -500 1 0 {name=R34
value=\{R1\}
footprint=1206
device=resistor
m=1}
C {capa.sym} 3360 -580 2 0 {name=C28
m=1
value=\{C1\}
footprint=1206
device="ceramic capacitor"}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 4320 -2460 0 0 {name=x2
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm_pex.sym} 4320 -2160 0 0 {name=x3
spice_ignore=true}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2800 -2140 0 0 {name=x5
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2300 -1320 0 0 {name=x4
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 2300 -580 0 0 {name=x6
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 3940 -1320 0 0 {name=x7
spice_ignore=false}
C {iqmod_mfb_lpf_ota_core_hybrid_bm.sym} 3940 -580 0 0 {name=x8
spice_ignore=false}
C {devices/code_shown.sym} 3740 -2750 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.lib cornerDIO.lib dio_tt
"}
