/*
* SPDX-FileCopyrightText: 2026 Harald Pretl
* Johannes Kepler University, Institute for Integrated Circuits
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
* SPDX-License-Identifier: Apache-2.0
*
* Testbench for 2nd order delta-sigma modulator (IHP130).
* Feeds a 10-bit sine wave (1024 samples, 4 periods) at OSR=64
* and checks output density and complementary output correctness.
*/

`timescale 10ns / 1ns

`include "../src/dsmod.v"

module dsmod_tb;

    parameter SAMPLE_COUNT = 1024;
    parameter OSR_VAL      = 64;

    reg CLK;
    reg RESET_N;
    reg ENABLE;
    reg signed [9:0] DATA;
    reg MODE;
    reg [1:0] OSR;
    wire OUTP, OUTN;
    wire READ_STRB;
    integer CTR_CLK;
    reg reset_done;

    // Sine wave samples (10-bit, hex)
    reg [9:0] sine_wave [0:SAMPLE_COUNT-1];
    integer i;

    // Statistics
    integer ones_count, total_count;
    integer segment, seg_ones, seg_total;
    integer err_count;

    // Per-sample density tracking for SNR-like analysis
    integer sample_idx;
    integer sample_ones, sample_total;

    // Instantiate DUT with default NBIT=30
    dsmod dut (
        .i_clk(CLK),
        .i_rst_n(RESET_N),
        .i_ena_mod(ENABLE),
        .i_data(DATA),
        .i_mode(MODE),
        .i_osr(OSR),
        .o_data_rd(READ_STRB),
        .o_ds(OUTP),
        .o_ds_n(OUTN)
    );

    // 50 MHz clock (period = 20 time units at 10ns timescale)
    always #1 CLK = ~CLK;

    // Track output density
    always @(posedge CLK) begin
        if (reset_done) begin
            total_count <= total_count + 1;
            seg_total   <= seg_total + 1;
            sample_total <= sample_total + 1;
            if (OUTP) begin
                ones_count  <= ones_count + 1;
                seg_ones    <= seg_ones + 1;
                sample_ones <= sample_ones + 1;
            end
        end
    end

    // Feed sine wave data and track per-sample density
    always @(negedge CLK) begin
        if (!RESET_N) begin
            CTR_CLK <= 0;
        end else begin
            CTR_CLK <= CTR_CLK + 1;

            if (READ_STRB && reset_done) begin
                // Print per-sample density (every 16 samples to avoid flooding)
                if (i > 0 && (i % 64) == 0 && sample_total > 0) begin
                    $display("  Sample %4d: input=%4d, density=%0f",
                             i, DATA, 1.0 * sample_ones / sample_total);
                end
                sample_ones = 0;
                sample_total = 0;

                i = i + 1;
                if (i < SAMPLE_COUNT) begin
                    DATA <= sine_wave[i];
                    sample_idx = i;
                end else begin
                    $display("");
                    $display("=== SIMULATION COMPLETE (IHP130 dsmod, 2nd order) ===");
                    $display("  Samples processed: %0d", SAMPLE_COUNT);
                    $display("  OSR:               %0d", OSR_VAL);
                    $display("  Total clocks:      %0d", total_count);
                    $display("  Output ones:       %0d", ones_count);
                    $display("  Overall density:   %0f", 1.0 * ones_count / total_count);
                    $display("  Expected density:  ~0.50 (zero-mean sine)");
                    $display("");
                    if (err_count == 0)
                        $display("PASS: complementary outputs always correct");
                    else
                        $display("FAIL: %0d complementary output errors", err_count);

                    // Density sanity check: should be between 0.40 and 0.60
                    if (1.0 * ones_count / total_count > 0.40 &&
                        1.0 * ones_count / total_count < 0.60)
                        $display("PASS: overall density within expected range [0.40, 0.60]");
                    else
                        $display("FAIL: overall density out of expected range");

                    $finish;
                end
            end
        end
    end

    // Check complementary outputs (only after reset)
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

    // Print density every 256 OSR periods
    always @(posedge CLK) begin
        if (reset_done && seg_total > 0 && (seg_total % (OSR_VAL * 256)) == 0) begin
            segment = segment + 1;
            $display("Segment %0d: density = %0f (ones=%0d / %0d)",
                     segment, 1.0 * seg_ones / (OSR_VAL * 256), seg_ones, OSR_VAL * 256);
            seg_ones = 0;
        end
    end

    initial begin
        $dumpfile("dsmod_tb.vcd");
        $dumpvars(0, dsmod_tb);
        $display("=== 2nd Order Delta-Sigma Modulator Testbench (IHP130) ===");
        $display("  NBIT=30 (default), OSR=64, MODE=2nd order");
        $display("");

        $readmemh("data/sine_wave_100%_10bit_256s_125kHz_4periods.mem", sine_wave);

        CLK          = 1'b0;
        RESET_N      = 1'b0;
        ENABLE       = 1'b0;
        OSR          = 2'd1;    // OSR=64
        MODE         = 1'b1;    // 2nd order
        DATA         = 10'sd0;
        i            = 0;
        ones_count   = 0;
        total_count  = 0;
        segment      = 0;
        seg_ones     = 0;
        seg_total    = 0;
        err_count    = 0;
        reset_done   = 1'b0;
        sample_idx   = 0;
        sample_ones  = 0;
        sample_total = 0;

        // Hold reset for several clock cycles
        #10 RESET_N  = 1'b1;
        #2  ENABLE   = 1'b1;
            reset_done = 1'b1;
        $display("Reset released, modulator enabled at time %0t", $time);
        $display("");

        // Safety timeout
        #200000 begin
            $display("TIMEOUT: simulation did not finish in time");
            $finish;
        end
    end

endmodule
