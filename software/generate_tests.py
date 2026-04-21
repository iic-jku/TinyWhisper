# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0

#!/usr/bin/env python3

from wspr import align_call, encode_call, encode_locator, encode_power, pack_bits, fec, reverse_bits, interleave, mapping, mapping_table
from cocotb.types import LogicArray, Range
from itertools import product
import random


def mapped_to_logic(mapped):
    result = "0b"

    for i in mapped:
        result += bin(i)[2:].zfill(2)

    return result

def loc_to_encode(loc):
    result = ""
    result += "5'd{}, ".format(str(ord(loc[0].upper()) - 65))
    result += "5'd{}, ".format(str(ord(loc[1].upper()) - 65))
    result += "5'd{}, ".format(str(loc[2]))
    result += "5'd{}, ".format(str(loc[3]))
    return result

def callsign_tests():
    calls = ["DL9MJ", "DK7JH", "DO5JMH",
             "DA6LJ", "DA6LJH", "EA1RDT", "DP0GVN",
             "KK6OLF", "DL2YMR"]

    locs = ["JN49", "JN28", "IO82", "GP74", "CO73", "EP35", "DL90", "JL96"]

    for call, loc in product(calls, locs):
        aligned = align_call(call)

        sv_string = "{"
        for a in aligned:
            tmp = mapping_table[a]
            sv_string += f"6'd{tmp}, "

        # sv_string += "5'd9, 5'd13, 5'd4, 5'd9, 5'd30, "
        sv_string += loc_to_encode(loc)

        pwr = random.randint(0, 60)
        sv_string += f"6'd{str(pwr)}, "

        encoded_call = encode_call(call)
        encoded_loc = encode_locator(loc)
        encoded_pwr = encode_power(encoded_loc, pwr)
        packed = pack_bits(encoded_call, encoded_pwr)
        error_corrected = fec(packed)
        interleaved = interleave(error_corrected)
        mapped = mapping(interleaved)
        sv_string += f"324'd{str(int(mapped_to_logic(mapped), base=2))}" + "},"
        print(sv_string)


if __name__ == "__main__":
    callsign_tests()
