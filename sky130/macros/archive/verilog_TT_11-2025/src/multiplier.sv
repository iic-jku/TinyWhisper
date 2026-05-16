// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
module multiplier #(
    WIDTH = 32
) (
    input  logic               clk,
    input  logic               reset_n,
    input  logic [  WIDTH-1:0] a,
    input  logic [  WIDTH-1:0] b,
    output logic [2*WIDTH-1:0] result,
    output logic               valid
);

  logic [  WIDTH-1:0] counter;
  logic [2*WIDTH-1:0] accumulator;

  always_ff @(posedge clk) begin
    if (counter < b) begin
      accumulator <= accumulator + {28'd0, a};
      counter <= counter + 1;
    end

    if (reset_n == 0) begin
      counter <= 0;
      accumulator <= 0;
    end
  end

  assign result = accumulator;
  assign valid  = (reset_n == 1 && counter >= b) ? 1 : 0;

endmodule
