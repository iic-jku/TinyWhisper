// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0

`timescale 1ns/1ps;

module toplevel_uart_tb ();
  logic        clk = 0;
  logic        reset = 1;

  logic [15:0] buffer;
  logic        req = 0;
  logic        rx;
  logic master_busy, slave_busy, slave_valid;
  logic       start_transmission = 0;
  logic       tx_start = 0;
  logic [7:0] tx_byte = 0;
  logic       tx_done;

  localparam real F_CLK = 56_000_000;
  realtime PERIOD_NS = (1/F_CLK) * 1_000_000_000;
  realtime HALFPERIOD_NS = PERIOD_NS / 2;

  uart_tx uart_tx (
      .i_Clock(clk),
      .i_Tx_DV(tx_start),
      .i_Tx_Byte(tx_byte),
      .o_Tx_Serial(rx),
      .o_Tx_Done(tx_done)
  );

  logic encoding_valid;
  toplevel_uart dut (
      .clk(clk),
      .reset(reset),
      .rx(rx),
      .start_transmission(start_transmission),
      .encoding_valid(encoding_valid)
  );

  logic [7:0] to_send[] = '{
8'd0,
8'd0,
8'd0,
8'd10,
8'd53,
8'd80,
8'd11,
8'd1,
8'd48,
8'd12,
8'd89,
8'd224,
8'd13,
8'd0,
8'd66,
8'd14,
8'd18,
8'd32,
8'd1,
8'd0,
8'd2,
8'd2,
8'd93,
8'd30,
8'd3,
8'd70,
8'd150,
8'd4,
8'd109,
8'd129,
8'd5,
8'd70,
8'd150,
8'd6,
8'd125,
8'd225,
8'd7,
8'd70,
8'd150,
8'd8,
8'd142,
8'd68,
8'd9,
8'd70,
8'd150,
8'd0,
8'd0,
8'd1
  };

  always begin
    clk <= ~clk;
    #HALFPERIOD_NS;
  end

  initial begin
    $display("Time: %f", PERIOD_NS);
    $dumpfile("toplevel_uart_tb.vcd");
    $dumpvars(0, dut, uart_tx);
    reset = 0;
    req   = 0;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    reset = 1;
    #PERIOD_NS;
    #PERIOD_NS;
    foreach (to_send[i]) begin
      tx_byte = to_send[i];
      tx_start = 1;
      #PERIOD_NS;

      tx_start = 0;
      #PERIOD_NS;
      @(posedge tx_done);
      #PERIOD_NS;
      #PERIOD_NS;
      #PERIOD_NS;
    end

    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    @(posedge encoding_valid);
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    start_transmission = 1;
    #PERIOD_NS;
    #PERIOD_NS;
    #PERIOD_NS;
    start_transmission = 0;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;

    #6;
    $finish;
  end
endmodule
