# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: pico-ice (Lattice iCE40UP5K, SG48). The riscv_top ports (clk, reset,
# the SPI SRAM, I2C, UART and GPIO interfaces and the baseband outputs) are
# mapped straight onto board pins, no board-top wrapper. See ../README.md.

TOP := riscv_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := pico-ice.pcf

ARCH         := ice40
ICE40_DEVICE := --up5k --package sg48

# DFU alt 0 is the SPI flash, alt 1 the FPGA's volatile configuration memory.
# The RP2040 co-processor is the DFU bootloader, so iceprog does not work here.
# Must be `=`, not `:=`, since BITSTREAM is only defined later, by fpga.mk.
LOAD_CMD  = dfu-util --alt 1 --download $(BITSTREAM)
FLASH_CMD = dfu-util --alt 0 --download $(BITSTREAM) --reset

include $(TOP_FPGA_DIR)/fpga.mk
