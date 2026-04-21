module regs (
    input logic clk,
    input logic reset,

    input logic regwrite,

    input logic [3:0] rs1adr,
    input logic [3:0] rs2adr,
    input logic [3:0] rdadr,

    input  logic [31:0] rd,
    output logic [31:0] rs1,
    output logic [31:0] rs2
);

  // Internal register data structure
  typedef logic [31:0] registers_t[16];
  registers_t registers;

  always_ff @(posedge clk) begin
    // Only perform write if control sets regwrite
    // and x0 isn't the target
    if (reset && regwrite && rdadr != 0) begin
      registers[rdadr] <= rd;
    end

    // Perform read
    rs1 <= registers[rs1adr];
    rs2 <= registers[rs2adr];

    if (reset == 0) begin
      registers[0] <= 0;

      rs1 <= 0;
      rs2 <= 0;
    end
  end
endmodule  // regs
