// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0
module interleaver_tb ();

  logic clk = 0;
  logic reset_n = 1;

  // logic [161:0] data_in = 162'h35158cefafd970a5ed4c8b385cafbc8b6dcedc4f0;
  logic [161:0] data_in = 162'h3c8edcedb44f7d4e87344cade943a6fd7dcc6a2b;
  logic [161:0] data_out;
  // logic [161:0] expected = 162'h2de187da76ffffae07a55b36a942c6403ac71f971;
  logic [161:0] expected = 162'h23a7e38d70098d0a55b36a9781d7fffdb96f861ed;
  logic valid;

  interleaver dut (
      .clk(clk),
      .reset_n(reset_n),
      .data_in(data_in),
      .data_out(data_out),
      .valid(valid)
  );

  initial begin
    forever #1 clk <= ~clk;
  end

  initial begin
    $dumpfile("interleaver_tb.vcd");
    $dumpvars(0, dut);

    #2;
    reset_n <= 0;
    #6;
    reset_n <= 1;

    @(posedge valid);
    assert (data_out == expected)
    else $error("Ergebnis passt nicht");

    #40;
    $finish;
  end
endmodule
