# -*- coding: utf-8 -*-
# Master-Thesis
# @ JKU IIC / ISP
# 2024
# Author: Simon Dorrer
# Description: ToDo
# Created: ToDo
# Last Modified: ToDo
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

    # Load data from .txt
    data_ToDo = ng.loadngspicecol("data/ToDo.txt", "v(ToDo)")
    
    # data_ol_gain_Amag_ol_dB = ng.loadngspicecol("data/given_OTA/tb_amp_ol_gain.txt", "v(Amag_ol_dB)")
    # print("Open-Loop Gain at DC = %0.2f" % data_ol_gain_Amag_ol_dB[0], "dB")
    
    # Plot
    """ fig1 = plt.figure(num = 1, tight_layout = True)
    plt.plot([0 , 255], [0, 1.5], linewidth = 2)
    plt.plot(code, data, linewidth = 2)
    plt.xlabel('ToDo')
    plt.ylabel('ToDo')
    plt.title("ToDo")
    plt.grid(visible = True, linestyle='--')
    plt.xlim((0, 260))
    plt.ylim((0, 1.6))
    plt.legend(['Ideal Transfer Charateristic', 'Ideal 8-Bit DAC'])
    plt.show()

    fig2, axs = plt.subplots(2)
    axs[0].set_xscale('log')
    axs[0].plot(data_ol_gain_freq, data_ol_gain_Amag_ol_dB, linewidth = 2)
    axs[0].set_xlabel('$f$ (Hz)')
    axs[0].set_ylabel('Open-Loop Gain (dB)')
    axs[0].grid(True, which="both")
    axs[0].yaxis.set_major_locator(ticker.MultipleLocator(base=20))
    axs[1].set_xscale('log')
    axs[1].plot(data_ol_gain_freq, data_ol_gain_Aarg_ol, linewidth = 2)
    axs[1].set_xlabel('$f$ (Hz)')
    axs[1].set_ylabel('Phase (°)')
    axs[1].grid(True, which="both")
    axs[1].yaxis.set_major_locator(ticker.MultipleLocator(base=90))
    # plt.legend(['Ideal Transfer ', 'Ideal 8-Bit DAC'])
    plt.tight_layout()
    plt.show() """
    
    # fig2.savefig("figures/ToDo.svg", bbox_inches='tight')
    # fig2.savefig("figures/ToDo.pdf", bbox_inches='tight')
    # np.savetxt("figures/ToDo/ToDo.csv", 
    #           np.column_stack((data_time, data_a_1V5, data_x1t, data_b_3V3)), comments = "", 
    #           header = "time,a_1V5,x1t,b_3V3", delimiter = ",")
# ============================================