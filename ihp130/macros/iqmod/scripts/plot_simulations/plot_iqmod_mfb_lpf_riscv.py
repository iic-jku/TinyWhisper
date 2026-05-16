# -*- coding: utf-8 -*-
# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Author: Simon Dorrer
# Description: Transient and FFT plots of the MFB LPF driven by the RISC-V
#              DSM output (ngspice simulation).
# Created: 03.04.2026
# Last Modified: 03.04.2026
# ============================================

# Imports
import numpy as np
import matplotlib.pyplot as plt
import ngspice2python as ng
from pathlib import Path
# ============================================

# Plotting Configuration
# ============================================
# Enable interactive mode so plots do not block execution
plt.ion()
plt.close("all")

# Use LaTeX if available, otherwise fallback gracefully
try:
    plt.rc('text', usetex=True)
    plt.rc('font', family='serif', size=14)
except Exception:
    print("Warning: LaTeX not available. Using standard fonts.")
    plt.rc('font', size=12)
# =========================================================================

def main():
    # Resolve data and output paths relative to this script
    script_dir = Path(__file__).resolve().parent
    data_dir = script_dir / "data"
    figures_dir = script_dir / "figures"
    figures_dir.mkdir(parents=True, exist_ok=True)

    # ------------------------------------------------------------------
    # 1. Load transient simulation data
    # ------------------------------------------------------------------
    tran_file = data_dir / "iqmod_mfb_lpf_riscv_tb_tran.txt"

    time = ng.loadngspicecol(str(tran_file), "time")
    vinp = ng.loadngspicecol(str(tran_file), "v(vinp)")
    vinn = ng.loadngspicecol(str(tran_file), "v(vinn)")
    voutp = ng.loadngspicecol(str(tran_file), "v(voutp)")
    voutn = ng.loadngspicecol(str(tran_file), "v(voutn)")
    vout = ng.loadngspicecol(str(tran_file), "v(vout)")

    # Convert time to microseconds for readability
    time_us = time * 1e6

    # ------------------------------------------------------------------
    # 2. Transient Plot
    # ------------------------------------------------------------------
    fig1, axs = plt.subplots(2, sharex=True)
    fig1.set_figwidth(10)
    fig1.set_figheight(7)

    # Input signals: DSM+ and DSM-
    axs[0].plot(time_us, vinp, linewidth=1.2, label=r'$V_\mathrm{inp}$ (DSM+)')
    axs[0].plot(time_us, vinn, linewidth=1.2, label=r'$V_\mathrm{inn}$ (DSM$-$)')
    axs[0].set_ylabel(r'Voltage (V)')
    axs[0].set_title(r'MFB LPF -- RISC-V DSM Transient Simulation')
    axs[0].grid(visible=True, which='both', linestyle='--', alpha=0.5)
    axs[0].legend(loc='upper right')

    # Output signals: Voutp, Voutn, Vout
    axs[1].plot(time_us, voutp, linewidth=1.2, label=r'$V_\mathrm{outp}$')
    axs[1].plot(time_us, voutn, linewidth=1.2, label=r'$V_\mathrm{outn}$')
    axs[1].plot(time_us, vout, linewidth=1.8, label=r'$V_\mathrm{out} = V_\mathrm{outp} - V_\mathrm{outn}$')
    axs[1].set_xlabel(r'Time ($\mu$s)')
    axs[1].set_ylabel(r'Voltage (V)')
    axs[1].grid(visible=True, which='both', linestyle='--', alpha=0.5)
    axs[1].legend(loc='upper right')

    plt.tight_layout()
    plt.show()

    # ------------------------------------------------------------------
    # 3. Load FFT data
    # ------------------------------------------------------------------
    fft_file = data_dir / "iqmod_mfb_lpf_riscv_tb_tran_fft.txt"

    freq = ng.loadngspicecol(str(fft_file), "freq")
    mag_dB = ng.loadngspicecol(str(fft_file), "v(vout_spec_db)")

    # Convert frequency to kHz for readability
    freq_kHz = freq / 1e3

    # ------------------------------------------------------------------
    # 4. Identify fundamental and harmonics
    # ------------------------------------------------------------------
    # Fundamental: bin with the highest magnitude
    fund_idx = np.argmax(mag_dB)
    fund_freq = freq[fund_idx]

    # Detect harmonics as integer multiples of the fundamental
    harmonic_indices = []
    n = 2
    while True:
        harmonic_freq = n * fund_freq
        if harmonic_freq > freq[-1]:
            break
        idx = np.argmin(np.abs(freq - harmonic_freq))
        harmonic_indices.append((n, idx))
        n += 1

    # ------------------------------------------------------------------
    # 5. FFT Plot
    # ------------------------------------------------------------------
    fig2, ax = plt.subplots()
    fig2.set_figwidth(10)
    fig2.set_figheight(5)

    ax.plot(freq_kHz, mag_dB, linewidth=1.5, color='C0', label='Spectrum')

    # Highlight fundamental
    ax.plot(freq_kHz[fund_idx], mag_dB[fund_idx], 'o', markersize=8,
            color='C1', zorder=5,
            label=rf'Fundamental ($f_0 = {fund_freq/1e3:.1f}$ kHz)')

    # Highlight harmonics
    for n, idx in harmonic_indices:
        label = r'Harmonics' if n == 2 else None
        ax.plot(freq_kHz[idx], mag_dB[idx], 's', markersize=7,
                color='C3', zorder=5, label=label)
        ax.annotate(rf'${n}f_0$', xy=(freq_kHz[idx], mag_dB[idx]),
                    xytext=(5, 6), textcoords='offset points', fontsize=11,
                    color='C3')

    ax.set_xlabel(r'Frequency (kHz)')
    ax.set_ylabel(r'Magnitude (dB)')
    ax.set_title(r'MFB LPF -- RISC-V DSM Output Spectrum (FFT)')
    ax.grid(visible=True, which='both', linestyle='--', alpha=0.5)
    ax.legend(loc='upper right')
    plt.tight_layout()
    plt.show()

    # ------------------------------------------------------------------
    # 6. Single-period Vout plot (starting at zero crossing)
    # ------------------------------------------------------------------
    # Period from the fundamental frequency
    T = 1.0 / fund_freq

    # Find rising zero crossings of vout
    zero_crossings = np.where(np.diff(np.sign(vout)) > 0)[0]
    if len(zero_crossings) > 0:
        # Refine: pick the first crossing that leaves enough room for one period
        start_idx = None
        for zc in zero_crossings:
            end_time = time[zc] + T
            if end_time <= time[-1]:
                start_idx = zc
                break

        if start_idx is not None:
            end_idx = np.searchsorted(time, time[start_idx] + T)
            t_period = (time[start_idx:end_idx] - time[start_idx]) * 1e6  # µs
            vout_period = vout[start_idx:end_idx]

            fig3, ax3 = plt.subplots()
            fig3.set_figwidth(10)
            fig3.set_figheight(5)

            ax3.plot(t_period, vout_period, linewidth=2, color='C0',
                     label=r'$V_\mathrm{out}$')
            ax3.set_xlabel(r'Time ($\mu$s)')
            ax3.set_ylabel(r'Voltage (V)')
            ax3.set_title(r'MFB LPF -- $V_\mathrm{out}$')
            ax3.grid(visible=True, which='both', linestyle='--', alpha=0.5)
            ax3.legend(loc='upper right')
            plt.tight_layout()
            plt.show()

            # Export
            fig3.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran_period.svg"), bbox_inches='tight')
            fig3.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran_period.pdf"), bbox_inches='tight')
        else:
            print("Warning: No complete period found after a zero crossing.")
    else:
        print("Warning: No rising zero crossing found in Vout.")

    # ------------------------------------------------------------------
    # 7. DSM signal – a few periods
    # ------------------------------------------------------------------
    num_periods_dsm = 0.25
    T_dsm = num_periods_dsm * T

    # Start the DSM view from the same zero crossing used for the Vout period
    start_idx = start_idx + 9000
    if len(zero_crossings) > 0 and start_idx is not None:
        dsm_end_idx = np.searchsorted(time, time[start_idx] + T_dsm)
        t_dsm = (time[start_idx:dsm_end_idx] - time[start_idx]) * 1e6  # µs
        vinp_dsm = vinp[start_idx:dsm_end_idx]

        fig4, ax4 = plt.subplots()
        fig4.set_figwidth(10)
        fig4.set_figheight(5)

        ax4.plot(t_dsm, vinp_dsm, linewidth=1.2, color='C0', label=r'DSM')
        ax4.set_xlabel(r'Time ($\mu$s)')
        ax4.set_ylabel(r'Voltage (V)')
        ax4.set_title(r'MFB LPF -- Delta-Sigma Modulator Output')
        ax4.grid(visible=True, which='both', linestyle='--', alpha=0.5)
        ax4.legend(loc='upper right')
        plt.tight_layout()
        plt.show()

        # Export
        fig4.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_dsm.svg"), bbox_inches='tight')
        fig4.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_dsm.pdf"), bbox_inches='tight')
    else:
        t_dsm = None
        vinp_dsm = None
        print("Warning: Cannot plot DSM periods – no zero crossing found.")

    # ------------------------------------------------------------------
    # 8. Export figures and CSV
    # ------------------------------------------------------------------
    fig1.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran.svg"), bbox_inches='tight')
    fig1.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran.pdf"), bbox_inches='tight')

    fig2.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran_fft.svg"), bbox_inches='tight')
    fig2.savefig(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran_fft.pdf"), bbox_inches='tight')

    # CSV: DSM signal (few periods)
    if t_dsm is not None:
        np.savetxt(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_dsm.csv"),
                   np.column_stack((t_dsm, vinp_dsm)), comments="",
                   header="time_us,dsm", delimiter=",")

    # CSV: Single-period Vout
    if start_idx is not None:
        np.savetxt(str(figures_dir / "iqmod_mfb_lpf_riscv_tb_tran_period.csv"),
                   np.column_stack((t_period, vout_period)), comments="",
                   header="time_us,vout", delimiter=",")
    # ============================================

# Main Execution
if __name__ == '__main__':
    main()

    # Keep plots open
    input("\nPress Enter to close plots and exit...")
# =========================================================================
