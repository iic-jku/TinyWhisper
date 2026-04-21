/*
* SPDX-FileCopyrightText: 2022-2025 Harald Pretl
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
* Delta-sigma modulator with differential single-bit output.
* Coded after example from:
* https://github.com/hamsternz/second_order_sigma_delta_DAC
*
* TODO: add dithering
*/

`default_nettype none
`ifndef __DSMOD__
`define __DSMOD__

module dsmod #(
	parameter	NBIT=30
) (
	input					i_rst_n,		// async. reset
	input					i_clk,
	input					i_ena_mod,		// i_ena_mod=1 activates the ds-mod
	input signed [NBIT-1:0]	i_data,
	output wire				o_data_rd, 		// indicates a read for next sample
	
	input					i_mode,			// 0=1st order, 1=2nd order
	input		[1:0]		i_osr, 			// 0=32; 1=64, 2=128, 3=256
	input					i_out_invert,	// invert output signals
	output wire				o_ds,			// single-bit SD-modulator output
	output wire				o_ds_n			// plus the complementary output
);

	localparam	[7:0]		CTR_OSR32  	=  8'd31;
	localparam	[7:0]		CTR_OSR64  	=  8'd63;
	localparam	[7:0]		CTR_OSR128 	=  8'd127;
	localparam	[7:0]		CTR_OSR256 	=  8'd255;
	localparam	[1:0]		OSR32  		= 2'd0;
	localparam	[1:0]		OSR64  		= 2'd1;
	localparam	[1:0]		OSR128 		= 2'd2;
	localparam	[1:0]		OSR256 		= 2'd3;
	localparam				ORD1 		= 1'd0;
	localparam				ORD2 		= 1'd1;

	// store last input sample for interpolation
	reg signed	[NBIT-1+8:0]	data_pre_r;

	// input data extended with 8 bits for interpolation
	wire signed [NBIT-1+8:0]	data_ext_w;
	assign data_ext_w = {i_data, 8'b0};

	// interpolated input data
	reg signed [NBIT-1+8:0]		data_interp_r;
	reg signed [NBIT-1+8:0]		data_step_w;

	// sign-extend input data
	wire signed	[NBIT+1+8:0]	input_ext1_w;
	wire signed	[NBIT+3+8:0]	input_ext2_w;

	// accu for 1st order
	reg signed	[NBIT+1+8:0]	accu1_r;
	wire signed	[NBIT+1+8:0]	accu1_nxt_w;

	// feedback signal for 1st order
	wire signed	[NBIT+1+8:0]	feedback1_w;

	// accus for 2nd order
	reg signed	[NBIT+3+8:0]	accu2_r;
	wire signed	[NBIT+3+8:0]	accu2_nxt_w;
	reg signed	[NBIT+3+8:0]	accu3_r;
	wire signed	[NBIT+3+8:0]	accu3_nxt_w;

	// feedback signal for 2nd order
	wire signed	[NBIT+3+8:0]	feedback2_w;

	// sample fetch counter, i_clk divided by OSR
	reg			[7:0]		fetch_ctr_r;
	reg			[7:0]		fetch_ctr_nxt_w;

	// provide out and out_n (for differential output)
	assign o_ds   =	i_out_invert ^ (i_mode === ORD1) ? ~accu1_r[NBIT+1+8] :
					(i_mode === ORD2) ? ~accu3_r[NBIT+3+8] :
					1'b0; // undefined, should not happen
  	assign o_ds_n = i_out_invert ^ ~o_ds;

	// the fetch counter controls the read of the next sample from the FIFO
	// counter runs down so decoding is easier for different counter
	// cycles
	assign o_data_rd = (fetch_ctr_r === 8'd0);

	// create feedback signals
	assign feedback1_w = 1'b1 << (NBIT-1+8);
	assign feedback2_w = 1'b1 << (NBIT-1+8);

	// sign-extend input data
	assign input_ext1_w = {{2{data_interp_r[NBIT-1+8]}}, data_interp_r};
	assign input_ext2_w = {{4{data_interp_r[NBIT-1+8]}}, data_interp_r};

	// calculate next values for dsmod order 1
	assign accu1_nxt_w = o_ds ? accu1_r + input_ext1_w - feedback1_w
	                          : accu1_r + input_ext1_w + feedback1_w;

	// calculate next values for dsmod order 2
	assign accu2_nxt_w = o_ds ? accu2_r + input_ext2_w - feedback2_w
	                          : accu2_r + input_ext2_w + feedback2_w;
	assign accu3_nxt_w = o_ds ? accu3_r + accu2_nxt_w  - feedback2_w
	                          : accu3_r + accu2_nxt_w  + feedback2_w;

	// calculate next value for fetch_ctr
	always @(*) begin
		if (fetch_ctr_r === 8'd0) begin
			// fetch_ctr finished, restart with proper cycle count
			// depending on osr
			case (i_osr)
				OSR32:	fetch_ctr_nxt_w = CTR_OSR32;
				OSR64:	fetch_ctr_nxt_w = CTR_OSR64;
				OSR128:	fetch_ctr_nxt_w = CTR_OSR128;
				OSR256:	fetch_ctr_nxt_w = CTR_OSR256;
				default: fetch_ctr_nxt_w = 8'bx; // undefined
			endcase
		end else begin
			//just keep counting down
			fetch_ctr_nxt_w = fetch_ctr_r - 1'b1;
		end
	end

	// interpolar input data (linear ramp)
	always @(*) begin
		case (i_osr)
			OSR32:	data_step_w = (data_ext_w - data_pre_r) >>> $clog2(32);
			OSR64:	data_step_w = (data_ext_w - data_pre_r) >>> $clog2(64);	
			OSR128:	data_step_w = (data_ext_w - data_pre_r) >>> $clog2(128);
			OSR256:	data_step_w = (data_ext_w - data_pre_r) >>> $clog2(256);
			default: data_step_w = {(NBIT+8){1'bx}}; // undefined
		endcase
	end

  	always @(posedge i_clk or negedge i_rst_n) begin
		if (!i_rst_n) begin
			// reset all registers
			accu1_r <= {(NBIT+2+8){1'b0}};
			accu2_r <= {(NBIT+4+8){1'b0}};
			accu3_r <= {(NBIT+4+8){1'b0}};
			fetch_ctr_r <= 8'b0;
			data_pre_r <= {(NBIT+8){1'b0}};
			data_interp_r <= {(NBIT+8){1'b0}};
		end else begin
			if (i_ena_mod) begin
				// sd-modulator is running
				fetch_ctr_r <= fetch_ctr_nxt_w;
				accu1_r <= accu1_nxt_w;
				accu2_r <= accu2_nxt_w;
				accu3_r <= accu3_nxt_w;
			
				if (fetch_ctr_nxt_w === 8'd0) begin
					// store last input sample for interpolation
					data_pre_r <= data_ext_w;
				end
			
				// interpolate input data
				data_interp_r <= data_interp_r + data_step_w;
			end
		end
	end
endmodule // dsmod

`endif
`default_nettype wire
