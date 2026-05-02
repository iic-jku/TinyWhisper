// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0
module loc_pwr_tb ();

  logic clk = 0;
  logic reset_n = 1;

  // DL9MJ
  logic [19:0] locator = {5'd9, 5'd13, 5'd4, 5'd9};
  logic [5:0] power = 30;

  logic [31:0] a_mul, b_mul, mul_result;
  logic mul_valid;
  logic mul_reset_n;

  loc_pwr dut (
      .clk(clk),
      .reset_n(reset_n),
      .locator(locator),
      .power(power),
      .a_mul(a_mul),
      .b_mul(b_mul),
      .mul_result(mul_result),
      .mul_valid(mul_valid),
      .mul_reset_n(mul_reset_n)
  );

  always_ff @(posedge clk) begin : multiplier
    mul_result <= a_mul * b_mul;
    mul_valid  <= 1;

    if (mul_reset_n == 0) begin
      mul_result <= 0;
      mul_valid  <= 0;
    end
  end

  initial begin
    forever #1 clk <= ~clk;
  end

  initial begin
    $dumpfile("loc_pwr_tb.vcd");
    $dumpvars(0, dut);

    #2;
    reset_n <= 0;
    #6;
    reset_n <= 1;
    #200;

    $finish;
  end
endmodule
