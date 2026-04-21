module control (
    input logic        clk,
    input logic        reset,
    input logic [31:0] iword,
    input logic        mem_busy,
    input logic        mem_valid,

    output logic [31:0] immediate,
    output logic [ 5:0] control_flags,
    output logic        wbflag,
    output logic        memflag,
    output logic        pcflag,
    output logic        fetchflag,
    output logic        mem_ce,

    input logic interrupt_pending,
    input logic [2:0] exceptions,
    output logic jump_to_isr,
    output logic mret,
    output logic csr_write
);

`ifndef SIM
`ifdef FPGA
  `include "constants.sv"
`endif
`endif

  // NOTE for docs:
  // wbflag: connected to registers. If wbflag == 1 then R[rdadr] = rd is performed
  // memflag: held high while entire memory phase. This ensures that the mux are set
  // pcflag: connected to instruction counter. If pcflag == 1 the new pc is calculated
  // fetchflag: connected to toplevel cpu. If fetchflag == 1 the new iword
  // is read from the memory output
  // mem_ce: active low to enable the memory. Has to be set while fetch and memory

  logic       mem_phase;
  logic       mem_write;
  logic       reg_write;
  logic       AUIPC;
  logic       imm_as_b;
  logic       jump;
  logic [6:0] opcode;
  logic [2:0] funct3;
  logic [6:0] funct7;

  logic       pc_misaligned;
  logic       illegal_instruction;
  logic       load_access_fault;

  assign pc_misaligned       = exceptions[0];
  assign illegal_instruction = exceptions[1];
  assign load_access_fault   = exceptions[2];

  assign opcode              = iword[6:0];
  assign funct3              = iword[14:12];
  assign funct7              = iword[31:25];

  // NOTE for docs
  // These control flags are constant for one iword. They encode useful
  // information about the current iword that is needed elsewhere. (mostly CPU)
  assign control_flags[0]    = mem_phase;  // We enter mem_phase (for checks in control)
  assign control_flags[1]    = mem_write;  // We must set the write enable for mem
  assign control_flags[2]    = reg_write;  // Same for regs
  assign control_flags[3]    = AUIPC;  // AUIPC instruction, PC has to be ALU a input
  assign control_flags[4]    = imm_as_b;  // imm needs to be ALU b input
  assign control_flags[5]    = jump;  // jump instruction. PC can't just increment by +4

  // NOTE for docs
  // We need two states for fetch and memory
  // fetch_await: We wait until the memory sets busy to 1, so it actually
  // starts working on our request
  // fetch: We stay in this state while the memory is working and leave once
  // it is finished
  // If we omit fetch_await then we would assume the memory has finished
  // (busy == 0), because the posedge of busy has not arrived yet
  typedef enum {
    rst,
    fetch_await,
    fetch,
    decode,
    execute,
    memory_await,
    memory,
    writeback,
    interrupt
  } states_t;

  states_t state_d, state_q;

  always_ff @(posedge clk) begin
    if (reset == 0) state_q <= rst;
    else state_q <= state_d;
  end

  always_comb begin : Delta
    state_d = state_q;
    case (state_q)
      rst: begin
        state_d = fetch_await;
      end

      // FE
      fetch_await: begin
        if (pc_misaligned) state_d = interrupt;
        else if (load_access_fault) state_d = interrupt;
        else if (mem_busy) state_d = fetch;
      end
      fetch: if (~mem_busy) state_d = decode;

      // ID
      decode: state_d = execute;

      // EX
      execute: begin
        if (illegal_instruction) begin
          state_d = interrupt;
        end else if (mem_phase == 1) begin
          state_d = memory_await;
        end else state_d = writeback;
      end

      // MEM
      memory_await: begin
        if (load_access_fault) state_d = interrupt;
        else if (mem_busy) state_d = memory;
      end
      memory: if (~mem_busy) state_d = writeback;

      // WB
      writeback: begin
        if (interrupt_pending) state_d = interrupt;
        else state_d = fetch_await;
      end

      // ISR
      interrupt: state_d = fetch_await;
    endcase
  end

  logic [31:0] imm_out;
  imm_gen imm_gen_i (
      .iword(iword),
      .immediate(imm_out)
  );

  always_ff @(posedge clk) begin
    immediate <= imm_out;

    if (reset == 0) immediate <= 32'b0;
  end

  // Flags for control flow
  always_comb begin
    pcflag = 0;
    memflag = 0;
    mem_ce = 1;
    wbflag = 0;
    fetchflag = 0;
    jump_to_isr = 0;
    mret = 0;
    csr_write = 0;

    case (state_q)
      fetch: if (mem_valid) fetchflag = 1;

      memory, memory_await: memflag = 1;

      writeback: begin
        pcflag = 1;
        if (reg_write) wbflag = 1;
        if ({funct7, funct3, opcode} == {FUNCT7_MRET, FUNCT3_MRET, OP_MRET}) mret = 1;
        if ({funct3, opcode} == {FUNCT3_CSRW, OP_CSR}) csr_write = 1;
      end

      interrupt: begin
        jump_to_isr = 1;
      end
    endcase

    if (state_q == memory_await || state_q == memory || state_q == fetch_await || state_q == fetch)
      mem_ce = 0;
  end

  // Flags for iword itself
  always_comb begin
    mem_phase = 0;
    mem_write = 0;
    reg_write = 1;
    AUIPC = 0;
    imm_as_b = 0;
    jump = 0;

    // mem_phase needed for alu/mem multiplexer to rd
    if (opcode == OP_LW || opcode == OP_SW) mem_phase = 1;

    // write enable for memory
    if (opcode == OP_SW) mem_write = 1;

    // Don't write back into rd on branch and sw
    if (opcode == OP_BRANCH || opcode == OP_SW) reg_write = 0;

    // Input to alu a op mux
    if (opcode == OP_AUIPC) AUIPC = 1;

    if (opcode == OP_ITYPE || opcode == OP_LUI || opcode == OP_AUIPC || opcode == OP_LW ||
        opcode == OP_SW || opcode == OP_JAL || opcode == OP_JALR)
      imm_as_b = 1;

    if (opcode == OP_BRANCH || opcode == OP_JAL || opcode == OP_JALR) jump = 1;

    // Dont write back on csrw (only writes to csr, not reg)
    if (opcode == OP_CSR && funct3 == FUNCT3_CSRW) reg_write = 0;

    // Dont write back on mret
    if (opcode == OP_MRET && funct3 == FUNCT3_MRET && funct7 == FUNCT7_MRET) reg_write = 0;
  end
endmodule
