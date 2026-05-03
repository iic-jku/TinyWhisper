#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0

# =====================================================
# Author: Simon Dorrer
# Last Modified: 02.10.2025
# Description: This .sh file verifies and simulates a verilog testbench with Verilator, IVerilog and GTKWave.
# =====================================================

set -e -x

cd $(dirname "$0")

GREEN='\033[1;32m'
NC='\033[0m'

name=$1

RTL=${RTL:-../rtl}
SRC_FOLDER=${SRC_FOLDER:-.}

echo -e "${GREEN}SKIPPING Verilator!:------------------------------------------ ${NC}"
# echo -e "${GREEN}Verilator:------------------------------------------ ${NC}"
# verilator --lint-only -I"$RTL" "$RTL/../constants.sv" "$RTL"/"$name".sv # -I"$RTL" for multiple Verilog file dependencies in "rtl" folder

echo -e "${GREEN}IVerilog:------------------------------------------- ${NC}"
iverilog -g2012 -DSIM -I "$RTL"  "$RTL/../constants.sv" "$RTL/sram_sim.sv" "$RTL/uart_tx.v"\
    "$RTL/alu.sv" "$RTL/control.sv" "$RTL/csr.sv" "$RTL/instructioncounter.sv" "$RTL/memory.sv"\
    "$RTL/regs.sv" "$RTL/freq_generator.sv" "$RTL/i2c_master.sv" "$RTL/imm_gen.sv"\
    "$RTL/spi_master.sv" "$RTL/uart_rx.v" "$RTL/cordic_iterative.v" "$RTL/cordic_slice.v"\
    "$RTL/dsmod.v" "$RTL/lo_gen.v" "$RTL/tinywhisper_riscv.sv" "$SRC_FOLDER/${name}_tb.sv" # -I"$RTL" for multiple Verilog file dependencies in "rtl" folder


echo -e "${GREEN}a:-------------------------------------------------- ${NC}"
./a.out

echo -e "${GREEN}GTKWave:-------------------------------------------- ${NC}"
if [ -e "$SRC_FOLDER"/"$name".gtkw ]
then
  gtkwave "$SRC_FOLDER"/"$name".gtkw
else
  gtkwave "$SRC_FOLDER"/"$name".vcd
fi

# Clean
rm -f a.out
# rm -f *.vcd

echo -e "${GREEN}Generated files were removed------------------------ ${NC}"
