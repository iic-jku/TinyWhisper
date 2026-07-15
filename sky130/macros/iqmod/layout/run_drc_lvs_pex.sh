#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# =====================================================
# Author: Simon Dorrer
# Last Modified: 07.02.2026
# Description: This .sh file executes DRC, LVS and PEX for a given building block.
# Usage: run_drc_lvs_pex.sh <schematic> <layout>
#        <schematic> - Name/path of the schematic file (.sch)
#        <layout>    - Name/path of the layout file (.mag/.gds)
# =====================================================

set -e +x

cd $(dirname "$0")

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# Check for required parameters
if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <schematic> <layout>${NC}"
    echo "       <schematic> - Name/path of the schematic file (.sch)"
    echo "       <layout>    - Name/path of the layout file (.mag/.gds)"
    exit 1
fi

schematic=$1
layout=$2

# Extract cell name from layout (basename without extension)
cellname=$(basename "$layout" | cut -d. -f1)

# Create output directories if they don't exist
mkdir -p ../drc
mkdir -p ../lvs
mkdir -p ../spice

echo -e "${GREEN}Executing DRC... ${NC}"
sak-drc.sh -m -w ../drc ${layout}

echo -e "${GREEN}Executing LVS... ${NC}"
sak-lvs.sh -s ${schematic} -l ${layout} -c ${cellname} -w ../lvs

echo -e "${GREEN}Executing PEX... ${NC}"
sak-pex.sh -m 1 -w ../spice ${layout}

echo -e "${GREEN}Executed DRC, LVS and PEX successfully. ${NC}"
