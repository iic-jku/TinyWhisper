# C toolchain for the TinyWhisper RISC-V CPU
## Requirements
You need to install CMake >= 3.30 and the [RISC-V GNU toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) with arch=rv32e and abi=ilp32e

## Building and flashing the demo
Assuming you are in the c_toolchain directory:
``` sh
$ git submodule update --init
$ mkdir build && cd build
$ cmake ..
$ make demo.bin # Compile the target demo.bin
$ python3 ../program_sram.py /dev/ttyACM0 demo.bin # Assuming the pico-ice shows up as ttyACM0
```

## What the demo does
The demo shows how the CPU can be programmed to send WSPR using the analog frontend. The generated WSPR frequencies are 1500, 1501.5, 1503 and 1504.5 Hz, so that the prototype can be attached to a speaker and more easily decoded by WSJT-X. For this, the program performs the following steps:
1. Read the callsign, locator and power from the UART interface. You can use any console for this (for example picocom).
2. Compute the corresponding WSPR symbols
3. Prompt the user to start the transmissions through an external interrupt (or UART - currently commented out)
4. Set the cordic, dsmod and lo_gen settings and change the generated frequency to that of the first symbol
5. Activate timer interrupts and set them to 1 second
6. Wait until the timer interrupt fires, change the symbol to the next one and reset the timer interrupt
7. After all 162 symbols have been transmitted, deactivate the cordic, dsmod and the analog frontend
