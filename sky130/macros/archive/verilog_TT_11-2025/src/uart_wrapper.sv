// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0
module uart_wrapper (
    input logic clk,
    input logic reset_n,
    input logic rx,

    output logic [7:0] addr,
    output logic [15:0] data,
    output logic valid
);

  logic byte_valid;
  logic [7:0] uart_byte;

  uart_rx uart_rx (
      .i_Clock(clk),
      .i_Rx_Serial(rx),
      .reset_n(reset_n),
      .o_Rx_DV(byte_valid),
      .o_Rx_Byte(uart_byte)
  );

  typedef enum {
    ADDR,
    DATAH,
    DATA
  } current_t;

  current_t current;

  always_ff @(posedge clk) begin
    valid <= 0;

    if (byte_valid) begin
      case (current)
        ADDR: begin
          addr <= uart_byte;
          current <= DATAH;
        end

        DATAH: begin
          data[15:8] <= uart_byte;
          current <= DATA;
        end

        DATA: begin
          data[7:0] <= uart_byte;
          current <= ADDR;
          valid <= 1;
        end
      endcase
    end

    if (reset_n == 0) begin
      valid   <= 0;
      current <= ADDR;
      addr <= 0;
      data <= 0;
    end
  end

endmodule
