# TinyWhisper: An Open-Source Fully-Integrated Multi-Mode Short-Wave Transmitter for Amateur Radio Applications in 130-nm CMOS

[![Quarto Publish](https://github.com/iic-jku/TinyWhisper/actions/workflows/quarto-publish.yml/badge.svg?branch=main)](https://github.com/iic-jku/TinyWhisper/actions/workflows/quarto-publish.yml)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20004085.svg)](https://doi.org/10.5281/zenodo.20004085)

(c) 2025-2026 Simon Dorrer* (OE3SDE), Jonathan Hager** (DK7JH), Matthias Jung** (DL9MJ) and Harald Pretl*

*Institute for Integrated Circuits and Quantum Computing, Johannes Kepler University (JKU), Linz, Austria

**Computer Engineering, Julius-Maximilians-Universität, Würzburg, Germany

> [!WARNING]
> This repository is a Work in Progress.

> [!IMPORTANT]
> This repository requires the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container with tag `2026.05` or later.

> [!TIP]
> This repository is based on the [ihp-sg13g2-ams-chip-template](https://github.com/iic-jku/ihp-sg13g2-ams-chip-template) template repository. For a better understanding of the folder structure, how to use the Makefiles, and how to implement your own designs, it is recommended to go through this [tutorial](https://iic-jku.github.io/ihp-sg13g2-ams-chip-template/index.html).

<p align="center">
  <a href="doc/fig/tinywhisper_top_black.png">
    <img src="doc/fig/tinywhisper_top_black.png" alt="Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm)" width=70%>
  </a>
  <br>
  <em>Chip render of the ihp-sg13g2 TinyWhisper ASIC (2mm x 2mm).</em>
</p>

<p align="center">
  <a href="doc/fig/tinywhisper_top_black_TM2.png">
    <img src="doc/fig/tinywhisper_top_black_TM2.png" alt="Render of the TopMetal2 TinyWhisper logo, generated with the tool ArtistIC" width=70%>
  </a>
  <br>
  <em>Render of the TopMetal2 TinyWhisper logo, generated with the tool ArtistIC.</em>
</p>


## Documentation

The full documentation of the TinyWhisper transmitter is available [here](https://iic-jku.github.io/TinyWhisper/index.html).


## Purpose

TinyWhisper demonstrates what is possible with current open-source tools and open-source PDKs, from system design to final tapeout, from packaging to PCB design, and even to a 3D-printed enclosure. It can also be used for:

- Ham radio courses
- University courses
- Regression tests of various open-source tools


## Chip Specifications

| Parameter           | Value                                                                             |
| ------------------- | --------------------------------------------------------------------------------- |
| Technology          | SKY130 \& IHP SG13G2 (130 nm CMOS)                                                |
| Die Area            | 2000 × 2000 µm (4 mm²)                                                            |
| Core Area           | 1270 × 1270 µm (1.613 mm²)                                                        |
| Clock Frequency     | 56 MHz                                                                            |
| Core Supply Voltage | 1.5 V                                                                             |
| I/O Supply Voltage  | 3.3 V                                                                             |
| Total Pads          | 56 (8 analog, 6 input, 9 output, 9 bidirectional, 7 VDD, 9 VSS, 3 IOVDD, 3 IOVSS) |
| Packaging           | QFN-48 package → 8 pads are connected directly to package VSS                     |
| Temperature Range   | -40 °C to +125 °C                                                                 |


## Overview

- Analog Front-End — IQ Modulator
    - 3rd-order multiple-feedback (MFB) low-pass filter
        - Butterworth
        - fc = 400 kHz
        - Barthelemy / Manfredini (B/M) inverter-based OTA
    - Passive CMOS voltage-mode mixer
        - Single-to-differential conversion circuit
        - Simple transmission-gate switch
- Digital Core
    - RISC-V CPU
        - SPI interface for external SRAM extension
        - I²C interface for external peripherals (I/O extender, display, keyboard, etc.)
        - UART interface for connection to PC / Raspberry Pi RP2040 + MicroPython
        - 8 × GPIOs (4 × inputs, one with external interrupt capability, and 4 × outputs)
    - 30-bit iterative CORDIC for sine / cosine generation
        - Adjustable amplitude
        - Adjustable fc, fm, and phim enable different modulation schemes
        - Frequency resolution: df = fclk / 2^(n) = fclk / 2^(30) ~ 0.05 Hz
        - Maximum frequency: fc = 2 × OSR × frequency / fclk
    - Delta-Sigma modulator
        - OSR = 32 / 64 / 128 / 256
        - 1st / 2nd order
        - Inversion / exchange of the I/Q channel
    - 25% LO Generation for Mixer
        - DIV = 1 / 2 / 4 / 8
        - Debugging modes (mixer TG always on / off → fully differential measurement of the MFB filter is possible)
    - Debugging features
        - Bidirectional pads: measure DSM / LO output or inject signals externally
        - Analog pads: inject analog IQ modulator signals externally


## Description

TinyWhisper is a compact WSPR transmitter realized with the ihp-sg13g2 PDK. The 2 mm x 2 mm chip operates at a core supply voltage of 1.5 V and an I/O supply voltage of 3.3 V. The chip is [packaged](https://github.com/iic-jku/TinyWhisper/tree/main/packaging) in a QFN-48 package with a total of 56 pins, eight of which are VSS pins connected directly to the package VSS. All documentation, presentations, design files, and future updates are publicly available [here](https://github.com/iic-jku/TinyWhisper/tree/main/presentations). The block diagram is shown below. A render of the final chip layout is shown above, with the digital part placed on the left side of the chip and the analog part on the right. A custom logo on the topmost metal layer, generated with the tool [ArtistIC](https://arxiv.org/abs/2502.02626), is also shown above.

<p align="center">
  <a href="doc/fig/tinywhisper_blockdiagramm.png">
    <img src="doc/fig/tinywhisper_blockdiagramm.png" alt="Block diagram of the TinyWhisper ASIC and external RF circuitry" width=90%>
  </a>
  <br>
  <em>Block diagram of the TinyWhisper ASIC and external RF circuitry.</em>
</p>

### Weak Signal Propagation Reporter

WSPR is a popular digital transmission scheme in amateur radio, specifically designed to study propagation conditions at low transmit power. WSPR transmits a short message containing the callsign, location, and transmit power using 4-FSK modulation (tone spacing 1.46 Hz, symbol duration 0.683 s). Thanks to strong forward error correction (rate 1/2), long ranges can be achieved even at very low transmit power levels (down to 10 mW). Receivers can decode WSPR signals down to -31 dB below the noise floor of a 2500 Hz channel. Received signals are reported to a central [database](https://www.wsprnet.org/drupal/wsprnet/map) via the internet, enabling global analysis of signal propagation.

### Digital Core

The heart of the digital core is a simple multi-cycle embedded processor based on a 32-bit RISC-V architecture running at a clock rate of 56 MHz. By using the RISC-V architecture, the CPU is directly compatible with common compilers, and programs can, for example, be written in C. The program is stored in an external SPI SRAM, from which the CPU fetches its instructions. For communication with peripherals, the chip features I2C and UART interfaces as well as digital GPIO pins that can be freely controlled.

An integrated 30-bit CORDIC algorithm generates the 4-FSK-modulated I/Q baseband signals according to the WSPR protocol. The phase increment of the CORDIC can be configured via software, allowing any frequency to be generated with a resolution of approximately 0.05 Hz. This also enables compensation for frequency errors of the external crystal oscillator. Using a second-order Delta-Sigma (DS) modulator with selectable oversampling (32, 64, 128, or 256), the parallel 30-bit data from the CORDIC is converted into a 1-bit signal that is passed directly to the analog front-end. Additionally, the digital core generates the LO frequencies listed in the table below by dividing the 56 MHz clock by two, covering the most common shortwave bands: 28 MHz, 14 MHz, 7 MHz, and 3.5 MHz.

| Band | RF Frequency  | LO Frequency | IF (CORDIC) |
| ---- | ------------- | ------------ | ----------- |
| 80m  | 3.592600 MHz  | 3.5 MHz      | 92.600 kHz  |
| 40m  | 7.038600 MHz  | 7 MHz        | 38.600 kHz  |
| 20m  | 14.095600 MHz | 14 MHz       | 95.600 kHz  |
| 10m  | 28.124600 MHz | 28 MHz       | 124.600 kHz |

### Analog Front-End

The analog front-end is an IQ modulator consisting of two third-order multiple-feedback (MFB) low-pass filters with a cutoff frequency of 400 kHz and a Butterworth characteristic. The amplifier core of the MFB filter is based on a Barthelemy / Manfredini (B/M) inverter-based OTA. Two passive voltage-mode mixers are driven by a 25% duty-cycle local oscillator and produce a single-ended RF output signal.

Integrated SPDT switches allow switching between the internal CORDIC/DSM signals and external analog inputs, enabling tests with an external function generator, among other uses.

Since the analog front-end is an IQ modulator, it supports not only WSPR but also other modulation schemes such as FT8, SSB, and CW. Hence, the title "TinyWhisper: An Open-Source Fully-Integrated Multi-Mode Short-Wave Transmitter for Amateur Radio Applications in 130-nm CMOS".

### Outlook

The chip is still in production and is expected to be delivered in December 2026. The ASIC is just the beginning of a broader open-hardware project. The next step is to design a [PCB](https://github.com/iic-jku/TinyWhisper/tree/main/pcb) that includes all necessary external components: switchable bandpass filters for each RF band, an RF amplifier, a crystal oscillator as the clock source, external SRAM, voltage regulators for the various supply voltages, a display, controls, an SMA connector for the antenna, and a USB interface for configuration. The packaged chip will be soldered onto this board and then [characterized](https://github.com/iic-jku/TinyWhisper/tree/main/measurements).

Building on this PCB, a compact, 3D-printable [enclosure](https://github.com/iic-jku/TinyWhisper/tree/main/enclosure) is planned that accommodates the board together with a small battery and is robust enough for outdoor use during field tests and SOTA activations.


## ToDo List

The ToDo list can be found in [ToDo.md](https://github.com/iic-jku/TinyWhisper/tree/main/ToDo.md).


## Tapeouts

- [x] TinyWhisper Transmitter (Digital Core + IQ Modulator) — IHP130: https://github.com/iic-jku/TinyWhisper/tree/main/ihp130/release
- [x] RISC-V CPU — GF180 wafer.space: https://github.com/iic-jku/gf180mcu-jku-projects
- [x] WSPR in Hardware without RISC-V CPU (see [archive](https://github.com/iic-jku/TinyWhisper/tree/main/sky130/macros/archive/verilog_TT_11-2025) folder) — SKY130 Tiny Tapeout: https://tinytapeout.com/chips/ttsky25b/tt_um_cejmu_wspr
- [x] IQ Modulator — SKY130 Tiny Tapeout: https://tinytapeout.com/chips/ttsky25b/tt_um_TinyWhisper


## Directory Structure

```text
📁 TinyWhisper/
├─ 📁 .github/
│  └─ 📁 workflows/
│     └─ quarto-publish.yml
├─ 📁 doc/
│  ├─ 📁 fig/
│  │  ├─ 📁 funding/
│  │  │  ├─ iic-jku.svg
│  │  │  └─ silicon-austria-labs-logo.svg
│  │  ├─ Makefile
│  │  ├─ tinywhisper_blockdiagramm.png
│  │  ├─ tinywhisper_top_black.png
│  │  └─ tinywhisper_top_white.png
│  ├─ _quarto.yml
│  ├─ index.qmd
│  └─ Makefile
├─ 📁 enclosure/
│  └─ README.md
├─ 📁 ihp130/
│  ├─ 📁 doc/
│  ├─ 📁 flow/
│  │  ├─ 📁 artistic/
│  │  ├─ 📁 final/
│  │  ├─ 📁 librelane/
│  │  ├─ 📁 logo/
│  │  └─ 📁 reports/
│  ├─ 📁 ip/
│  │  ├─ 📁 sg13g2_io_custom/
│  │  ├─ 📁 sg13g2_ip__bondpad_70x70/
│  │  ├─ 📁 sg13g2_ip__ce/
│  │  ├─ 📁 sg13g2_ip__ce_names/
│  │  ├─ 📁 sg13g2_ip__jku/
│  │  └─ 📁 sg13g2_ip__jku_names/
│  ├─ 📁 layout/
│  │  ├─ tinywhisper_top.gds.gz
│  │  └─ tinywhisper_top_logo_fill.gds.gz
│  ├─ 📁 macros/
│  │  ├─ 📁 coupled_resonator_lc_bpf/
│  │  ├─ 📁 iqmod/
│  │  └─ 📁 riscv/
│  ├─ 📁 netlist/
│  │  ├─ 📁 layout/
│  │  ├─ 📁 nl/
│  │  ├─ 📁 pex/
│  │  ├─ 📁 pnl/
│  │  └─ 📁 spice/
│  ├─ 📁 release/
│  │  ├─ 📁 v.1.0.0/
│  │  │  ├─ 📁 doc/
│  │  │  │  └─ README.md
│  │  │  ├─ 📁 gds/
│  │  │  │  └─ SoC4219.gds.gz
│  │  │  └─ 📁 img/
│  │  │     ├─ tinywhisper_top_black.png
│  │  │     └─ tinywhisper_top_white.png
│  │  └─ 📁 v.2.0.0/
│  │     ├─ 📁 gds/
│  │     │  └─ tinywhisper_top_logo_fill.gds.gz
│  │     └─ 📁 netlist/
│  │        ├─ 📁 layout/
│  │        ├─ 📁 pnl/
│  │        └─ 📁 spice/
│  ├─ 📁 render/
│  │  ├─ 📁 blender/
│  │  └─ 📁 img/
│  │     ├─ tinywhisper_top_black.png
│  │     ├─ tinywhisper_top_librelane.png
│  │     └─ tinywhisper_top_white.png
│  ├─ 📁 rtl/
│  │  ├─ tinywhisper_core.sv
│  │  └─ tinywhisper_top.sv
│  ├─ 📁 schematic/
│  │  ├─ tinywhisper.sch
│  │  ├─ tinywhisper.sym
│  │  ├─ tinywhisper_top.sch
│  │  ├─ tinywhisper_top.sym
│  │  ├─ tinywhisper_top_pex.sym
│  │  └─ xschemrc
│  ├─ 📁 scripts/
│  │  ├─ 📁 plot_simulations/
│  │  ├─ add_logo_fill.sh
│  │  ├─ add_rectangle.py
│  │  ├─ gds_xor.py
│  │  └─ lay2img.py
│  ├─ 📁 testbenches/
│  │  ├─ 📁 cocotb/
│  │  └─ 📁 xschem/
│  ├─ 📁 verification/
│  │  ├─ 📁 drc/
│  │  └─ 📁 lvs/
│  ├─ Makefile
│  └─ README.md
├─ 📁 measurements/
│  └─ README.md
├─ 📁 packaging/
│  └─ README.md
├─ 📁 pcb/
│  └─ README.md
├─ 📁 presentations/
│  ├─ EasterHegg_04042026.pdf
│  └─ README.md
├─ 📁 sky130/
│  └─ 📁 macros/
│     ├─ 📁 archive/
│     ├─ 📁 iqmod/
│     └─ 📁 riscv/
├─ 📁 software/
│  ├─ 📁 c_toolchain/
│  ├─ generate_tests.py
│  ├─ program_fpga_uart.py
│  ├─ README.md
│  ├─ test_wspr.py
│  └─ wspr.py
├─ .designinit
├─ .gitattributes
├─ .gitignore
├─ .gitmodules
├─ CITATION.cff
├─ LICENSE
├─ README.md
└─ requirements.txt
```


## Cite This Work

```
@software{2026_TinyWhisper,
	author = {Dorrer, Simon and Hager, Jonathan and Jung, Matthias and Pretl, Harald},
	month = apr,
    year = {2026},
	title = {{GitHub Repository for TinyWhisper: An Open-Source Fully-Integrated Multi-Mode Short-Wave Transmitter for Amateur Radio Applications in 130-nm CMOS}},
	url = {https://github.com/iic-jku/TinyWhisper},
	doi = {10.5281/zenodo.20004085}
}
```


## Acknowledgements

This project is funded by the JKU/SAL [IWS Lab](https://research.jku.at/de/projects/jku-lit-sal-intelligent-wireless-systems-lab-iws-lab/), a collaboration of [Johannes Kepler University](https://jku.at) and [Silicon Austria Labs](https://silicon-austria-labs.com).

<table width="100%">
  <tr>
    <td align="left" width="50%">
      <a href="https://iic.jku.at" target="_blank">
        <img src="doc/fig/funding/iic-jku.svg" alt="Johannes Kepler University: Institute for Integrated Circuits and Quantum Computing" width="94%"/>
      </a>
    </td>
    <td align="right" width="50%">
      <a href="https://silicon-austria-labs.com" target="_blank">
        <img src="doc/fig/funding/silicon-austria-labs-logo.svg" alt="Silicon Austria Labs" width="94%"/>
      </a>
    </td>
  </tr>
</table>