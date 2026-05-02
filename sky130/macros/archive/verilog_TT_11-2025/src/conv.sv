// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0
module conv (
    input logic clk,
    input logic reset_n,

    input [80:0] data,

    output logic [161:0] encoded_data,
    output logic valid
);

  logic      [31:0] reg0;
  localparam logic [31:0] reg0_and = 32'hF2D05351;

  localparam logic [31:0] reg1_and = 32'hE4613C47;

  logic       [ 6:0] counter;
  logic              current_bit;
  assign current_bit = data[counter];

  logic [  1:0] state;
  logic [161:0] output_buffer;

  always_ff @(posedge clk) begin
    case (state)
      0: begin
        reg0  <= {reg0[30:0], current_bit};
        state <= 1;
      end

      1: begin
        output_buffer <= {output_buffer[159:0], ^(reg0 & reg0_and), ^(reg0 & reg1_and)};
        if (counter > 0) begin
          counter <= counter - 1;
          state   <= 0;
        end else state <= 2;
      end

      default: state <= state;
    endcase

    if (reset_n == 0) begin
      state <= 0;
      counter <= 80;

      reg0 <= 0;
      output_buffer <= 0;
    end
  end

  assign encoded_data = output_buffer;
  assign valid = (state == 2) ? 1 : 0;

endmodule
