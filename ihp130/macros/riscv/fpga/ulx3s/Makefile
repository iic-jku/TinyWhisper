# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: ULX3S (Lattice ECP5-85F, CABGA381). The riscv_top ports (clk, reset,
# the SPI SRAM, I2C, UART and GPIO interfaces and the baseband outputs) are
# mapped straight onto board pins, no board-top wrapper. See ../README.md.
#
# This is the default board of the dispatcher: the macro no longer fits an
# iCE40UP5K (6132 of 5280 LCs), while it takes 6.9% of the 85F.

TOP := riscv_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := ulx3s.lpf

ARCH        := ecp5
ECP5_DEVICE := --85k --package CABGA381

OPENFPGALOADER_BOARD := ulx3s
OPENFPGALOADER_FLAGS := --unprotect-flash

include $(TOP_FPGA_DIR)/fpga.mk
