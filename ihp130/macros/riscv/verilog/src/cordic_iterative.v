// Copyright 2025 Dominik Brandstetter
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE−2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// `include "cordic_slice.v"

module cordic_iterative(
    input  wire              clk_i,
    input  wire              rstn_i,
    input  wire              strb_data_valid_i,
    input  wire signed [29:0] X_i,
    input  wire signed [29:0] Y_i,
    input  wire signed [29:0] Z_i,
    output wire signed [29:0] X_o,
    output wire signed [29:0] Y_o,
    output wire signed [29:0] Z_o,
    output wire              strb_data_valid_o
);

// ------------------------- params -------------------------- //

localparam integer N_INT             = 0;
localparam integer N_FRAC            = -29;
localparam integer BITWIDTH          = N_INT - N_FRAC + 1;

// Additional parameters for CORDIC mode and coordinate system: TODO
localparam integer CORDIC_MODE       = 0;  // 0 = ROTATION, 1 = VECTORING
localparam integer COORDINATE_SYSTEM = 0;  // 0 = CIRCULAR, 1 = LINEAR, 2 = HYPERBOLIC

localparam integer N_CORDIC_ITERATIONS   = BITWIDTH;           
localparam integer SHIFT_VALUE_BITWIDTH  = $clog2(N_CORDIC_ITERATIONS + 1);

