// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
module loc_pwr (
    input logic clk,
    input logic reset_n,

    input logic [19:0] locator,
    input logic [ 5:0] power,

    output logic [21:0] M,
    output logic valid,

    // Multiplier interface
    output logic [27:0] a_mul,
    output logic [27:0] b_mul,
    output logic mul_reset_n,
    input logic [55:0] mul_result,
    input logic mul_valid
);

  logic [4:0] loc1, loc2, loc3, loc4;
  assign loc1 = locator[19:15];
  assign loc2 = locator[14:10];
  assign loc3 = locator[9:5];
  assign loc4 = locator[4:0];

  logic [21:0] acc;

  // Locator = (179 - 10 * loc1 - loc3) * 180 + 10 * loc2 + loc4;
  // 0: acc = 10 * loc1
  // 1: acc = 179 - acc
  // 2: acc = acc - loc3
  // 3: acc = acc * 180
  // 4: acc = acc + 10 * loc2
  // 5: acc = acc + loc4
  // 6: power encoding
  // 7: valid
  logic [3:0] state;
  logic pause;

  always_ff @(posedge clk) begin
    pause <= 0;
    mul_reset_n <= 1;

    unique case (state)
      0: begin
        if (mul_valid && !pause) begin
          acc <= mul_result[21:0];
          state <= 1;
          pause <= 1;
          mul_reset_n <= 0;
        end
      end

      1: begin
        acc   <= 179 - acc;
        state <= 2;
      end

      2: begin
        acc <= acc - {17'd0, loc3};
        state <= 3;
        pause <= 1;
        mul_reset_n <= 0;
      end

      3: begin
        if (mul_valid && !pause) begin
          acc <= mul_result[21:0];
          state <= 4;
          pause <= 1;
          mul_reset_n <= 0;
        end
      end

      4: begin
        if (mul_valid && !pause) begin
          acc <= acc + mul_result[21:0];
          state <= 5;
          pause <= 1;
          mul_reset_n <= 0;
        end
      end

      5: begin
        acc   <= acc + {17'd0, loc4};
        state <= 6;
      end

      6: begin
        acc   <= (acc << 7) + {16'd0, power} + 22'd64;
        state <= 7;
      end

      7: begin
        state <= 7;
      end
    endcase

    if (reset_n == 0) begin
      state <= 0;
      acc <= 0;
      pause <= 0;
    end
  end

  always_comb begin
    unique case (state)
      0: begin
        a_mul = 10;
        b_mul = {23'd0, loc1};
      end

      3: begin
        a_mul = {6'd0, acc};
        b_mul = 28'd180;
      end

      4: begin
        a_mul = 28'd10;
        b_mul = {23'd0, loc2};
      end

      default: begin
        a_mul = 28'd0;
        b_mul = 28'd0;
      end
    endcase
  end

  assign valid = (state == 7) ? 1 : 0;
  assign M = acc;

endmodule
