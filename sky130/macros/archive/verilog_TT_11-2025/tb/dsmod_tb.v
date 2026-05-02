/*
* SPDX-FileCopyrightText: 2025 Harald Pretl
* Johannes Kepler University, Institute for Integrated Circuits
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
* SPDX-License-Identifier: Apache-2.0
*
* Simple TB for delta-sigma modulator.
*/

`timescale 10ns / 1ns // `timescale <time_unit> / <time_precision>

`include "../src/dsmod.v"

module dsmod_tb;

    reg CLK;
    reg RESET_N;
    reg ENABLE;
    reg signed [9:0] DATA;
    reg MODE;
    reg [1:0] OSR;
    wire OUTP, OUTN;
    wire READ_STRB;
    integer CTR_CLK;
    reg signed [9:0] STEP;
	
	// 10-bit sine wave, 4 periods, 256 samples per period, f = 125kHz, fs = 50MHz
	parameter SAMPLE_COUNT = 1024;
	
	// SystemVerilog
	// reg [9:0] sine_wave [0:127] = '{
	// 512, 562, 611, 659, 706, 751, 793, 833,
	// 869, 902, 931, 955, 975, 990, 1001, 1007,
	// 1009, 1007, 1001, 990, 975, 955, 931, 902,
	// 869, 833, 793, 751, 706, 659, 611, 562,
	// 512, 462, 413, 365, 318, 273, 231, 191,
	// 155, 122, 93, 69, 49, 34, 23, 17,
	// 15, 17, 23, 34, 49, 69, 93, 122,
	// 155, 191, 231, 273, 318, 365, 413, 462,
	// 512, 562, 611, 659, 706, 751, 793, 833,
	// 869, 902, 931, 955, 975, 990, 1001, 1007,
	// 1009, 1007, 1001, 990, 975, 955, 931, 902,
	// 869, 833, 793, 751, 706, 659, 611, 562,
	// 512, 462, 413, 365, 318, 273, 231, 191,
	// 155, 122, 93, 69, 49, 34, 23, 17,
	// 15, 17, 23, 34, 49, 69, 93, 122,
	// 155, 191, 231, 273, 318, 365, 413, 462
	// };
	
	// Verilog (with $readmemh)
	reg [9:0] sine_wave [0:SAMPLE_COUNT-1];
	integer i = 0;
	integer test = 0; // 0... sine wave, 1... linear sweep
	
    // instantiate DUT module
    dsmod dut (
        .i_clk(CLK),
        .i_rst_n(RESET_N),
        .i_ena_mod(ENABLE),
        .i_data(DATA),
        .i_mode(MODE),
        .i_osr(OSR),
        .o_data_rd(READ_STRB),
        .o_ds(OUTP),
        .o_ds_n(OUTN)
    );

    always #1 CLK = ~CLK; // toggle clock (50MHz)

    always @(negedge CLK) begin
        if (!RESET_N) begin
            CTR_CLK <= 0;
            STEP <= +1;
        end else begin
            CTR_CLK <= CTR_CLK + 1;
			
			if (test) begin
				if (READ_STRB) begin
					DATA <= DATA + STEP; // linear sweep
				end
				if (CTR_CLK == 400*64) begin
					STEP <= -1;
				end
				if (CTR_CLK == 400*64*3) begin
					$finish;
				end
			end else begin
				if (READ_STRB) begin
					// Sine Wave
					i = i + 1;
					DATA <= sine_wave[i]; // sine wave
					if (i == SAMPLE_COUNT) begin
						// i = 0;  // Loop back after reaching the end
						$finish;
					end
				end
			end
        end 
    end

    initial begin
        // dump signals into VCD for debug
		$dumpfile("dsmod_tb.vcd");
		$dumpvars(0, dsmod_tb);
        $display("Start testbench for dsmod");
		$readmemh("data/sine_wave_100%_10bit_256s_125kHz_4periods.mem", sine_wave); // 100% full-scale
		// $readmemh("sine_wave_75%_10bit_256s_125kHz_4periods.mem", sine_wave); // 75% full-scale
		// $readmemh("sine_wave_50%_10bit_256s_125kHz_4periods.mem", sine_wave); // 50% full-scale
		// $readmemh("sine_wave_25%_10bit_256s_125kHz_4periods.mem", sine_wave); // 25% full-scale
		
        CLK     = 1'b0;
        RESET_N = 1'b0;
        ENABLE  = 1'b1;
        OSR     = 2'd1; // OSR=64
        MODE    = 1'b1;

        DATA    = 10'd0;

        #1 RESET_N = 1'b1; // release reset
        // #10 ENABLE = 1'b1; // enable LO generation
        // #500 DATA = 10'd150;
        // #500 DATA = 10'd950;
        // #500 DATA = 10'd512;
        // #500 $display("Test finished.");
        // #2000 $finish;
    end

endmodule // dsmod_tb
