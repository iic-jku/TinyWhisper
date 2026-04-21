MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

RUN_TAG = $(shell ls librelane/runs/ | tail -n 1)
TOP = riscv_top

PDK_ROOT ?= $(MAKEFILE_DIR)/../../IHP-Open-PDK
PDK ?= ihp-sg13g2
include $(MAKEFILE_DIR)/../../pdk_hash.mk

.DEFAULT_GOAL := help

$(PDK_ROOT)/$(PDK):
	ciel enable $(PDK_COMMIT) --pdk-root $(PDK_ROOT) --pdk-family $(PDK)

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help

librelane: $(PDK_ROOT)/$(PDK) ## Run LibreLane
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to final/
.PHONY: librelane

librelane-nodrc: $(PDK_ROOT)/$(PDK) ## Run LibreLane without DRC checks
	librelane librelane/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to final/ --skip KLayout.DRC --skip Magic.DRC
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

copy-reports: ## Copy yosys, antenna violations, hold & setup timing and manufacturability reports
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
	# cp librelane/runs/${RUN_TAG}/*-klayout-antenna/reports/antenna.klayout.json reports/antenna.klayout.json
	cp librelane/runs/${RUN_TAG}/*-magic-drc/reports/drc.magic.rpt reports/drc.magic.rpt
	# cp librelane/runs/${RUN_TAG}/*-klayout-drc/reports/drc.klayout.json reports/drc.klayout.json
	cp librelane/runs/${RUN_TAG}/*-misc-reportmanufacturability/manufacturability.rpt reports/manufacturability.rpt
.PHONY: copy-reports

render-image: ## Render an image from the layout of the macro
	rm -rf img/
	mkdir -p img/
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} python3 $(MAKEFILE_DIR)/../../scripts/lay2img.py final/gds/${TOP}.gds img/${TOP}.png --width 2048 --oversampling 4
.PHONY: render-image

all: librelane copy-reports render-image ## Run the full flow: LibreLane, copy reports, and render final layout image
.PHONY: all

# The following commands are for generating an XSPICE file for mixed-signal simulation in Xschem.
# Note that these commands should not be run in `all`, since this XSPICE file is generated once with specific CPU settings for a more convenient simulation.
# Note that this method does not work with the .nl.v file in the final/ folder. The .nl.v file from the LibreLane step yosys-synthesis has to be used.
# Conversion pipeline: Copy gate-level Verilog (.nl.v) -> Verilog with power pins (.vp) -> SPICE (.spice) -> XSPICE (.xspice) -> Reorder pins in XSPICE file according to the Xschem symbol
generate-xspice: $(PDK_ROOT)/$(PDK) ## Generate XSPICE model from gate-level Verilog netlist
	rm -rf xspice/${TOP}
	mkdir -p xspice/${TOP}
	cp librelane/runs/${RUN_TAG}/*-yosys-synthesis/${TOP}.nl.v xspice/${TOP}/${TOP}_xspice.nl.v
	vlog2Verilog xspice/${TOP}/${TOP}_xspice.nl.v -o xspice/${TOP}/${TOP}.vp -l $(PDK_ROOT)/$(PDK)/libs.ref/sg13g2_stdcell/lef/sg13g2_stdcell.lef -v "VPWR,VPB" -g "VGND,VNB"
	vlog2Spice xspice/${TOP}/${TOP}.vp -l $(PDK_ROOT)/$(PDK)/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice -o xspice/${TOP}/${TOP}.spice
	python3 xspice/spi2xspice.py $(PDK_ROOT)/$(PDK)/libs.ref/sg13g2_stdcell/lib/sg13g2_stdcell_typ_1p50V_25C.lib -io_time=500p -time=50p -idelay=5p -odelay=50p -cload=250f xspice/${TOP}/${TOP}.spice xspice/${TOP}/${TOP}.xspice
	python3 xspice/reorder_xspice_pins.py xschem/${TOP}.sym xspice/${TOP}/${TOP}.xspice
.PHONY: generate-xspice