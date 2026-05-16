// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

#include "csr.h"
#include "interrupts.h"
#include "mmio.h"
#include "printf.h"
#include "wspr.h"

const uint32_t CLK_FREQ = 12e6;
const double TIME_PER_SYMBOL = 0.683;
const uint32_t CYCLES_PER_SYMBOL = CLK_FREQ * TIME_PER_SYMBOL;
const uint32_t FRAQ_BITS = 29;

void _putchar(char character) { *UART_TX = character; }
uint32_t compute_osr_fc(double frequency, uint8_t OSR);
uint32_t compute_cordic_I(double scale);
void cordic_set_scale(double scale);

int main() {
  interrupts_disable();
  mtvec_set_table(&mtvec_table);
  scl_ratio_set(scl_compute_ratio(CLK_FREQ, 100e3));
  uart_rx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200));
  uart_tx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200));

  *I2C_DEVICE_ADDR = 0x5A;

  /* *I2C_MASK = 0b0001; */
  /* *I2C_DATA = 0xF4; */

  /* *I2C_MASK = 0b0011; */
  /* *I2C_DATA = 0x0110; */
  /* printf("ACKS: %d\r\n", ((*I2C_ACKS) >> 2)); */
  /* /\* *I2C_MASK = 0b0011; *\/ */

  /* *I2C_MASK = 0b0001; */
  /* *I2C_DATA = 0x02; */

  /* while (1) { */
  /*   *I2C_MASK = 0b0001; */
  /*   *I2C_DATA = 0x02; */
  /*   *I2C_MASK = 0b0011; */
  /*   printf("Got 0x%02X\r\n", *I2C_DATA); */
  /* } */
  *I2C_MC_ENABLED = 1;
  *I2C_MC_WRITE = 0;
  *I2C_MC_BYTELEN = 1;
  *I2C_MC_DATAIN = 0x20;
  *I2C_MC_SUBADDR = 0x12;
  *I2C_MC_REQ_TRANS = 1;
  *I2C_MC_REQ_TRANS = 0;

  while (1) {
    int tmp = *I2C_MC_STATUS & 0b00100;
    if (tmp){
      break;
    }
  }
  while (1) {
    int tmp = *I2C_MC_STATUS & 0b00100;
    if (!tmp){
      break;
    }
  }

  *I2C_MC_WRITE = 1;
  *I2C_MC_BYTELEN = 2;
  *I2C_MC_DATAIN = 0xAB;
  *I2C_MC_SUBADDR = 0x12;
  *I2C_MC_REQ_TRANS = 1;
  *I2C_MC_REQ_TRANS = 0;

  // Waiting for it to request next byte
  while (1) {
    int tmp = *I2C_MC_STATUS & 0b10000;
    if (tmp){
      break;
    }
  }

  printf("Got: %02X\r\n", *I2C_MC_DATAOUT);
  *I2C_MC_CONTINUE_READ = 1;

  *I2C_MC_DATAIN = 0xCD;
  /* *I2C_MC_FORCE_STOP = 1; */
  /* *I2C_MC_NEXT_BYTE_READY = 1; */

  while (1) {
    printf("Waiting\r\n");
    int tmp = *I2C_MC_STATUS & 0b00001;
    if (tmp){
      printf("Got: %02X\r\n", *I2C_MC_DATAOUT);
      break;
    }
  }

  while (1) {
  }

  /* uart_rx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200)); */
  /* uart_tx_set_cpb(uart_compute_cpb(CLK_FREQ, 115200)); */

  // 22.8 dB
  // 28.4 dB
  /* freq_ds_mode_set(0); */
  /* freq_ds_out_invert_set(0); */
  /* freq_ds_out_switch_set(0); */
  /* freq_lo_div_set(2); */
  /* cordic_set_scale(0.5); */
  /* freq_osr_fc_set(compute_osr_fc(1e3, 3)); */

  freq_reset_n_set(0);
  freq_start_set(0);
  freq_reset_n_set(1);
  freq_start_set(1);

  // Start normal generation
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  // Disable dsmod and lo
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10010011;
  *FREQ_STATUS = 0b10001011;
  *FREQ_STATUS = 0b10000011;

  // Enable external analog input
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10111011;
  *FREQ_STATUS = 0b11011011;
  *FREQ_STATUS = 0b11111011;

  // Disable analog frontend
  *FREQ_STATUS = 0b01111011;

  // Normal generation again
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;

  // Deactivate everything
  *FREQ_STATUS = 0b01100000;

  // Normal generation again
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;

  // Test defaults
  *DS_DEFAULTS = 0b00000000;
  *DS_DEFAULTS = 0b00010000;
  *DS_DEFAULTS = 0b00110000;
  *DS_DEFAULTS = 0b01000000;
  *DS_DEFAULTS = 0b10010000;
  *DS_DEFAULTS = 0b10010001;
  *DS_DEFAULTS = 0b10011001;
  *DS_DEFAULTS = 0b11111111;

  // Deactivate everything
  *FREQ_STATUS = 0b01100000;

  // Normal generation again
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;
  *FREQ_STATUS = 0b10011011;

  // All LO modes
  *FREQ_DS_LO_CONF = 0b00000000;
  *FREQ_DS_LO_CONF = 0b00000001;
  *FREQ_DS_LO_CONF = 0b00000010;
  *FREQ_DS_LO_CONF = 0b00000011;
  // Test LO debug
  *FREQ_DS_LO_CONF = 0b00010000;
  *FREQ_DS_LO_CONF = 0b00010001;
  *FREQ_DS_LO_CONF = 0b00010010;
  *FREQ_DS_LO_CONF = 0b00010011;
  *FREQ_DS_LO_CONF = 0b00010100;
  *FREQ_DS_LO_CONF = 0b00010101;
  *FREQ_DS_LO_CONF = 0b00010110;
  *FREQ_DS_LO_CONF = 0b00010111;
  *FREQ_DS_LO_CONF = 0b00011000;
  *FREQ_DS_LO_CONF = 0b00011001;
  *FREQ_DS_LO_CONF = 0b00011010;
  *FREQ_DS_LO_CONF = 0b00011011;
  *FREQ_DS_LO_CONF = 0b00011100;
  *FREQ_DS_LO_CONF = 0b00011101;
  *FREQ_DS_LO_CONF = 0b00011110;
  *FREQ_DS_LO_CONF = 0b00011111;

  // Deactivate everything
  *FREQ_STATUS = 0b01100000;

  while (1) {
  }
  /* freq_reset_n_set(0); */
  /* // Test 2nd Order */
  /* freq_ds_mode_set(1); */
  /* freq_ds_out_invert_set(0); */
  /* /\* freq_ds_out_switch_set(0); *\/ */
  /* freq_lo_div_set(2); */
  /* cordic_set_scale(0.71); */
  /* freq_osr_fc_set(compute_osr_fc(10e3, 0)); */

  /* freq_reset_n_set(0); */
  /* freq_start_set(0); */
  /* freq_reset_n_set(1); */
  /* freq_start_set(1); */

  while (1) {
  }
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

uint32_t compute_cordic_I(double scale) {
  const double K_inv = 0.60725;
  double scaled_K = scale * K_inv;
  return scaled_K * (1 << FRAQ_BITS);
}

void cordic_set_scale(double scale) { *CORDIC_I = compute_cordic_I(scale); }
