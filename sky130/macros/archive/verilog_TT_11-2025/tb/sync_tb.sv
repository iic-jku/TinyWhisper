// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
module sync_tb ();

  logic clk = 0;
  logic reset_n = 1;

  logic [161:0] data = 162'h23a7e38d70098d0a55b36a9781d7fffdb96f861ed;
  logic [1:0] symbols[162];
  logic valid;

  sync dut (
      .clk(clk),
      .reset_n(reset_n),
      .data(data),
      .symbols(symbols),
      .valid(valid)
  );

  initial begin
    forever #1 clk <= ~clk;
  end

  int i;
  initial begin
    $dumpfile("sync_tb.vcd");
    $dumpvars(0, dut);

    for (i = 0; i < 162; i++) begin
      $dumpvars(0, symbols[i]);
    end

    #2;
    reset_n <= 0;
    #6;
    reset_n <= 1;

    @(posedge valid);
    // assert (data_out == expected)
    // else $error("Ergebnis passt nicht");

    #40;
    $finish;
  end

endmodule
