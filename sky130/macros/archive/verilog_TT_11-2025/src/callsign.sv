// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0
module callsign (
    input logic clk,
    input logic reset_n,

    input logic [35:0] callsign_in,  // C1, C2, ..., C6

    output logic [27:0] callsign_out,
    output logic valid,

    // Multiplier interface
    output logic [27:0] a_mul,
    output logic [27:0] b_mul,
    output logic mul_reset_n,
    input logic [27:0] mul_result,
    input logic mul_valid
);

  logic [27:0] accumulator = 0;
  logic [ 6:0] slice_index = 35;
  logic [ 5:0] slice;

  // 0: init, 1: wait
  // 2: * 36, 3: wait
  // 4: * 10, 5: wait
  // 6: * 27 - 10, 7: wait
  // 8: valid
  logic [ 3:0] state = 0;

  always_ff @(posedge clk) begin
    mul_reset_n <= 1;

    case (state)
      0: begin
        accumulator <= {22'd0, slice};
        state <= 1;
        mul_reset_n <= 0;
        slice_index <= slice_index - 6;
      end

      1: begin
        mul_reset_n <= 0;
        state <= 2;
      end

      2: begin
        if (mul_valid) begin
          accumulator <= mul_result + {22'd0, slice};
          state <= 3;
          mul_reset_n <= 0;
          slice_index <= slice_index - 6;
        end
      end

      3: begin
        mul_reset_n <= 0;
        state <= 4;
      end

      4: begin
        if (mul_valid) begin
          accumulator <= mul_result + {22'd0, slice};
          state <= 5;
          mul_reset_n <= 0;
          slice_index <= slice_index - 6;
        end
      end

      5: begin
        mul_reset_n <= 0;
        state <= 6;
      end

      6: begin
        if (mul_valid) begin
          accumulator <= mul_result + {22'd0, slice} - 28'd10;
          slice_index <= slice_index - 6;
          mul_reset_n <= 0;
          state <= 7;

          if (slice_index <= 5) begin
            state <= 8;
            slice_index <= 5;
          end
        end
      end

      7: begin
        // Go back to 6 and compute the next digit
        mul_reset_n <= 0;
        state <= 6;
      end

      8: begin
        slice_index <= 5;
        state <= 8;
        mul_reset_n <= 0;
      end

      default: begin
        slice_index <= 35;
        accumulator <= 0;
        state <= 0;
        mul_reset_n <= 0;
      end
    endcase

    if (reset_n == 0) begin
      slice_index <= 35;
      accumulator <= 0;
      state <= 0;
      mul_reset_n <= 0;
    end
  end

  always_comb begin
    unique case (state)
      2: b_mul = 36;
      4: b_mul = 10;
      6: b_mul = 27;
      default: b_mul = 36;
    endcase
  end

  assign a_mul = accumulator;
  assign slice = callsign_in[slice_index-:6];
  assign valid = (state == 8) ? 1 : 0;
  assign callsign_out = accumulator;

endmodule
