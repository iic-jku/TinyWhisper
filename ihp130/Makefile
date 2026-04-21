# TODO: LibreLane 3.0 is already running within the IIC-OSIC-TOOLS.
# Hence, in the future, all nix-shell related targets will be removed (PDK_ROOT, PDK, pdk_hash.mk, and clone-pdk).

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

RUN_TAG = $(shell ls librelane/runs/ | tail -n 1)
TOP = tinywhisper_top

PDK_ROOT ?= $(MAKEFILE_DIR)/IHP-Open-PDK
PDK ?= ihp-sg13g2
include $(MAKEFILE_DIR)/pdk_hash.mk

.DEFAULT_GOAL := help

$(PDK_ROOT)/$(PDK):
	ciel enable $(PDK_COMMIT) --pdk-root $(PDK_ROOT) --pdk-family $(PDK)

# PEX mode (1 = C-decoupled, 2 = C-coupled, 3 = full-RC)
# Override with: make pex PEX_MODE=<1|2|3>
PEX_MODE ?= 1

# Floating-point precision (significant digits) for xschem's ev function
# Override with: make lvs-netlist EV_PRECISION=<digits>
EV_PRECISION ?= 5

# Folder structure
XSCHEM_DIR  := xschem
# Final deliverables
GDS_DIR     := gds
# LibreLane's final GDS output directory (before adding logo & fillers)
LL_GDS_DIR  := final/gds
# Verification directories
LVS_DIR     := verification/lvs
DRC_DIR     := verification/drc
PEX_DIR     := verification/pex
LVS_RPT_DIR := $(LVS_DIR)/reports
DRC_RPT_DIR := $(DRC_DIR)/reports

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help

init-submodules: ## Initialize and update git submodules (e.g. ihp130/artistic)
	git -C $(MAKEFILE_DIR)/.. submodule update --init
.PHONY: init-submodules

clone-pdk: $(PDK_ROOT)/$(PDK) ## Clone the IHP-Open-PDK repository
.PHONY: clone-pdk

librelane: $(PDK_ROOT)/$(PDK) ## Run LibreLane
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to final/
.PHONY: librelane

librelane-nodrc: $(PDK_ROOT)/$(PDK) ## Run LibreLane without DRC checks
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to final/ --skip KLayout.DRC --skip Magic.DRC --skip KLayout.Antenna --skip KLayout.Density
.PHONY: librelane-nodrc

librelane-magicdrc: $(PDK_ROOT)/$(PDK) ## Run LibreLane with only Magic DRC checks
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to final/ --skip KLayout.DRC
.PHONY: librelane-magicdrc

librelane-klayoutdrc: $(PDK_ROOT)/$(PDK) ## Run LibreLane with only KLayout DRC checks
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to final/ --skip Magic.DRC
.PHONY: librelane-klayoutdrc

librelane-openroad: $(PDK_ROOT)/$(PDK) ## Open the last LibreLane run in OpenROAD GUI
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --last-run --flow OpenInOpenROAD
.PHONY: librelane-openroad

librelane-klayout: $(PDK_ROOT)/$(PDK) ## Open the last LibreLane run in KLayout
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --last-run --flow OpenInKLayout
.PHONY: librelane-klayout

sim: ## Run RTL simulation with cocotb
	cd cocotb; PDK_ROOT=${PDK_ROOT} PDK=${PDK} python3 ${TOP}_tb.py
.PHONY: sim

sim-gl: $(PDK_ROOT)/$(PDK) ## Run gate-level simulation with cocotb
	cd cocotb; GL=1 PDK_ROOT=${PDK_ROOT} PDK=${PDK} python3 ${TOP}_tb.py
.PHONY: sim-gl

sim-view: ## View simulation waveforms in GTKWave
	gtkwave cocotb/sim_build/${TOP}.fst
.PHONY: sim-view

