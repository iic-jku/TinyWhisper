#include "csr.h"
#include "mmio.h"

void mtvec_set_table(void *mtvec_table) {
  __asm__ volatile("csrw mtvec, %0"
                   :                              // no output
                   : "r"((int)mtvec_table | 0b01) // first input
                   :);
}

void interrupts_disable() {
  __asm__ volatile("csrw mstatus, %0" : : "r"((int)0) :);
}

void interrupts_enable() {
  __asm__ volatile("csrw mstatus, %0" : : "r"((int)8) :);
}

void timer_interrupt_disable() {
  int mie;
  __asm__ volatile("csrr %0, mie" : "=r"(mie) : :);

  int mask = 1 << 7;
  mask = ~mask;
  mie &= mask;

  __asm__ volatile("csrw mie, %0" : : "r"(mie) :);
}

void timer_interrupt_enable() {
  int mie;
  __asm__ volatile("csrr %0, mie" : "=r"(mie) : :);

  int mask = 1 << 7;
  mie |= mask;

  __asm__ volatile("csrw mie, %0" : : "r"(mie) :);
}

void external_interrupt_disable() {
  int mie;
  __asm__ volatile("csrr %0, mie" : "=r"(mie) : :);

  int mask = 1 << 11;
  mask = ~mask;
  mie &= mask;

  __asm__ volatile("csrw mie, %0" : : "r"(mie) :);
}

void external_interrupt_enable() {
  int mie;
  __asm__ volatile("csrr %0, mie" : "=r"(mie) : :);

  int mask = 1 << 11;
  mie |= mask;

  __asm__ volatile("csrw mie, %0" : : "r"(mie) :);
}

void external_interrupt_clear() {
  int mip;
  __asm__ volatile("csrr %0, mip" : "=r"(mip) : :);

  int mask = 1 << 11;
  mask = ~mask;
  mip &= mask;

  __asm__ volatile("csrw mip, %0" : : "r"(mip) :);
}

uint32_t external_interrupt_pending() {
  int mip;
  __asm__ volatile("csrr %0, mip" : "=r"(mip) : :);

  int mask = 1 << 11;
  return mip & mask;
}

void uart_interrupt_disable(){
  int mie;
  __asm__ volatile("csrr %0, mie" : "=r"(mie) : :);

  int mask = 1 << 16;
  mask = ~mask;
  mie &= mask;

  __asm__ volatile("csrw mie, %0" : : "r"(mie) :);
}

void uart_interrupt_enable(){
  int mie;
  __asm__ volatile("csrr %0, mie" : "=r"(mie) : :);

  int mask = 1 << 16;
  mie |= mask;

  __asm__ volatile("csrw mie, %0" : : "r"(mie) :);
}

uint32_t uart_interrupt_pending() {
  int mip;
  __asm__ volatile("csrr %0, mip" : "=r"(mip) : :);

  int mask = 1 << 16;
  return mip & mask;
}

void uart_interrupt_clear(){
  int mip;
  __asm__ volatile("csrr %0, mip" : "=r"(mip) : :);

  int mask = 1 << 16;
  mask = ~mask;
  mip &= mask;

  __asm__ volatile("csrw mip, %0" : : "r"(mip) :);
}

uint32_t mcause_get() {
  uint32_t mcause;
  __asm__ volatile("csrr %0, mcause" : "=r"(mcause) : :);
  return mcause;
}

uint32_t mepc_get() {
  uint32_t mepc;
  __asm__ volatile("csrr %0, mepc" : "=r"(mepc) : :);
  return mepc;
}

void mepc_set(uint32_t mepc) {
  __asm__ volatile("csrw mepc, %0" : : "r"(mepc) :);
}

uint64_t mtime_get() {
  uint64_t current_time = *MTIMEH;
  current_time <<= 32;
  current_time |= *MTIME;
  return current_time;
}

void mtime_set(uint64_t cycles) {
  uint32_t mtime = (uint32_t)cycles;
  uint32_t mtimeh = (uint32_t)(cycles >> 32);

  *MTIME = mtime;
  *MTIMEH = mtimeh;
}

uint64_t mtimecmp_get() {
  uint64_t current_time = *MTIMECMPH;
  current_time <<= 32;
  current_time |= *MTIMECMP;
  return current_time;
}

void mtimecmp_set(uint64_t cycles) {
  uint32_t mtimecmp = (uint32_t)cycles;
  uint32_t mtimecmph = (uint32_t)(cycles >> 32);

  *MTIMECMP = mtimecmp;
  *MTIMECMPH = mtimecmph;
}
