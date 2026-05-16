// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

// Memory Map:
// GPIO_OUT_ADDR :       0x00800000;
// GPIO_IN_ADDR :        0x00800001;
// UART_TX_ADDR :        0x00800002;
// I2C_DEVICE_ADDR :     0x00800003;
// I2C_DATA_ADDR :       0x00800004;
// I2C_MASK_ADDR :       0x00800005;
// I2C_ACK_ADDR :        0x00800006;
// MTIME_ADDR :          0x00800008;
// MTIMEH_ADDR :         0x0080000C;
// MTIMECMP_ADDR :       0x00800010;
// MTIMECMPH_ADDR :      0x00800014;
// FREQ_STATUS_ADDR :    0x00800018;
// FREQ_OSR_FC_ADDR :    0x0080001C;
// FREQ_LO_DIV_ADDR :    0x00800020;
// UART_RX_STATUS_ADDR : 0x00800021;
// UART_RX_DATA_ADDR :   0x00800022;
// UART_RX_CPB_ADDR :    0x00800024;
// UART_TX_CPB_ADDR :    0x00800028;
// SCL_RATIO_ADDR :      0x0080002C;
// CORDIC_I_ADDR :       0x00800030;
// CORDIC_Q_ADDR :       0x00800034;
// DSMOD_DEFAULTS_ADDR : 0x00800038;
// I2C_MC_ENABLED_ADDR : 0x0080003C;
// I2C_MC_SUBADDR_ADDR : 0x00800040;
// I2C_MC_SUBLEN_ADDR :  0x00800044;
// I2C_MC_BYTELEN_ADDR : 0x00800048;
// I2C_MC_REQ_ADDR :     0x0080004C;
// I2C_MC_WRITE_ADDR :   0x00800050;
// I2C_MC_DATAIN_ADDR :  0x00800054;
// I2C_MC_DATAOUT_ADDR : 0x00800058;
// I2C_MC_STATUS_ADDR :  0x0080005C;
// I2C_MC_NEXT_RD_ADDR : 0x00800060;
// I2C_MC_STOP_ADDR :    0x00800064;
// I2C_MC_CONT_RD_ADDR : 0x00800068;
// 0x00800069 - end: throws a load_access_fault (store_acces_fault not implemented)

module memory #(
    parameter int CLK_FREQ,
    parameter int BAUD
) (
    input logic clk,
    input logic reset,
    input logic ce,     // active low

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
    output logic analog_en,
    output logic I_ae,
    output logic ds_I_oe,
    input  logic ds_I_p_i,
    output logic ds_I_p_o,
    input  logic ds_I_n_i,
    output logic ds_I_n_o,
    output logic lo_I_oe,
    input  logic lo_I_i,
    output logic lo_I_o,
    input  logic lo_Ix_i,
    output logic lo_Ix_o,
    input  logic lo_Qx_i,
    output logic lo_Qx_o,
    input  logic lo_Q_i,
    output logic lo_Q_o,
    output logic lo_Q_oe,
    input  logic ds_Q_n_i,
    output logic ds_Q_n_o,
    input  logic ds_Q_p_i,
    output logic ds_Q_p_o,
    output logic ds_Q_oe,
    output logic Q_ae,

    output logic intr_timer,
    output logic load_access_fault
);

