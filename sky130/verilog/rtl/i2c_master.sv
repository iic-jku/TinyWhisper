module i2c_master (
    input logic clk,
    input logic reset,
    input logic req,
    input logic [15:0] scl_ratio,

    // I2C pins
    input  logic sda_i,
    output logic sda_o,
    output logic sda_oe,
    output logic scl,

    // memory interface
    input  logic [ 3:0] mask,
    input  logic [ 6:0] device_addr,
    input  logic [31:0] data_in,
    output logic [31:0] data_out,

    // status flags
    input logic write,
    output logic busy,
    output logic valid,
    output logic [4:0] acks
);

  typedef enum {
    RESET,
    START,
    SEND_ADDR,

    SEND_CMD,
    RECV_CMD_ACK,

    RECV_FRAME,
    SEND_FRAME_ACK,
    SEND_FRAME,
    RECV_FRAME_ACK,

    STOP,
    END
  } states_t;

  states_t        state;

  logic           scl_reg;
  logic           scl_trigger;
  logic           data_trigger;
  logic           command_trigger;

  logic    [15:0] scl_counter;

  logic    [ 1:0] frame_index;
  logic    [ 1:0] next_frame_index;
  logic           has_next_index;
  logic    [ 7:0] frame;

  logic           sda_i_sync0;
  logic           sda_i_sync1;

  logic    [ 2:0] index;

  always_ff @(posedge clk) begin : scl_trigger_gen
    sda_i_sync0 <= sda_i;
    sda_i_sync1 <= sda_i_sync0;
    // Step clock down to 100 kHz as supported by I2C
    if (scl_counter >= scl_ratio) begin
      scl_counter <= 0;
    end else scl_counter <= scl_counter + 1;

    if (reset == 0 || req == 1) begin
      scl_counter <= 0;
    end
  end


  logic is_sending;
  assign is_sending = (state == START || state == SEND_ADDR || state == SEND_CMD || state == RECV_CMD_ACK || state == RECV_FRAME
                        || state == SEND_FRAME_ACK || state == SEND_FRAME || state == RECV_FRAME_ACK);
  assign scl = scl_reg;
  assign scl_trigger = (scl_counter == scl_ratio);
  assign data_trigger = (is_sending && scl_counter == {1'b0, scl_ratio[15:1]} && scl_reg == 0);
  assign command_trigger = (scl_counter == {1'b0, scl_ratio[15:1]} && scl_reg == 1);

  // Posedge of scl. State transistions
  always_ff @(posedge clk) begin
    if (scl_trigger) begin
      scl_reg <= ~scl_reg;
    end

    if (command_trigger) begin
      case (state)
        RESET: state <= START;

        RECV_FRAME: data_out[frame_index*8+index] <= sda_i_sync1;
        STOP: state <= END;
        END: state <= END;
      endcase
    end

    if (data_trigger) begin
      case (state)
        START: begin
          state <= SEND_ADDR;
          index <= 6;
          data_out <= 32'b0;
        end
        SEND_ADDR: begin
          if (index == 0) begin
            state <= SEND_CMD;
            index <= 7;

            if (mask[3] == 1) frame_index <= 3;
            else if (mask[2] == 1) frame_index <= 2;
            else if (mask[1] == 1) frame_index <= 1;
            else frame_index <= 0;
          end else index <= index - 1;
        end

        SEND_CMD: state <= RECV_CMD_ACK;
        RECV_CMD_ACK: begin
          if (write) state <= SEND_FRAME;
          else state <= RECV_FRAME;
        end

        RECV_FRAME: begin
          if (index == 0) begin
            state <= SEND_FRAME_ACK;
            index <= 7;
          end else index <= index - 1;
        end
        SEND_FRAME_ACK: begin
          state <= STOP;

          if (has_next_index) begin
            frame_index <= next_frame_index;
            state <= RECV_FRAME;
          end
        end

        SEND_FRAME: begin
          if (index == 0) begin
            state <= RECV_FRAME_ACK;
            index <= 7;
          end else index <= index - 1;
        end
        RECV_FRAME_ACK: begin
          state <= STOP;

          if (has_next_index) begin
            frame_index <= next_frame_index;
            state <= SEND_FRAME;
          end
        end
      endcase
    end

    if (reset == 0) begin
      state <= RESET;
      scl_reg <= 1;
      frame_index <= 3;
      index <= 6;
      data_out <= 32'b0;
    end else if (req == 1) begin
      state   <= RESET;
      scl_reg <= 1;
      index   <= 6;
    end
  end

  logic cmd_ack;
  logic [3:0] frame_acks;
  always_ff @(posedge clk) begin
    if (command_trigger) begin
      case (state)
        START: begin
          frame_acks <= 4'b1111;
          cmd_ack <= 1'b1;
        end

        RECV_CMD_ACK:   cmd_ack <= sda_i_sync1;
        RECV_FRAME_ACK: frame_acks[frame_index] <= sda_i_sync1;
      endcase

    end

    if (reset == 0) begin
      frame_acks <= 4'b1111;
      cmd_ack <= 1;
    end
  end

  assign acks = {cmd_ack, frame_acks};

  always_comb begin
    has_next_index   = 0;
    next_frame_index = 3;

    case (frame_index)
      3: begin
        if (mask[2] == 1) begin
          next_frame_index = 2;
          has_next_index   = 1;
        end else if (mask[1] == 1) begin
          next_frame_index = 1;
          has_next_index   = 1;
        end else if (mask[0] == 1) begin
          next_frame_index = 0;
          has_next_index   = 1;
        end
      end

      2: begin
        if (mask[1] == 1) begin
          next_frame_index = 1;
          has_next_index   = 1;
        end else if (mask[0] == 1) begin
          next_frame_index = 0;
          has_next_index   = 1;
        end
      end

      1: begin
        if (mask[0] == 1) begin
          next_frame_index = 0;
          has_next_index   = 1;
        end
      end
    endcase
  end

  always_comb begin
    sda_oe = 1;
    sda_o  = 1;
    busy   = 1;
    valid  = 0;

    frame  = data_in[frame_index*8+:8];

    case (state)
      START: begin
        sda_o = 0;
      end

      SEND_ADDR: sda_o = device_addr[index];
      SEND_CMD:  sda_o = ~write;  // 0: write, 1: read
      RECV_CMD_ACK: begin
        sda_oe = 0;
      end

      RECV_FRAME: begin
        sda_oe = 0;
      end
      SEND_FRAME_ACK: sda_o = 0;

      SEND_FRAME: sda_o = frame[index];
      RECV_FRAME_ACK: begin
        sda_oe = 0;
      end

      // Final stuff
      STOP: begin
        sda_o = 0;
      end

      RESET, END: begin
        busy = 0;
      end
    endcase
  end

endmodule
