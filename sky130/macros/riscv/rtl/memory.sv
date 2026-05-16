// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

// Memory Map: (OUTDATED. CHECK LOCALPARAMS BELOW!!!!!)
// 0x000000 - 0xFFFFFF: SRAM
// 0x1000000: GPIO Outputs
// 0x1000001: GPIO Inputs
// 0x1000002: Send via UART
// 0x1000003: I2C data
// 0x1000004: I2C device address
// 0x1000005: I2C byte mask
// 0x1000006: mtime
// 0x1000007: mtimeh
// 0x1000008: mtimecmp
// 0x1000009: mtimecmph
// 0x1000010 - end: load_access_fault

module memory #(
    parameter int CLK_FREQ,
    parameter int BAUD
) (
    input logic clk,
    input logic reset,
    input logic ce,     // active low
    input logic spi_slow_mode,

    input logic [ 2:0] funct3,
    input logic [31:0] addr,
    input logic [31:0] datain,
    input logic        memwrite,

    output logic [31:0] dataout,
    output logic        busy,
    output logic        valid,

    // SPI interface to SRAM
    input  logic so,
    output logic si,
    output logic sclk,
    output logic sram_ce,

    // I2C interface
    output logic scl,
    input  logic sda_i,
    output logic sda_o,
    output logic sda_oe,

    // UART Interface
    input  logic rx,
    output logic tx,
    output logic uart_rx_valid,

    // GPIOs
    input  logic [3:0] gpio_in,
    output logic [3:0] gpio_out,

    // Frequency generator
    output logic cos_ds,
    output logic cos_ds_n,
    output logic sin_ds,
    output logic sin_ds_n,
    output logic lo_i,
    output logic lo_q,
    output logic lo_ix,
    output logic lo_qx,

    output logic intr_timer,
    output logic load_access_fault
);

