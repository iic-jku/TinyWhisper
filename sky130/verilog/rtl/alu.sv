module alu (
    input logic [31:0] a,               // rs1/pc
    input logic [31:0] b,               // rs2/imm
    input logic [16:0] instruction,

    output logic [31:0] rd,
    output logic illegal_instruction
);

`ifndef SIM
  `ifdef FPGA
    `include "constants.sv"
  `endif
`endif

  wire [6:0] opcode;
  wire [6:0] funct7;
  wire [2:0] funct3;
  logic [31:0] jalr_temp;

  // Concatenated slices of the iword. Used for selecting correct operation
  assign opcode  = instruction[6:0];
  assign funct7  = instruction[16:10];
  assign funct3  = instruction[9:7];
  assign jalr_temp = a + b;


  always_comb begin
      illegal_instruction = 0;
      rd = 0;

      casez({funct7, funct3, opcode})
        {FUNCT7_ADD, FUNCT3_ADD, OP_RTYPE},
        {DONT_CARES, FUNCT3_ADDI, OP_ITYPE}: begin
          rd = a + b;
        end

        {FUNCT7_SUB, FUNCT3_SUB, OP_RTYPE}: begin
          rd = a - b;
        end

        {FUNCT7_AND, FUNCT3_AND, OP_RTYPE},
        {DONT_CARES, FUNCT3_ANDI, OP_ITYPE}: begin
          rd = a & b;
        end

        {FUNCT7_OR, FUNCT3_OR, OP_RTYPE},
        {DONT_CARES, FUNCT3_ORI, OP_ITYPE}: begin
          rd = a | b;
        end

        {FUNCT7_XOR, FUNCT3_XOR, OP_RTYPE},
        {DONT_CARES, FUNCT3_XORI, OP_ITYPE}: begin
          rd = a ^ b;
        end

        // {FUNCT7_MUL, FUNCT3_MUL, OP_RTYPE}: begin
        //   rd = mulResult[31:0];
        // end

        {FUNCT7_SLT, FUNCT3_SLT, OP_RTYPE},
        {DONT_CARES, FUNCT3_SLTI, OP_ITYPE}: begin
          rd = ($signed(a) < $signed(b)) ? 32'h00000001 : 32'h00000000;
        end

        {FUNCT7_SLTU, FUNCT3_SLTU, OP_RTYPE},
        {DONT_CARES, FUNCT3_SLTIU, OP_ITYPE}: begin
          rd = ($unsigned(a) < $unsigned(b)) ? 32'h00000001 : 32'h00000000;
        end

        {FUNCT7_SLL, FUNCT3_SLL, OP_RTYPE},
        {FUNCT7_SLLI, FUNCT3_SLLI, OP_ITYPE}: begin
          rd = $signed(a) <<< b[4:0];
        end

        {FUNCT7_SRA, FUNCT3_SRA, OP_RTYPE},
        {FUNCT7_SRAI, FUNCT3_SRAI, OP_ITYPE}: begin
          rd = $signed(a) >>> b[4:0];
        end


        {FUNCT7_SRL, FUNCT3_SRL, OP_RTYPE},
        {FUNCT7_SRLI, FUNCT3_SRLI, OP_ITYPE}: begin
          rd = a >> b[4:0];
        end

        {FUNCT7_MRET, FUNCT3_MRET, OP_MRET}: begin
          rd = 0;
        end

        {DONT_CARES, FUNCT3_CSRR, OP_CSR},
        {DONT_CARES, FUNCT3_CSRW, OP_CSR}: begin
          rd = 0;
        end

        default: begin
          case (opcode)
            OP_JAL: begin
              rd[31:25] = '0;
              rd[22:0]  = '0;
              rd[24:23] = 2'b00;
            end

            OP_JALR: begin
              rd[31:25] = '0;
              rd[22:1]  = jalr_temp[22:1];
              rd[0]     = 1'b0;
              rd[24:23] = 2'b01;
            end

            OP_LUI: begin
              rd = b;
            end

            OP_AUIPC: begin
              rd = a + b;
            end

            OP_SW, OP_LW: begin
              if (funct3 == FUNCT3_MEM_B || funct3 == FUNCT3_MEM_H ||
                  funct3 == FUNCT3_MEM_W || funct3 == FUNCT3_LBU || funct3 == FUNCT3_LHU)
                rd = a + b; // Adding register and immediate offset for correct target address
            end

            OP_BRANCH: begin
              rd[31:25] = '0;
              rd[22:0]  = '0;
              case (funct3)
                // Checking condition and setting jump[1] and jump[0] for corresponding
                // instructioncounter command (indirect, direct, increment)
                FUNCT3_BEQ: rd[24:23] = (a == b) ? 2'b00 : 2'b10;
                FUNCT3_BNE: rd[24:23] = (a == b) ? 2'b10 : 2'b00;
                FUNCT3_BLT: rd[24:23] = ($signed(a) < $signed(b)) ? 2'b00 : 2'b10;
                FUNCT3_BGE: rd[24:23] = ($signed(a) >= $signed(b)) ? 2'b00 : 2'b10;
                FUNCT3_BLTU: rd[24:23] = ($unsigned(a) < $unsigned(b)) ? 2'b00 : 2'b10;
                FUNCT3_BGEU: rd[24:23] = ($unsigned(a) >= $unsigned(b)) ? 2'b00 : 2'b10;
                default: begin
                    rd = '0;
                    illegal_instruction = 1;
                end
              endcase
            end

            default: begin
                rd = '0;
                illegal_instruction = 1;
            end
          endcase
        end
      endcase
    end

endmodule
