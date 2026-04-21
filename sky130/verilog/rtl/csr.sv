module csr (
    input logic clk,
    input logic reset,

    // Interrupt signals
    input  logic       intr_timer,
    input  logic       intr_ext,
    input  logic       uart_rx_valid,
    input  logic [2:0] exceptions,
    input  logic       mret,
    input  logic       enter_isr,
    output logic       interrupt_pending,

    // Signals for reading/writing CSRs
    input  logic [31:0] data_in,
    input  logic [11:0] addr,
    input  logic        write_en,
    output logic [31:0] data_out,

    input  logic [22:0] pc,
    output logic [22:0] isr_return,
    output logic [22:0] isr_target
);

  logic intr_ext_sync;
  logic timer_interrupt;
  logic external_interrupt;
  logic uart_interrupt;

  logic [11:0] addr_reg;

  localparam [4:0] TIMER = 7;
  localparam [4:0] EXTERNAL = 11;
  localparam [4:0] UART = 16;

  logic [31:0] mstatus;  // 0x300
  logic [31:0] mie;  // 0x304
  logic [31:0] mtvec;  // 0x305
  logic [31:0] mepc;  // 0x341
  logic [31:0] mcause;  // 0x342
  logic [31:0] mip;  // 0x344

  assign timer_interrupt = mstatus[3] && mie[TIMER] && mip[TIMER];
  assign external_interrupt = mstatus[3] && mie[EXTERNAL] && mip[EXTERNAL];
  assign uart_interrupt = mstatus[3] && mie[UART] && mip[UART];
  assign interrupt_pending = timer_interrupt || external_interrupt || uart_interrupt;

  assign isr_return = mepc[22:0];

  always_ff @(posedge clk) begin
    addr_reg <= addr;
    intr_ext_sync <= intr_ext;

    mip[TIMER] <= intr_timer;
    if (intr_ext_sync) mip[EXTERNAL] <= 1;
    if (uart_rx_valid) mip[UART] <= 1;

    if (enter_isr) begin
      mepc <= {9'b0, pc};
      mstatus[3] <= 0;
      if (mcause == {1'b1, 31'd11}) mip[EXTERNAL] <= 0;
    end

    if (mret) begin
      mstatus[3] <= 1;
    end

    /* verilator lint_off CASEINCOMPLETE */
    if (write_en) begin
      case (addr_reg)
        12'h300: mstatus <= data_in;
        12'h304: mie <= data_in;
        12'h305: mtvec <= data_in;
        12'h341: mepc <= data_in;
        12'h342: mcause <= data_in;
        12'h344: mip <= data_in;
      endcase
    end
    /* verilator lint_on CASEINCOMPLETE */

    if (external_interrupt) mcause <= {1'b1, 31'd11};
    else if (uart_interrupt) mcause <= {1'b1, 31'd16};
    else if (timer_interrupt) mcause <= {1'b1, 31'd7};
    else if (exceptions[1]) mcause <= {1'b0, 31'd2};  // illegal instruction
    else if (exceptions[0]) mcause <= {1'b0, 31'd0};  // PC misaligned
    else if (exceptions[2]) mcause <= {1'b0, 31'd5};  // load access fault

    if (reset == 0) begin
      mstatus <= 32'd0;  // MIE = 0
      mie <= 32'd0;
      mtvec <= {30'b0, 2'd1};
      mepc <= 32'd0;
      mcause <= 32'd0;
      mip <= 32'd0;
      intr_ext_sync <= 0;
    end
  end

  /* verilator lint_off WIDTHEXPAND */
  /* verilator lint_off WIDTHTRUNC */
  always_comb begin
    if (mcause[31]) isr_target = (mtvec[31:2] + mcause[30:0]) << 2;
    else isr_target = {mtvec[31:2], 2'b00};

    case (addr_reg)
      12'h300: data_out = mstatus;
      12'h304: data_out = mie;
      12'h305: data_out = mtvec;
      12'h341: data_out = mepc;
      12'h342: data_out = mcause;
      12'h344: data_out = mip;

      default: data_out = 0;
    endcase
  end
  /* verilator lint_on WIDTHEXPAND */
  /* verilator lint_on WIDTHTRUNC */

endmodule
