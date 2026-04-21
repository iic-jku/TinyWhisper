# -*- coding: utf-8 -*-
# Master-Thesis
# @ JKU IIC / ISP
# 2024
# Author: Simon Dorrer
# Description: Plotting simulations of CFA.
# Created: 30.05.2025
# Last Modified: 30.05.2025
# ============================================

# Imports
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import ngspice2python as ng
# ============================================

plt.close("all")
# %matplotlib qt
# %matplotlib inline
# ============================================

# Latex font settings in plot
# plt.rc('text', usetex = True)
# plt.rc('font', family = 'serif', size = 14)
# ============================================

# Variables

# ============================================

# Functions

# ============================================

# Main
if __name__ == '__main__':

    # CFA
    # Open-Loop Gain
    # Load data from .txt
    data_frequency = ng.loadngspicecol("data/amplifier_core_simplified_tb_ac_ol_final.txt", "frequency")
    frequency = data_frequency[0::2]
    
    data_Aol_dB = ng.loadngspicecol("data/amplifier_core_simplified_tb_ac_ol_final.txt", "v(Aol_dB)")
    Aol_dB = data_Aol_dB[0::2]
    
    data_Aol_arg = ng.loadngspicecol("data/amplifier_core_simplified_tb_ac_ol_final.txt", "v(Aol_arg)")
    Aol_arg = data_Aol_arg[0::2]
    
    # Plot
    fig1, axs = plt.subplots(2)
    axs[0].set_xscale('log')
    axs[0].plot(frequency, Aol_dB, linewidth = 2)
    axs[0].set_xlabel('$f$ (Hz)')
    axs[0].set_ylabel('Magnitude (dB)')
    axs[0].grid(visible = True, linestyle='--')
    axs[1].set_xscale('log')
    axs[1].plot(frequency, Aol_arg, linewidth = 2)
    axs[1].set_xlabel('$f$ (Hz)')
    axs[1].set_ylabel('Phase (°)')
    axs[1].grid(visible = True, linestyle='--')
    plt.tight_layout()
    plt.show()
    
    fig1.savefig("figures/amplifier/amplifier_core_simplified_tb_ac_ol.svg", bbox_inches='tight')
    fig1.savefig("figures/amplifier/amplifier_core_simplified_tb_ac_ol.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/amplifier_core_simplified_tb_ac_ol.csv", 
              np.column_stack((frequency, Aol_dB, Aol_arg)), comments = "", 
              header = "frequency,Aol_dB,Aol_arg", delimiter = ",")
    
    # Closed-Loop Gain
    # Load data from .txt
    data_frequency = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_20dB.txt", "frequency")
    frequency = data_frequency[0::2]
    
    data_Aol_dB_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_20dB.txt", "v(Amag_dB)")
    Aol_dB_20dB = data_Aol_dB_20dB[0::2]
    
    data_Aol_arg_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_20dB.txt", "v(Aarg)")
    Aol_arg_20dB = data_Aol_arg_20dB[0::2]
    
    data_Aol_dB_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_34dB.txt", "v(Amag_dB)")
    Aol_dB_34dB = data_Aol_dB_34dB[0::2]
    
    data_Aol_arg_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_34dB.txt", "v(Aarg)")
    Aol_arg_34dB = data_Aol_arg_34dB[0::2]
    
    data_Aol_dB_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_40dB.txt", "v(Amag_dB)")
    Aol_dB_40dB = data_Aol_dB_40dB[0::2]
    
    data_Aol_arg_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_40dB.txt", "v(Aarg)")
    Aol_arg_40dB = data_Aol_arg_40dB[0::2]
    
    # Plot
    fig2, axs = plt.subplots(2)
    axs[0].set_xscale('log')
    axs[0].plot(frequency, Aol_dB_20dB, linewidth = 2)
    axs[0].plot(frequency, Aol_dB_34dB, linewidth = 2)
    axs[0].plot(frequency, Aol_dB_40dB, linewidth = 2)
    axs[0].legend(['20dB', '34dB', '40dB'])
    axs[0].set_xlabel('$f$ (Hz)')
    axs[0].set_ylabel('Magnitude (dB)')
    axs[0].grid(visible = True, linestyle='--')
    axs[1].set_xscale('log')
    axs[1].plot(frequency, Aol_arg_20dB, linewidth = 2)
    axs[1].plot(frequency, Aol_arg_34dB, linewidth = 2)
    axs[1].plot(frequency, Aol_arg_40dB, linewidth = 2)
    axs[1].legend(['20dB', '34dB', '40dB'])
    axs[1].set_xlabel('$f$ (Hz)')
    axs[1].set_ylabel('Phase (°)')
    axs[1].grid(visible = True, linestyle='--')
    plt.tight_layout()
    plt.show()
    
    fig2.savefig("figures/amplifier/bio_amplifier_simplified_tb_ac_cl.svg", bbox_inches='tight')
    fig2.savefig("figures/amplifier/bio_amplifier_simplified_tb_ac_cl.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/bio_amplifier_simplified_tb_ac_cl.csv", 
              np.column_stack((frequency, Aol_dB_20dB, Aol_dB_34dB, Aol_dB_40dB, Aol_arg_20dB, Aol_arg_34dB, Aol_arg_40dB)), comments = "", 
              header = "frequency,Aol_dB_20dB,Aol_dB_34dB,Aol_dB_40dB,Aol_arg_20dB,Aol_arg_34dB,Aol_arg_40dB", delimiter = ",")
    
    # Loop Gain
    # Load data from .txt
    data_frequency = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_20dB.txt", "frequency")
    frequency = data_frequency[0::2]
    
    data_Tian_dB_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_20dB.txt", "v(Ttian_dB)")
    Tian_dB_20dB = data_Tian_dB_20dB[0::2]
    
    data_Tian_arg_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_20dB.txt", "v(Ttian_arg)")
    Tian_arg_20dB = data_Tian_arg_20dB[0::2]
    
    data_Tian_dB_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_34dB.txt", "v(Ttian_dB)")
    Tian_dB_34dB = data_Tian_dB_34dB[0::2]
    
    data_Tian_arg_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_34dB.txt", "v(Ttian_arg)")
    Tian_arg_34dB = data_Tian_arg_34dB[0::2]
    
    data_Tian_dB_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_40dB.txt", "v(Ttian_dB)")
    Tian_dB_40dB = data_Tian_dB_40dB[0::2]
    
    data_Tian_arg_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_loopgain_all_40dB.txt", "v(Ttian_arg)")
    Tian_arg_40dB = data_Tian_arg_40dB[0::2]
    
    # Plot
    fig3, axs = plt.subplots(2)
    axs[0].set_xscale('log')
    axs[0].plot(frequency, Tian_dB_20dB, linewidth = 2)
    axs[0].plot(frequency, Tian_dB_34dB, linewidth = 2)
    axs[0].plot(frequency, Tian_dB_40dB, linewidth = 2)
    axs[0].legend(['20dB', '34dB', '40dB'])
    axs[0].set_xlabel('$f$ (Hz)')
    axs[0].set_ylabel('Magnitude (dB)')
    axs[0].grid(visible = True, linestyle='--')
    axs[1].set_xscale('log')
    axs[1].plot(frequency, Tian_arg_20dB, linewidth = 2)
    axs[1].plot(frequency, Tian_arg_34dB, linewidth = 2)
    axs[1].plot(frequency, Tian_arg_40dB, linewidth = 2)
    axs[1].legend(['20dB', '34dB', '40dB'])
    axs[1].set_xlabel('$f$ (Hz)')
    axs[1].set_ylabel('Phase (°)')
    axs[1].grid(visible = True, linestyle='--')
    plt.tight_layout()
    plt.show()
    
    fig3.savefig("figures/amplifier/bio_amplifier_simplified_tb_loopgain.svg", bbox_inches='tight')
    fig3.savefig("figures/amplifier/bio_amplifier_simplified_tb_loopgain.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/bio_amplifier_simplified_tb_loopgain.csv", 
              np.column_stack((frequency, Tian_dB_20dB, Tian_dB_34dB, Tian_dB_40dB, Tian_arg_20dB, Tian_arg_34dB, Tian_arg_40dB)), comments = "", 
              header = "frequency,Tian_dB_20dB,Tian_dB_34dB,Tian_dB_40dB,Tian_arg_20dB,Tian_arg_34dB,Tian_arg_40dB", delimiter = ",")
    
    # Transient - ECG 1s
    # Load data from .txt
    data_time = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "time")
    time = data_time[0::1000]
    
    data_Vind = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "v(vind)")
    Vind = data_Vind[0::1000]
    
    data_vinp = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "v(vinp)")
    Vinp = data_vinp[0::1000]
    
    data_vinn = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "v(vinn)")
    Vinn = data_vinn[0::1000]
    
    data_voutp = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "v(voutp)")
    Voutp = data_voutp[0::1000]
    
    data_voutn = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "v(voutn)")
    Voutn = data_voutn[0::1000]
    
    data_vout = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_ECG_1s.txt", "v(vout)")
    Vout = data_vout[0::1000]
    
    # Plot
    fig4 = plt.figure(num = 1, tight_layout = True)
    plt.plot(time, Voutp, linewidth = 2)
    plt.plot(time, Voutn, linewidth = 2)
    plt.plot(time, Vout, linewidth = 2)
    plt.xlabel('$t$ (s)')
    plt.ylabel('$V$ (V)')
    plt.grid(visible = True, linestyle='--')
    plt.legend(['Voutp', 'Voutn', 'Vout'])
    plt.show()
    
    fig4.savefig("figures/amplifier/bio_amplifier_simplified_tb_tran_ECG_1s.svg", bbox_inches='tight')
    fig4.savefig("figures/amplifier/bio_amplifier_simplified_tb_tran_ECG_1s.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/bio_amplifier_simplified_tb_tran_ECG_1s.csv", 
              np.column_stack((time, Voutp, Voutn, Vout)), comments = "", 
              header = "time,Voutp,Voutn,Vout", delimiter = ",")
    
    # CM Zin
    # Load data from .txt
    data_frequency = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_cm_20dB.txt", "frequency")
    frequency = data_frequency[0::2]
    
    data_Zin_cm_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_cm_20dB.txt", "v(Zin_cm)")
    Zin_cm_20dB = data_Zin_cm_20dB[0::2] / 1e9
    
    data_Zin_cm_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_cm_34dB.txt", "v(Zin_cm)")
    Zin_cm_34dB = data_Zin_cm_34dB[0::2] / 1e9
    
    data_Zin_cm_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_cm_40dB.txt", "v(Zin_cm)")
    Zin_cm_40dB = data_Zin_cm_40dB[0::2] / 1e9
      
    # Plot
    fig5 = plt.figure(num = 1, tight_layout = True)
    plt.xscale('log')
    plt.plot(frequency, Zin_cm_20dB, linewidth = 2)
    plt.plot(frequency, Zin_cm_34dB, linewidth = 2)
    plt.plot(frequency, Zin_cm_40dB, linewidth = 2)
    plt.xlabel('$f$ (Hz)')
    plt.ylabel('$CM Zin$ (GOhm)')
    plt.grid(visible = True, linestyle='--')
    plt.legend(['20dB', '34dB', '40dB'])
    plt.show()
    
    fig5.savefig("figures/amplifier/bio_amplifier_simplified_tb_Zin_cm.svg", bbox_inches='tight')
    fig5.savefig("figures/amplifier/bio_amplifier_simplified_tb_Zin_cm.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/bio_amplifier_simplified_tb_Zin_cm.csv", 
              np.column_stack((frequency, Zin_cm_20dB, Zin_cm_34dB, Zin_cm_40dB)), comments = "", 
              header = "frequency,Zin_cm_20dB,Zin_cm_34dB,Zin_cm_40dB", delimiter = ",")
    
    # DM Zin
    # Load data from .txt
    data_frequency = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_dm_20dB.txt", "frequency")
    frequency = data_frequency[0::2]
    
    data_Zin_dm_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_dm_20dB.txt", "v(Zin_dm)")
    Zin_dm_20dB = data_Zin_dm_20dB[0::2] / 1e6
    
    data_Zin_dm_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_dm_34dB.txt", "v(Zin_dm)")
    Zin_dm_34dB = data_Zin_dm_34dB[0::2] / 1e6
    
    data_Zin_dm_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_Zin_dm_40dB.txt", "v(Zin_dm)")
    Zin_dm_40dB = data_Zin_dm_40dB[0::2] / 1e6
      
    # Plot
    fig6 = plt.figure(num = 1, tight_layout = True)
    plt.xscale('log')
    plt.plot(frequency, Zin_dm_20dB, linewidth = 2)
    plt.plot(frequency, Zin_dm_34dB, linewidth = 2)
    plt.plot(frequency, Zin_dm_40dB, linewidth = 2)
    plt.xlabel('$f$ (Hz)')
    plt.ylabel('$DM Zin$ (MOhm)')
    plt.grid(visible = True, linestyle='--')
    plt.legend(['20dB', '34dB', '40dB'])
    plt.show()
    
    fig6.savefig("figures/amplifier/bio_amplifier_simplified_tb_Zin_dm.svg", bbox_inches='tight')
    fig6.savefig("figures/amplifier/bio_amplifier_simplified_tb_Zin_dm.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/bio_amplifier_simplified_tb_Zin_dm.csv", 
              np.column_stack((frequency, Zin_dm_20dB, Zin_dm_34dB, Zin_dm_40dB)), comments = "", 
              header = "frequency,Zin_dm_20dB,Zin_dm_34dB,Zin_dm_40dB", delimiter = ",")
    
    # Zin
    # Load data from .txt
    data_frequency = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_33pF_480M.txt", "frequency")
    frequency = data_frequency[0::2]
    
    data_Aol_dB_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_33pF_480M.txt", "v(Amag_dB)")
    Aol_dB_20dB = data_Aol_dB_20dB[0::2]
    
    data_Aol_arg_20dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_33pF_480M.txt", "v(Aarg)")
    Aol_arg_20dB = data_Aol_arg_20dB[0::2]
    
    data_Aol_dB_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_165pF_96M.txt", "v(Amag_dB)")
    Aol_dB_34dB = data_Aol_dB_34dB[0::2]
    
    data_Aol_arg_34dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_165pF_96M.txt", "v(Aarg)")
    Aol_arg_34dB = data_Aol_arg_34dB[0::2]
    
    data_Aol_dB_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_330pF_48M.txt", "v(Amag_dB)")
    Aol_dB_40dB = data_Aol_dB_40dB[0::2]
    
    data_Aol_arg_40dB = ng.loadngspicecol("data/bio_amplifier_simplified_tb_ac_cl_330pF_48M.txt", "v(Aarg)")
    Aol_arg_40dB = data_Aol_arg_40dB[0::2]
    
    # Plot
    fig7, axs = plt.subplots(2)
    axs[0].set_xscale('log')
    axs[0].plot(frequency, Aol_dB_20dB, linewidth = 2)
    axs[0].plot(frequency, Aol_dB_34dB, linewidth = 2)
    axs[0].plot(frequency, Aol_dB_40dB, linewidth = 2)
    axs[0].legend(['C1 = 33pF, R1 = 480M', 'C1 = 165pF, R1 = 96M', 'C1 = 330pF, R1 = 48M'])
    axs[0].set_xlabel('$f$ (Hz)')
    axs[0].set_ylabel('Magnitude (dB)')
    axs[0].grid(visible = True, linestyle='--')
    axs[1].set_xscale('log')
    axs[1].plot(frequency, Aol_arg_20dB, linewidth = 2)
    axs[1].plot(frequency, Aol_arg_34dB, linewidth = 2)
    axs[1].plot(frequency, Aol_arg_40dB, linewidth = 2)
    axs[1].legend(['C1 = 33pF, R1 = 480M', 'C1 = 165pF, R1 = 96M', 'C1 = 330pF, R1 = 48M'])
    axs[1].set_xlabel('$f$ (Hz)')
    axs[1].set_ylabel('Phase (°)')
    axs[1].grid(visible = True, linestyle='--')
    plt.tight_layout()
    plt.show()
    
    fig7.savefig("figures/amplifier/bio_amplifier_simplified_tb_ac_Zin.svg", bbox_inches='tight')
    fig7.savefig("figures/amplifier/bio_amplifier_simplified_tb_ac_Zin.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/bio_amplifier_simplified_tb_ac_Zin.csv", 
              np.column_stack((frequency, Aol_dB_20dB, Aol_dB_34dB, Aol_dB_40dB, Aol_arg_20dB, Aol_arg_34dB, Aol_arg_40dB)), comments = "", 
              header = "frequency,Aol_dB_20dB,Aol_dB_34dB,Aol_dB_40dB,Aol_arg_20dB,Aol_arg_34dB,Aol_arg_40dB", delimiter = ",")
    
    # Transient - Slew Rate
    # Load data from .txt
    data_time = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "time")
    time = data_time[16000:16500:1] * 1e3
    
    data_Vind = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "v(vind)")
    Vind = data_Vind[16000:16500:1]
    
    data_vinp = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "v(vinp)")
    Vinp = data_vinp[16000:16500:1]
    
    data_vinn = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "v(vinn)")
    Vinn = data_vinn[16000:16500:1]
    
    data_voutp = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "v(voutp)")
    Voutp = data_voutp[16000:16500:1]
    
    data_voutn = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "v(voutn)")
    Voutn = data_voutn[16000:16500:1]
    
    data_vout = ng.loadngspicecol("data/bio_amplifier_simplified_tb_tran_SR.txt", "v(vout)")
    Vout = data_vout[16000:16500:1]
    
    # Plot
    fig8 = plt.figure(num = 1, tight_layout = True)
    # plt.plot(time, Vind, linewidth = 2)
    # plt.plot(time, Vout, linewidth = 2)
    plt.plot(time, Vinp, linewidth = 2)
    plt.plot(time, Vinn, linewidth = 2)
    plt.plot(time, Voutp, linewidth = 2)
    plt.plot(time, Voutn, linewidth = 2)
    plt.xlabel('$t$ (ms)')
    plt.ylabel('$V$ (V)')
    plt.grid(visible = True, linestyle='--')
    # plt.legend(['Vind', 'Vout'])
    plt.legend(['Vinp', 'Vinn', 'Voutp', 'Voutn'])
    plt.show()
    
    fig8.savefig("figures/amplifier/biosignal_amplifier_slew_rate.svg", bbox_inches='tight')
    fig8.savefig("figures/amplifier/biosignal_amplifier_slew_rate.pdf", bbox_inches='tight')
    np.savetxt("figures/amplifier/biosignal_amplifier_slew_rate.csv", 
              np.column_stack((time, Vind, Vinp, Vinn, Voutp, Voutn, Vout)), comments = "", 
              header = "time,Vind,Vinp,Vinn,Voutp,Voutn,Vout", delimiter = ",")
# ============================================