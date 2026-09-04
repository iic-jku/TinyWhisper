# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# Variables
TOP = coupled_resonator_lc_bpf

.DEFAULT_GOAL := help

# PDK Guard
# Override with: make <target> REQUIRED_PDK=<pdk>, an empty value skips the check
REQUIRED_PDK ?= ihp-sg13g2

# Goals that do not read the PDK
PDK_FREE_GOALS = help clean

ifneq ($(REQUIRED_PDK),)
ifneq ($(filter-out $(PDK_FREE_GOALS),$(or $(MAKECMDGOALS),$(.DEFAULT_GOAL))),)
ifneq ($(PDK),$(REQUIRED_PDK))
$(error PDK is "$(PDK)", but this macro needs "$(REQUIRED_PDK)". Run `sak-pdk $(REQUIRED_PDK)` in this shell and retry, or pass REQUIRED_PDK= to skip this check)
endif
endif
endif
# ================================================================================================


# Extra options for the sak-open.py file browser (e.g. --all to include build outputs)
# Override with: make open OPEN_ARGS=<options>
OPEN_ARGS ?=

# Folder structure
XSCHEM_SCH_DIR  := schematic/xschem
XSCHEM_TB_DIR   := testbenches/xschem
SCRIPTS_DIR     := scripts


# Help Target
help: ## Show this help message
	@echo 'Usage: make <target> [TB=<testbenchname>] [OPEN_ARGS=<options>]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z0-9_.-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-20s %s\n", $$1, $$2}'
	@echo ''
	@echo 'TB selects the Xschem testbench for sim-xschem (default: $(TOP)_tb_ac).'
	@echo 'OPEN_ARGS passes extra options to sak-open.py for the open target (e.g. --all).'
	@echo 'REQUIRED_PDK defaults to $(REQUIRED_PDK). Every target except help and clean aborts if $$PDK differs.'
.PHONY: help
# ================================================================================================


# Open Target
open: ## Open the design files of this folder in the sak-open.py file browser (needs the VNC/X11 desktop)
	sak-open.py $(OPEN_ARGS) .
.PHONY: open
# ================================================================================================


# Simulation Targets
# Testbench for the Xschem simulation targets (default: <TOP>_tb_ac, the only testbench of this macro)
# Override with: make <target> TB=<testbenchname>
TB ?= $(TOP)_tb_ac

sim-xschem: ## Run TB simulation with Xschem in batch mode (usage: make sim-xschem [TB=<testbenchname>])
	mkdir -p $(XSCHEM_TB_DIR)/simulations
	cd $(XSCHEM_TB_DIR) && xschem -r -x -q --rcfile xschemrc --command ' \
		xschem set netlist_type spice; \
		set netlist_dir $(abspath $(XSCHEM_TB_DIR)/simulations); \
		xschem save; \
		write_data [save_params] $(abspath $(XSCHEM_TB_DIR)/simulations)/$(TB).save; \
		xschem netlist \
	' $(TB).sch
	cd $(XSCHEM_TB_DIR)/simulations && ngspice -b $(TB).spice
.PHONY: sim-xschem

sim-all: ## Simulate the macro
	$(MAKE) sim-xschem TB=$(TOP)_tb_ac
.PHONY: sim-all
# ================================================================================================


# Simulate All Target
# This macro is schematic-only (ideal LC band-pass filter used for system-level simulations),
# so there are no build or verification targets.
all: ## Simulate the macro
	$(MAKE) sim-all
.PHONY: all
# ================================================================================================


# Clean Target
clean: ## Delete all generated files and folders (simulation outputs)
	rm -rf $(XSCHEM_SCH_DIR)/simulations $(XSCHEM_TB_DIR)/simulations
.PHONY: clean
# ================================================================================================
