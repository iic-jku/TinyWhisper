# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0

# FILE = toplevel_uart

MODULES_SLIM = src/uart.v src/uart_wrapper.sv src/cordic_slice.v src/dsmod.v src/lo_gen.v src/cordic_iterative.v
MODULES_FULL = $(MODULES_SLIM) src/multiplier.sv src/callsign.sv src/loc_pwr.sv src/conv.sv src/interleaver.sv src/sync.sv src/wspr_encoder.sv

simulation: sim_callsign sim_locator sim_fec sim_interleave sim_sync sim_wspr_encoding

# sim_multiplier:
# 	iverilog -g2012 -o test_pre src/multiplier.sv tb/multiplier_tb.sv
# 	vvp test_pre

sim_callsign:
	iverilog -g2012 -o test_pre src/callsign.sv tb/callsign_tb.sv
	vvp test_pre

sim_locator:
	iverilog -g2012 -o test_pre src/loc_pwr.sv tb/loc_pwr_tb.sv
	vvp test_pre

sim_fec:
	iverilog -g2012 -o test_pre src/conv.sv tb/conv_tb.sv
	vvp test_pre

sim_interleave:
	iverilog -g2012 -o test_pre src/interleaver.sv tb/interleaver_tb.sv
	vvp test_pre

sim_sync:
	iverilog -g2012 -o test_pre src/sync.sv tb/sync_tb.sv
	vvp test_pre

sim_wspr_encoding:
	iverilog -g2012 -o test_pre src/multiplier.sv src/callsign.sv src/loc_pwr.sv src/conv.sv src/interleaver.sv src/sync.sv src/wspr_encoder.sv tb/wspr_encoder_tb.sv
	vvp test_pre

sim_spi:
	iverilog -g2012 -o test_pre src/spi_slave.sv src/spi_master.sv tb/spi_tb.sv
	vvp test_pre

sim_toplevel:
	iverilog -g2012 -o test_pre src/cordic_slice.v src/dsmod.v src/lo_gen.v src/cordic_iterative.v src/spi_slave.sv src/multiplier.sv src/callsign.sv src/loc_pwr.sv src/conv.sv src/interleaver.sv src/sync.sv src/wspr_encoder.sv src/toplevel.sv src/spi_master.sv tb/toplevel_tb.sv
	vvp test_pre


# Trimmed down version for submission of digital + analog
sim_toplevel_slim:
	iverilog -g2012 -DSIMULATION -o test_pre $(MODULES_FULL) src/uart_tx.v src/toplevel_uart.sv tb/toplevel_uart_tb.sv
	vvp test_pre
synthesis_slim: toplevel_slim.json
toplevel_slim.json: src/toplevel_uart.sv $(MODULES_SLIM)
	yosys -p 'synth_ice40 -top toplevel_uart; write_json toplevel_slim.json;' src/toplevel_uart.sv $(MODULES_SLIM)

pr_slim: toplevel_slim.asc
gen_bitstream_slim: toplevel_slim.bin
flash_slim: toplevel_slim.bin
	dfu-util --alt 0 --download toplevel_slim.bin

# Full version for submission of the entire digital core
sim_toplevel_full:
	iverilog -g2012 -DSIMULATION -DFULL -o test_pre $(MODULES_FULL) src/uart_tx.v src/toplevel_uart.sv tb/toplevel_uart_tb.sv
	vvp test_pre
synthesis_full: toplevel_full.json
toplevel_full.json: src/toplevel_uart.sv $(MODULES_SLIM)
	yosys -DFULL -p 'synth_ice40 -top toplevel_uart; write_json toplevel_full.json;' src/toplevel_uart.sv $(MODULES_FULL)
pr_slim: toplevel_full.asc
gen_bitstream_full: toplevel_full.bin
flash_full: toplevel_full.bin
	dfu-util --alt 0 --download toplevel_full.bin


convert_slim: toplevel_uart_slim.v
toplevel_uart_slim.v: src/toplevel_uart.sv $(MODULES_SLIM)
	yosys -p 'hierarchy -top toplevel_uart; proc; write_verilog toplevel_uart_slim.v;' src/toplevel_uart.sv $(MODULES_SLIM)

convert_full: toplevel_uart_full.v
toplevel_uart_full.v: src/toplevel_uart.sv $(MODULES_FULL)
	yosys -DFULL -p 'hierarchy -top toplevel_uart; proc; write_verilog toplevel_uart_full.v;' src/toplevel_uart.sv $(MODULES_FULL)

# Targets for place&route and generating the bitstream
%.asc: %.json pico-ice.pcf
	nextpnr-ice40 --up5k --package sg48 --pcf pico-ice.pcf --asc $@ --json $<

%.bin: %.asc
	icepack $< $@

