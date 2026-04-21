module instructioncounter (
    input logic clk,
    input logic reset,

    input logic        pcflag,
    input logic        interrupt,
    input logic [ 1:0] jump,
    input logic [22:0] imm,
    input logic [22:0] isr_target,
    input logic [22:0] isr_return,

    output logic [22:0] pc_new,
    output logic pc_misaligned
);

  logic [22:0] pc_reg;

  always_ff @(posedge clk) begin
    if (interrupt) begin
      pc_reg <= isr_target;
    end else if (pcflag) begin
      case (jump)
        2'b00: pc_reg <= pc_reg + imm;  // Indirekter Sprung
        2'b01: pc_reg <= imm;  // Direkter Sprung
        2'b10: pc_reg <= pc_reg + 4;  // Inkrementieren
        2'b11: pc_reg <= isr_return;  // MRET

        default: pc_reg <= pc_reg + 4;
      endcase
    end

    if (reset == 0) pc_reg <= 0;
  end

  assign pc_new = pc_reg;
  assign pc_misaligned = (pc_reg[1:0] != 2'b00);

endmodule  // instructioncounter
