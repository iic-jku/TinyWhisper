#ifndef INTERRUPTS_H_
#define INTERRUPTS_H_

enum {
  INTR_MTI = 7,
  INTR_MEI = 11,
  INTR_UART = 16,
};

enum {
  INSTRUCTION_ADDRESS_MISALIGNED = 0,
  ILLEGAL_INSTRUCTION = 2,
  LOAD_ACCESS_FAULT = 5,
};

void exception_handler();
__attribute__((interrupt("machine"))) void ext_intr_handler();
__attribute__((interrupt("machine"))) void timer_intr_handler();
__attribute__((interrupt("machine"))) void uart_intr_handler();

__attribute__((naked, aligned(4), section(".text.mtvec_table"))) void
mtvec_table();

#endif // INTERRUPTS_H_
