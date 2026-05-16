#!/usr/bin/env sh

# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

hexdump -v -e '1/1 " %02X" "\n"' hardware_test.bin | sed 's/ //g' > demo.txt
