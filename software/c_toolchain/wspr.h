#ifndef WSPR_H_
#define WSPR_H_

#include <stdint.h>

extern const uint8_t WSPR_SYNC_VECTOR[162];
extern const uint32_t WSPR_FEC_A;
extern const uint32_t WSPR_FEC_B;

uint8_t wspr_bit_parity(uint32_t number);
uint8_t wspr_mapping_table(char character);
uint8_t wspr_align_call(char *call); // Expects buffer of 6 elements
uint32_t wspr_encode_call(char *aligned_call);
uint32_t wspr_encode_locator(char *locator); // Expects 4 elements
uint32_t wspr_encode_power(uint32_t locator, uint8_t power);
void wspr_pack_bits(uint32_t call, uint32_t loc_pwr, uint8_t *buffer);
void wspr_fec(uint8_t *input, uint8_t *buffer); // 162 bit buffer
uint8_t wspr_bit_reverse(uint8_t number);
void wspr_interleave(uint8_t *buffer);
void wspr_mapping(uint8_t *buffer);
uint8_t wspr_compute_symbols(uint8_t *symbol_buffer, char *callsign,
                             char *locator, char *power);

#endif // WSPR_H_
