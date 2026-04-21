#ifndef CSR_H_
#define CSR_H_

#include <stdint.h>

void mtvec_set_table(void *mtvec_table);

void interrupts_disable();
void interrupts_enable();
void timer_interrupt_disable();
void timer_interrupt_enable();
void external_interrupt_disable();
void external_interrupt_enable();
void external_interrupt_clear();
uint32_t external_interrupt_pending();
void uart_interrupt_disable();
void uart_interrupt_enable();
uint32_t uart_interrupt_pending();
void uart_interrupt_clear();

uint32_t mcause_get();
uint32_t mepc_get();
void mepc_set(uint32_t mepc);

uint64_t mtime_get();
void mtime_set(uint64_t cycles);
uint64_t mtimecmp_get();
void mtimecmp_set(uint64_t cycles);

#endif // CSR_H_
