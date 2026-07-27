# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.DEFAULT_GOAL := help

# Folder structure
XSCHEM_SCH_DIR  := schematic/xschem
XSCHEM_TB_DIR   := testbenches/xschem
SCRIPTS_DIR     := scripts


# Help Target
help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z0-9_.-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help
# ================================================================================================


# Simulation Targets
# Testbench name for sim-xschem target (required: make sim-xschem TB=<testbenchname>)
TB ?= $(error TB is not set. Usage: make sim-xschem TB=<testbenchname>)

sim-xschem: ## Run TB simulation with Xschem (usage: make sim-xschem TB=<testbenchname>)
	cd $(XSCHEM_TB_DIR) && xschem -x -q --rcfile xschemrc --command ' \
		set netlist_dir $(abspath $(XSCHEM_TB_DIR)/simulations); \
		xschem save; \
		xschem netlist; \
		xschem simulate \
	' $(TB).sch
.PHONY: sim-xschem

sim-all: ## Simulate the macro
	$(MAKE) sim-xschem TB=coupled_resonator_lc_bpf_tb_ac
.PHONY: sim-all
# ================================================================================================


# Simulate All Target
# This macro is schematic-only (ideal LC band-pass filter used for system-level simulations),
# so there are no build or verification targets.
all: ## Simulate the macro
	$(MAKE) sim-all
.PHONY: all
# ================================================================================================