`ifndef SIM
`ifdef FPGA
  `include "constants.sv"
`endif
`endif

  // verilog_format: off
  localparam int SRAM_LOW_ADDR =       32'h00000000;
  localparam int SRAM_HIGH_ADDR =      32'h007FFFFF;

  localparam int GPIO_OUT_ADDR =       32'h00800000;
  localparam int GPIO_IN_ADDR =        32'h00800001;

  localparam int UART_TX_ADDR =        32'h00800002;

  localparam int I2C_DEVICE_ADDR =     32'h00800003;
  localparam int I2C_DATA_ADDR =       32'h00800004;  // is 4-byte aligned
  localparam int I2C_MASK_ADDR =       32'h00800005;
  localparam int I2C_ACK_ADDR =        32'h00800006;

  // ===== Alignment required =====
  localparam int MTIME_ADDR =          32'h00800008;
  localparam int MTIMEH_ADDR =         32'h0080000C;
  localparam int MTIMECMP_ADDR =       32'h00800010;
  localparam int MTIMECMPH_ADDR =      32'h00800014;

  localparam int FREQ_STATUS_ADDR =    32'h00800018;
  localparam int FREQ_OSR_FC_ADDR =    32'h0080001C;
  localparam int FREQ_LO_DIV_ADDR =    32'h00800020;

  localparam int UART_RX_STATUS_ADDR = 32'h00800021;
  localparam int UART_RX_DATA_ADDR =   32'h00800022; // readonly!

  // ===== Alignment required =====
  localparam int UART_RX_CPB_ADDR =    32'h00800024;
  localparam int UART_TX_CPB_ADDR =    32'h00800028;
  localparam int SCL_RATIO_ADDR =      32'h0080002C;
// verilog_format: on

  typedef enum {
    IDLE,
    WRITING,
    READING,
    GPIO_WAIT,
    CONTROL_REG,
    VALID,
    FINISH,
    FAULT
  } states_t;

  typedef enum {
    SRAM,
    I2C,
    UART,
    CONTROL,
    GPIO,
    TFAULT
  } target_t;

  states_t        state;
  target_t        target;

  logic    [63:0] mtime;
  logic    [63:0] mtimecmp;

  logic    [31:0] addr_reg;
  logic    [31:0] datain_reg;
  logic           memwrite_reg;

  logic master_reset, master_busy;
  logic sram_busy, sram_valid;
  logic i2c_req, i2c_busy, i2c_valid;
  logic [6:0] i2c_addr;
  logic [3:0] i2c_mask;

  logic [31:0] master_dataout, sram_dataout, i2c_dataout;

  logic [3:0] gpio_in_sync;

  // This ensures that the spi_master actually started working
  // Otherwise we would assume it has finished before it began
  // TODO: Rewrite as seperate states like READING_AWAIT, ...
  logic sclk_flag;

  logic sram_req;
  spi_master sram_master (
      .clk(clk),
      .reset(reset),
      .req(sram_req),
      .slow_mode(spi_slow_mode),
      .si(si),
      .so(so),
      .sclk(sclk),
      .ce(sram_ce),
      .addr(addr_reg[23:0]),  // NOTE: the SRAM is 23 bit wide but uses 24 bit addresses
      .byte_mask(funct3[1:0]),
      .data_in(datain_reg),
      .data_out(sram_dataout),
      .write(memwrite_reg),
      .busy(sram_busy),
      .valid(sram_valid)
  );

  logic [4:0] i2c_acks;
  localparam TARGET = 100_000;  // Hz
  localparam SCL_RATIO_DEFAULT = (CLK_FREQ / TARGET) / 2;
  logic [15:0] scl_ratio;
  i2c_master i2c_master (
      .clk(clk),
      .reset(reset),
      .req(i2c_req),
      .scl_ratio(scl_ratio),
      .sda_i(sda_i),
      .sda_o(sda_o),
      .sda_oe(sda_oe),
      .scl(scl),
      .device_addr(i2c_addr),
      .mask(i2c_mask),
      .data_in(datain_reg),  // TODO: Refactor
      .data_out(i2c_dataout),
      .write(memwrite_reg),
      .busy(i2c_busy),
      .valid(i2c_valid),
      .acks(i2c_acks)
  );

  localparam BIT_P = 1_000_000_000 * 1 / BAUD;  // nanoseconds
  localparam CLK_P = 1_000_000_000 * 1 / CLK_FREQ;  // nanoseconds
  localparam [15:0] CYCLES_PER_BIT_DEFAULT = 16'(BIT_P / CLK_P);
  logic uart_tx_busy;
  logic uart_tx_en;
  logic [15:0] uart_tx_cpb;

  uart_tx uart_transmitter (
      .clk(clk),
      .resetn(reset),
      .uart_txd(tx),
      .uart_tx_busy(uart_tx_busy),
      .uart_tx_en(uart_tx_en),
      .uart_tx_data(datain_reg[7:0]),
      .CYCLES_PER_BIT(uart_tx_cpb)
  );

  logic [ 2:0] uart_rx_status;
  logic [ 7:0] uart_rx_data;
  logic [15:0] uart_rx_cpb;
  assign uart_rx_valid = uart_rx_status[2];
  uart_rx uart_receiver (
      .clk(clk),
      .resetn(reset),
      .uart_rxd(rx),
      .uart_rx_en(uart_rx_status[0]),
      .uart_rx_break(uart_rx_status[1]),
      .uart_rx_valid(uart_rx_status[2]),
      .uart_rx_data(uart_rx_data),
      .CYCLES_PER_BIT(uart_rx_cpb)
  );

  // active | start | reset_n
  logic [ 2:0] freq_status;
  logic [31:0] osr_fc_reg;
  logic [ 4:0] ds_lo_conf;
  freq_generator freq_inst (
      .clk(clk),
      .reset_n(freq_status[0]),
      .f_c(osr_fc_reg[29:0]),
      .osr_level(osr_fc_reg[31:30]),
      .lo_div_sel(ds_lo_conf[2:0]),
      .ds_mode(ds_lo_conf[3]),
      .ds_invert(ds_lo_conf[4]),
      .start(freq_status[1]),

      .active(freq_status[2]),
      .cos_ds(cos_ds),
      .cos_ds_n(cos_ds_n),
      .sin_ds(sin_ds),
      .sin_ds_n(sin_ds_n),
      .lo_i(lo_i),
      .lo_q(lo_q),
      .lo_ix(lo_ix),
      .lo_qx(lo_qx)
  );

  always_ff @(posedge clk) begin
    mtime <= mtime + 1;

    // Avoiding metastability
    gpio_in_sync <= gpio_in;

    if (reset == 0) begin
      state <= IDLE;
      uart_tx_en <= 0;
      mtime <= 0;
      mtimecmp <= 0;
      freq_status[1:0] <= 2'b00;
      gpio_out <= 4'd0;
      gpio_in_sync <= 4'd0;
      uart_rx_status[0] <= 1'b0;
      osr_fc_reg <= {2'b11, 30'b000001100111110101011101010101};
      uart_tx_cpb <= CYCLES_PER_BIT_DEFAULT;
      uart_rx_cpb <= CYCLES_PER_BIT_DEFAULT;
      scl_ratio <= SCL_RATIO_DEFAULT[15:0];
      sclk_flag <= 0;
      i2c_mask <= 4'b1111;
      i2c_addr <= 6'b0;
      ds_lo_conf <= 5'b00100;
      state <= IDLE;
      target <= SRAM;
    end else if (ce) begin
      state <= IDLE;
      uart_tx_en <= 0;
    end else begin
      // starting when ce falls to 0
      case (state)
        IDLE: begin
          if (memwrite == 1) state <= WRITING;
          else state <= READING;
          // Storing all inputs before transmission
          addr_reg <= addr;
          memwrite_reg <= memwrite;
          sclk_flag <= 0;
          target <= TFAULT;

          // == SRAM ==================================
          if (addr >= SRAM_LOW_ADDR && addr <= SRAM_HIGH_ADDR) begin
            target <= SRAM;
            datain_reg <= {datain[7:0], datain[15:8], datain[23:16], datain[31:24]};

            // == GPIO ==================================
          end else if (addr == GPIO_OUT_ADDR) begin
            target <= GPIO;
            state  <= GPIO_WAIT;

            if (memwrite) gpio_out <= datain[3:0];
            else begin
              // Set to a defined value, just in case
              dataout <= 0;
              state   <= FAULT;
            end
          end else if (addr == GPIO_IN_ADDR) begin
            target <= GPIO;
            state  <= GPIO_WAIT;

            if (~memwrite) dataout <= {28'b0, gpio_in_sync};
            else state <= FAULT;

            // == UART ==================================
          end else if (addr == UART_TX_ADDR) begin
            if (memwrite) begin
              target <= UART;
              datain_reg <= datain;
              uart_tx_en <= 1;
            end else state <= FAULT;  // Reading from UART not possible here

            // == I2C device ==================================
          end else if (addr == I2C_DEVICE_ADDR) begin
            datain_reg <= datain;
            state <= CONTROL_REG;
            target <= CONTROL;

            // == I2C data ==================================
          end else if (addr == I2C_DATA_ADDR) begin
            datain_reg <= datain;
            target <= I2C;

            // == Control registers ==================================
          end else if (addr >= I2C_MASK_ADDR && addr <= SCL_RATIO_ADDR) begin
            datain_reg <= datain;
            state <= CONTROL_REG;
            target <= CONTROL;

            // == Load Access Fault ==================================
          end else state <= FAULT;
        end

        READING: begin
          if (master_busy) sclk_flag <= 1;

          // Master became busy (sclk_flag) and is now finished
          if (sclk_flag && ~master_busy) begin
            state <= VALID;

            if (target == SRAM) begin
              case (funct3)
                FUNCT3_MEM_B: dataout <= {24'b0, master_dataout[31:24]};

                FUNCT3_LBU: dataout <= {{24{master_dataout[31]}}, master_dataout[31:24]};

                FUNCT3_MEM_H: dataout <= {16'b0, master_dataout[23:16], master_dataout[31:24]};

                FUNCT3_LHU:
                dataout <= {{16{master_dataout[23]}}, master_dataout[23:16], master_dataout[31:24]};

                default:
                dataout <= {
                  master_dataout[7:0],
                  master_dataout[15:8],
                  master_dataout[23:16],
                  master_dataout[31:24]
                };
              endcase
            end else dataout <= master_dataout;
          end
        end

        WRITING: begin
          // HACK: Das mit uart_en is net schön gelöst
          if (master_busy) begin
            sclk_flag <= 1;
            if (target == UART) uart_tx_en <= 0;
          end

          // Master became busy (sclk_flag) and is now finished
          if (sclk_flag && ~master_busy) state <= FINISH;
        end

        GPIO_WAIT: state <= FINISH;
        CONTROL_REG: begin
          state <= FINISH;
          if (memwrite) begin
            case (addr_reg)
              I2C_DEVICE_ADDR:     i2c_addr <= datain_reg[6:0];
              I2C_MASK_ADDR:       i2c_mask <= datain_reg[3:0];
              MTIME_ADDR:          mtime[31:0] <= datain_reg;
              MTIMEH_ADDR:         mtime[63:32] <= datain_reg;
              MTIMECMP_ADDR:       mtimecmp[31:0] <= datain_reg;
              MTIMECMPH_ADDR:      mtimecmp[63:32] <= datain_reg;
              FREQ_STATUS_ADDR:    freq_status[1:0] <= datain_reg[1:0];
              FREQ_OSR_FC_ADDR:    osr_fc_reg <= datain_reg;
              FREQ_LO_DIV_ADDR:    ds_lo_conf <= datain_reg[4:0];
              UART_RX_STATUS_ADDR: uart_rx_status[0] <= datain_reg[0];
              // UART_RX_DATA_ADDR: lo_reg <= datain_reg[2:0];
              UART_RX_CPB_ADDR:    uart_rx_cpb <= datain_reg[15:0];
              UART_TX_CPB_ADDR:    uart_tx_cpb <= datain_reg[15:0];
              SCL_RATIO_ADDR:      scl_ratio <= datain_reg[15:0];
            endcase
          end else begin
            case (addr_reg)
              I2C_DEVICE_ADDR:     dataout <= {25'b0, i2c_addr};
              I2C_MASK_ADDR:       dataout <= {28'b0, i2c_mask};
              I2C_ACK_ADDR:        dataout <= {27'b0, i2c_acks};
              MTIME_ADDR:          dataout <= mtime[31:0];
              MTIMEH_ADDR:         dataout <= mtime[63:32];
              MTIMECMP_ADDR:       dataout <= mtimecmp[31:0];
              MTIMECMPH_ADDR:      dataout <= mtimecmp[63:32];
              FREQ_STATUS_ADDR:    dataout <= {29'b0, freq_status};
              FREQ_OSR_FC_ADDR:    dataout <= osr_fc_reg;
              FREQ_LO_DIV_ADDR:    dataout <= {27'b0, ds_lo_conf};
              UART_RX_STATUS_ADDR: dataout <= {29'b0, uart_rx_status};
              UART_RX_DATA_ADDR:   dataout <= {24'b0, uart_rx_data};
              UART_RX_CPB_ADDR:    dataout <= {16'b0, uart_rx_cpb};
              UART_TX_CPB_ADDR:    dataout <= {16'b0, uart_tx_cpb};
              SCL_RATIO_ADDR:      dataout <= {16'b0, scl_ratio};
            endcase
          end
        end
        VALID:     state <= VALID;
        FINISH:    state <= FINISH;
        FAULT:     state <= FAULT;
      endcase  // unique case (state)
    end
  end

  always_comb begin
    master_dataout = sram_dataout;
    master_busy = sram_busy;

    if (target == I2C) begin
      master_dataout = i2c_dataout;
      master_busy = i2c_busy;
    end else if (target == UART) begin
      master_busy = uart_tx_busy;
    end
  end

  assign busy = (state == READING || state == WRITING || state == GPIO_WAIT || state == CONTROL_REG) ? 1'b1 : 1'b0;
  assign valid = (state == VALID) ? 1'b1 : 1'b0;

  // reset master if not doing anything
  assign master_reset = (state == READING || state == WRITING) ? 1'b0 : 1'b1;

  assign i2c_req = (target == I2C) ? master_reset : 1;
  assign sram_req = (target == SRAM) ? master_reset : 1;

  assign intr_timer = ($unsigned(mtime) >= $unsigned(mtimecmp)) ? 1 : 0;
  assign load_access_fault = (state == FAULT) ? 1 : 0;
endmodule  // memory
