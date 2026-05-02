// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0
module toplevel_uart (
    input logic clk,
    input logic reset,
    input logic rx,
    input logic start_transmission,

    output logic encoding_valid,

    output logic cos_ds,
    output logic cos_ds_n,
    output logic sin_ds,
    output logic sin_ds_n,
    output logic lo_i,
    output logic lo_q,
    output logic lo_ix,
    output logic lo_qx,
    output logic [1:0] current//,
    // output logic clk_out
);

  // assign clk_out = clk;
  logic [7:0] addr;
  logic [15:0] data;

  logic uart_valid;

  // Registers
  logic [35:0] callsign;
  logic [19:0] locator;
  logic [5:0] power;

  logic [29:0] f_c0;
  logic [29:0] f_c1;
  logic [29:0] f_c2;
  logic [29:0] f_c3;
  logic [1:0] OSR_0;
  logic [1:0] OSR_1;
  logic [1:0] OSR_2;
  logic [1:0] OSR_3;
  logic [1:0] OSR_PARAM;

  logic [29:0] cordic_I;
  logic [29:0] cordic_Q;

  logic encoder_reset;
  logic start_encoding;
  // logic [323:0] symbols;

  // Signals used for the FSM
  localparam int CLK_FREQ = 56_000_000;  // Hz
  localparam int SYMBOL_DURATION = 683;  // ms

  logic [7:0] OSR;
  // localparam [1:0] OSR_PARAM = 2'd2;

`ifdef SIMULATION
  localparam logic [31:0] CYCLES_PER_SYMBOL = 10000;
`else
  localparam logic [31:0] CYCLES_PER_SYMBOL = (CLK_FREQ / 1000) * SYMBOL_DURATION;