# TODO: Antenna and DRC reports are temporarily commented out until IHP fixes the `metal1_pin_offgrid` errors.
# For now, `make librelane-nodrc` has to be used.
# https://github.com/IHP-GmbH/IHP-Open-PDK/issues/683#issuecomment-4065791975
copy-reports: ## Copy yosys, antenna violations, hold & setup timing, DRC, LVS and manufacturability reports
	rm -rf reports/
	mkdir -p reports/
	# Using * wildcard to ignore step numbers
	cp librelane/runs/${RUN_TAG}/*-yosys-synthesis/reports/pre_synth_chk.rpt reports/yosys_synth_check.rpt
	cp librelane/runs/${RUN_TAG}/*-yosys-synthesis/reports/pre_techmap.rpt reports/yosys_pre_techmap.rpt
	cp librelane/runs/${RUN_TAG}/*-yosys-synthesis/reports/post_dff.rpt reports/yosys_post_dff.rpt
	cp librelane/runs/${RUN_TAG}/*-yosys-synthesis/reports/stat.rpt reports/stat.rpt
	cp librelane/runs/${RUN_TAG}/*-openroad-checkantennas-1/reports/antenna.rpt reports/antenna_violations.rpt
	cp librelane/runs/${RUN_TAG}/*-openroad-checkantennas-1/reports/antenna_summary.rpt reports/antenna_summary.rpt
	cp librelane/runs/${RUN_TAG}/*-openroad-stapostpnr/summary.rpt reports/hold_setup_timing.rpt
# 	cp librelane/runs/${RUN_TAG}/*-klayout-antenna/reports/antenna.klayout.json reports/antenna.klayout.json
# 	cp librelane/runs/${RUN_TAG}/*-magic-drc/reports/drc.magic.rpt reports/drc.magic.rpt
# 	cp librelane/runs/${RUN_TAG}/*-klayout-drc/reports/drc.klayout.json reports/drc.klayout.json
	cp librelane/runs/${RUN_TAG}/*-netgen-lvs/reports/lvs.netgen.rpt reports/lvs.netgen.rpt
	cp librelane/runs/${RUN_TAG}/*-misc-reportmanufacturability/manufacturability.rpt reports/manufacturability.rpt
.PHONY: copy-reports

copy-gds: ## Copy and compress final output GDS from the last LibreLane run (no logo & fillers) to the gds/ directory
	rm -rf $(GDS_DIR)/
	mkdir -p $(GDS_DIR)/
	cp -r $(LL_GDS_DIR)/${TOP}.gds $(GDS_DIR)/${TOP}.gds
	gzip -k $(GDS_DIR)/${TOP}.gds
.PHONY: copy-gds

# This target is for adding the TinyWhisper logo and fillers on all layers.
# TODO: This step is temporary and will be replaced by a custom LibreLane step in the future.
add-logo-fill: init-submodules ## Init. submodules and call add_logo_fill.sh to add TinyWhisper logo
	cd scripts && ./add_logo_fill.sh
.PHONY: add-logo-fill

render-image: ## Render an image from the final layout with logo and fillers using lay2img.py
	rm -f img/tinywhisper_top_*.png
	mkdir -p img/
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} python3 scripts/lay2img.py $(GDS_DIR)/${TOP}_logo_fill.gds.gz img/${TOP}.png --width 2048 --oversampling 4
.PHONY: render-image

build-bondpad: $(PDK_ROOT)/$(PDK) ## Build the bondpad
	@$(MAKE) -C ip/bondpad_70x70 all
.PHONY: build-bondpad

build-logos: $(PDK_ROOT)/$(PDK) ## Build the logos
	@$(MAKE) -C ip/sg13g2_ip__jku all
	@$(MAKE) -C ip/sg13g2_ip__ce all
	@$(MAKE) -C ip/sg13g2_ip__jku_names all
	@$(MAKE) -C ip/sg13g2_ip__ce_names all
.PHONY: build-logos

build-riscv: $(PDK_ROOT)/$(PDK) ## Build the RISC-V macro
	@$(MAKE) -C macros/riscv all
.PHONY: build-riscv

build-iqmod: ## Build the IQ modulator macro
	@$(MAKE) -C macros/iqmod all
.PHONY: build-iqmod

build-all-macros: build-riscv build-iqmod ## Build all macros (RISC-V and IQ modulator)
.PHONY: build-all-macros

# TODO: See above, `make librelane-nodrc` is used for now until IHP fixes the `metal1_pin_offgrid` errors. Once fixed, `make librelane` can be used again.
# TODO: Add `make build-all-macros`. For now, this is not possible. RISC-V CPU is built with nix-shell. Top-Level is built with `next` release of IIC-OSIC-TOOLS due to https://github.com/FPGA-Research/heichips25-tapeout/blob/8944926f1f49e382616fbdd150e356bbdcf23b8c/nix/disable_auto_taper.patch#L4.
build-all: build-bondpad build-logos librelane-nodrc copy-reports copy-gds add-logo-fill render-image librelane-openroad ## Build the whole chip (clone PDK, build logos, build analog & digital macros, run LibreLane, copy reports & final files, render image)
.PHONY: build-all

# Verification targets
lvs-netlist: ## Export LVS netlist from Xschem (usage: make lvs-netlist [EV_PRECISION=<digits>])
	mkdir -p $(LVS_DIR)
	xschem -s -x -q --rcfile $(XSCHEM_DIR)/xschemrc --command ' \
		set spiceprefix 0; \
		set lvs_netlist 1; \
		set ev_precision $(EV_PRECISION); \
		set netlist_dir $(LVS_DIR); \
		xschem set netlist_name [file tail [file rootname [xschem get current_name]]].spice; \
		xschem netlist \
	' $(XSCHEM_DIR)/$(TOP).sch
.PHONY: lvs-netlist

lvs: ## LVS of the chip with logo and fillers (usage: make lvs)
	$(MAKE) lvs-netlist
	mkdir -p $(LVS_RPT_DIR)
	python3 $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/lvs/run_lvs.py \
		--path=$(GDS_DIR)/${TOP}_logo_fill.gds.gz \
		--netlist=$(LVS_DIR)/$(TOP).spice \
		--topcell=$(TOP) \
		--run_dir=$(LVS_RPT_DIR)
	sleep 4
.PHONY: lvs

drc-minimum: ## Minimum pre-check DRC of the chip with logo and fillers (usage: make drc-minimum)
	mkdir -p $(DRC_RPT_DIR)
	python3 $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/drc/run_drc.py \
		--path=$(GDS_DIR)/${TOP}_logo_fill.gds.gz \
		--topcell=${TOP} \
		--run_dir=$(DRC_RPT_DIR) \
		--precheck_drc \
		--mp=32 \
		--no_offgrid \
		--density_thr=32 \
		--no_angle \
		--disable_extra_rules \
		--no_recommended
	sleep 4
.PHONY: drc-minimum

drc-regular: ## Regular DRC of the chip with logo and fillers (usage: make drc-regular)
	mkdir -p $(DRC_RPT_DIR)
	python3 $(PDK_ROOT)/$(PDK)/libs.tech/klayout/tech/drc/run_drc.py \
		--path=$(GDS_DIR)/${TOP}_logo_fill.gds.gz \
		--topcell=${TOP} \
		--run_dir=$(DRC_RPT_DIR) \
		--mp=32 \
		--density_thr=32
	sleep 4
.PHONY: drc-regular

pex: ## PEX of the chip without logo and fillers (usage: make pex [PEX_MODE=<1|2|3>])
	mkdir -p $(PEX_DIR)
	PDK_ROOT=$(PDK_ROOT) PDK=$(PDK) sak-pex.sh -d -m $(PEX_MODE) -w $(PEX_DIR) $(GDS_DIR)/${TOP}.gds
	mv $(PEX_DIR)/$(TOP).pex.spice $(PEX_DIR)/$(TOP)_pex.spice
	sed -i 's/$(TOP)/$(TOP)_pex/g' $(PEX_DIR)/$(TOP)_pex.spice
	rm -f $(PEX_DIR)/pex_$(TOP).tcl $(PEX_DIR)/$(TOP).ext
	@if [ -f $(XSCHEM_DIR)/$(TOP)_pex.sym ]; then \
		echo "Reordering pins in $(TOP)_pex.spice to match $(TOP)_pex.sym..."; \
		python3 $(PEX_DIR)/reorder_spice_pins.py $(XSCHEM_DIR)/$(TOP)_pex.sym $(PEX_DIR)/$(TOP)_pex.spice; \
	else \
		echo "No symbol $(XSCHEM_DIR)/$(TOP)_pex.sym found, skipping pin reorder."; \
	fi
	sleep 4
.PHONY: pex

verify-top: ## Verify chip (usage: make verify-top)
	$(MAKE) lvs drc-regular pex
.PHONY: verify-top

all: build-all verify-top ## Build and verify the whole chip
.PHONY: all 
