module spi_master (
    input logic clk,
    input logic reset,  // reset should be held high if not in use
    input logic req,

    input  logic so,
    output logic si,
    output logic sclk,  // clk exported to the SRAM
    output logic ce,    // ce signal to enable the SRAM (active high on pico ice, low on its own)

    input  logic [23:0] addr,
    input  logic [31:0] data_in,
    input  logic [ 1:0] byte_mask,  // Amount of bytes to send/read
    output logic [31:0] data_out,

    input  logic write,
    output logic busy,
    output logic valid
);

  // The state machine according to the SRAM specifiation is the following:
  // Write: SEND_COMMAND, SEND_ADDR, SEND_DATA
  // Read: SEND_COMMAND, SEND_ADDR, WAITING (1 sclk cycle), RECV_DATA
  typedef enum {
    RESET,
    SEND_COMMAND,
    SEND_ADDR,
    WAITING,
    RECV_DATA,
    SEND_DATA,
    VALID
  } states_t;
  states_t state;

  // The mode is stored internally because we do not want it to change
  // while talking to the SRAM. The initial command determines the behavior
  // of the SRAM. Changing read/write during operation will corrupt the state
  logic    write_reg;

  localparam logic [7:0] SPI_WRITE_CMD = 8'h02;
  localparam logic [7:0] SPI_READ_CMD = 8'h03;

  byte index;
  byte end_index;

  logic [1:0] clk_counter;
  logic posedge_trigger;
  logic negedge_trigger;

  always_ff @(posedge clk) begin : clock_generator
    clk_counter <= clk_counter + 1;
    posedge_trigger <= 1'b0;
    negedge_trigger <= 1'b0;

    if (clk_counter[0] == 0) posedge_trigger <= 1;
    else negedge_trigger <= 1;

    if (reset == 0) begin
      clk_counter <= 0;
    end
  end
  // State transistions (delta)
  always_ff @(posedge clk) begin
    if (posedge_trigger) begin  // == posedge of sclk (we set it to 1 in the same cycle)
      sclk <= 1;

      case (state)

        SEND_COMMAND: begin
          if (index == 0) begin
            state <= SEND_ADDR;
            index <= 23;
          end else index <= index - 1;
        end

        SEND_ADDR: begin
          if (index == 0) begin  // 0 is last valid index
            if (write_reg == 1'b1) state <= SEND_DATA;
            else state <= WAITING;

            index <= 31;
          end else index <= index - 1;
        end

        WAITING: state <= RECV_DATA;

        RECV_DATA: begin
          if (index == end_index) begin
            state <= VALID;
          end else index <= index - 1;
        end

        SEND_DATA: begin
          if (index == end_index) begin
            state <= VALID;
          end else index <= index - 1;
        end

        default: state <= (state == VALID) ? VALID : RESET;
      endcase
    end else if (negedge_trigger) begin  // == negedge of sclk. Setting si here so it's stable on posedge
      sclk <= 0;

      case (state)
        RESET: begin
          write_reg <= write;
          state <= SEND_COMMAND;
          index <= 7;
          ce <= 1'b1;
        end
        SEND_COMMAND: si <= (write_reg) ? SPI_WRITE_CMD[index[2:0]] : SPI_READ_CMD[index[2:0]];
        RECV_DATA: begin
          data_out[index[4:0]] <= so;
        end

        SEND_ADDR: si <= addr[index[4:0]];
        SEND_DATA: si <= data_in[index[4:0]];
        VALID: ce <= 1'b0;
      endcase
    end

    if (req == 1) begin  // active low
      state <= RESET;
      ce <= 1'b0;
      si <= 1'b0;
    end

    if (reset == 0) begin
      write_reg <= 0;
      state <= RESET;
      ce <= 1'b0;
      index <= 7;
      data_out <= 32'd0;
    end
  end

  // Set outputs according to state (lambda)
  always_comb begin
    case (state)
      RESET: begin
        busy  = 0;
        valid = 0;
      end

      VALID: begin
        valid = 1;
        busy  = 0;
      end
      default: begin
        busy  = 1;
        valid = 0;
      end
    endcase

    case (byte_mask)
      2'b00: end_index = 24;
      2'b01: end_index = 16;

      default: end_index = 0;
    endcase
  end

endmodule  // spi_master