`endif

  // NOTE: This should have been 31, Jonathan forgot to change this after increasing
  // the Cordic accuracy. Cordic and Dsmod still work fine for all OSRs, however.
  localparam logic [7:0] CORDIC_START = 21;

  localparam logic [7:0] SYMBOL_START = 10;
  logic symbols_valid;

  localparam int CYCLE_COUNTER_WIDTH = $clog2(CYCLES_PER_SYMBOL + 1);
  localparam int SYMBOL_COUNTER_WIDTH = $clog2(323 + 1);

  logic [CYCLE_COUNTER_WIDTH-1:0] cycle_counter;
  logic [SYMBOL_COUNTER_WIDTH-1:0] symbol_counter;
  logic [1:0] symbol;
  logic [1:0] next_symbol;
  assign current = symbol;

  // Signals for Cordic
  logic [29:0] theta;
  logic [29:0] f_c;
  logic [29:0] cosine;
  logic [29:0] sine;
  logic [29:0] X_o;
  logic [29:0] Y_o;

  logic        transmission_reset_n;

  uart_wrapper uart_wrapper (
      .clk(clk),
      .reset_n(reset),
      .rx(rx),
      .addr(addr),
      .data(data),
      .valid(uart_valid)
  );

  logic ready;
  logic req_next_symbol;
  wspr_encoder encoder (
      .clk(clk),
      .reset_n(encoder_reset),
      .callsign_in(callsign),
      .locator_in(locator),
      .power_in(power),
      .req_next_symbol(req_next_symbol),
      .symbol_out(next_symbol),
      .symbol_valid(symbols_valid),
      .ready(ready)
  );

  assign encoding_valid = ready;

  logic cordic_strb_i;
  logic cordic_strb_o;
  logic [29:0] Z_o;

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
  logic dsmod_cos_data_rd;
  dsmod dsmod_cos (
      .i_rst_n(transmission_reset_n),
      .i_clk(clk),
      .i_ena_mod(dsmod_ena),
      .i_data(cosine),
      .o_data_rd(dsmod_cos_data_rd),
      .i_mode(1'b0),
      .i_osr(OSR_PARAM),
      .o_ds(cos_ds),
      .o_ds_n(cos_ds_n)
  );

  logic dsmod_sin_data_rd;
  dsmod dsmod_sin (
      .i_rst_n(transmission_reset_n),
      .i_clk(clk),
      .i_ena_mod(dsmod_ena),
      .i_data(sine),
      .o_data_rd(dsmod_sin_data_rd),
      .i_mode(1'b0),
      .i_osr(OSR_PARAM),
      .o_ds(sin_ds),
      .o_ds_n(sin_ds_n)
  );

  logic lo_enable;
  logic [2:0] lo_div_sel;
  lo_gen lo_gen (
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
    ENCODING,
    FIRST_SYMBOL,
    READY,
    TRANSMIT,
    FINISH
  } states_t;

  typedef enum {
    CORDIC_ONLY,  // For first symbol only
    DSMOD_ONLY,   // First phase until last 10 cycles
    DSMOD_CORDIC  // Last 10 cycles. Both compute and finish simultaneously
  } transmit_state_t;

  states_t state;
  transmit_state_t transmit_state;

  logic [7:0] transmit_counter;

  always_ff @(posedge clk) begin
    transmission_reset_n <= 1;

    if (state == TRANSMIT && cordic_strb_o) begin
      theta  <= theta + f_c;
      cosine <= X_o;
      sine   <= Y_o;
    end

    case (state)
      ENCODING: begin
        if (ready) begin
          state <= FIRST_SYMBOL;
          req_next_symbol <= 1;
        end
      end

      FIRST_SYMBOL: state <= READY;

      READY: begin
        req_next_symbol <= 0;
        symbol <= next_symbol;
        if (start_transmission == 1) begin
          symbol_counter <= 323;
          state <= TRANSMIT;
          transmit_state <= CORDIC_ONLY;
          transmit_counter <= OSR;
          theta <= 0;
          cordic_strb_i <= 1;
        end
      end

      TRANSMIT: begin
        req_next_symbol <= 0;

        if (symbols_valid) symbol <= next_symbol;

        if (cycle_counter >= CYCLES_PER_SYMBOL) begin
          req_next_symbol <= 1;
          cycle_counter   <= 0;
          symbol_counter  <= symbol_counter - 2;

          if (symbol_counter <= 1) state <= FINISH;
        end else cycle_counter <= cycle_counter + 1;

        case (transmit_state)
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

      end

      FINISH: begin
        state <= FINISH;
        dsmod_ena <= 0;
      end
    endcase

    if (uart_valid) begin
      case (addr)
        0: begin
          if (data[0] == 1'b0) begin
            transmission_reset_n <= 0;
            cordic_strb_i <= 0;
            start_encoding <= 0;
            theta <= 0;
            dsmod_ena <= 0;
            cycle_counter <= 0;
            lo_div_sel <= 3'b010;
            lo_enable <= 0;
            cosine <= 30'd0;
            sine <= 30'd0;
            encoder_reset <= 0;
            state <= ENCODING;
            symbol <= 0;
            req_next_symbol <= 0;
            symbol_counter <= 323;
            transmit_counter <= 255;
          end else begin
            start_encoding <= 1;
          end
        end

        // Addr 1: Encode regs
        1: lo_div_sel <= data[2:0];

        // // Addr 2-5: f_c
        2: f_c0[15:0] <= data;
        3: begin
          f_c0[29:16] <= data[13:0];
          OSR_0 <= data[15:14];
        end
        4: f_c1[15:0] <= data;
        5: begin
          f_c1[29:16] <= data[13:0];
          OSR_1 <= data[15:14];
        end
        6: f_c2[15:0] <= data;
        7: begin
          f_c2[29:16] <= data[13:0];
          OSR_2 <= data[15:14];
        end
        8: f_c3[15:0] <= data;
        9: begin
          f_c3[29:16] <= data[13:0];
          OSR_3 <= data[15:14];
        end

        // Addr 2-7: Callsign
        10: callsign[35:24] <= data[15:4];
        11: callsign[23:12] <= data[15:4];
        12: callsign[11:0] <= data[15:4];

        // Addr 8-11: Locator
        13: locator[19:5] <= data[15:1];
        14: begin
          locator[4:0] <= data[15:11];
          power <= data[10:5];
        end
      endcase
    end

    if (start_encoding) begin
      encoder_reset <= 1;
    end

    if (reset == 0) begin
      transmission_reset_n <= 0;
      cordic_strb_i <= 0;
      start_encoding <= 0;
      theta <= 0;
      dsmod_ena <= 0;
      cycle_counter <= 0;
      lo_div_sel <= 3'b010;
      lo_enable <= 0;
      cosine <= 30'd0;
      sine <= 30'd0;
      f_c0 <= 30'b000001100000000000011100000110;
      f_c1 <= 30'b000001100000000000011100000111;
      f_c2 <= 30'b000001100000000000011100001001;
      f_c3 <= 30'b000001100000000000011100001011;
      OSR_0 <= 2'd1;
      OSR_1 <= 2'd1;
      OSR_2 <= 2'd1;
      OSR_3 <= 2'd1;
      req_next_symbol <= 0;
      callsign <= 36'd0;
      locator <= 20'd0;
      power <= 6'd0;
      cordic_I <= 30'b010011011011101001011110001101;
      cordic_Q <= 30'b000000000000000000000000000000;
      encoder_reset <= 0;
      state <= ENCODING;
      symbol <= 0;
      symbol_counter <= 323;
      transmit_counter <= 255;
    end
  end

  always_comb begin
    case (symbol)
      2'b00: begin
        f_c = f_c0;
        OSR_PARAM = OSR_0;
      end
      2'b01: begin
        f_c = f_c1;
        OSR_PARAM = OSR_1;
      end
      2'b10: begin
        f_c = f_c2;
        OSR_PARAM = OSR_2;
      end
      2'b11: begin
        f_c = f_c3;
        OSR_PARAM = OSR_3;
      end

      default: begin
        f_c = f_c0;
        OSR_PARAM = OSR_0;
      end
    endcase

    case (OSR_PARAM)
      2'b00: OSR = 8'd31;
      2'b01: OSR = 8'd63;
      2'b10: OSR = 8'd127;
      2'b11: OSR = 8'd255;
    endcase
  end

endmodule
