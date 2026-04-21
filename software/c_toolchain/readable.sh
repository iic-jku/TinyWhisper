#!/usr/bin/env sh

hexdump -v -e '1/1 " %02X" "\n"' hardware_test.bin | sed 's/ //g' > demo.txt