/* verilator lint_off WIDTHTRUNC */
// Generate arctan lookup table in Matlab:
// TinyWhisper/verilog/tb/matlab/write_std_definitions.m
localparam signed [BITWIDTH-1:0] PI_HALF = 30'b010000000000000000000000000000;
localparam [N_CORDIC_ITERATIONS*BITWIDTH-1:0] ATAN_TABLE = {
30'b000000000000000000000000000000,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000000000,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000000001,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000000001,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000000011,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000000101,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000001010,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000010100,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000000101001,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000001010001,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000010100011,  // 0.000000 (quant.), 0.000000 (exact) 
30'b000000000000000000000101000110,  // 0.000001 (quant.), 0.000001 (exact) 
30'b000000000000000000001010001100,  // 0.000001 (quant.), 0.000001 (exact) 
30'b000000000000000000010100011000,  // 0.000002 (quant.), 0.000002 (exact) 
30'b000000000000000000101000110000,  // 0.000005 (quant.), 0.000005 (exact) 
30'b000000000000000001010001011111,  // 0.000010 (quant.), 0.000010 (exact) 
30'b000000000000000010100010111110,  // 0.000019 (quant.), 0.000019 (exact) 
30'b000000000000000101000101111101,  // 0.000039 (quant.), 0.000039 (exact) 
30'b000000000000001010001011111010,  // 0.000078 (quant.), 0.000078 (exact) 
30'b000000000000010100010111110011,  // 0.000155 (quant.), 0.000155 (exact) 
30'b000000000000101000101111100110,  // 0.000311 (quant.), 0.000311 (exact) 
30'b000000000001010001011111001100,  // 0.000622 (quant.), 0.000622 (exact) 
30'b000000000010100010111110010101,  // 0.001243 (quant.), 0.001243 (exact) 
30'b000000000101000101111100010101,  // 0.002487 (quant.), 0.002487 (exact) 
30'b000000001010001011110110001000,  // 0.004973 (quant.), 0.004973 (exact) 
30'b000000010100010111010111111000,  // 0.009944 (quant.), 0.009944 (exact) 
30'b000000101000101100001101010001,  // 0.019869 (quant.), 0.019869 (exact) 
30'b000001010001000100010001110101,  // 0.039583 (quant.), 0.039583 (exact) 
30'b000010011111101100111000010111,  // 0.077979 (quant.), 0.077979 (exact) 
30'b000100101110010000000101000111,  // 0.147584 (quant.), 0.147584 (exact) 
30'b001000000000000000000000000000}; // 0.250000 (quant.), 0.250000 (exact) 

/* verilator lint_on WIDTHTRUNC */

function [BITWIDTH-1:0] atan_value;
    input [SHIFT_VALUE_BITWIDTH-1:0] i;
    begin
        atan_value = ATAN_TABLE[i*BITWIDTH +: BITWIDTH];
    end
endfunction

// ------------------------- signals ------------------------- //

// ROC stage
reg  signed [BITWIDTH-1:0] roc_in_X, roc_in_Y, roc_in_Z;
reg  signed [BITWIDTH-1:0] roc_out_X, roc_out_Y, roc_out_Z;

// CORDIC datapath
reg  signed [BITWIDTH-1:0] cordic_in_X,  cordic_in_Y,  cordic_in_Z;
wire signed [BITWIDTH-1:0] cordic_out_X, cordic_out_Y, cordic_out_Z;

reg  [SHIFT_VALUE_BITWIDTH-1:0] shift_value;
wire signed [BITWIDTH-1:0] current_rotation_angle;

// ------------------------- ROC preprocessing ------------------------- //

always @(posedge clk_i) begin
    if (!rstn_i) begin
        roc_in_X <= {BITWIDTH{1'b0}};
        roc_in_Y <= {BITWIDTH{1'b0}};
        roc_in_Z <= {BITWIDTH{1'b0}};
    end else if (strb_data_valid_i) begin
        roc_in_X <= X_i;
        roc_in_Y <= Y_i;
        roc_in_Z <= Z_i;
    end
end

always @(*) begin
    if (roc_in_Z > PI_HALF) begin
        // Rotate (X,Y) by +90° -> subtract PI/2 from Z
        roc_out_X = -roc_in_Y;
        roc_out_Y =  roc_in_X;
        roc_out_Z =  roc_in_Z - PI_HALF;
    end else if (roc_in_Z < -PI_HALF) begin
        // Rotate (X,Y) by -90° -> add PI/2 to Z
        roc_out_X =  roc_in_Y;
        roc_out_Y = -roc_in_X;
        roc_out_Z =  roc_in_Z + PI_HALF;
    end else begin
        // Pass-through
        roc_out_X = roc_in_X;
        roc_out_Y = roc_in_Y;
        roc_out_Z = roc_in_Z;
    end
end

// ------------------------- CORDIC slice ------------------------- //

cordic_slice #(
    .N_INT(N_INT),
    .N_FRAC(N_FRAC),
    .CORDIC_MODE(CORDIC_MODE),
    .COORDINATE_SYSTEM(COORDINATE_SYSTEM),
    .SHIFT_BITWIDTH(SHIFT_VALUE_BITWIDTH)
) slice (
    .clk_i(clk_i),
    .rstn_i(rstn_i),
    .current_rotation_angle_i(current_rotation_angle),
    .shift_value_i(shift_value),
    .X_i(cordic_in_X),
    .Y_i(cordic_in_Y),
    .Z_i(cordic_in_Z),
    .X_o(cordic_out_X),
    .Y_o(cordic_out_Y),
    .Z_o(cordic_out_Z)
);

// ------------------------- control & muxing ------------------------- //

// Datapath mux
always @(*) begin
    if (shift_value == 0) begin
        cordic_in_X = roc_out_X;
        cordic_in_Y = roc_out_Y;
        cordic_in_Z = roc_out_Z;
    end else begin
        cordic_in_X = cordic_out_X;
        cordic_in_Y = cordic_out_Y;
        cordic_in_Z = cordic_out_Z;
    end
end

// Iteration counter (shift_value)
always @(posedge clk_i) begin
    if (!rstn_i || strb_data_valid_i) begin
        shift_value <= {SHIFT_VALUE_BITWIDTH{1'b0}};
    end else if (shift_value != (N_CORDIC_ITERATIONS[SHIFT_VALUE_BITWIDTH-1:0] + 1)) begin
        shift_value <= shift_value + 1'b1;
    end
end

// Current angle
assign current_rotation_angle = (shift_value < N_CORDIC_ITERATIONS[SHIFT_VALUE_BITWIDTH-1:0]) ? atan_value(shift_value[SHIFT_VALUE_BITWIDTH-1:0]) : {BITWIDTH{1'b0}};

// Output strobe after final iteration
assign strb_data_valid_o = (shift_value == N_CORDIC_ITERATIONS[SHIFT_VALUE_BITWIDTH-1:0]);

assign X_o = cordic_out_X;
assign Y_o = cordic_out_Y;
assign Z_o = cordic_out_Z;

endmodule
