module tinywhisper_riscv #(
    parameter int CLK_FREQ = 12_000_000,
    parameter int BAUD = 115_200
) (
`ifdef USE_POWER_PINS
    inout wire  VDD,
    inout wire  VSS,
`endif
    input logic clk,
    input logic reset, // active low due to pico-ice button
    input logic spi_slow_mode,

    input  logic so,
    output logic si,
    output logic sclk,
    output logic sram_ce,

`ifdef FPGA
    inout  logic sda,
`else
    input  logic sda_i,
    output logic sda_o,
    output logic sda_oe,
`endif
    output logic scl,

    input  logic rx,
    output logic tx,

    input  logic [3:0] gpio_in,  // gpio[0] fires external interrupt
    output logic [3:0] gpio_out,

    output logic cos_ds,
    output logic cos_ds_n,
    output logic sin_ds,
    output logic sin_ds_n,
    output logic lo_i,
    output logic lo_q,
    output logic lo_ix,
    output logic lo_qx
);

`ifndef SIM
`ifdef FPGA
  `include "constants.sv"
`endif
`endif

  // Mapping I2C here as this is the toplevel module on the FPGA
`ifdef FPGA
  logic sda_i, sda_o, sda_oe;
  assign sda   = (sda_oe) ? sda_o : 1'bZ;
  assign sda_i = sda;
`endif

  logic mem_ce, memwrite, mem_busy, mem_valid;
  logic [31:0] mem_addr;
  logic [31:0] mem_dataout;

  logic [31:0] iword, immediate;
  logic wbflag, memflag, pcflag, fetchflag;

  logic [5:0] control_flags;

  logic [1:0] jump;
  logic [22:0] imm, pc_new;

  logic [31:0] a, b, rd;
  logic [16:0] instruction;

  logic [31:0] rd_alu, rs1, rs2, alu_comb;

  always_ff @(posedge clk) begin
    rd_alu <= alu_comb;

    if (fetchflag) iword <= mem_dataout;
    if (reset == 0) begin
      iword  <= 0;
      rd_alu <= 0;
    end
  end

  logic       intr_timer;
  logic       load_access_fault;
  logic [2:0] funct3;
  logic       uart_rx_valid;

  memory #(
      .CLK_FREQ(CLK_FREQ),
      .BAUD(BAUD)
  ) memory_i (
      .clk(clk),
      .reset(reset),
      .ce(mem_ce),
      .spi_slow_mode(spi_slow_mode),
      .funct3(funct3),
      .addr(mem_addr),
      .datain(rs2),
      .memwrite(memwrite),
      .dataout(mem_dataout),
      .busy(mem_busy),
      .valid(mem_valid),
      .so(so),
      .si(si),
      .rx(rx),
      .tx(tx),
      .uart_rx_valid(uart_rx_valid),
      .sclk(sclk),
      .sram_ce(sram_ce),
      .scl(scl),
      .sda_i(sda_i),
      .sda_o(sda_o),
      .sda_oe(sda_oe),
      .gpio_in(gpio_in),
      .gpio_out(gpio_out),
      .cos_ds(cos_ds),
      .cos_ds_n(cos_ds_n),
      .sin_ds(sin_ds),
      .sin_ds_n(sin_ds_n),
      .lo_i(lo_i),
      .lo_q(lo_q),
      .lo_ix(lo_ix),
      .lo_qx(lo_qx),
      .intr_timer(intr_timer),
      .load_access_fault(load_access_fault)
  );

  // NOTE: memwrite may only be set to flag determined by SW/LW
  // if actually mem_phase is currently executed. If we are fetching
  // instructions we need to set memwrite to 0
  assign memwrite = (memflag) ? control_flags[1] : 1'b0;

  // If we are in memory phase, the addr is the calculated address by the ALU
  // Else we use the programcounter to fetch the new iword
  assign mem_addr = (memflag) ? rd_alu : {9'b0, pc_new};
  assign funct3   = (memflag) ? iword[14:12] : FUNCT3_MEM_W;

  logic       jump_to_isr;
  logic       mret;
  logic       interrupt_pending;
  logic       csr_write;
  logic [2:0] exceptions;
  control control_i (
      .clk(clk),
      .reset(reset),
      .iword(iword),
      .mem_busy(mem_busy),
      .mem_valid(mem_valid),
      .immediate(immediate),
      .control_flags(control_flags),
      .wbflag(wbflag),
      .memflag(memflag),
      .pcflag(pcflag),
      .fetchflag(fetchflag),
      .mem_ce(mem_ce),
      .interrupt_pending(interrupt_pending),
      .exceptions(exceptions),
      .jump_to_isr(jump_to_isr),
      .mret(mret),
      .csr_write(csr_write)
  );

  logic [22:0] isr_return;
  logic [22:0] isr_target;
  logic [31:0] csr_dataout;
  csr csr_i (
      .clk(clk),
      .reset(reset),
      .intr_timer(intr_timer),
      .intr_ext(gpio_in[0]),
      .uart_rx_valid(uart_rx_valid),
      .exceptions(exceptions),
      .mret(mret),
      .enter_isr(jump_to_isr),
      .data_in(rs1),
      .addr(iword[31:20]),
      .write_en(csr_write),
      .data_out(csr_dataout),
      .pc(pc_new),
      .isr_return(isr_return),
      .isr_target(isr_target),
      .interrupt_pending(interrupt_pending)
  );

  logic pc_misaligned;
  instructioncounter inst_i (
      .clk(clk),
      .reset(reset),
      .pcflag(pcflag),
      .interrupt(jump_to_isr),
      .jump(jump),
      .imm(imm),
      .isr_target(isr_target),
      .isr_return(isr_return),
      .pc_new(pc_new),
      .pc_misaligned(pc_misaligned)
  );

  assign imm = (iword[6:0] == 7'b1100111) ? rd_alu[22:0] : immediate[22:0];

  // Branch behavior calculated by ALU with BNE, BEQ, ...
  always_comb begin
    jump[0] = (control_flags[5]) ? rd_alu[23] : 1'b0;
    jump[1] = (control_flags[5]) ? rd_alu[24] : 1'b1;

    if (mret) begin
      jump = 2'b11;
    end
  end

  logic illegal_instruction;
  alu alu_i (
      .a(a),
      .b(b),
      .instruction(instruction),
      .rd(alu_comb),
      .illegal_instruction(illegal_instruction)
  );

  assign exceptions = {load_access_fault, illegal_instruction, pc_misaligned};

  assign instruction = {iword[31:25], iword[14:12], iword[6:0]};
  assign a = (control_flags[3]) ? {9'b0, pc_new} : rs1;
  assign b = (control_flags[4]) ? immediate : rs2;
  // alu result goes back to the regs only if we don't have a mem_phase
  // Then it's either LW or SW (where regwrite would be 0, so no problem)

  always_comb begin
    rd = rd_alu;

    if (iword[6:0] == OP_JALR || iword[6:0] == OP_JAL) rd = pc_new + 4;
    else if (iword[6:0] == OP_CSR && iword[14:12] == FUNCT3_CSRR) rd = csr_dataout;
    else if (control_flags[0]) rd = mem_dataout;
  end

  regs regs (
      .clk(clk),
      .reset(reset),
      .regwrite(wbflag),
      .rs1adr(iword[18:15]),
      .rs2adr(iword[23:20]),
      .rdadr(iword[10:7]),
      .rd(rd),
      .rs1(rs1),
      .rs2(rs2)
  );

endmodule  // cpu
