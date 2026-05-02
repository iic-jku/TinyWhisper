// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0

#include "csr.h"
#include "interrupts.h"
#include "mmio.h"
#include "printf.h"
#include "wspr.h"

const uint32_t CLK_FREQ = 12e6;
const double TIME_PER_SYMBOL = 0.683;
const uint32_t CYCLES_PER_SYMBOL = CLK_FREQ * TIME_PER_SYMBOL;
const uint32_t FRAQ_BITS = 29;

#define SYMBOL_AMOUNT 162
uint8_t symbols[SYMBOL_AMOUNT] = {
    1, 1, 0, 2, 0, 2, 0, 0, 1, 0, 2, 0, 1, 1, 3, 0, 2, 0, 1, 0, 2, 3, 2, 3,
    1, 1, 1, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 1, 2, 1, 2, 2, 2, 0, 0, 2, 3, 2,
    1, 3, 0, 2, 1, 3, 2, 3, 0, 2, 2, 3, 3, 2, 3, 0, 2, 0, 2, 1, 1, 0, 1, 0,
    1, 0, 3, 2, 3, 0, 0, 3, 2, 0, 1, 2, 1, 3, 0, 2, 2, 3, 3, 2, 1, 0, 3, 2,
    2, 2, 3, 0, 0, 0, 0, 0, 3, 2, 2, 1, 0, 0, 1, 1, 3, 2, 3, 3, 2, 0, 1, 1,
    0, 1, 2, 0, 2, 1, 3, 1, 0, 0, 2, 2, 2, 3, 2, 1, 2, 0, 1, 3, 2, 0, 0, 2,
    0, 0, 2, 1, 3, 2, 1, 2, 3, 3, 2, 2, 0, 3, 1, 2, 0, 2};
uint32_t current;

uint32_t f_c[4];

uint32_t compute_osr_fc(double frequency, uint8_t OSR);
void start_transmission();
void end_transmission();

uint32_t read_string(char *buf, int len) {
  uart_rx_enable();
  uart_interrupt_disable();
  uart_interrupt_clear();

  int i;
  for (i = 0; i < len - 1;) {
    while (!uart_interrupt_pending()) {
      // Idle
    }
    char current = uart_data_read();
    uart_interrupt_clear();

    // Carriage return
    if (current == 0x0D) {
      buf[i] = '\0';
      printf("\r\n");
      return i;
    }
    // Backspace
    /* else if (current == 0x08) { */
    /*   /\* printf("\x1b[C"); // Move cursor one backwards *\/ */
    /*   printf("back"); */
    /*   i--; */
    /* } */
    else {
      printf("%c", current);
      buf[i++] = current;
    }
  }

  buf[i + 1] = '\0';
  return i + 1;
}

/* int main() { */
/*   interrupts_disable(); */
/*   mtvec_set_table(&mtvec_table); */

/*   scl_ratio_set(scl_compute_ratio(CLK_FREQ, 100e3)); */
/*   uart_rx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200)); */
/*   uart_tx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200)); */

/*   uint8_t OSR = 0; */

/*   f_c[0] = compute_osr_fc(20e3, OSR); */

/*   freq_ds_mode_set(1); */
/*   freq_ds_out_invert_set(0); */
/*   /\* freq_ds_out_switch_set(0); *\/ */
/*   freq_lo_div_set(2); */

/*   uart_rx_enable(); */
/*   char call[10]; */
/*   printf("\rReady to transmit. Press ENTER to start\r\n"); */
/*   read_string(call, 10); */

/*   freq_reset_n_set(0); */
/*   freq_reset_n_set(1); */
/*   freq_start_set(0); */
/*   freq_osr_fc_set(f_c[0]); */
/*   freq_start_set(1); */

/*   while (1) { */
/*     printf("Generating...\r\n"); */
/*   }; */
/* } */

int main() {
  interrupts_disable();
  mtvec_set_table(&mtvec_table);

  scl_ratio_set(scl_compute_ratio(CLK_FREQ, 100e3));
  uart_rx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200));
  uart_tx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200));

  f_c[0] = compute_osr_fc(1500.0, 0);
  f_c[1] = compute_osr_fc(1501.5, 0);
  f_c[2] = compute_osr_fc(1503.0, 0);
  f_c[3] = compute_osr_fc(1504.5, 0);

  uart_rx_enable();
  char call[10];
  char loc[10];
  char pwr[10];
  printf("Callsign: ");
  read_string(call, 10);

  printf("Locator: ");
  read_string(loc, 10);

  printf("Power: ");
  read_string(pwr, 10);

  printf("Computing WSPR...");
  wspr_compute_symbols(symbols, call, loc, pwr);

  printf("\rReady to transmit. Press ENTER to start\r\n");
  external_interrupt_enable();
  /* read_string(call, 10); */
  interrupts_enable();
  /* start_transmission(); */

  // Waiting for start button
  while (!freq_active_get()) {
  }
  printf("Started transmission.\r\n");

  // Waiting for end of transmission
  while (freq_active_get()) {
  }
  printf("Finished. Thank you for using CE CPU!\r\n");
}

void _putchar(char character) { *UART_TX = character; }

__attribute__((interrupt("machine"))) void ext_intr_handler() {
  external_interrupt_disable();
  start_transmission();
}

__attribute__((interrupt("machine"))) void timer_intr_handler() {
  current += 1;

  if (current < SYMBOL_AMOUNT) {
    printf("current: %d\r\n", current);
    mtimecmp_set(mtimecmp_get() + CYCLES_PER_SYMBOL);
    freq_osr_fc_set(f_c[symbols[current]]);
  } else {
    end_transmission();
    external_interrupt_clear();
    /* external_interrupt_enable(); */
  }
}

__attribute__((weak, interrupt("machine"))) void uart_intr_handler() {
  printf("%c", uart_data_read());
  uart_interrupt_clear();
}

void start_transmission() {
  current = 0;
  freq_reset_n_set(0);
  freq_reset_n_set(1);
  freq_start_set(0);
  freq_lo_div_set(2);
  freq_ds_mode_set(0);
  freq_ds_out_invert_set(0);
  freq_osr_fc_set(f_c[symbols[current]]);
  *FREQ_STATUS = 0b10011011;
  *GPIO_OUT = 255;

  mtimecmp_set(CYCLES_PER_SYMBOL);
  mtime_set(0);
  freq_start_set(1);
  timer_interrupt_enable();
}

void end_transmission() {
  timer_interrupt_disable();
  freq_reset_n_set(0);
  freq_start_set(0);
  *GPIO_OUT = 0;
}

uint32_t compute_osr_fc(double frequency, uint8_t OSR) {
  double iterations = 256.0;
  switch (OSR) {
  case 0:
    iterations = 32.0;
    break;
  case 1:
    iterations = 64.0;
    break;
  case 2:
    iterations = 128.0;
    break;
  case 3:
    iterations = 256.0;
    break;
  }

  double f_s = CLK_FREQ / iterations;
  double fc = (2.0 / f_s) * frequency;

  uint32_t osr_fc = 0;
  osr_fc |= OSR << 30;
  osr_fc |= (uint32_t)(fc * (1 << FRAQ_BITS));

  return osr_fc;
}
