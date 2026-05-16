/*
* SPDX-FileCopyrightText: 2025 Harald Pretl
* Johannes Kepler University, Institute for Integrated Circuits
* SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
*
* Simple TB for the synthesized LO generator.
*/

`timescale 10ns / 1ns // `timescale <time_unit> / <time_precision>

`include "../src/lo_gen.v"

module lo_gen_tb;

    reg CLK;
    reg RESET_N;
    reg [2:0] DIVIDER;
    reg ENABLE;
    wire LO_I, LO_Q, LO_IX, LO_QX;

    // instantiate DUT module
    lo_gen dut (
        .i_clk(CLK),
        .i_rst_n(RESET_N),
        .i_enable(ENABLE),
        .i_div_sel(DIVIDER),
        .o_lo_i(LO_I),
        .o_lo_q(LO_Q),
        .o_lo_ix(LO_IX),
        .o_lo_qx(LO_QX)
    );

    always #1 CLK = ~CLK; // toggle clock (50MHz)

    initial begin
        // dump signals into VCD for debug
		$dumpfile("lo_gen_tb.vcd");
		$dumpvars(0, lo_gen_tb);
        $display("Start testbench for lo_gen");

        CLK     = 1'b0;
        RESET_N = 1'b0;
        DIVIDER = 4'd1;
        ENABLE  = 1'b0;
        
        #5 RESET_N = 1'b1; // release reset
        #10 ENABLE = 1'b1; // enable LO generation

        #50 DIVIDER = 3'd1; // change divider to 2

        #100 DIVIDER = 3'd2; // change divider to 4

        #200 DIVIDER = 3'd3; // change divider to 8

        #100 DIVIDER = 3'd4; // static I
        #100 DIVIDER = 3'd5; // static Q
        #100 DIVIDER = 3'd6; // static IX
        #100 DIVIDER = 3'd7; // static QX

        #50 $display("Test finished.");
        $finish;
    end

endmodule // lo_gen_tb
