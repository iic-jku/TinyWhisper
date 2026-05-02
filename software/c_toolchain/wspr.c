#include "wspr.h"
#include <stddef.h>

const uint8_t WSPR_SYNC_VECTOR[162] = {
    1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1,
    1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0,
    1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0,
    1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0,
    0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1,
    0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0,
    0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0};

const uint32_t WSPR_FEC_A = 0xF2D05351;
const uint32_t WSPR_FEC_B = 0xE4613C47;

void *memset(void *ptr, int x, size_t n) {
  for (int i = 0; i < n; i++)
    ((unsigned char *)ptr)[i] = (unsigned char)x;

  return ptr;
}

void *memcpy(void *dest_str, const void *src_str, size_t n) {
  uint8_t *dest = (uint8_t *)dest_str;
  uint8_t *src = (uint8_t *)src_str;

  for (int i = 0; i < n; i++) {
    dest[i] = src[i];
  }

  return dest_str;
}

uint8_t wspr_bit_parity(uint32_t number) {
  uint8_t number_ones = 0;

  for (int i = 0; i < 32; i++) {
    number_ones += (number & 0x01);
    number = number >> 1;
  }

  return number_ones & 0x01;
}

// clang-format off
uint8_t wspr_mapping_table(char character) {
  switch (character) {
    case '0': return 0;
    case '1': return 1;
    case '2': return 2;
    case '3': return 3;
    case '4': return 4;
    case '5': return 5;
    case '6': return 6;
    case '7': return 7;
    case '8': return 8;
    case '9': return 9;
    case 'A': return 10;
    case 'B': return 11;
    case 'C': return 12;
    case 'D': return 13;
    case 'E': return 14;
    case 'F': return 15;
    case 'G': return 16;
    case 'H': return 17;
    case 'I': return 18;
    case 'J': return 19;
    case 'K': return 20;
    case 'L': return 21;
    case 'M': return 22;
    case 'N': return 23;
    case 'O': return 24;
    case 'P': return 25;
    case 'Q': return 26;
    case 'R': return 27;
    case 'S': return 28;
    case 'T': return 29;
    case 'U': return 30;
    case 'V': return 31;
    case 'W': return 32;
    case 'X': return 33;
    case 'Y': return 34;
    case 'Z': return 35;
    case ' ': return 36;
  }

  return 37;
}
// clang-format on

// Expects buffer of 7 elements
uint8_t wspr_align_call(char *call) {
  char tmp[7];
  tmp[6] = '\0';
  int8_t digit_pos = -1;
  int8_t end_index = 6;

  for (int i = 0; i < 6; i++) {
    if (digit_pos == -1 && call[i] >= 48 && call[i] <= 57) {
      // Found first digit
      digit_pos = i;
    }

    if (call[i] == '\0') {
      end_index = i;
      break;
    }
  }

  if (digit_pos == -1) {
    return 1; // Does not contain digit at all. Error
  }

  if (digit_pos > 2) {
    return 2; // Digit too late in callsign. Cannot fix by padding
  }

  if (digit_pos == 0) {
    return 3; // Digit at first position. Not possible
  }

  if (digit_pos == 2) {
    // Digit at correct pos, copy first three chars
    tmp[0] = call[0];
    tmp[1] = call[1];
    tmp[2] = call[2];
  } else if (digit_pos < 2) {
    // Padding left required
    tmp[0] = ' ';
    tmp[1] = call[0];
    tmp[2] = call[1];
  }

  // Copy/Pad remaining call
  for (int i = 3; i < 6; i++) {
    if (++digit_pos < end_index) {
      tmp[i] = call[digit_pos];
    } else {
      tmp[i] = ' ';
    }
  }

  // Copy tmp array back into parameter to be in situ
  for (int i = 0; i < 7; i++) {
    call[i] = tmp[i];
  }

  return 0;
}

uint32_t wspr_encode_call(char *aligned_call) {
  uint32_t N = wspr_mapping_table(aligned_call[0]);
  N = N * 36 + wspr_mapping_table(aligned_call[1]);
  N = N * 10 + wspr_mapping_table(aligned_call[2]);
  N = N * 27 + wspr_mapping_table(aligned_call[3]) - 10;
  N = N * 27 + wspr_mapping_table(aligned_call[4]) - 10;
  N = N * 27 + wspr_mapping_table(aligned_call[5]) - 10;

  return N;
}

