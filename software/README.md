# RISC-V Software
This directory contains software implementations that can be used to generate WSPR encodings in Python and compile programs for the RISC-V core of TinyWhisper

## WSPR Python implementation
### Installation
The software reference implementation uses `uv`

To setup the project use 

`uv venv`

Then `direnv allow` to enable the virtual environment

Install all requirements:

```
uv pip install -r requirements.txt
```

For developers:

To generate the requirements.txt:

```
uv pip freeze > requirements.txt
```

### Usage
[wspr.py](wspr.py) contains a reference implementation of the [WSPR encoding process](http://g4jnt.com/WSPR_Coding_Process.pdf). The process is split into steps where each function implements one step in the encoding pipeline. [test_wspr.py](test_wspr.py) provides unit tests for the implementation and shows how the functions have to be used.

The file [program_fpga_uart.py](program_fpga_uart.py) implements the communication protocol for the [TinyWhisper tapeout](https://github.com/CEJMU/tt-WhisperEncoder) on Tiny Tapeout. It is used to send callsign, locator, power, lo division ratio and the cordic frequency to the Tiny Tapeout board.

## C toolchain
This directory contains a small hardware abstraction layer for the RISC-V cpu and a CMake build system for compiling programs and sending the program to the CPU (this currently only works for the pico-ice FPGA prototype board. More targets will be supported after the respective tapeouts arrive).
