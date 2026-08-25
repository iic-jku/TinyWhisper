# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: iCEBreaker (Lattice iCE40UP5K, SG48). The riscv_top ports (clk, reset,
# the SPI SRAM, I2C, UART and GPIO interfaces and the baseband outputs) are
# mapped straight onto board pins, no board-top wrapper. See ../README.md.

TOP := riscv_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := icebreaker.pcf

ARCH         := ice40
ICE40_DEVICE := --up5k --package sg48

# openFPGALoader has no dedicated iCEBreaker board profile. The board carries an
# FT2232H, so iceprog talks to the flash over SPI directly.
# Must be `=`, not `:=`, since BITSTREAM is only defined later, by fpga.mk.
LOAD_CMD  = iceprog -S $(BITSTREAM)
FLASH_CMD = iceprog $(BITSTREAM)

include $(TOP_FPGA_DIR)/fpga.mk
