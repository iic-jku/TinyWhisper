# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0

#!/usr/bin/env python3

import sys
import serial
import time
from wspr import *

iterations = 256  # OSR from dsmod takes longer than cordic
f_clk = 56e6  # 12 MHz on pico-ice
f_s = f_clk / iterations

RESET_ADDR = 0
LO_DIV_ADDR = 1
F_C_START = 2
CALLSIGN_START = 10


def send_to_chip(bytes, port):
    with serial.Serial(port, baudrate=115200) as ser:
        for b in bytes:
            print(f"8'd{int.from_bytes(b)},")
            ser.write(b)
            time.sleep(0.02)


def reset(port="/dev/ttyACM1"):
    to_send = [RESET_ADDR.to_bytes(), b"\x00", b"\x00"]
    send_to_chip(to_send, port)


def start_encoding(port="/dev/ttyACM1"):
    to_send = [RESET_ADDR.to_bytes(), b"\x00", b"\x01"]
    send_to_chip(to_send, port)


def set_data(callsign, locator, power, port="/dev/ttyACM1"):
    aligned = align_call(callsign)
    call = list(map(lambda c: mapping_table[c], aligned))

    loc = list(map(lambda c: mapping_table[c] - 10, locator[0:2]))
    loc.append(int(locator[2]))
    loc.append(int(locator[3]))

    to_send = []
    # C1, C2
    tmp = bin(call[0])[2:].zfill(6) + bin(call[1])[2:].zfill(6) + "0000"
    to_send.append(CALLSIGN_START.to_bytes())
    to_send.append(int("0b" + tmp[0:8], base=2).to_bytes())
    to_send.append(int("0b" + tmp[8:16], base=2).to_bytes())
    # C3, C4
    tmp = bin(call[2])[2:].zfill(6) + bin(call[3])[2:].zfill(6) + "0000"
    to_send.append((CALLSIGN_START+1).to_bytes())
    to_send.append(int("0b" + tmp[0:8], base=2).to_bytes())
    to_send.append(int("0b" + tmp[8:16], base=2).to_bytes())
    # C5, C6
    tmp = bin(call[4])[2:].zfill(6) + bin(call[5])[2:].zfill(6) + "0000"
    to_send.append((CALLSIGN_START+2).to_bytes())
    to_send.append(int("0b" + tmp[0:8], base=2).to_bytes())
    to_send.append(int("0b" + tmp[8:16], base=2).to_bytes())

    # Loc 1-3
    tmp = bin(loc[0])[2:].zfill(5) + bin(loc[1])[2:].zfill(5) + bin(loc[2])[2:].zfill(5) + "0"
    to_send.append((CALLSIGN_START+3).to_bytes())
    to_send.append(int("0b" + tmp[0:8], base=2).to_bytes())
    to_send.append(int("0b" + tmp[8:16], base=2).to_bytes())
    # Loc 4 + Pwr
    tmp = bin(loc[3])[2:].zfill(5) + bin(power)[2:].zfill(6) + "00000"
    to_send.append((CALLSIGN_START+4).to_bytes())
    to_send.append(int("0b" + tmp[0:8], base=2).to_bytes())
    to_send.append(int("0b" + tmp[8:16], base=2).to_bytes())

    send_to_chip(to_send, port)


def set_symbols(symbols, port="/dev/ttyACM1"):
    # Handle all except last 2 symbols
    for i in range(20):
        msb = "0b"
        lsb = "0b"
        msb += bin(symbols[8*i+0])[2:].zfill(2)
        msb += bin(symbols[8*i+1])[2:].zfill(2)
        msb += bin(symbols[8*i+2])[2:].zfill(2)
        msb += bin(symbols[8*i+3])[2:].zfill(2)
        lsb += bin(symbols[8*i+4])[2:].zfill(2)
        lsb += bin(symbols[8*i+5])[2:].zfill(2)
        lsb += bin(symbols[8*i+6])[2:].zfill(2)
        lsb += bin(symbols[8*i+7])[2:].zfill(2)

        msb = int(msb, base=2)
        lsb = int(lsb, base=2)

        to_send = [(i+SYMBOL_START).to_bytes(), msb.to_bytes(), lsb.to_bytes()]
        send_to_chip(to_send, port)

    # Handle last two symbols
    to_send = [(SYMBOL_START + 20).to_bytes()]
    data = ""
    data += bin(symbols[8*20+0])[2:].zfill(2)
    data += bin(symbols[8*20+1])[2:].zfill(2)
    data += "0000"
    data = int("0b" + data, base=2)
    to_send.append(data.to_bytes())
    to_send.append(b"\x00")
    send_to_chip(to_send, port)


def set_lo_div(value, port="/dev/ttyACM1"):
    to_send = []
    to_send.append(LO_DIV_ADDR.to_bytes())
    to_send.append(b"\x00")
    to_send.append(value.to_bytes())

    send_to_chip(to_send, port)

def compute_fc(frequency):
    global f_s

    return (2 / f_s) * frequency


def set_fc(value, OSR, symbol, port="/dev/ttyACM1"):
    freq_bytes = bin(round(value * 2**29))[2:].zfill(30)
    osr_bits = bin(OSR)[2:].zfill(2)

    tmp = osr_bits + freq_bytes

    result = []
    result.append((symbol*2 + F_C_START).to_bytes())
    result.append(int("0b" + tmp[16:24], base=2).to_bytes())
    result.append(int("0b" + tmp[24:32], base=2).to_bytes())
    result.append((symbol*2 + F_C_START + 1).to_bytes())
    result.append(int("0b" + tmp[0:8], base=2).to_bytes())
    result.append(int("0b" + tmp[8:16], base=2).to_bytes())

    send_to_chip(result, port)


if __name__ == "__main__":
    frac_bits = 29

    reset()
    set_data("DK7JH", "JN49", 30)

    # TODO: OSR for computing f_c is currently set globally but
    # OSR that is programmed is parameter. @Jonathan fix this
    set_lo_div(2)
    set_fc(compute_fc(1500), 3, symbol=0)
    set_fc(compute_fc(1501.5), 3, symbol=1)
    set_fc(compute_fc(1503), 3, symbol=2)
    set_fc(compute_fc(1504.5), 3, symbol=3)

    # set_fc(compute_fc(38.6e3 - 2.197), 2, symbol=0)
    # set_fc(compute_fc(38.6e3 - 0.732), 2, symbol=1)
    # set_fc(compute_fc(38.6e3 + 0.732), 2, symbol=2)
    # set_fc(compute_fc(38.6e3 + 2.197), 2, symbol=3)

    start_encoding()
