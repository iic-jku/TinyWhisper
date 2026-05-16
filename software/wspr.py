# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

import re
from cocotb.types import LogicArray, Range, concat

mapping_table = {
    "0" : 0,
    "1" : 1,
    "2" : 2,
    "3" : 3,
    "4" : 4,
    "5" : 5,
    "6" : 6,
    "7" : 7,
    "8" : 8,
    "9" : 9,
    "A" : 10,
    "B" : 11,
    "C" : 12,
    "D" : 13,
    "E" : 14,
    "F" : 15,
    "G" : 16,
    "H" : 17,
    "I" : 18,
    "J" : 19,
    "K" : 20,
    "L" : 21,
    "M" : 22,
    "N" : 23,
    "O" : 24,
    "P" : 25,
    "Q" : 26,
    "R" : 27,
    "S" : 28,
    "T" : 29,
    "U" : 30,
    "V" : 31,
    "W" : 32,
    "X" : 33,
    "Y" : 34,
    "Z" : 35,
    " " : 36,
}

def align_call(call):
    call = call.strip()

    c0 = re.compile(r'\w\w\d\w\w\w')
    c1 = re.compile(r'\w\w\d\w\w')
    c2 = re.compile(r'\w\d\w\w')
    c3 = re.compile(r'\w\w\d\w')
    c4 = re.compile(r'\w\d\w$')

    if c0.match(call):
        return call
    elif c1.match(call):
        return call + " "
    elif c2.match(call):
        return " " + call + "  "
    elif c3.match(call):
        return call + "  "
    elif c4.match(call):
        return " " + call + "  "

def encode_call(call): # 28 Bits

    call = align_call(call)

    C = list(map(lambda c: mapping_table[c], call))

    N1 = C[0]
    N2 = N1 * 36 + C[1]
    N3 = N2 * 10 + C[2]
    N4 = N3 * 27 + C[3] - 10
    N5 = N4 * 27 + C[4] - 10
    N  = N5 * 27 + C[5] - 10

    return N

def encode_locator(locator):

    C = list(map(lambda c: mapping_table[c] - 10, locator[0:2]))
    C.append(int(locator[2]))
    C.append(int(locator[3]))

    M1 = (179-10*C[0]-C[2])*180+10*C[1]+C[3]

    return M1

def encode_power(locator, power):
    M = locator * 128 + power + 64
    return M

def pack_bits(call, locator_power):
    N = LogicArray(call, Range(27, 'downto', 0)) 
    M = LogicArray(locator_power, Range(21, 'downto', 0)) 

    result = concat(N, M)
    result = concat(result, LogicArray(0, Range(37, 'downto', 0)))
    result = LogicArray(result[87:7]) # Only the left-most 81 of these 88 total bits are subsequently used.

    return result

def fec(input):

    const_a = 0xF2D05351
    const_b = 0xE4613C47

    reg_a = 0
    reg_b = 0

    output = []

    for i in input:
        
        # Shift left and mask to keep it within 32 bits
        reg_a = (reg_a << 1) & 0xFFFFFFFF
        reg_b = (reg_b << 1) & 0xFFFFFFFF
        
        # Convert input to integer and mask to 32 bits and add it to the LSB
        reg_a |= int(i) & 0xFFFFFFFF
        reg_b |= int(i) & 0xFFFFFFFF

        # Perform the bitwise AND with the constants, this is are the taps of the SR
        tmp_a = reg_a & const_a
        tmp_b = reg_b & const_b

        # XOR the bits of the tapped registers (i.e. counting ones)
        parity_a = bin(tmp_a).count('1') & 1
        parity_b = bin(tmp_b).count('1') & 1

        output.append(parity_a)
        output.append(parity_b)

    return output

def reverse_bits(number):
    return int('{:08b}'.format(number)[::-1], 2) # Create bit-reverse

def interleave(bits): 
    output = [0] * 162
    p = 0
    for i in range(0, 255):
        j = reverse_bits(i)
        if j < 162:
            output[j] = bits[p]
            p += 1
    return output 

def mapping(bits):
    sync=[1,1,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0,0,1,0,0,1,0,1,1,1,1,0,0,0,0,0,0,0,1,0,0,1,0,1,0,0,0,0,0,0,1,0,1,1,0,0,1,1,0,1,0,0,0,1,1,0,1,0,0,0,0,1,1,0,1,0,1,0,1,0,1,0,0,1,0,0,1,0,1,1,0,0,0,1,1,0,1,0,1,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,1,1,1,0,1,1,0,0,1,1,0,1,0,0,0,1,1,1,0,0,0,0,0,1,0,1,0,0,1,1,0,0,0,0,0,0,0,1,1,0,1,0,1,1,0,0,0,1,1,0,0,0]
    symbols = []
    for i, bit in enumerate(bits):
        symbols.append(sync[i]+2*bit)
    return symbols

