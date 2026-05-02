# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
import pandas as pd
import os

# --- 1. Define parameters ---
f_sine = 1         # Frequency of the sine wave (1 cycle)
f_carrier = 20     # Frequency of the carrier signal (number of PWM pulses)
fs = 10000         # Sampling rate (high enough for sharp edges in the square wave)
t = np.arange(0, 1, 1/fs) # Time axis for exactly 1 second

# --- 2. Generate signals ---
# The "filtered" base signal (sine wave)
sine_wave = np.sin(2 * np.pi * f_sine * t)

# The carrier signal (triangle wave) to generate the PWM
# signal.sawtooth with 0.5 generates a symmetrical triangle
triangle_wave = signal.sawtooth(2 * np.pi * f_carrier * t, 0.5)

# Generate the PWM signal through comparison (comparator)
# We set the amplitude of the square wave slightly higher (1.2) than the sine wave (1.0),
# so it matches the visual proportions of your original image.
pwm_amplitude = 1.2
pwm_wave = np.where(sine_wave >= triangle_wave, pwm_amplitude, -pwm_amplitude)

# --- 3. Plotting ---
plt.figure(figsize=(10, 4))

# Draw the zero line
plt.axhline(0, color='black', linewidth=1, linestyle='-', zorder=1)

# Plot signals
plt.plot(t, pwm_wave, label='PWM / Bitstream', linewidth=1.5,)
plt.plot(t, sine_wave, label='Sine wave (filtered)', linewidth=2.5)
plt.xlim(0, 1)
plt.ylim(-1.5, 1.5)
plt.xlabel('Time (s)')
plt.ylabel('Voltage (V)')
plt.tight_layout()

# Show plot
plt.show()

# --- 4. Export to CSV ---
# We use Pandas to cleanly format the data into columns
df = pd.DataFrame({
    'Time_s': t,
    'Sine_Amplitude': sine_wave,
    'PWM_Amplitude': pwm_wave
})

# Export to the file (without saving the row index)
figures_dir = os.path.join(os.path.dirname(__file__), 'figures')
csv_filename = os.path.join(figures_dir, 'dsm_sine_data.csv')
df.to_csv(csv_filename, index=False)

print(f"Success! The signal data has been saved to '{csv_filename}'.")