`ifndef SIM
`ifdef FPGA
  `include "../rtl/constants.sv"
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
  localparam int CORDIC_I_ADDR =       32'h00800030;
  localparam int CORDIC_Q_ADDR =       32'h00800034;
  localparam int DSMOD_DEFAULTS_ADDR = 32'h00800038;

  // Second I2C master
  localparam int I2C_MC_ENABLED_ADDR = 32'h0080003C;
  localparam int I2C_MC_SUBADDR_ADDR = 32'h00800040;
  localparam int I2C_MC_SUBLEN_ADDR =  32'h00800044;
  localparam int I2C_MC_BYTELEN_ADDR = 32'h00800048;
  localparam int I2C_MC_REQ_ADDR =     32'h0080004C;
  localparam int I2C_MC_WRITE_ADDR =   32'h00800050;
  localparam int I2C_MC_DATAIN_ADDR =  32'h00800054;
  localparam int I2C_MC_DATAOUT_ADDR = 32'h00800058;
  localparam int I2C_MC_STATUS_ADDR =  32'h0080005C;
  localparam int I2C_MC_NEXT_RD_ADDR = 32'h00800060;
  localparam int I2C_MC_STOP_ADDR =    32'h00800064;
  localparam int I2C_MC_CONT_RD_ADDR = 32'h00800068;
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

  /* verilator lint_off UNUSEDSIGNAL */
  logic sram_busy, sram_valid;
  logic i2c_req, i2c_busy, i2c_valid;
  /* verilator lint_on UNUSEDSIGNAL */
  logic [6:0] i2c_addr;
  logic [3:0] i2c_mask;

  logic [31:0] master_dataout, sram_dataout, i2c_dataout;

  logic [3:0] gpio_in_sync;

  // This ensures that the spi_master actually started working
  // Otherwise we would assume it has finished before it began
  logic sclk_flag;

  logic sram_req;
  spi_master sram_master (
      .clk(clk),
      .reset(reset),
      .req(sram_req),
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
  logic i2c_scl, i2c_sda_o, i2c_sda_oe;
  i2c_master i2c_master (
      .clk(clk),
      .reset(reset),
      .req(i2c_req),
      .scl_ratio(scl_ratio - 1),
      .sda_i(sda_i),
      .sda_o(i2c_sda_o),
      .sda_oe(i2c_sda_oe),
      .scl(i2c_scl),
      .device_addr(i2c_addr),
      .mask(i2c_mask),
      .data_in(datain_reg),
      .data_out(i2c_dataout),
      .write(memwrite_reg),
      .busy(i2c_busy),
      .valid(i2c_valid),
      .acks(i2c_acks)
  );

  logic        i2c_mc_enabled;  // MMIO
  logic [15:0] i2c_mc_subaddr;  // MMIO
  logic [ 1:0] i2c_mc_sublen_addr;  // MMIO
  logic [23:0] i2c_mc_bytelen;  // MMIO
  logic        i2c_mc_req_trans;  // MMIO
  logic        i2c_mc_write;  // MMIO
  logic [ 7:0] i2c_mc_datain;  // MMIO
  logic [ 7:0] i2c_mc_dataout;  // MMIO

  logic        i2c_mc_scl;
  logic        i2c_mc_sda_o;
  logic        i2c_mc_sda_oe;

  // Status register
  // byte_ready | nack | busy | req_chunk | valid
  logic [ 4:0] i2c_mc_status;  // MMIO
  logic        i2c_mc_next_chunk_ready;  // MMIO
  logic        i2c_mc_force_stop;  // MMIO
  logic        i2c_mc_read_next;  // MMIO
  i2c_master_mc i2c_master_mc (
      .i_clk(clk),
      .reset_n(reset),
      .clock_division(scl_ratio),
      .i_addr_w_rw({i2c_addr, i2c_mc_write}),
      .i_sub_addr(i2c_mc_subaddr),
      .i_sub_len(i2c_mc_sublen_addr[1]),
      .i_byte_len(i2c_mc_bytelen),
      .i_data_write(i2c_mc_datain),
      .req_trans(i2c_mc_req_trans),
      .next_chunk_ready(i2c_mc_next_chunk_ready),
      .force_stop(i2c_mc_force_stop),
      .read_next_byte(i2c_mc_read_next),
      .use_subaddr(i2c_mc_sublen_addr[0]),

      .data_out(i2c_mc_dataout),
      .valid_out(i2c_mc_status[0]),
      .byte_ready(i2c_mc_status[4]),
      .scl_o(i2c_mc_scl),
      .sda_i(sda_i),
      .sda_o(i2c_mc_sda_o),
      .sda_oe(i2c_mc_sda_oe),
      .req_data_chunk(i2c_mc_status[1]),
      .busy(i2c_mc_status[2]),
      .nack(i2c_mc_status[3])
  );

  assign scl = (i2c_mc_enabled) ? i2c_mc_scl : i2c_scl;
  assign sda_o = (i2c_mc_enabled) ? i2c_mc_sda_o : i2c_sda_o;
  assign sda_oe = (i2c_mc_enabled) ? i2c_mc_sda_oe : i2c_sda_oe;

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

  // I_ae | Q_ae | ds_I_oe | ds_Q_oe
  // lo_oe | active | start | reset_n
  logic [ 7:0] freq_status;
  logic [31:0] osr_fc_reg;

  //     7     |    6      |    5    |    4   | 3  ...   0
  // ds_switch | ds_invert | ds_mode | lo_dbg | lo_div_sel
  logic [ 7:0] ds_lo_conf;

  //     7     |     6     |     5     |     4
  // ds_I_p_set| ds_I_n_set| ds_Q_p_set| ds_Q_n_set
  //     3     |     2     |     1     |     0
  // ds_I_p_val| ds_I_n_val| ds_Q_p_val| ds_Q_n_val
  logic [ 7:0] ds_defaults;
  logic ds_I_p, ds_I_n, ds_Q_p, ds_Q_n;
  logic ds_I_p_out, ds_I_n_out, ds_Q_p_out, ds_Q_n_out;
  logic lo_I, lo_Q, lo_Ix, lo_Qx;

  logic [29:0] cordic_I;
  logic [29:0] cordic_Q;
  freq_generator freq_inst (
      .clk(clk),
      .reset_n(freq_status[0]),
      .f_c(osr_fc_reg[29:0]),
      .osr_level(osr_fc_reg[31:30]),
      .lo_div_sel(ds_lo_conf[4:0]),
      .ds_mode(ds_lo_conf[5]),
      .ds_invert(ds_lo_conf[6]),
      .ds_switch(ds_lo_conf[7]),
      .cordic_I(cordic_I),
      .cordic_Q(cordic_Q),
      .start(freq_status[1]),

      .active(freq_status[2]),
      .ds_I_p_o(ds_I_p_out),
      .ds_I_n_o(ds_I_n_out),
      .ds_Q_p_o(ds_Q_p_out),
      .ds_Q_n_o(ds_Q_n_out),
      .lo_i(lo_I),
      .lo_q(lo_Q),
      .lo_ix(lo_Ix),
      .lo_qx(lo_Qx)
  );


  // Assign analog enable output
  // When analog_en = 1 (default): The analog front-end (e.g., MFB Filter and mixer) is enabled and can be used for transmitting.
  assign analog_en = freq_status[7];

  // Assign output enables for bidir pins
  // Between the RISC-V CPU outputs (ds_Q_p_o, ds_Q_n_o, ds_I_p_o and ds_I_n_o) and four analog pads, there are SPDT switches, where the output is connected to the IQ-Modulator.
  // These switches can be controlled by the RISC-V CPU signals (I_ae and Q_ae) to select whether the RISC-V outputs or the analog pad inputs are connected to the IQ-Modulator.
  // When _ae = 1:
  // - The SPDT switch connects the analog pad inputs to the IQ-Modulator.
  // - This enables the use of external analog signals (e.g., from an AWG), which can be useful for testing the IQ-Modulator without the RISC-V CPU.
  // When _ae = 0 (default):
  // - The SPDT switch connects the RISC-V outputs to the IQ-Modulator.
  // - In this case, the RISC-V outputs drive the IQ-Modulator.
  assign I_ae = freq_status[6];
  assign Q_ae = freq_status[5];

  // Debugging
  // When _oe = 1 (default):
  // - Pass signal_o to bidir_out & to pad (output mode)
  // - In this case, the RISC-V outputs drive the IQ-Modulator and are connected to the corrsponding pads for debugging.
  // When _oe = 0:
  // - Pass bidir_in (pad input) to bidir_out (input mode)
  // - In this case, the pad can be used as a debugging input instead of the RISC-V outputs (e.g., for testing the IQ-Modulator without the RISC-V CPU).
  assign ds_I_oe = freq_status[4];
  assign ds_Q_oe = freq_status[4];
  assign lo_I_oe = freq_status[3];
  assign lo_Q_oe = freq_status[3];

  // ds_I_p / ds_I_n
  assign ds_I_p_o = ds_I_oe ? ds_I_p : ds_I_p_i;
  assign ds_I_n_o = ds_I_oe ? ds_I_n : ds_I_n_i;

  // ds_Q_p / ds_Q_n
  assign ds_Q_p_o = ds_Q_oe ? ds_Q_p : ds_Q_p_i;
  assign ds_Q_n_o = ds_Q_oe ? ds_Q_n : ds_Q_n_i;

  // lo_I / lo_Ix
  assign lo_I_o = lo_I_oe ? lo_I : lo_I_i;
  assign lo_Ix_o = lo_I_oe ? lo_Ix : lo_Ix_i;

  // lo_Q / lo_Qx
  assign lo_Q_o = lo_Q_oe ? lo_Q : lo_Q_i;
  assign lo_Qx_o = lo_Q_oe ? lo_Qx : lo_Qx_i;

  // Assign configured default values to dsmod outputs
  // This allows the user to deactivate specific outputs
  // while still using others as usual
  assign ds_I_p = (ds_defaults[7]) ? ds_defaults[3] : ds_I_p_out;
  assign ds_I_n = (ds_defaults[6]) ? ds_defaults[2] : ds_I_n_out;
  assign ds_Q_p = (ds_defaults[5]) ? ds_defaults[1] : ds_Q_p_out;
  assign ds_Q_n = (ds_defaults[4]) ? ds_defaults[0] : ds_Q_n_out;

  always_ff @(posedge clk) begin
    mtime <= mtime + 1;

    // Avoiding metastability
    gpio_in_sync <= gpio_in;

    if (reset == 0) begin
      state <= IDLE;
      uart_tx_en <= 0;
      mtime <= 0;
      mtimecmp <= 0;

      // freq_status[2] is driven by the frequency module
      freq_status[7] <= 1'b1;  // enable analog front-end
      freq_status[6:5] <= 2'b11;  // disable external analog input
      freq_status[4:3] <= 2'b00;  // enable outputs
      freq_status[1:0] <= 2'b00;  // disable transmission and reset the module

      // Set cordic defaults
      // Full Amplitude
      cordic_I <= 30'b010011011011101001011110001101;
      // Half Amplitude
      // cordic_I <= 30'd163007430;
      cordic_Q <= 30'b000000000000000000000000000000;

      gpio_out <= 4'd0;
      gpio_in_sync <= 4'd0;
      uart_rx_status[0] <= 1'b0;
      osr_fc_reg <= 32'd76450417;  // OSR 32 and 124.6 kHz @ 56 MHz
      uart_tx_cpb <= CYCLES_PER_BIT_DEFAULT;
      uart_rx_cpb <= CYCLES_PER_BIT_DEFAULT;
      scl_ratio <= SCL_RATIO_DEFAULT[15:0];
      sclk_flag <= 0;
      i2c_mask <= 4'b1111;
      i2c_addr <= 7'b0;
      ds_lo_conf <= 8'b00000000;
      ds_defaults <= 8'b00000000;
      state <= IDLE;
      target <= SRAM;

      i2c_mc_enabled <= 1'b0;
      i2c_mc_subaddr <= 16'b0;
      i2c_mc_sublen_addr <= 2'b00;
      i2c_mc_bytelen <= 24'd1;
      i2c_mc_req_trans <= 1'b0;
      i2c_mc_datain <= 8'b0;
      i2c_mc_next_chunk_ready <= 1'b0;
      i2c_mc_force_stop <= 1'b0;
      i2c_mc_read_next <= 1'b0;
    end else if (ce) begin
      // NOTE: Uncomment the line below to enable permanent frequency generation without involving the CPU.
      // The reset logic above already resets the freq_generator, so this assigment will be executed when the CPU
      // tries to read its first instruction. Setting [1:0] to 11 disables the reset and start the frequency generation.
      // The default Cordic values defined in the reset logic of the freq_generator will be used. Be sure to change them according
      // to your needs!
      // freq_status[1:0] <= 2'b11;

      state <= IDLE;
      uart_tx_en <= 0;
    end else begin
      // Reset ready back to 0 if the master module accepted our data
      i2c_mc_next_chunk_ready <= i2c_mc_next_chunk_ready & i2c_mc_status[1];

      // Same for reading
      i2c_mc_read_next <= i2c_mc_read_next & i2c_mc_status[4];

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
          /* verilator lint_off UNSIGNED */
          if (addr >= SRAM_LOW_ADDR && addr <= SRAM_HIGH_ADDR) begin
            target <= SRAM;
            datain_reg <= {datain[7:0], datain[15:8], datain[23:16], datain[31:24]};
            /* verilator lint_on UNSIGNED */

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
          end else if (addr >= I2C_MASK_ADDR && addr <= I2C_MC_CONT_RD_ADDR) begin
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
                FUNCT3_LBU: dataout <= {24'b0, master_dataout[31:24]};

                FUNCT3_MEM_B: dataout <= {{24{master_dataout[31]}}, master_dataout[31:24]};

                FUNCT3_LHU: dataout <= {16'b0, master_dataout[23:16], master_dataout[31:24]};

                FUNCT3_MEM_H:
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
              FREQ_STATUS_ADDR: begin
                freq_status[1:0] <= datain_reg[1:0];
                freq_status[7:3] <= datain_reg[7:3];
              end
              FREQ_OSR_FC_ADDR:    osr_fc_reg <= datain_reg;
              FREQ_LO_DIV_ADDR:    ds_lo_conf <= datain_reg[7:0];
              UART_RX_STATUS_ADDR: uart_rx_status[0] <= datain_reg[0];
              // UART_RX_DATA_ADDR: lo_reg <= datain_reg[2:0];
              UART_RX_CPB_ADDR:    uart_rx_cpb <= datain_reg[15:0];
              UART_TX_CPB_ADDR:    uart_tx_cpb <= datain_reg[15:0];
              SCL_RATIO_ADDR:      scl_ratio <= datain_reg[15:0];
              CORDIC_I_ADDR:       cordic_I <= datain_reg[29:0];
              CORDIC_Q_ADDR:       cordic_Q <= datain_reg[29:0];
              DSMOD_DEFAULTS_ADDR: ds_defaults <= datain_reg[7:0];
              I2C_MC_ENABLED_ADDR: i2c_mc_enabled <= datain_reg[0];
              I2C_MC_SUBADDR_ADDR: i2c_mc_subaddr <= datain_reg[15:0];
              I2C_MC_SUBLEN_ADDR:  i2c_mc_sublen_addr <= datain_reg[1:0];
              I2C_MC_BYTELEN_ADDR: i2c_mc_bytelen <= datain_reg[23:0];
              I2C_MC_REQ_ADDR:     i2c_mc_req_trans <= datain_reg[0];
              I2C_MC_WRITE_ADDR:   i2c_mc_write <= datain_reg[0];
              I2C_MC_DATAIN_ADDR:  i2c_mc_datain <= datain_reg[7:0];
              I2C_MC_NEXT_RD_ADDR: i2c_mc_next_chunk_ready <= datain_reg[0];
              I2C_MC_STOP_ADDR:    i2c_mc_force_stop <= datain_reg[0];
              I2C_MC_CONT_RD_ADDR: i2c_mc_read_next <= datain_reg[0];
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
              FREQ_STATUS_ADDR:    dataout <= {24'b0, freq_status};
              FREQ_OSR_FC_ADDR:    dataout <= osr_fc_reg;
              FREQ_LO_DIV_ADDR:    dataout <= {24'b0, ds_lo_conf};
              UART_RX_STATUS_ADDR: dataout <= {29'b0, uart_rx_status};
              UART_RX_DATA_ADDR:   dataout <= {24'b0, uart_rx_data};
              UART_RX_CPB_ADDR:    dataout <= {16'b0, uart_rx_cpb};
              UART_TX_CPB_ADDR:    dataout <= {16'b0, uart_tx_cpb};
              SCL_RATIO_ADDR:      dataout <= {16'b0, scl_ratio};
              CORDIC_I_ADDR:       dataout <= {2'b0, cordic_I};
              CORDIC_Q_ADDR:       dataout <= {2'b0, cordic_Q};
              DSMOD_DEFAULTS_ADDR: dataout <= {24'b0, ds_defaults};
              I2C_MC_ENABLED_ADDR: dataout <= {31'b0, i2c_mc_enabled};
              I2C_MC_SUBADDR_ADDR: dataout <= {16'b0, i2c_mc_subaddr};
              I2C_MC_SUBLEN_ADDR:  dataout <= {30'b0, i2c_mc_sublen_addr};
              I2C_MC_BYTELEN_ADDR: dataout <= {8'b0, i2c_mc_bytelen};
              I2C_MC_REQ_ADDR:     dataout <= {31'b0, i2c_mc_req_trans};
              I2C_MC_WRITE_ADDR:   dataout <= {31'b0, i2c_mc_write};
              I2C_MC_DATAOUT_ADDR: dataout <= {24'b0, i2c_mc_dataout};
              I2C_MC_STATUS_ADDR:  dataout <= {27'b0, i2c_mc_status};
              I2C_MC_NEXT_RD_ADDR: dataout <= {31'b0, i2c_mc_next_chunk_ready};
              I2C_MC_STOP_ADDR:    dataout <= {31'b0, i2c_mc_force_stop};
              I2C_MC_CONT_RD_ADDR: dataout <= {31'b0, i2c_mc_read_next};
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
