MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

RUN_TAG = $(shell ls librelane/runs/ | tail -n 1)
TOP = sg13g2_ip__ce_names

PDK_ROOT ?= $(MAKEFILE_DIR)/../../IHP-Open-PDK
PDK ?= ihp-sg13g2
include $(MAKEFILE_DIR)/../../pdk_hash.mk

.DEFAULT_GOAL := help

$(PDK_ROOT)/$(PDK):
	ciel enable $(PDK_COMMIT) --pdk-root $(PDK_ROOT) --pdk-family $(PDK)

# Folder structure
GDS_DIR     := gds
LEF_DIR     := lef
LIB_DIR     := lib
VH_DIR      := vh
DRC_RPT_DIR := reports

# Logo parameters
IMG_FILE    := image/ce_names.png
IMG_SIZE_PX ?= 750
BLOCK_SIZE  ?= 100
PIXEL_SIZE  ?= 0.25 	# Pixel size in microns. Must be >= minimum layer width to avoid DRC violations.
# scale = BLOCK_SIZE / (IMG_SIZE_PX * PIXEL_SIZE)
SCALE       := $(shell python3 -c "print($(BLOCK_SIZE) / ($(IMG_SIZE_PX) * $(PIXEL_SIZE)))")

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help

all: clean logo lef lib verilog drc
.PHONY: all

# Layers (IHP SG13G2):
# (8, 0),      # Metal1
# (10, 0),     # Metal2
# (30, 0),     # Metal3
# (50, 0),     # Metal4
# (67, 0),     # Metal5
# (126, 0),    # TopMetal1
# (134, 0),    # TopMetal2
# (189, 0),    # prBoundary
# (160, 0),    # NoMetFiller
logo:
	mkdir -p $(GDS_DIR)
	python3 script/make_gds.py $(IMG_FILE) $(GDS_DIR)/$(TOP).gds --cellname $(TOP) --invert --merge --pixel-size $(PIXEL_SIZE) --scale $(SCALE) --foreground "67/0" --boundary "189/0" "160/0"
.PHONY: logo

lef:
	mkdir -p $(LEF_DIR)
	@printf 'VERSION 5.8 ;\n  NOWIREEXTENSIONATPIN ON ;\n  DIVIDERCHAR "/" ;\n  BUSBITCHARS "[]" ;\nMACRO $(TOP)\n  CLASS BLOCK ;\n  FOREIGN $(TOP) ;\n  ORIGIN 0.000 0.000 ;\n  SIZE $(BLOCK_SIZE) BY $(BLOCK_SIZE) ;\n  OBS\n      LAYER TopMetal2 ;\n        RECT 0.0 0.0 $(BLOCK_SIZE) $(BLOCK_SIZE) ;\n  END\nEND $(TOP)\nEND LIBRARY\n' > $(LEF_DIR)/$(TOP).lef
.PHONY: lef

lib:
	mkdir -p $(LIB_DIR)
	@printf 'library ($(TOP)) {\n  input_threshold_pct_fall: 50.0;\n  input_threshold_pct_rise: 50.0;\n  output_threshold_pct_fall: 50.0;\n  output_threshold_pct_rise: 50.0;\n  slew_lower_threshold_pct_fall: 20.0;\n  slew_lower_threshold_pct_rise: 20.0;\n  slew_upper_threshold_pct_fall: 80.0;\n  slew_upper_threshold_pct_rise: 80.0;\n  \n  cell ($(TOP)) {\n  }\n}\n' > $(LIB_DIR)/$(TOP).lib
.PHONY: lib

verilog:
	mkdir -p $(VH_DIR)
	@printf 'module $(TOP);\nendmodule\n' > $(VH_DIR)/$(TOP).v
.PHONY: verilog

drc:
	mkdir -p $(DRC_RPT_DIR)
	python3 $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/drc/run_drc.py \
		--path=$(GDS_DIR)/$(TOP).gds \
		--topcell=$(TOP) \
		--run_dir=$(DRC_RPT_DIR) \
		--no_feol \
		--no_density \
		--disable_extra_rules
.PHONY: drc

clean:
	rm -rf $(GDS_DIR)
	rm -rf $(LEF_DIR)
	rm -rf $(LIB_DIR)
	rm -rf $(VH_DIR)
	rm -rf $(DRC_RPT_DIR)
.PHONY: clean
