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

module cordic_slice #(
    parameter integer N_INT            	= 0,   // N_INT
    parameter integer N_FRAC           	= -9,  // N_FRACT
    parameter integer CORDIC_MODE      	= 0,   // 0 = ROTATION, 1 = VECTORING
    parameter integer COORDINATE_SYSTEM	= 0,   // 0 = CIRCULAR, 1 = LINEAR, 2 = HYPERBOLIC
    parameter integer SHIFT_BITWIDTH   	= 4
) (
    input  wire                             clk_i,
    input  wire                             rstn_i,
    input  wire signed [N_INT - N_FRAC:0]   current_rotation_angle_i,
    input  wire        [SHIFT_BITWIDTH-1:0] shift_value_i,
    input  wire signed [N_INT - N_FRAC:0]   X_i,
    input  wire signed [N_INT - N_FRAC:0]   Y_i,
    input  wire signed [N_INT - N_FRAC:0]   Z_i,
    output wire signed [N_INT - N_FRAC:0]   X_o,
    output wire signed [N_INT - N_FRAC:0]   Y_o,
    output wire signed [N_INT - N_FRAC:0]   Z_o
);

localparam integer BITWIDTH = N_INT - N_FRAC + 1;

// Direction selection:
// ROTATION : dir_up = (Z_i >= 0)
// VECTORING: dir_up = (Y_i <  0)
wire dir_up;

generate
    if (CORDIC_MODE == 0) begin : gen_rot     // ROTATION
        assign dir_up = (Z_i[BITWIDTH-1] == 1'b0);
    end else begin : gen_vec                  // VECTORING
        assign dir_up = (Y_i[BITWIDTH-1] == 1'b1);
    end
endgenerate

// Registered state
reg signed [BITWIDTH-1:0] X_r, Y_r, Z_r;

// Precompute variable arithmetic shifts once.
wire signed [BITWIDTH-1:0] y_shr = (Y_i >>> shift_value_i);
wire signed [BITWIDTH-1:0] x_shr = (X_i >>> shift_value_i);

// Output mapping
assign X_o = X_r;
assign Y_o = Y_r;
assign Z_o = Z_r;

// ------------------------------------ X ------------------------------------ //
wire signed [BITWIDTH-1:0] dx;

generate
    if (COORDINATE_SYSTEM == 0) begin          : gen_circ // CIRCULAR (m = +1)
        assign dx = sat_add(X_i, (dir_up)? -y_shr :  y_shr);
    end else if (COORDINATE_SYSTEM == 1) begin : gen_lin  // LINEAR (m = 0)
        assign dx = X_i;
    end else if (COORDINATE_SYSTEM == 2) begin : gen_hyp  // HYPERBOLIC (m = -1)           
        assign dx = sat_add(X_i, (dir_up)?  y_shr : -y_shr);
    end
endgenerate

always @ (posedge clk_i) begin
    if (!rstn_i) begin
        X_r <= {BITWIDTH{1'b0}};
    end else begin
        X_r <= dx;
    end
end


// ------------------------------------ Y ------------------------------------ //
wire signed [BITWIDTH-1:0] dy;
assign dy = sat_add(Y_i, (dir_up)?  x_shr : -x_shr);

always @ (posedge clk_i) begin
    if (!rstn_i) begin
        Y_r <= {BITWIDTH{1'b0}};
    end else begin
        Y_r <= dy;
    end
end


// ------------------------------------ Z ------------------------------------ //
wire signed [BITWIDTH-1:0] dz;
assign dz = sat_add(Z_i, (dir_up)? -current_rotation_angle_i : current_rotation_angle_i);

always @ (posedge clk_i) begin
    if (!rstn_i) begin
        Z_r <= {BITWIDTH{1'b0}};
    end else begin
        Z_r <= dz;
    end
end


// ----------------------- SATURATED ADDITION FUNCTION ----------------------- //
function automatic [BITWIDTH-1:0] sat_add;
    input signed [BITWIDTH-1:0] a;
    input signed [BITWIDTH-1:0] b;
    reg   signed [BITWIDTH:0]   sum_ext; 
begin
    // ADD
    sum_ext = {a[BITWIDTH-1], a} + {b[BITWIDTH-1], b};
	
    // Signed overflow if the two top bits differ after extension
    if (sum_ext[BITWIDTH] ^ sum_ext[BITWIDTH-1]) begin
        if (sum_ext[BITWIDTH])
            sat_add = {1'b1, {BITWIDTH-1{1'b0}}}; // 1000...0 (MIN)
        else
            sat_add = {1'b0, {BITWIDTH-1{1'b1}}}; // 0111...1 (MAX)
    end else begin
        sat_add = sum_ext[BITWIDTH-1:0];
    end
end
endfunction

endmodule
