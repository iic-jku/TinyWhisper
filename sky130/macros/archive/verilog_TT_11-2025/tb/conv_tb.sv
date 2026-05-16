// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
module conv_tb ();

  logic clk = 0;
  logic reset_n = 1;

  logic [80:0] data = 81'h1160f02daaaea00000000;

  conv dut (
      .clk(clk),
      .reset_n(reset_n),
      .data(data)
  );

  initial begin
    forever #1 clk <= ~clk;
  end

  initial begin
    $dumpfile("conv_tb.vcd");
    $dumpvars(0, dut);

    #2;
    reset_n <= 0;
    #6;
    reset_n <= 1;
    #400;

    $finish;
  end
endmodule
