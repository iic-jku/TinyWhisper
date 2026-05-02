/*
* SPDX-FileCopyrightText: 2025 Harald Pretl
* Johannes Kepler University, Department for Integrated Circuits
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
* LO generation for TinyWhisper radio. The clk frequency is divided and
* a 25% 4-phase LO signal is created.
*/

`default_nettype none
`ifndef __LO_GEN__
`define __LO_GEN__

module lo_gen (
	input				i_rst_n,		// async. reset
	input				i_clk,
	input				i_enable,		// i_enable=1 activates the lo-gen
	input 		[2:0]	i_div_sel,		// select LO pre-divider
	output reg			o_lo_i,
	output reg			o_lo_q,
	output reg			o_lo_ix,
	output reg			o_lo_qx
);

	reg					lo_i_r, lo_q_r;
	reg			[3:0]	lo_ctr_r;
	wire				lo1_i_w, lo1_q_w, lo1_ix_w, lo1_qx_w;	

	localparam	[2:0]	DIV1  = 3'b000; // divide by 1
	localparam	[2:0]	DIV2  = 3'b001; // divide by 2
	localparam	[2:0]	DIV4  = 3'b010; // divide by 4
	localparam	[2:0]	DIV8  = 3'b011; // divide by 8
	localparam	[2:0]	DBG1  = 3'b100; // set static I
	localparam	[2:0]	DBG2  = 3'b101; // set static Q
	localparam	[2:0]	DBG3  = 3'b110; // set static IX
	localparam	[2:0]	DBG4  = 3'b111; // set static QX

	// logic for LO division and IQ generation
	always @(*) begin
		case (i_div_sel)
			DIV1: begin
				o_lo_i  = lo1_i_w;
				o_lo_q  = lo1_q_w;
				o_lo_ix = lo1_ix_w;
				o_lo_qx = lo1_qx_w;
			end
			DIV2: begin
				o_lo_i  = lo_ctr_r[1:0] == 2'b00;
				o_lo_q  = lo_ctr_r[1:0] == 2'b01; 
				o_lo_ix = lo_ctr_r[1:0] == 2'b10;
				o_lo_qx = lo_ctr_r[1:0] == 2'b11; 
			end
			DIV4: begin
				o_lo_i  = lo_ctr_r[2:1] == 2'b00;
				o_lo_q  = lo_ctr_r[2:1] == 2'b01; 
				o_lo_ix = lo_ctr_r[2:1] == 2'b10;
				o_lo_qx = lo_ctr_r[2:1] == 2'b11; 
			end
			DIV8: begin
				o_lo_i  = lo_ctr_r[3:2] == 2'b00;
				o_lo_q  = lo_ctr_r[3:2] == 2'b01; 
				o_lo_ix = lo_ctr_r[3:2] == 2'b10;
				o_lo_qx = lo_ctr_r[3:2] == 2'b11; 
			end
			DBG1: begin
				o_lo_i  = 1'b1;
				o_lo_q  = 1'b0;
				o_lo_ix = 1'b0;
				o_lo_qx = 1'b0;
			end	
			DBG2: begin
				o_lo_i  = 1'b0;
				o_lo_q  = 1'b1;
				o_lo_ix = 1'b0;
				o_lo_qx = 1'b0;
			end	
			DBG3: begin
				o_lo_i  = 1'b0;
				o_lo_q  = 1'b0;
				o_lo_ix = 1'b1;
				o_lo_qx = 1'b0;
			end	
			DBG4: begin
				o_lo_i  = 1'b0;
				o_lo_q  = 1'b0;
				o_lo_ix = 1'b0;
				o_lo_qx = 1'b1;
			end	
			default: begin
				o_lo_i  = 1'b0;
				o_lo_q  = 1'b0;
				o_lo_ix = 1'b0; 
				o_lo_qx = 1'b0;
			end
		endcase
	end

	// DIV=1: LO I phase acts on rising edge
  	always @(posedge i_clk) begin
		if (!i_rst_n) begin
			lo_i_r <= 1'b0;
			lo_ctr_r <= 4'b0;
		end else begin
			if (i_enable) begin
				lo_i_r <= ~lo_i_r;
				lo_ctr_r <= lo_ctr_r + 1'b1;
			end
		end	
	end

	// DIV=1: LO Q phase acts on falling edge, but always follows I
	always @(negedge i_clk) begin
		if (!i_rst_n) begin
			lo_q_r <= 1'b0;
		end else begin
			if (i_enable) begin
				lo_q_r <= lo_i_r;
			end
		end	
	end	

	// DIV=1: create 25% LO with 4 phases
  	assign lo1_i_w  =  lo_i_r & ~lo_q_r;
	assign lo1_q_w  =  lo_i_r &  lo_q_r;
	assign lo1_ix_w = ~lo_i_r &  lo_q_r;
	assign lo1_qx_w = ~lo_i_r & ~lo_q_r;

endmodule // lo_gen

`endif
`default_nettype wire
