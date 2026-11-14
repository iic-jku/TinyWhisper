// SPDX-FileCopyrightText: 2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Description: Wrapper for the timed gate-level simulation of the
// riscv_top netlist. Icarus Verilog annotates the delays of the SDF
// file that the plusarg +SDF=<file> names.

`default_nettype none

module riscv_top_sdf (
  input  wire       clk,
  input  wire       reset,
  output wire       sram_ce,
  output wire       sclk,
  output wire       si,
  input  wire       so,
  input  wire       rx,
  output wire       tx,
  output wire       scl,
  input  wire       sda_i,
  output wire       sda_o,
  output wire       sda_oe,
  input  wire [3:0] gpio_in,
  output wire [3:0] gpio_out,
  output wire       analog_en,
  output wire       I_ae,
  output wire       Q_ae,
  input  wire       lo_I_i,
  output wire       lo_I_o,
  output wire       lo_I_oe,
  input  wire       lo_Ix_i,
  output wire       lo_Ix_o,
  input  wire       lo_Q_i,
  output wire       lo_Q_o,
  output wire       lo_Q_oe,
  input  wire       lo_Qx_i,
  output wire       lo_Qx_o,
  input  wire       ds_I_n_i,
  output wire       ds_I_n_o,
  output wire       ds_I_oe,
  input  wire       ds_I_p_i,
  output wire       ds_I_p_o,
  input  wire       ds_Q_n_i,
  output wire       ds_Q_n_o,
  output wire       ds_Q_oe,
  input  wire       ds_Q_p_i,
  output wire       ds_Q_p_o
);

  riscv_top u_riscv_top (.*);

  string sdf_file;

  initial begin
    if ($value$plusargs("SDF=%s", sdf_file)) begin
      $sdf_annotate(sdf_file, u_riscv_top);
    end
  end

endmodule

`default_nettype wire
