MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

RUN_TAG = $(shell ls librelane/runs/ | tail -n 1)
TOP = bondpad_70x70

PDK_ROOT ?= $(MAKEFILE_DIR)/../../IHP-Open-PDK
PDK ?= ihp-sg13g2
include $(MAKEFILE_DIR)/../../pdk_hash.mk

.DEFAULT_GOAL := help

$(PDK_ROOT)/$(PDK):
	ciel enable $(PDK_COMMIT) --pdk-root $(PDK_ROOT) --pdk-family $(PDK)

# Folder structure
GDS_DIR   	:= gds
LEF_DIR   	:= lef
VH_DIR    	:= vh
DRC_RPT_DIR := reports

# Bondpad parameters
DIAMETER  	?= 70.0
SHAPE     	?= square

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help

all: clean bondpad verilog drc
.PHONY: all

bondpad:
	KLAYOUT_PATH=$(PDK_ROOT)/$(PDK)/libs.tech/klayout:$(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech klayout -n sg13g2 -zz -r script/bondpad.py -rd diameter=$(DIAMETER) -rd shape=$(SHAPE) -rd gds_output=$(GDS_DIR)/$(TOP).gds -rd lef_output=$(LEF_DIR)/$(TOP).lef
.PHONY: bondpad

drc:
	mkdir -p $(DRC_RPT_DIR)
	python3 $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/drc/run_drc.py \
		--path=$(GDS_DIR)/$(TOP).gds \
		--topcell=$(TOP) \
		--run_dir=$(DRC_RPT_DIR) \
		--antenna \
		--no_feol \
		--no_density \
		--disable_extra_rules
.PHONY: drc

verilog:
	mkdir -p $(VH_DIR)
	@printf 'module $(TOP) (\n    inout pad\n);\nendmodule\n' > $(VH_DIR)/$(TOP).v
.PHONY: verilog

clean:
	rm -rf $(GDS_DIR)
	rm -rf $(LEF_DIR)
	rm -rf $(VH_DIR)
	rm -rf $(DRC_RPT_DIR)
.PHONY: clean
