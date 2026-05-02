#include "interrupts.h"
#include "csr.h"
#include "mmio.h"
#include "printf.h"

__attribute__((weak)) void exception_handler() {
  uint32_t mcause = mcause_get();
  uint32_t mepc = mepc_get();

  switch (mcause) {
  case INSTRUCTION_ADDRESS_MISALIGNED:
    printf("INSTRUCTION_ADDRESS_MISALIGNED exception occured at ");
    break;

  case ILLEGAL_INSTRUCTION:
    printf("ILLEGAL_INSTRUCTION exception occured at ");
    break;

  case LOAD_ACCESS_FAULT:
    printf("LOAD_ACCESS_FAULT exception occured at ");
    break;

  default:
    printf("Unknown exception occured at ");
  }

  printf("mepc = %x\r\n", mepc);

  while (1) {
  };
}
__attribute__((weak, interrupt("machine"))) void ext_intr_handler() {
  printf("External interrupt occured!\r\n");
}
__attribute__((weak, interrupt("machine"))) void timer_intr_handler() {
  printf("Timer interrupt occured!\r\n");
}
__attribute__((weak, interrupt("machine"))) void uart_intr_handler() {
  printf("UART interrupt occured!\r\n");
}

__attribute__((naked, aligned(4))) void mtvec_table() {
  __asm__ volatile(".org  mtvec_table + 0*4;"
                   "j     exception_handler;"

                   ".org  mtvec_table + 7*4;"
                   "j     timer_intr_handler;"

                   ".org  mtvec_table + 11*4;"
                   "j     ext_intr_handler;"

                   ".org  mtvec_table + 16*4;"
                   "j     uart_intr_handler;");
}
