# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# RTL of the design under test, shared by all boards.
#
# constants.sv defines the shared opcode/funct localparams and must compile before
# any module that uses them, so it is the first entry. riscv_top.sv comes last, after
# every module it instantiates.

# Path from a <board>/ folder back to the shared flow (fpga.mk, arch/)
TOP_FPGA_DIR := ..

SRC_DIR := ../../rtl

DUT_SRCS := \
	$(SRC_DIR)/constants.sv \
	$(SRC_DIR)/uart_tx.v \
	$(SRC_DIR)/uart_rx.v \
	$(SRC_DIR)/i2c_master.sv \
	$(SRC_DIR)/i2c_master_mc.sv \
	$(SRC_DIR)/spi_master.sv \
	$(SRC_DIR)/dsmod.v \
	$(SRC_DIR)/cordic_slice.v \
	$(SRC_DIR)/cordic_iterative.v \
	$(SRC_DIR)/lo_gen.v \
	$(SRC_DIR)/freq_generator.sv \
	$(SRC_DIR)/memory.sv \
	$(SRC_DIR)/regs.sv \
	$(SRC_DIR)/alu.sv \
	$(SRC_DIR)/control.sv \
	$(SRC_DIR)/instructioncounter.sv \
	$(SRC_DIR)/csr.sv \
	$(SRC_DIR)/imm_gen.sv \
	$(SRC_DIR)/riscv_top.sv
