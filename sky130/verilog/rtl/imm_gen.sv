module imm_gen (
    input  logic [31:0] iword,
    output logic [31:0] immediate
);

`ifndef SIM
  `ifdef FPGA
    `include "constants.sv"
  `endif
`endif

    logic [6:0] opcode;
    logic [20:0] w31_to_w11_se;
    logic [5:0] w30_to_w25;
    logic [4:0] w24_to_w20;
    logic [4:0] w11_to_w7;
    logic [19:0] w31_to_w12_se;
    logic w7;
    logic [3:0] w11_to_w8;
    logic [19:0] w31_to_w12;
    logic [11:0] w31_to_20_se;

    logic [7:0] w19_to_w12;
    logic w20;
    logic [3:0] w24_to_21;

    assign opcode = iword[6:0];
    assign w31_to_w11_se = {21{iword[31]}};
    assign w30_to_w25 = iword[30:25];
    assign w24_to_w20 = iword[24:20];
    assign w11_to_w7 = iword[11:7];
    assign w31_to_w12_se = {20{iword[31]}};
    assign w7 = iword[7];
    assign w11_to_w8 = iword[11:8];
    assign w31_to_w12 = iword[31:12];
    assign w19_to_w12 = iword[19:12];
    assign w20 = iword[20];
    assign w24_to_21 = iword[24:21];
    assign w31_to_20_se = {12{iword[31]}};

    always_comb begin
        case (opcode)
            7'b0000011, 7'b0010011, 7'b1100111, 7'b1110011:
            immediate = {w31_to_w11_se, w30_to_w25, w24_to_w20};  // I-Type

            7'b0100011: immediate = {w31_to_w11_se, w30_to_w25, w11_to_w7};  // S-Type

            7'b1100011: immediate = {w31_to_w12_se, w7, w30_to_w25, w11_to_w8, 1'b0};  // B-Type

            7'b0010111, 7'b0110111: immediate = {w31_to_w12, 12'b0};  // U-Type

            7'b1101111:
            immediate = {w31_to_20_se, w19_to_w12, w20, w30_to_w25, w24_to_21, 1'b0};  // J-Type

            default: immediate = 32'b0;  // Default case
        endcase
    end

endmodule
