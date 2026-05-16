# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

from wspr import align_call, encode_call, encode_locator, encode_power, pack_bits, fec, reverse_bits, interleave, mapping
from cocotb.types import LogicArray, Range

# Used reference implementations to create these tests:
# - https://github.com/kk6olf/wspr/blob/master/WSPR_Encode.ipynb
# - https://swharden.com/software/wspr-code-generator/ 

def test_align_call():
    assert align_call("DL9MJX")  == "DL9MJX"
    assert align_call("DL9MJ")   == "DL9MJ "
    assert align_call(" DL9MJ ") == "DL9MJ "
    assert align_call("DR1N")    == "DR1N  "
    assert align_call("A9MJ")    == " A9MJ  "
    assert align_call("A9M")     == " A9M  "
    assert align_call(" A9M ")   == " A9M  "

def test_encode_call() :
    assert encode_call("DL9MJ") == 96436034
    assert encode_call("KK6OLF") == 145782806

def test_encode_locator():
    assert encode_locator("JN49") == 15439

def test_encode_power():
    locator = encode_locator("JN49")
    assert encode_power(0, 0) == 64
    assert encode_power(locator, 30) == 1976286
    locator = encode_locator("CM87")
    assert encode_power(locator, 20) == 3495380

def test_pack_bits():
    assert pack_bits(0,0) == LogicArray(0, Range(80, 'downto', 0)) # 81 bits
    assert len(pack_bits(0,0)) == 81
    data = pack_bits(encode_call("KK6OLF"), encode_power(encode_locator("CM87"), 20))
    assert data[80:73] == LogicArray(0x8B, Range(7, 'downto', 0)) 
    assert data[80:33] == LogicArray(0x8B07816D5575, Range(47, 'downto', 0)) 

def test_fec():
    data = pack_bits(encode_call("KK6OLF"), encode_power(encode_locator("CM87"), 20))
    data = fec(data)
    test = [1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0]
    assert len(data) == 162
    assert data == test

def test_reverse_bits():
    assert reverse_bits(0b00000000) == 0b00000000
    assert reverse_bits(0b00000001) == 0b10000000
    assert reverse_bits(0b11111111) == 0b11111111

def test_interleave():
    data = interleave(fec(pack_bits(encode_call("KK6OLF"), encode_power(encode_locator("CM87"), 20))))
    test = [1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1]
    assert len(data) == 162
    assert data == test

def test_mapping():
    data = mapping(interleave(fec(pack_bits(encode_call("KK6OLF"), encode_power(encode_locator("CM87"), 20)))))
    test = [3, 1, 2, 2, 0, 2, 2, 2, 3, 0, 0, 0, 1, 3, 3, 0, 0, 0, 1, 2, 2, 3, 2, 3, 1, 3, 3, 0, 2, 0, 0, 2, 2, 2, 1, 2, 2, 1, 2, 3, 2, 2, 2, 2, 2, 2, 3, 2, 3, 3, 2, 2, 3, 3, 2, 1, 2, 0, 2, 3, 3, 0, 1, 0, 0, 0, 0, 3, 3, 2, 3, 0, 3, 0, 1, 2, 1, 2, 0, 3, 0, 2, 3, 0, 3, 3, 0, 0, 2, 3, 1, 2, 3, 0, 3, 0, 2, 0, 3, 0, 0, 2, 0, 2, 1, 0, 0, 1, 2, 0, 3, 3, 1, 0, 1, 3, 2, 0, 1, 3, 0, 1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 0, 2, 1, 2, 3, 0, 0, 1, 3, 2, 2, 0, 0, 0, 2, 2, 3, 3, 2, 3, 0, 1, 3, 0, 2, 2, 3, 1, 0, 0, 2]
    assert len(data) == 162
    assert data == test
    data = mapping(interleave(fec(pack_bits(encode_call("DL9MJ"), encode_power(encode_locator("JN49"), 30)))))
    test = [1, 1, 0, 2, 0, 2, 0, 0, 1, 0, 2, 0, 1, 1, 3, 0, 2, 0, 1, 0, 2, 3, 2, 3, 1, 1, 1, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 1, 2, 1, 2, 2, 2, 0, 0, 2, 3, 2, 1, 3, 0, 2, 1, 3, 2, 3, 0, 2, 2, 3, 3, 2, 3, 0, 2, 0, 2, 1, 1, 0, 1, 0, 1, 0, 3, 2, 3, 0, 0, 3, 2, 0, 1, 2, 1, 3, 0, 2, 2, 3, 3, 2, 1, 0, 3, 2, 2, 2, 3, 0, 0, 0, 0, 0, 3, 2, 2, 1, 0, 0, 1, 1, 3, 2, 3, 3, 2, 0, 1, 1, 0, 1, 2, 0, 2, 1, 3, 1, 0, 0, 2, 2, 2, 3, 2, 1, 2, 0, 1, 3, 2, 0, 0, 2, 0, 0, 2, 1, 3, 2, 1, 2, 3, 3, 2, 2, 0, 3, 1, 2, 0, 2]
    assert len(data) == 162
    assert data == test
