// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
module interleaver (
    input logic clk,
    input logic reset_n,

    input logic [161:0] data_in,
    output logic [161:0] data_out,
    output logic valid
);

  logic [7:0] P = 0;
  logic [7:0] I = 0;
  logic [7:0] J;
  initial data_out <= 0;

  always_ff @(posedge clk) begin
    if (J < 162) begin
      // Python arrays are indexed inversely
      data_out[161-J] <= data_in[161-P];
      P <= P + 1;
       // if (reset_n == 1)
       //   $display("assign interleave_out[%0d] = fec_out[%0d];", 161-J, 161-P);
    end

    if (I < 255) I <= I + 1;

    if (reset_n == 0) begin
      P <= 0;
      I <= 0;
      data_out <= 0;
    end
  end

  genvar i;
  generate
    for (i = 0; i <= 7; i++) begin : g_reverse_bits
      assign J[i] = I[7-i];
    end
  endgenerate

  assign valid = (I == 255) ? 1 : 0;

endmodule