// Expects 4 elements
uint32_t wspr_encode_locator(char *locator) {
  uint8_t C[4];
  C[0] = wspr_mapping_table(locator[0]) - 10;
  C[1] = wspr_mapping_table(locator[1]) - 10;
  C[2] = locator[2] - 48;
  C[3] = locator[3] - 48;

  uint32_t M1 = (179 - 10 * C[0] - C[2]) * 180 + 10 * C[1] + C[3];
  return M1;
}

uint32_t wspr_encode_power(uint32_t locator, uint8_t power) {
  uint32_t M = (locator << 7) + power + 64;
  return M;
}

void wspr_pack_bits(uint32_t call, uint32_t loc_pwr, uint8_t *buffer) {
  // Pack call
  for (int i = 27; i >= 0; i--) {
    buffer[i] = call & 0x01;
    call = call >> 1;
  }

  // Pack loc_pwr
  for (int i = 49; i >= 28; i--) {
    buffer[i] = loc_pwr & 0x01;
    loc_pwr = loc_pwr >> 1;
  }

  for (int i = 50; i < 81; i++) {
    buffer[i] = 0;
  }
}

// 162 bit buffer
void wspr_fec(uint8_t *input, uint8_t *buffer) {
  uint32_t reg_a = 0;
  uint32_t reg_b = 0;

  uint32_t tmp_a = 0;
  uint32_t tmp_b = 0;

  uint8_t buffer_counter = 0;
  for (int i = 0; i < 81; i++) {
    reg_a = (reg_a << 1) | input[i];
    reg_b = (reg_b << 1) | input[i];

    tmp_a = reg_a & WSPR_FEC_A;
    tmp_b = reg_b & WSPR_FEC_B;

    buffer[buffer_counter++] = wspr_bit_parity(tmp_a);
    buffer[buffer_counter++] = wspr_bit_parity(tmp_b);
  }
}

uint8_t wspr_bit_reverse(uint8_t number) {
  uint8_t reversed = 0;
  for (int i = 0; i < 8; i++) {
    reversed = reversed << 1;
    reversed += number & 0x01;
    number = number >> 1;
  }
  return reversed;
}

void wspr_interleave(uint8_t *buffer) {
  uint8_t tmp[162];
  uint8_t P = 0;
  uint8_t J;
  uint8_t I = 0;

  do {
    J = wspr_bit_reverse(I);

    if (J < 162) {
      tmp[J] = buffer[P++];
    }
    I++;
  } while (P != 162);

  // Copy tmp array back into buffer to stay in situ
  for (int i = 0; i < 162; i++) {
    buffer[i] = tmp[i];
  }
}

void wspr_mapping(uint8_t *buffer) {
  for (int i = 0; i < 162; i++) {
    buffer[i] = WSPR_SYNC_VECTOR[i] + (buffer[i] << 1);
  }
}

uint8_t wspr_compute_symbols(uint8_t *symbol_buffer, char *callsign,
                             char *locator, char *power) {
  // Copying callsign
  char call[7];
  for (int i = 0; i < 6; i++) {
    if (callsign[i] == '\0')
      break;
    call[i] = callsign[i];
  }

  char loc[5];
  for (int i = 0; i < 4; i++) {
    if (locator[i] == '\0')
      return 2; // Locator too short
    loc[i] = locator[i];
  }

  uint8_t pwr;
  if (power[0] >= '0' && power[0] <= '9') {
    pwr = power[0] - '0';
  } else {
    return 3;
  }

  if (power[1] >= '0' && power[1] <= '9') {
    pwr *= 10;
    pwr += power[1] - '0';
  } else {
    return 3;
  }

  if (wspr_align_call(call)) {
    return 1;
  }

  uint32_t call_encoded = wspr_encode_call(call);
  uint32_t loc_encoded = wspr_encode_locator(loc);
  uint32_t loc_pwr_encoded = wspr_encode_power(loc_encoded, pwr);

  uint8_t packed[81];
  wspr_pack_bits(call_encoded, loc_pwr_encoded, packed);

  wspr_fec(packed, symbol_buffer);
  wspr_interleave(symbol_buffer);
  wspr_mapping(symbol_buffer);

  return 0;
}
