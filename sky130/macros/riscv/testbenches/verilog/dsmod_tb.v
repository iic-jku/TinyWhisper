/*
* SPDX-FileCopyrightText: 2025 Harald Pretl
* Johannes Kepler University, Institute for Integrated Circuits
* SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
*
* Testbench for 2nd order delta-sigma modulator verification.
*/

`timescale 10ns / 1ns

`include "../rtl/dsmod.v"

module dsmod_tb;

    parameter SAMPLE_COUNT = 1024;

    reg CLK;
    reg RESET_N;
    reg ENABLE;
    reg signed [9:0] DATA;
    reg MODE;
    reg [1:0] OSR;
    reg OUT_INVERT;
    wire OUTP, OUTN;
    wire READ_STRB;
    integer CTR_CLK;
    reg reset_done;

    // Sine wave samples (10-bit unsigned hex)
    reg [9:0] sine_wave [0:SAMPLE_COUNT-1];
    integer i;

    // Statistics for output quality check
    integer ones_count;
    integer total_count;
    integer segment;
    integer seg_ones;
    integer seg_total;
    integer err_count;

    // Instantiate DUT with default NBIT=30
    dsmod dut (
        .i_clk(CLK),
        .i_rst_n(RESET_N),
        .i_ena_mod(ENABLE),
        .i_data(DATA),
        .i_mode(MODE),
        .i_osr(OSR),
        .i_out_invert(OUT_INVERT),
        .o_data_rd(READ_STRB),
        .o_ds(OUTP),
        .o_ds_n(OUTN)
    );

    always #1 CLK = ~CLK;

    // Track output density
    always @(posedge CLK) begin
        if (reset_done) begin
            total_count <= total_count + 1;
            seg_total <= seg_total + 1;
            if (OUTP) begin
                ones_count <= ones_count + 1;
                seg_ones <= seg_ones + 1;
            end
        end
    end

    // Feed sine wave data
    always @(negedge CLK) begin
        if (!RESET_N) begin
            CTR_CLK <= 0;
        end else begin
            CTR_CLK <= CTR_CLK + 1;

            if (READ_STRB) begin
                i = i + 1;
                if (i < SAMPLE_COUNT) begin
                    DATA <= sine_wave[i];
                end else begin
                    // Print final statistics
                    $display("=== SIMULATION COMPLETE ===");
                    $display("Total clocks: %0d, Ones: %0d, Density: %0f",
                             total_count, ones_count, 1.0 * ones_count / total_count);
                    $display("Expected density ~0.50 for zero-mean sine wave");
                    if (err_count == 0)
                        $display("PASS: no complementary output errors detected");
                    else
                        $display("FAIL: %0d complementary output errors detected", err_count);
                    $finish;
                end
            end
        end
    end

    // Check complementary outputs (only after reset is done)
    always @(posedge CLK) begin
        if (reset_done) begin
            if (OUTP === OUTN) begin
                if (err_count < 10)
                    $display("ERROR at time %0t: o_ds (%b) == o_ds_n (%b) -- not complementary!",
                             $time, OUTP, OUTN);
                err_count = err_count + 1;
            end
        end
    end

    // Print density every 256 OSR periods for visual check
    always @(posedge CLK) begin
        if (reset_done && seg_total > 0 && (seg_total % (64*256)) == 0) begin
            segment = segment + 1;
            $display("Segment %0d: density = %0f (ones=%0d, total=%0d)",
                     segment, 1.0 * seg_ones / (64*256), seg_ones, 64*256);
            seg_ones = 0;
        end
    end

    initial begin
        $dumpfile("dsmod_tb.vcd");
        $dumpvars(0, dsmod_tb);
        $display("=== 2nd Order Delta-Sigma Modulator Testbench ===");
        $readmemh("../../archive/verilog_TT_11-2025/tb/data/sine_wave_100%_10bit_256s_125kHz_4periods.mem", sine_wave);

        CLK         = 1'b0;
        RESET_N     = 1'b0;
        ENABLE      = 1'b0;
        OSR         = 2'd1;    // OSR=64
        MODE        = 1'b1;    // 2nd order
        OUT_INVERT  = 1'b0;
        DATA        = 10'sd0;
        i           = 0;
        ones_count  = 0;
        total_count = 0;
        segment     = 0;
        seg_ones    = 0;
        seg_total   = 0;
        err_count   = 0;
        reset_done  = 1'b0;

        // Hold reset for several clock cycles
        #10 RESET_N = 1'b1;
        #2  ENABLE  = 1'b1;
            reset_done = 1'b1;
        $display("Reset released, modulator enabled at time %0t", $time);

        // Safety timeout
        #200000 begin
            $display("TIMEOUT: simulation did not finish in time");
            $finish;
        end
    end

endmodule
