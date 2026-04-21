#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Harald Pretl
# SPDX-License-Identifier: Apache-2.0
#
# Run PSD and SNDR simulations for all ORDER/OSR combinations.
# Generates plots for ORDER=1,2 and OSR=32,256 at -8 dBFS.
#
# Usage: ./sim_dsmod.sh [OPTIONS] [PYTHON_BIN]
#   -c, --clean   Remove intermediate files, keep only PNG plots
#   PYTHON_BIN    defaults to python3.13

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Parse options ---
DO_CLEAN=0
PYTHON_BIN="python3.13"

for arg in "$@"; do
    case "${arg}" in
        -c|--clean)
            DO_CLEAN=1
            ;;
        *)
            PYTHON_BIN="${arg}"
            ;;
    esac
done

# --- Clean mode ---
if [[ ${DO_CLEAN} -eq 1 ]]; then
    echo "Cleaning intermediate files in ${SCRIPT_DIR} ..."
    rm -f  "${SCRIPT_DIR}"/dsmod_*.txt
    rm -f  "${SCRIPT_DIR}"/dsmod_*.xml
    rm -f  "${SCRIPT_DIR}"/dsmod_*.log
    rm -f  "${SCRIPT_DIR}"/*.vcd
    rm -rf "${SCRIPT_DIR}"/dsmod_sim_build
    rm -rf "${SCRIPT_DIR}"/dsmod_sndr_results
    rm -rf "${SCRIPT_DIR}"/__pycache__
    echo "Done. PNG plot files preserved."
    exit 0
fi
AMP_PSD="-3"

ORDERS=(1 2)
OSRS=(32 64 128 256)

echo "=== Delta-Sigma Modulator Simulation Suite ==="
echo "  Orders : ${ORDERS[*]}"
echo "  OSRs   : ${OSRS[*]}"
echo "  Amp    : ${AMP_PSD} dBFS"
echo "  Python : ${PYTHON_BIN}"
echo ""

# Shared intermediate files prevent parallel cocotb runs in the same
# directory, so PSD and SNDR configs run sequentially.  Each SNDR sweep
# parallelises internally across amplitude points using all CPU cores.

failed=0

for order in "${ORDERS[@]}"; do
    for osr in "${OSRS[@]}"; do
        tag="ord${order}_osr${osr}"

        # --- PSD ---
        echo "[PSD]  ORDER=${order} OSR=${osr} ..."
        DSMOD_ORDER=${order} DSMOD_OSR=${osr} DSMOD_AMP_PSD=${AMP_PSD} \
            make -C "${SCRIPT_DIR}" -f Makefile.dsmod plot \
                PYTHON_BIN="${PYTHON_BIN}" \
            > "${SCRIPT_DIR}/dsmod_psd_${tag}.log" 2>&1 \
            && echo "[PSD]  ORDER=${order} OSR=${osr} done" \
            || { echo "[PSD]  ORDER=${order} OSR=${osr} FAILED (see dsmod_psd_${tag}.log)"; failed=1; }

        # --- SNDR (internally parallel across amplitude points) ---
        echo "[SNDR] ORDER=${order} OSR=${osr} ..."
        DSMOD_ORDER=${order} DSMOD_OSR=${osr} \
            "${PYTHON_BIN}" "${SCRIPT_DIR}/dsmod_sndr_sweep.py" \
            > "${SCRIPT_DIR}/dsmod_sndr_${tag}.log" 2>&1 \
            && DSMOD_ORDER=${order} DSMOD_OSR=${osr} \
                "${PYTHON_BIN}" "${SCRIPT_DIR}/dsmod_plot_sndr.py" \
                >> "${SCRIPT_DIR}/dsmod_sndr_${tag}.log" 2>&1 \
            && echo "[SNDR] ORDER=${order} OSR=${osr} done" \
            || { echo "[SNDR] ORDER=${order} OSR=${osr} FAILED (see dsmod_sndr_${tag}.log)"; failed=1; }

        echo ""
    done
done

echo "=== Summary ==="
echo "PSD plots:"
for order in "${ORDERS[@]}"; do
    for osr in "${OSRS[@]}"; do
        fname="dsmod_psd_ord${order}_osr${osr}_amp${AMP_PSD}dBFS.png"
        if [[ -f "${SCRIPT_DIR}/${fname}" ]]; then
            echo "  OK ${fname}"
        else
            echo "  MISSING ${fname}"
            failed=1
        fi
    done
done

echo "Analog plots:"
for order in "${ORDERS[@]}"; do
    for osr in "${OSRS[@]}"; do
        fname="dsmod_analog_ord${order}_osr${osr}_amp${AMP_PSD}dBFS.png"
        if [[ -f "${SCRIPT_DIR}/${fname}" ]]; then
            echo "  OK ${fname}"
        else
            echo "  MISSING ${fname}"
            failed=1
        fi
    done
done

echo "SNDR plots:"
for order in "${ORDERS[@]}"; do
    for osr in "${OSRS[@]}"; do
        fname="dsmod_sndr_ord${order}_osr${osr}.png"
        if [[ -f "${SCRIPT_DIR}/${fname}" ]]; then
            echo "  OK ${fname}"
        else
            echo "  MISSING ${fname}"
            failed=1
        fi
    done
done

if [[ ${failed} -ne 0 ]]; then
    echo ""
    echo "Some simulations failed. Check log files in ${SCRIPT_DIR}/"
    exit 1
fi

echo ""
echo "All simulations completed successfully."
