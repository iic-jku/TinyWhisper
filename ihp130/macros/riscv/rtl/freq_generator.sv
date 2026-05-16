// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
module freq_generator (
    input logic        clk,
    input logic        reset_n,
    input logic [29:0] f_c,
    input logic [ 1:0] osr_level,   // 0: 32, 1: 64, 2: 128, 3: 256
    input logic [ 4:0] lo_div_sel,
    input logic        ds_mode,
    input logic        ds_invert,
    input logic        ds_switch,
    input logic [29:0] cordic_I,
    input logic [29:0] cordic_Q,

    input logic start,

    output logic active,
    output logic ds_I_p_o,
    output logic ds_I_n_o,
    output logic ds_Q_p_o,
    output logic ds_Q_n_o,
    output logic lo_i,
    output logic lo_q,
    output logic lo_ix,
    output logic lo_qx
);

  // ============================================
  // Default values for lo and ds that are set during resets
  localparam LO_DEFAULT = 0;
  // ============================================

  localparam logic [7:0] CORDIC_START = 31;
  logic [ 7:0] OSR;

  // Signals for Cordic
  logic [29:0] theta;
  logic [29:0] cosine;
  logic [29:0] sine;
  logic [29:0] X_o;
  logic [29:0] Y_o;

  logic        cordic_strb_i;
  logic        cordic_strb_o;
/* verilator lint_off UNUSEDSIGNAL */
  logic [29:0] Z_o;
/* verilator lint_on UNUSEDSIGNAL */
  logic        transmission_reset_n;

  cordic_iterative cordic (
      .clk_i(clk),
      .rstn_i(transmission_reset_n),
      .strb_data_valid_i(cordic_strb_i),
      .X_i(cordic_I),
      .Y_i(cordic_Q),
      .Z_i(theta),
      .X_o(X_o),
      .Y_o(Y_o),
      .Z_o(Z_o),
      .strb_data_valid_o(cordic_strb_o)
  );

  logic dsmod_ena;
/* verilator lint_off UNUSEDSIGNAL */
  logic dsmod_cos_data_rd;
/* verilator lint_on UNUSEDSIGNAL */
  logic cos_o_ds;
  logic cos_o_ds_n;
  dsmod dsmod_cos (
      .i_rst_n(transmission_reset_n),
      .i_clk(clk),
      .i_ena_mod(dsmod_ena),
      .i_data(cosine),
      .o_data_rd(dsmod_cos_data_rd),
      .i_mode(ds_mode),
      .i_osr(osr_level),
      .o_ds(cos_o_ds),
      .o_ds_n(cos_o_ds_n)
  );

/* verilator lint_off UNUSEDSIGNAL */
  logic dsmod_sin_data_rd;
/* verilator lint_on UNUSEDSIGNAL */
  logic sin_o_ds;
  logic sin_o_ds_n;
  dsmod dsmod_sin (
      .i_rst_n(transmission_reset_n),
      .i_clk(clk),
      .i_ena_mod(dsmod_ena),
      .i_data(sine),
      .o_data_rd(dsmod_sin_data_rd),
      .i_mode(ds_mode),
      .i_osr(osr_level),
      .o_ds(sin_o_ds),
      .o_ds_n(sin_o_ds_n)
  );

  logic cos_ds, cos_ds_n, sin_ds, sin_ds_n;

  // Invert sin and cos
  assign sin_ds   = (ds_invert) ? sin_o_ds_n : sin_o_ds;
  assign sin_ds_n = (ds_invert) ? sin_o_ds : sin_o_ds_n;
  assign cos_ds   = (ds_invert) ? cos_o_ds_n : cos_o_ds;
  assign cos_ds_n = (ds_invert) ? cos_o_ds : cos_o_ds_n;

  // Switch sin and cos for I/Q modulation
  assign ds_I_p_o = (ds_switch) ? sin_ds : cos_ds;
  assign ds_I_n_o = (ds_switch) ? sin_ds_n : cos_ds_n;
  assign ds_Q_p_o = (ds_switch) ? cos_ds : sin_ds;
  assign ds_Q_n_o = (ds_switch) ? cos_ds_n : sin_ds_n;

  logic lo_enable;
  lo_gen #(
      .DEFAULT(LO_DEFAULT)
  ) lo_gen (
      .i_rst_n(transmission_reset_n),
      .i_clk(clk),
      .i_enable(lo_enable),
      .i_div_sel(lo_div_sel),
      .o_lo_i(lo_i),
      .o_lo_q(lo_q),
      .o_lo_ix(lo_ix),
      .o_lo_qx(lo_qx)
  );

  typedef enum {
    IDLE,
    CORDIC_ONLY,  // For first symbol only
    DSMOD_ONLY,   // First phase until last few cycles
    DSMOD_CORDIC  // Last few cycles. Both compute and finish simultaneously
  } transmit_state_t;

  transmit_state_t transmit_state;
  logic [7:0] transmit_counter;

  always_ff @(posedge clk) begin
    transmission_reset_n <= 1;

    if (cordic_strb_o) begin
      theta  <= theta + f_c;
      cosine <= X_o;
      sine   <= Y_o;
    end

    case (transmit_state)
      IDLE: begin
        if (start) begin
          transmit_state <= CORDIC_ONLY;
          cordic_strb_i <= 1;
          theta <= 0;
        end
      end

      CORDIC_ONLY: begin
        cordic_strb_i <= 0;
        if (cordic_strb_o) begin
          transmit_state <= DSMOD_ONLY;
          transmit_counter <= OSR;
          dsmod_ena <= 1;
          lo_enable <= 1;
        end
      end

      DSMOD_ONLY: begin
        transmit_counter <= transmit_counter - 1;
        if (transmit_counter <= CORDIC_START) begin
          transmit_state <= DSMOD_CORDIC;
          cordic_strb_i  <= 1;
        end
      end

      DSMOD_CORDIC: begin
        cordic_strb_i <= 0;

        if (transmit_counter == 0) begin
          transmit_counter <= OSR;
          transmit_state   <= DSMOD_ONLY;
        end else transmit_counter <= transmit_counter - 1;
      end
    endcase

    if (reset_n == 0) begin
      transmission_reset_n <= 0;
      cordic_strb_i <= 0;
      theta <= 0;
      dsmod_ena <= 0;
      lo_enable <= 0;
      cosine <= 30'd0;
      sine <= 30'd0;
      transmit_counter <= 255;
      transmit_state <= IDLE;
    end
  end

  always_comb begin
    case (osr_level)
      2'b00: OSR = 8'd31;
      2'b01: OSR = 8'd63;
      2'b10: OSR = 8'd127;
      2'b11: OSR = 8'd255;

      default: OSR = 8'd255;
    endcase
  end

  assign active = (transmit_state == IDLE) ? 0 : 1;

endmodule
