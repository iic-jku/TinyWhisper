# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
#
# Cocotb Makefile for delta-sigma modulator testbench

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
MAKEFILE_PATH := $(realpath $(firstword $(MAKEFILE_LIST)))

# Variables
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
TOPLEVEL = dsmod
PYTHON_BIN ?= python3

.DEFAULT_GOAL := help

# Folder structure
SRC_DIR 		 := $(MAKEFILE_DIR)/../../../rtl
RESULTS_DIR 	 := $(MAKEFILE_DIR)/results
PSD_RESULTS_DIR  := $(RESULTS_DIR)/psd
SNDR_RESULTS_DIR := $(RESULTS_DIR)/sndr
RAMP_RESULTS_DIR := $(RESULTS_DIR)/ramp

# Source files
VERILOG_SOURCES = $(SRC_DIR)/dsmod.v

# Cocotb test module
COCOTB_TEST_MODULES = dsmod_cocotb

# Enable waveform dumping
COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 100ps

# Icarus Verilog compile flags
COMPILE_ARGS += -g2012

# Override cocotb defaults so all generated artefacts carry the dsmod_ prefix
SIM_BUILD = $(RESULTS_DIR)/dsmod_sim_build
export COCOTB_RESULTS_FILE = $(RESULTS_DIR)/dsmod_results.xml

# Set simulation settings (timeunit, timeprecision, compile flags, etc.)
include $(shell cocotb-config --makefiles)/Makefile.sim


# Help Target
help: ## Show this help message
	@echo 'Usage: make [target] [PYTHON_BIN=<python>]' 
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z0-9_.-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help
# ================================================================================================


# PSD Target
psd: ## Run PSD cocotb test, then plot PSD and analog output
	mkdir -p $(PSD_RESULTS_DIR)
	DSMOD_RESULT_DIR=$(PSD_RESULTS_DIR) $(MAKE) -f $(MAKEFILE_PATH) sim COCOTB_TEST_MODULES=dsmod_cocotb COCOTB_TEST_FILTER=dsmod_psd_test SIM_BUILD=$(PSD_RESULTS_DIR)/dsmod_sim_build COCOTB_RESULTS_FILE=$(PSD_RESULTS_DIR)/dsmod_results.xml
	DSMOD_RESULT_DIR=$(PSD_RESULTS_DIR) $(PYTHON_BIN) $(MAKEFILE_DIR)/dsmod_plot_psd.py
	DSMOD_RESULT_DIR=$(PSD_RESULTS_DIR) $(PYTHON_BIN) $(MAKEFILE_DIR)/dsmod_plot_analog.py
.PHONY: psd
# ================================================================================================


# SNDR Target
sndr: ## Run SNDR sweep and generate SNDR plot
	mkdir -p $(SNDR_RESULTS_DIR)
	DSMOD_RESULT_DIR=$(SNDR_RESULTS_DIR) $(PYTHON_BIN) $(MAKEFILE_DIR)/dsmod_sndr_sweep.py
	DSMOD_RESULT_DIR=$(SNDR_RESULTS_DIR) $(PYTHON_BIN) $(MAKEFILE_DIR)/dsmod_plot_sndr.py
.PHONY: sndr
# ================================================================================================


# Ramp Target
ramp: ## Run ramp cocotb test and generate ramp plot
	mkdir -p $(RAMP_RESULTS_DIR)
	DSMOD_RESULT_DIR=$(RAMP_RESULTS_DIR) $(MAKE) -f $(MAKEFILE_PATH) sim COCOTB_TEST_MODULES=dsmod_ramp_cocotb COCOTB_TEST_FILTER=dsmod_ramp_test SIM_BUILD=$(RAMP_RESULTS_DIR)/dsmod_sim_build COCOTB_RESULTS_FILE=$(RAMP_RESULTS_DIR)/dsmod_results.xml
	DSMOD_RESULT_DIR=$(RAMP_RESULTS_DIR) $(PYTHON_BIN) $(MAKEFILE_DIR)/dsmod_plot_ramp.py
.PHONY: ramp
# ================================================================================================


# Clean Target
clean:: ## Remove generated plots and simulator build artifacts
	rm -rf $(RESULTS_DIR)
.PHONY: clean
# ================================================================================================


# All Target
all: ## Run all tests and generate all plots for DSMOD_ORDER=2 and DSMOD_OSR=64
	$(MAKE) clean
	$(MAKE) DSMOD_ORDER=2 DSMOD_OSR=64 psd
	$(MAKE) DSMOD_ORDER=2 DSMOD_OSR=64 sndr
	$(MAKE) DSMOD_ORDER=2 DSMOD_OSR=64 ramp
.PHONY: all
# ================================================================================================


# All Runs Target
all_runs: ## Run all tests and generate all plots for all DSMOD orders and OSRs
	$(MAKE) clean
	for order in 1 2; do \
		for osr in 32 64 128 256; do \
			echo "[all_runs] Running ORDER=$$order OSR=$$osr"; \
			$(MAKE) DSMOD_ORDER=$$order DSMOD_OSR=$$osr psd; \
			$(MAKE) DSMOD_ORDER=$$order DSMOD_OSR=$$osr sndr; \
			$(MAKE) DSMOD_ORDER=$$order DSMOD_OSR=$$osr ramp; \
		done; \
	done
.PHONY: all_runs
# ================================================================================================