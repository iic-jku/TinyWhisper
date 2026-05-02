# -*- coding: utf-8 -*-
# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0
# TinyWhisper
# @ JKU, JMU
# November 2025
# Author: Simon Dorrer
# Description: This Python file generates a PWM signal for the MFB filter Xschem testbench.
# Created: 22.10.2025
# Last Modified: 24.10.2025
# ============================================

# Imports
import os
import numpy as np
import matplotlib.pyplot as plt
from pygmid import main
# ============================================

# Plotting Configuration
# ============================================
# Enable interactive mode so plots do not block execution
plt.ion()
plt.close("all")

# Matplotlib Settings
# %matplotlib qt
# %matplotlib inline

# Use LaTeX if available, otherwise fallback gracefully
try:
    plt.rc('text', usetex=True)
    plt.rc('font', family='serif', size=14)
except Exception:
    print("Warning: LaTeX not available. Using standard fonts.")
    plt.rc('font', size=12)
# =========================================================================

def main():
    
  # User Constants
  VDD = 1.8 # Supply voltage (V)
  Vcm = VDD/2 # Common-mode voltage (V)
  V_sig = 0.25 * VDD # Amplitude of sine/cosine signals (V)
  f_sig = 125e3 # Frequency of sine/cosine signals (Hz)
  f_pwm = 56e6 # PWM frequency (Hz)
  OSR = 32 # Oversampling ratio
  fs = OSR*f_pwm # Sampling frequency (Hz)
  duration = 4 * 1/f_sig # Duration of signal (s)
  t = np.arange(0, duration, 1/fs) # time vector (s)
  # ============================================
  
  # Generate reference signals (sine and cosine)
  sine_wave = V_sig/2 * np.sin(2 * np.pi * f_sig * t) + Vcm
  cosine_wave = V_sig/2 * np.cos(2 * np.pi * f_sig * t) + Vcm
  # ============================================
  
  # Generate carrier (triangular) signal for PWM
  triangular_wave = VDD * np.abs(2 * (t * f_pwm - np.floor(t * f_pwm + 0.5)))
  # ============================================
  
  # Generate PWM signals by comparing reference with carrier
  pwm_sine = (sine_wave > triangular_wave).astype(float) * VDD
  pwm_cosine = (cosine_wave > triangular_wave).astype(float) * VDD
  # ============================================
  
  # Downsampling PWM Signal for Sine Wave (event-based)
  # Keep first value
  pwm_sine_downsampled = [pwm_sine[0]]
  t_pwm_sine_downsampled = [t[0]]
  
  # Loop over the array
  for i in range(1, len(pwm_sine)):
      if pwm_sine[i] != pwm_sine_downsampled[-1]:
          # Keep first changed value
          pwm_sine_downsampled.append(pwm_sine[i-1])  # last of previous run
          t_pwm_sine_downsampled.append(t[i-1])
          pwm_sine_downsampled.append(pwm_sine[i])    # first of new run
          t_pwm_sine_downsampled.append(t[i])
  
  # Ensure last value is kept
  if pwm_sine_downsampled[-1] != pwm_sine[-1]:
      pwm_sine_downsampled.append(pwm_sine[-1])
      t_pwm_sine_downsampled.append(t[-1])
  
  # Convert to numpy arrays
  pwm_sine_downsampled = np.array(pwm_sine_downsampled)
  t_pwm_sine_downsampled = np.array(t_pwm_sine_downsampled)
  # ============================================
  
  # Downsampling PWM Signal for Cosine Wave (event-based)
  # Keep first value
  pwm_cosine_downsampled = [pwm_cosine[0]]
  t_pwm_cosine_downsampled = [t[0]]
  
  # Loop over the array
  for i in range(1, len(pwm_cosine)):
      if pwm_cosine[i] != pwm_cosine_downsampled[-1]:
          # Keep first changed value
          pwm_cosine_downsampled.append(pwm_cosine[i-1])  # last of previous run
          t_pwm_cosine_downsampled.append(t[i-1])
          pwm_cosine_downsampled.append(pwm_cosine[i])    # first of new run
          t_pwm_cosine_downsampled.append(t[i])
  
  # Ensure last value is kept
  if pwm_cosine_downsampled[-1] != pwm_cosine[-1]:
      pwm_cosine_downsampled.append(pwm_cosine[-1])
      t_pwm_cosine_downsampled.append(t[-1])
  
  # Convert to numpy arrays
  pwm_cosine_downsampled = np.array(pwm_cosine_downsampled)
  t_pwm_cosine_downsampled = np.array(t_pwm_cosine_downsampled)
  # ============================================
  
  # Plot results (all-in-one, sine)
  plt.figure()
  plt.plot(t, sine_wave, label="Sine Wave", color='green')
  plt.plot(t, triangular_wave, label="Triangular Wave", color='orange')
  # plt.plot(t, pwm_sine, label="PWM (Sine)", color='red')
  plt.plot(t_pwm_sine_downsampled, pwm_sine_downsampled, label="PWM (Sine, Event)", color='blue')
  plt.title("PWM for Sine")
  plt.xlabel("Time (s)")
  plt.ylabel("Amplitude (V)")
  plt.legend()
  plt.grid(True)
  
  # Plot results (all-in-one, cosine)
  plt.figure()
  plt.plot(t, cosine_wave, label="Cosine Wave", color='green')
  plt.plot(t, triangular_wave, label="Triangular Wave", color='orange')
  # plt.plot(t, pwm_cosine, label="PWM (Cosine)", color='red')
  plt.plot(t_pwm_cosine_downsampled, pwm_cosine_downsampled, label="PWM (Cosine, Event)", color='blue')
  plt.title("PWM for Cosine")
  plt.xlabel("Time (s)")
  plt.ylabel("Amplitude (V)")
  plt.legend()
  plt.grid(True)
  
  # Plot results (Subplot)
  plt.figure(figsize=(12, 8))
  plt.subplot(4, 1, 1)
  plt.plot(t, sine_wave, label="Sine Wave")
  plt.plot(t, cosine_wave, label="Cosine Wave", linestyle='--')
  plt.title("Reference Sine and Cosine Waves")
  plt.xlabel("Time (s)")
  plt.ylabel("Amplitude (V)")
  plt.legend()
  plt.grid(True)
  
  plt.subplot(4, 1, 2)
  plt.plot(t, triangular_wave, label="Triangular Wave", color='orange')
  plt.title("Triangular Carrier Wave")
  plt.xlabel("Time (s)")
  plt.ylabel("Amplitude (V)")
  plt.legend()
  plt.grid(True)
  
  plt.subplot(4, 1, 3)
  plt.plot(t_pwm_sine_downsampled, pwm_sine_downsampled, label="PWM (Sine)", color='blue')
  plt.title("PWM Signal Equivalent to Sine Wave")
  plt.xlabel("Time (s)")
  plt.ylabel("Amplitude (V)")
  plt.legend()
  plt.grid(True)
  
  plt.subplot(4, 1, 4)
  plt.plot(t_pwm_cosine_downsampled, pwm_cosine_downsampled, label="PWM (Cosine)", color='red')
  plt.title("PWM Signal Equivalent to Cosine Wave")
  plt.xlabel("Time (s)")
  plt.ylabel("Amplitude (V)")
  plt.legend()
  plt.grid(True)
  
  plt.tight_layout()
  plt.show()
  # ============================================
  
  # Prepare and write data in Xschem format (Sine)
  pwm_sine_pwl = ''
  for idx, (ti, vi) in enumerate(zip(t_pwm_sine_downsampled, pwm_sine_downsampled)):
    pwm_sine_pwl += ''.join([str(ti), ' ', str(round(vi, 6)), ' '])

  pwm_sine_pwl_txt = '"dc 0 pwl(' + pwm_sine_pwl + ')"'

  # Write pwl data to .txt file
  os.makedirs('data', exist_ok=True)
  with open('./sky130/python/pwm_generator/data/pwm_sine_pwl.txt', 'w') as f:
    f.write(pwm_sine_pwl_txt)
  # ============================================
  
  # Prepare and write data in Xschem format (Cosine)
  pwm_cosine_pwl = ''
  for idx, (ti, vi) in enumerate(zip(t_pwm_cosine_downsampled, pwm_cosine_downsampled)):
    pwm_cosine_pwl += ''.join([str(ti), ' ', str(round(vi, 6)), ' '])
  
  pwm_cosine_pwl_txt = '"dc 0 pwl(' + pwm_cosine_pwl + ')"'

  # Write pwl data to .txt file
  with open('./sky130/python/pwm_generator/data/pwm_cosine_pwl.txt', 'w') as f:
    f.write(pwm_cosine_pwl_txt)
  # ============================================


# Main Execution
if __name__ == '__main__':
  main()

  # Keep plots open
  input("\nPress Enter to close plots and exit...")
# =========================================================================