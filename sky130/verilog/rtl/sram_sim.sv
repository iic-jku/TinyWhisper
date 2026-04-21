module sram_sim #(
    parameter string INIT_FILE = ""
) (
    input logic sclk,
    input logic reset,
    input logic ce,  // active high in sim and on pico-ice

    input  logic si,
    output logic so
);

  typedef logic [7:0] mem_t[2**23];

  // TODO: remove when finished
  logic [31:0] mem40;

  typedef enum {
    IDLE,
    RECV_COMMAND,
    RECV_ADDR,
    RECV_DATA,
    SEND_DATA,
    WAITING,
    END
  } sram_states_t;

  mem_t                mem;
  sram_states_t        state = IDLE;

  logic         [ 7:0] SPI_WRITE_CMD = 8'h02;
  logic         [ 7:0] SPI_READ_CMD = 8'h03;

  logic         [ 7:0] command_reg;
  logic         [23:0] addr_reg;
  logic         [ 7:0] datain_reg;
  logic         [31:0] dataout_reg;

  byte                 index;

  initial begin
    if (INIT_FILE != "") begin
      $display("INFO: Trying to load %s into SRAM", INIT_FILE);

      // warning due to not matching sizes may be ignored
      $readmemh(INIT_FILE, mem);
    end
  end

  always_ff @(negedge sclk) begin
    if (state == SEND_DATA) begin
      so <= dataout_reg[index];
    end
  end

  always_ff @(posedge sclk) begin
    if (reset || ~ce) begin
      state <= RECV_COMMAND;
      index <= 7;
    end else begin
      unique case (state)
        IDLE: begin
          state <= RECV_COMMAND;
          index <= 7;
        end

        RECV_COMMAND: begin
          if (ce) begin
            if (index == 0) begin
              index <= 23;
              state <= RECV_ADDR;
            end else begin
              index <= index - 1;
            end

            command_reg[index] <= si;
          end
        end

        RECV_ADDR: begin
          if (index == 0) begin
            index <= 31;

            case (command_reg)
              SPI_READ_CMD: begin
                state <= SEND_DATA;
                dataout_reg[31:24] <= mem[{addr_reg[22:1], si}];
                dataout_reg[23:16] <= mem[{addr_reg[22:1], si}+1];
                dataout_reg[15:8] <= mem[{addr_reg[22:1], si}+2];
                dataout_reg[7:0] <= mem[{addr_reg[22:1], si}+3];
              end
              SPI_WRITE_CMD: begin
                state <= RECV_DATA;
                index <= 7;
              end
              default: state <= END;
            endcase  // case (command_reg)

          end else begin
            index <= index - 1;
          end

          addr_reg[index] <= si;
        end

        // Not used currently
        WAITING: begin
          state <= SEND_DATA;
          dataout_reg <= {mem[addr_reg], mem[addr_reg+1], mem[addr_reg+2], mem[addr_reg+3]};
        end

        RECV_DATA: begin
          if (index == 0) begin
            // state <= END;
            mem[addr_reg[22:0]] <= {datain_reg[7:1], si};
            index <= 7;
            addr_reg <= addr_reg + 1;
          end else index <= index - 1;

          datain_reg[index] <= si;
        end

        SEND_DATA: begin
          if (index == 0) state <= END;
          else index <= index - 1;
        end

        END: state <= END;
      endcase  // unique case (state)
    end
  end
endmodule  // sram_sim
