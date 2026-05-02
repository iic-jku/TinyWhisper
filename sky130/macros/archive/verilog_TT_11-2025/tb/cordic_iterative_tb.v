/*
* SPDX-FileCopyrightText: 2025 Simon Dorrer
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
* Simple TB for the CORDIC.
*/

`timescale 10ns / 1ns // `timescale <time_unit> / <time_precision>

// `include "../src/cordic_iterative.v"

module cordic_iterative_tb;
	
	// Parameters
	parameter CORDIC_BW = 10;
	
	// CORDIC IOs
    reg CLK;
    reg RESET_N;
	wire STRB_DATA_VALID_i;
	reg [CORDIC_BW-1:0] X_i;
	reg [CORDIC_BW-1:0] Y_i;
	wire [CORDIC_BW-1:0] X_o;
	wire [CORDIC_BW-1:0] Y_o;
	wire [CORDIC_BW-1:0] Z_o;
	wire STRB_DATA_VALID_o;
	
	// Sine Generation Signals
	reg [CORDIC_BW-1:0] theta;
	reg [CORDIC_BW-1:0] f_c;
	
	reg STRB_DATA_VALID_dummy;
	reg [CORDIC_BW-1:0] cosine;
	reg [CORDIC_BW-1:0] sine;

    // instantiate DUT module
	cordic_iterative dut (
		.clk_i (CLK),
		.rstn_i (RESET_N),             
		.strb_data_valid_i(STRB_DATA_VALID_i),
		.X_i (X_i),
		.Y_i (Y_i),
		.Z_i (theta),
		.X_o (X_o),
		.Y_o (Y_o),
		.Z_o (Z_o),
		.strb_data_valid_o(STRB_DATA_VALID_o)
	);

    always #1 CLK = ~CLK; // toggle clock (50MHz)
	
	// Register for theta
	always @(posedge CLK) begin
        if (!RESET_N) begin
			X_i <= 10'b0100110101; // I = 1/K = 0.603516 (for full-scale)
			Y_i <= {CORDIC_BW{1'b0}};
            theta <= {CORDIC_BW{1'b0}}; // Z_i = {CORDIC_BW{1'b0}};
        end else if (STRB_DATA_VALID_i) begin
			theta <= theta + f_c;
		end
    end
	
	// Register for theta
	always @(posedge CLK) begin
        if (STRB_DATA_VALID_o) begin
			cosine <= X_o;
			sine <= Y_o;
		end
    end
	
	// Connect STRB_DATA_VALID_i with STRB_DATA_VALID_o.
	// New value is loaded immediately after one CORDIC value is finished.
	assign STRB_DATA_VALID_i = STRB_DATA_VALID_dummy || STRB_DATA_VALID_o;
	
    initial begin
        // dump signals into VCD for debug
		$dumpfile("cordic_iterative_tb.vcd");
		$dumpvars(0, cordic_iterative_tb);
        $display("Start testbench for CORDIC");
		
		// Generated with TinyWhisper/verilog/tb/matlab/write_std_definitions.m
		f_c = 10'b0000011100; // 0.054688 (quant.), 0.055000 (exact)
        
		// SIGNALS
		CLK     = 1'b0;
        RESET_N = 1'b0;
		
        #5 RESET_N = 1'b1; // release reset
		
		// First Valid Strobe
		#4 STRB_DATA_VALID_dummy = 1'b1; // Strobe HIGH
		#2 STRB_DATA_VALID_dummy = 1'b0; // Strobe LOW after on clock cycle

        #2000 $display("Test finished.");
        $finish;
    end

endmodule // cordic_iterative_tb
