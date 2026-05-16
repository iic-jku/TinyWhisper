/*
* SPDX-FileCopyrightText: 2025 Harald Pretl
* Johannes Kepler University, Department for Integrated Circuits
* SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
*
* LO generation for TinyWhisper radio. The clk frequency is divided and
* a 25% 4-phase LO signal is created.
*/

`default_nettype none
`ifndef __LO_GEN__
`define __LO_GEN__

module lo_gen #(parameter DEFAULT=0) (
	input				i_rst_n,		// async. reset
	input				i_clk,
	input				i_enable,		// i_enable=1 activates the lo-gen
	input 		[4:0]	i_div_sel,		// select LO pre-divider
	output reg			o_lo_i,
	output reg			o_lo_q,
	output reg			o_lo_ix,
	output reg			o_lo_qx
);

	reg					lo_i_r, lo_q_r;
	reg			[3:0]	lo_ctr_r;
	wire				lo1_i_w, lo1_q_w, lo1_ix_w, lo1_qx_w;	

	localparam	[1:0]	DIV1  = 2'b00; // divide by 1
	localparam	[1:0]	DIV2  = 2'b01; // divide by 2
	localparam	[1:0]	DIV4  = 2'b10; // divide by 4
	localparam	[1:0]	DIV8  = 2'b11; // divide by 8

	// logic for LO division and IQ generation
	always @(*) begin
       // Debug mode
        if (i_div_sel[4]) begin
            o_lo_i  = i_div_sel[3];
            o_lo_q  = i_div_sel[2];
            o_lo_ix = i_div_sel[1];
            o_lo_qx = i_div_sel[0];
        end
        else begin
            case (i_div_sel[1:0])
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
                default: begin
                    o_lo_i  = DEFAULT;
                    o_lo_q  = DEFAULT;
                    o_lo_ix = DEFAULT;
                    o_lo_qx = DEFAULT;
                end
            endcase
        end

       if (!i_rst_n) begin
          o_lo_i  = DEFAULT;
          o_lo_q  = DEFAULT;
          o_lo_ix = DEFAULT;
          o_lo_qx = DEFAULT;
       end
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
