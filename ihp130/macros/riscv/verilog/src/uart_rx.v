//
// Module: uart_rx (taken from https://github.com/ben-marshall/uart)
//
// Notes:
// - UART reciever module.
//

module uart_rx (
    input  wire        clk,            // Top level system clock input.
    input  wire        resetn,         // Asynchronous active low reset.
    input  wire        uart_rxd,       // UART Recieve pin.
    input  wire        uart_rx_en,     // Recieve enable
    output wire        uart_rx_break,  // Did we get a BREAK message?
    output wire        uart_rx_valid,  // Valid data recieved and available.
    output reg  [ 7:0] uart_rx_data,   // The recieved data.
    input  wire [15:0] CYCLES_PER_BIT
);

  // ---------------------------------------------------------------------------
  // External parameters.
  //

  //
  // Input bit rate of the UART line.
  // localparam BIT_P = 1_000_000_000 * 1 / BAUD;  // nanoseconds

  // //
  // // Clock frequency in hertz.
  // localparam CLK_P = 1_000_000_000 * 1 / CLK_FREQ;  // nanoseconds

  //
  // Number of data bits recieved per UART packet.

  //
  // Number of stop bits indicating the end of a packet.
  // localparam STOP_BITS = 1;

  // --------------------------------------------------------------------------
  // Internal parameters.
  //

  //
  // Number of clock cycles per uart bit.
  // localparam CYCLES_PER_BIT = BIT_P / CLK_P;

  //
  // Size of the registers which store sample counts and bit durations.
  // localparam COUNT_REG_LEN = 1 + $clog2(CYCLES_PER_BIT);
  localparam COUNT_REG_LEN = 16;

  // --------------------------------------------------------------------------
  // Internal registers.
  //

  //
  // Internally latched value of the uart_rxd line. Helps break long timing
  // paths from input pins into the logic.
  reg rxd_reg;
  reg rxd_reg_0;

  //
  // Storage for the recieved serial data.
  reg [7:0] recieved_data;

  //
  // Counter for the number of cycles over a packet bit.
  reg [COUNT_REG_LEN-1:0] cycle_counter;

  //
  // Counter for the number of recieved bits of the packet.
  reg [3:0] bit_counter;

  //
  // Sample of the UART input line whenever we are in the middle of a bit frame.
  reg bit_sample;

  //
  // Current and next states of the internal FSM.
  reg [2:0] fsm_state;
  reg [2:0] n_fsm_state;

  localparam FSM_IDLE = 0;
  localparam FSM_START = 1;
  localparam FSM_RECV = 2;
  localparam FSM_STOP = 3;

  // ---------------------------------------------------------------------------
  // Output assignment
  //

  assign uart_rx_break = uart_rx_valid && ~|recieved_data;
  assign uart_rx_valid = fsm_state == FSM_STOP && n_fsm_state == FSM_IDLE;

  always @(posedge clk) begin
    if (!resetn) begin
      uart_rx_data <= 8'b0;
    end else if (fsm_state == FSM_STOP) begin
      uart_rx_data <= recieved_data;
    end
  end

  // ---------------------------------------------------------------------------
  // FSM next state selection.
  //

  wire next_bit     = cycle_counter == CYCLES_PER_BIT ||
                        fsm_state       == FSM_STOP &&
                        cycle_counter   == {1'b0, CYCLES_PER_BIT[14:0]};
  wire payload_done = bit_counter == 8;

  //
  // Handle picking the next state.
  always @(*) begin : p_n_fsm_state
    case (fsm_state)
      FSM_IDLE:  n_fsm_state = rxd_reg ? FSM_IDLE : FSM_START;
      FSM_START: n_fsm_state = next_bit ? FSM_RECV : FSM_START;
      FSM_RECV:  n_fsm_state = payload_done ? FSM_STOP : FSM_RECV;
      FSM_STOP:  n_fsm_state = next_bit ? FSM_IDLE : FSM_STOP;
      default:   n_fsm_state = FSM_IDLE;
    endcase
  end

  // ---------------------------------------------------------------------------
  // Internal register setting and re-setting.
  //

  //
  // Handle updates to the recieved data register.
  always @(posedge clk) begin : p_recieved_data
    if (!resetn) begin
      recieved_data <= 8'b0;
    end else if (fsm_state == FSM_IDLE) begin
      recieved_data <= 8'b0;
    end else if (fsm_state == FSM_RECV && next_bit) begin
      recieved_data[7] <= bit_sample;
      recieved_data[0] <= recieved_data[1];
      recieved_data[1] <= recieved_data[2];
      recieved_data[2] <= recieved_data[3];
      recieved_data[3] <= recieved_data[4];
      recieved_data[4] <= recieved_data[5];
      recieved_data[5] <= recieved_data[6];
      recieved_data[6] <= recieved_data[7];
    end
  end

  /* verilator lint_off WIDTHTRUNC */
  //
  // Increments the bit counter when recieving.
  always @(posedge clk) begin : p_bit_counter
    if (!resetn) begin
      bit_counter <= 4'b0;
    end else if (fsm_state != FSM_RECV) begin
      bit_counter <= {COUNT_REG_LEN{1'b0}};
    end else if (fsm_state == FSM_RECV && next_bit) begin
      bit_counter <= bit_counter + 1'b1;
    end
  end
  /* verilator lint_on WIDTHTRUNC */

  //
  // Sample the recieved bit when in the middle of a bit frame.
  always @(posedge clk) begin : p_bit_sample
    if (!resetn) begin
      bit_sample <= 1'b0;
    end else if (cycle_counter == {1'b0, CYCLES_PER_BIT[14:0]}) begin
      bit_sample <= rxd_reg;
    end
  end


  //
  // Increments the cycle counter when recieving.
  always @(posedge clk) begin : p_cycle_counter
    if (!resetn) begin
      cycle_counter <= {COUNT_REG_LEN{1'b0}};
    end else if (next_bit) begin
      cycle_counter <= {COUNT_REG_LEN{1'b0}};
    end else if (fsm_state == FSM_START || fsm_state == FSM_RECV || fsm_state == FSM_STOP) begin
      cycle_counter <= cycle_counter + 1'b1;
    end
  end


  //
  // Progresses the next FSM state.
  always @(posedge clk) begin : p_fsm_state
    if (!resetn) begin
      fsm_state <= FSM_IDLE;
    end else begin
      fsm_state <= n_fsm_state;
    end
  end


  //
  // Responsible for updating the internal value of the rxd_reg.
  always @(posedge clk) begin : p_rxd_reg
    if (!resetn) begin
      rxd_reg   <= 1'b1;
      rxd_reg_0 <= 1'b1;
    end else if (uart_rx_en) begin
      rxd_reg   <= rxd_reg_0;
      rxd_reg_0 <= uart_rxd;
    end
  end


endmodule
