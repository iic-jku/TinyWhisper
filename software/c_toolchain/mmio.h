// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0

#ifndef MMIO_H_
#define MMIO_H_

#include <stdint.h>

extern volatile char *const GPIO_OUT;
extern volatile char *const GPIO_IN;

extern volatile char *const UART_TX;

extern volatile uint8_t *const I2C_DEVICE_ADDR;
extern volatile uint32_t *const I2C_DATA;
extern volatile uint8_t *const I2C_MASK;
extern volatile uint8_t *const I2C_ACKS;

extern volatile unsigned int *const MTIME;
extern volatile unsigned int *const MTIMEH;
extern volatile unsigned int *const MTIMECMP;
extern volatile unsigned int *const MTIMECMPH;

extern volatile uint8_t *const FREQ_STATUS;
extern volatile uint32_t *const FREQ_OSR_FC;
extern volatile uint8_t *const FREQ_DS_LO_CONF;

extern volatile uint8_t *const UART_RX_STATUS;
extern volatile uint8_t *const UART_RX_DATA;

extern volatile uint16_t *const UART_RX_CPB;
extern volatile uint16_t *const UART_TX_CPB;
extern volatile uint16_t *const SCL_RATIO;

extern volatile uint32_t *const CORDIC_I;
extern volatile uint32_t *const CORDIC_Q;

extern volatile uint8_t *const DS_DEFAULTS;

extern volatile uint8_t *const I2C_MC_ENABLED;
extern volatile uint16_t *const I2C_MC_SUBADDR;
extern volatile uint8_t *const I2C_MC_SUBLEN;
extern volatile uint32_t *const I2C_MC_BYTELEN;
extern volatile uint8_t *const I2C_MC_REQ_TRANS;
extern volatile uint8_t *const I2C_MC_WRITE;
extern volatile uint8_t *const I2C_MC_DATAIN;
extern volatile uint8_t *const I2C_MC_DATAOUT;
extern volatile uint8_t *const I2C_MC_STATUS;
extern volatile uint8_t *const I2C_MC_NEXT_BYTE_READY;
extern volatile uint8_t *const I2C_MC_FORCE_STOP;
extern volatile uint8_t *const I2C_MC_CONTINUE_READ;

void freq_reset_n_set(uint8_t reset_n);
void freq_start_set(uint8_t start);
uint8_t freq_active_get();
uint32_t freq_osr_fc_get();
void freq_osr_fc_set(uint32_t osr_fc);
void freq_lo_div_set(uint8_t lo_div);
void freq_ds_mode_set(uint8_t mode);
void freq_ds_out_invert_set(uint8_t out_invert);
void freq_cordic_I_set(uint32_t cordic_I);
void freq_cordic_Q_set(uint32_t cordic_Q);

char uart_data_read();
uint8_t uart_data_valid();
void uart_rx_enable();
void uart_rx_disable();

uint16_t uart_compute_cpb(uint32_t freq_ns, uint32_t baud);
void uart_rx_set_cpb(uint16_t cpb);
void uart_tx_set_cpb(uint16_t cpb);
uint16_t scl_compute_ratio(uint32_t freq_ns, uint32_t scl_ns);
void scl_ratio_set(uint16_t scl_ratio);

#endif // MMIO_H_
