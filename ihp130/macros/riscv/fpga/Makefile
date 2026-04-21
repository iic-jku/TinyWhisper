.DEFAULT_GOAL := all
TARGET ?= synth_ice40

FILE = riscv_top
MODULES_SYNTH = ../verilog/src/uart_tx.v ../verilog/src/uart_rx.v ../verilog/src/i2c_master.sv ../verilog/src/i2c_master_mc.sv ../verilog/src/spi_master.sv ../verilog/src/dsmod.v ../verilog/src/cordic_slice.v ../verilog/src/cordic_iterative.v ../verilog/src/lo_gen.v ../verilog/src/freq_generator.sv ../verilog/src/memory.sv ../verilog/src/regs.sv ../verilog/src/alu.sv ../verilog/src/control.sv ../verilog/src/instructioncounter.sv ../verilog/src/csr.sv ../verilog/src/imm_gen.sv
MODULES_SIM = ../verilog/constants.sv $(MODULES_SYNTH) ../verilog/src/sram_sim.sv

.PHONY: simulation lint synthesis synthesis_generic visualize visualize_generic pr pr-gui formal gen_bitstream flash_bitstream all clean

simulation: test_pre
	vvp test_pre

test_pre: ../verilog/src/$(FILE).sv ../verilog/tb/$(FILE)_tb.sv $(MODULES_SIM)
	iverilog -g2012 -DSIM -o test_pre $(MODULES_SIM) ../verilog/src/$(FILE).sv ../verilog/tb/$(FILE)_tb.sv

lint:
	verilator --lint-only -Wall -I../verilog/src ../verilog/src/$(FILE).sv

synthesis: $(FILE).json
$(FILE).json: ../verilog/src/$(FILE).sv $(MODULES_SYNTH)
	yosys -DFPGA -p '$(TARGET) -dsp -spram -top $(FILE); write_json $(FILE).json;' ../verilog/src/$(FILE).sv $(MODULES_SYNTH)

synthesis_generic: $(FILE)_generic.json
$(FILE)_generic.json: ../verilog/src/$(FILE).sv $(MODULES_SYNTH)
	yosys -p 'hierarchy -top $(FILE); proc; write_json $(FILE)_generic.json; show -format svg -prefix $(FILE)_generic_yosys $(FILE);' ../verilog/src/$(FILE).sv $(MODULES_SYNTH)

visualize_ice40: $(FILE).pdf
$(FILE).pdf: $(FILE).json
	sed -i -e 's/inout/output/g' $(FILE).json
	netlistsvg $(FILE).json -o $(FILE).svg
	svgo $(FILE).svg
	rsvg-convert -f pdf -o $(FILE).pdf $(FILE).svg

visualize_generic: $(FILE)_generic.pdf
$(FILE)_generic.pdf: $(FILE)_generic.json
	sed -i -e 's/inout/output/g' $(FILE)_generic.json
	netlistsvg $(FILE)_generic.json -o $(FILE)_generic.svg
	svgo $(FILE)_generic.svg
	rsvg-convert -f pdf -o $(FILE)_generic.pdf $(FILE)_generic.svg

pr: $(FILE).asc
$(FILE).asc: $(FILE).json pico-ice.pcf
	nextpnr-ice40 --up5k --package sg48 --pcf-allow-unconstrained --asc $(FILE).asc --pcf pico-ice.pcf --json $(FILE).json

pr-gui: $(FILE).json
	nextpnr-ice40 --up5k --package sg48 --asc $(FILE).asc --json $(FILE).json --gui

gen_bitstream: $(FILE).bin
$(FILE).bin: $(FILE).asc
	icepack $(FILE).asc $(FILE).bin

flash_bitstream: $(FILE).bin
	dfu-util --alt 0 --download $(FILE).bin

convert: riscv_top.v
riscv_top.v: ../verilog/src/riscv_top.sv $(MODULES_SYNTH)
	yosys -DFPGA -p 'hierarchy -top riscv_top; proc; write_verilog riscv_top.v;' ../verilog/src/riscv_top.sv $(MODULES_SYNTH)

all: simulation synthesis pr gen_bitstream flash_bitstream

clean:
	rm -f test_pre *.vcd $(FILE).json* $(FILE).asc $(FILE).bin $(FILE).pdf $(FILE).svg
	rm -f $(FILE)_generic.json* $(FILE).asc $(FILE).bin $(FILE)_generic.pdf $(FILE)_generic.svg
	rm -f $(FILE)_yosys.svg $(FILE)_yosys.dot $(FILE)_generic_yosys.svg $(FILE)_generic_yosys.dot
	rm -rf $(FILE) $(FILE)_basic $(FILE)_cover
