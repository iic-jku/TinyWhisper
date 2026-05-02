# SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
# SPDX-License-Identifier: Apache-2.0
# JKU, IICQC
# (c) Simon Dorrer, 2025-2026
#
# Description: Design of cascaded biquad multiple feedback (MFB) lowpass filters.
#              Supports Butterworth, Bessel, and Chebyshev Type I filter types
#              with even orders from 2nd to 10th (cascaded 2nd-order sections).
# 1.) Design of ideal filter prototype (LUT or scipy-based coefficients)
# 2.) Calculation of ideal RC values for each biquad section
# 3.) Selection of real RC values from available component values
# 4.) Area estimation for IHP130 PDK (resistors and MIM capacitors)
# Created: 10.08.2025
# Updated: 11.02.2026

__version__ = "1.0.0"

# Imports
# ============================================
import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import scipy.signal as scs
import control
from math import pi
# =========================================================================


# IHP130 PDK Parameters
# ============================================
IHP130_PARAMS = {
    'w_rpoly': 0.5e-6,          # High-res poly resistor width (m)
    'r_sheet': 1360.0,          # Sheet resistance (Ohm/sq)
    'c_prime': 1.5e-15 / 1e-12, # MIM capacitance density (F/m^2)
}
# =========================================================================


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


# Filter Coefficient Look-Up Tables (Tietze-Schenk Style)
# =========================================================================
# Coefficients for H(s) = 1 / (1 + a1*s + a2*s²) normalized to -3dB frequency
# Format:
#   - 2nd order sections (biquads): (a1, a2) --> H(s) = 1 / (1 + a1*s + a2*s²)
# =========================================================================

# Butterworth Coefficients (maximally flat, -3dB at wc)
BUTTERWORTH_COEFFS = {
    2: [(1.4142, 1.0000)],
    4: [(1.8478, 1.0000), (0.7654, 1.0000)],
    6: [(1.9319, 1.0000), (1.4142, 1.0000), (0.5176, 1.0000)],
    8: [(1.9616, 1.0000), (1.6629, 1.0000), (1.1111, 1.0000), (0.3902, 1.0000)],
    10: [(1.9754, 1.0000), (1.7820, 1.0000), (1.4142, 1.0000), (0.9080, 1.0000), (0.3129, 1.0000)],
}
# =========================================================================

# Bessel Coefficients (delay-normalized, maximally flat group delay)
BESSEL_COEFFS = {
    2: [(1.3617, 0.6180)],
    4: [(1.3397, 0.4889), (0.7743, 0.3890)],
    6: [(1.2217, 0.3887), (0.9686, 0.3505), (0.5131, 0.2756)],
    8: [(1.1112, 0.3162), (0.9754, 0.2979), (0.7202, 0.2621), (0.3728, 0.2087)],
    10: [(1.0215, 0.2650), (0.9393, 0.2549), (0.7815, 0.2351), (0.5604, 0.2059), (0.2883, 0.1665)],
}
# =========================================================================

# Chebyshev Type I Coefficients (equiripple passband)
# Indexed by ripple in dB: {ripple_dB: {order: [(a1, a2), ...]}}
CHEBYSHEV_COEFFS = {
    0.1: {
        2: [(1.4049, 1.1622)],
        4: [(2.4920, 2.3779), (0.4834, 1.1137)],
        6: [(3.5582, 4.5497), (0.9851, 1.7207), (0.2223, 1.0609)],
        8: [(4.6515, 7.6129), (1.3796, 2.6634), (0.4802, 1.3876), (0.1260, 1.0365)],
        10: [(5.7587, 11.5578), (1.7524, 3.8987), (0.6711, 1.8814), (0.2840, 1.2399), (0.0808, 1.0240)],
    },
    0.5: {
        2: [(1.3614, 1.3827)],
        4: [(2.6282, 3.4341), (0.3648, 1.1509)],
        6: [(3.8645, 6.9797), (0.7528, 1.8573), (0.1589, 1.0711)],
        8: [(5.1117, 11.9607), (1.0639, 2.9365), (0.3439, 1.4206), (0.0885, 1.0407)],
        10: [(6.3648, 18.3695), (1.3582, 4.3453), (0.4822, 1.9440), (0.1994, 1.2520), (0.0563, 1.0263)],
    },
    1.0: {
        2: [(1.3022, 1.5515)],
        4: [(2.5904, 4.1301), (0.3039, 1.1697)],
        6: [(3.8437, 8.5529), (0.6292, 1.9124), (0.1296, 1.0766)],
        8: [(5.1019, 14.7608), (0.8916, 3.0426), (0.2806, 1.4334), (0.0717, 1.0432)],
        10: [(6.3634, 22.7468), (1.1399, 4.5167), (0.3939, 1.9665), (0.1616, 1.2569), (0.0455, 1.0277)],
    },
    3.0: {
        2: [(1.0650, 1.9305)],
        4: [(2.1853, 5.5339), (0.1964, 1.2009)],
        6: [(3.2721, 11.6773), (0.4077, 1.9873), (0.0815, 1.0861)],
        8: [(4.3583, 20.2948), (0.5791, 3.1808), (0.1765, 1.4507), (0.0448, 1.0478)],
        10: [(5.4449, 31.3788), (0.7414, 4.7363), (0.2479, 1.9952), (0.1008, 1.2638), (0.0283, 1.0304)],
    },
}
# =========================================================================


def draw_biquad_mfb_lpf():
    import schemdraw as sd
    sd.svgconfig.svg2 = False
    import schemdraw.elements as elm

    with sd.Drawing() as d:
        d.config(unit=2, fontsize=16)

        # R1 & C2
        elm.Dot(open=True).label(r'$V_\mathrm{in,p}$', loc='left')
        elm.Line().right().length(1.0)
        elm.Resistor().label('$R_1$')
        dot1a = elm.Line().right().length(1.0).dot()
        elm.Line().down().length(1.5)
        elm.Capacitor().down().label('$C_2$').reverse()
        dot1b = elm.Line().down().length(1.5).dot()
        elm.Line().left().length(1.0)
        elm.Resistor().label('$R_1$')
        elm.Line().left().length(1.0)
        elm.Dot(open=True).label(r'$V_\mathrm{in,n}$', loc='left')

        # R3
        elm.Line().at(dot1a.end).right().length(1.0)
        elm.Resistor().label('$R_3$')
        dot3a = elm.Line().right().length(1.0).dot()
        elm.Line().at(dot1b.end).right().length(1.0)
        elm.Resistor().label('$R_3$')
        dot3b = elm.Line().right().length(1.0).dot()

        # OTA & Output
        elm.Line().at(dot3a.end).down().length(1.875)
        elm.Line().right().length(1.5)
        OTA = elm.Opamp().anchor('in2').flip()
        elm.Dot(open=True).at(OTA.n1)
        elm.Line().right().length(1.5).dot()
        dot2a = d.here
        elm.Line().right().length(1.0)
        cross1 = d.here
        elm.Line().to((cross1.x + 1, OTA.n2.y))
        elm.Line().right().length(1.0)
        elm.Dot(open=True).label(r'$V_\mathrm{out,n}$', loc='right')
        elm.Line().at(dot3b.end).up().length(1.875)
        elm.Line().right().length(1.5)
        elm.Line().right().at(OTA.n2).length(1.5).dot()
        dot2b = d.here
        elm.Line().right().length(1.0)
        cross2 = d.here
        elm.Line().to((cross2.x + 1, OTA.n1.y))
        elm.Line().right().length(1.0)
        elm.Dot(open=True).label(r'$V_\mathrm{out,p}$', loc='right')

        # C1
        elm.Line().at(dot3a.end).right().length(1.0)
        elm.Capacitor().label('$C_1$')
        elm.Line().right().tox(dot2a).dot()
        elm.Line().down().toy(dot2a)
        elm.Line().at(dot3b.end).right().length(1.0)
        elm.Capacitor().label('$C_1$')
        elm.Line().right().tox(dot2b).dot()
        elm.Line().up().toy(dot2b)

        # R2
        elm.Line().at(dot1a.end).up().length(2.0)
        elm.Line().right().length(1.0)
        elm.Resistor().label('$R_2$')
        elm.Line().right().tox(dot2a)
        elm.Line().down().toy(dot2a)
        elm.Line().at(dot1b.end).down().length(2.0)
        elm.Line().right().length(1.0)
        elm.Resistor().label('$R_2$')
        elm.Line().right().tox(dot2b)
        elm.Line().up().toy(dot2b)

        # Save the schematic
        _dir = os.path.dirname(os.path.abspath(__file__))
        _fig_dir = os.path.join(_dir, 'figures')
        os.makedirs(_fig_dir, exist_ok=True)
        d.save(os.path.join(_fig_dir, 'biquad_mfb_lpf_circuit.svg'))
        d.save(os.path.join(_fig_dir, 'biquad_mfb_lpf_circuit.pdf'))


def get_biquad_coefficients_lut(N, Wn, rp, btype, ftype, gp, section=1):
    """
    Get 2nd-order biquad coefficients from Tietze-Schenk style look-up table.
    
    Returns coefficients for a specific biquad section of a higher-order filter.
    This is designed for filter design where each section is implemented
    as a separate 2nd-order stage. Only 2nd-order (biquad) sections are returned.
    1st-order sections from odd-order filters are excluded.
    
    Cascaded biquad transfer function form (textbook style):
    
        H(s) = H1(s) · H2(s) · ... · H_{N/2}(s)
        
        where each biquad section has the form:
        
                         b0_k
        H_k(s) = -------------------
                  a2_k·s² + a1_k·s + 1
                  
    Use the 'section' parameter to select which biquad stage coefficients to return:
        - section=1: Returns (b0_1, [a2_1, a1_1, 1]) for the first biquad
        - section=2: Returns (b0_2, [a2_2, a1_2, 1]) for the second biquad
        - etc.
    
    Args:
        N (int): Filter order (2-10), determines which coefficient set to use.
                 Must be even (odd orders have 1st-order sections not supported).
        Wn (float): Cutoff frequency in rad/s (use 1 for normalized prototype)
        rp (float): Passband ripple in dB (0.1, 0.5, 1.0, or 3.0 for Chebyshev)
        btype (str): 'lowpass' (only lowpass supported currently)
        ftype (str): 'butter', 'bessel', or 'cheby1'
        gp (float): Desired passband gain (linear) for this section
        section (int): Which biquad section to return (1-indexed).
                       Number of biquads = N / 2
        
    Returns:
        tuple: (b, a) where:
            - b = [b0] numerator coefficient (DC gain)
            - a = [a2, a1, 1] denominator coefficients in descending powers
            
    Raises:
        ValueError: If filter type, order, section, or ripple not in LUT
        
    Notes:
        - Only even orders supported (2, 4, 6, 8, 10)
        - Coefficients are in textbook style with a[-1] = 1
        - Frequency scaling is applied if Wn != 1
        - Section indexing: 1 = first biquad, 2 = second biquad, etc.
        
    Example:
        # Get 2nd biquad of a 4th-order Butterworth (there are 2 biquads)
        b, a = get_biquad_coefficients_lut(N=4, Wn=1, rp=0, btype='lowpass', 
                                     ftype='butter', gp=1.0, section=2)
    """
    
    # Validate inputs
    if btype != 'lowpass':
        raise ValueError(f"Only 'lowpass' supported in LUT, got '{btype}'")
    
    if N < 2 or N > 10:
        raise ValueError(f"Order must be 2-10, got {N}")
    
    if N % 2 != 0:
        raise ValueError(f"Only even orders supported for biquads (got {N}). "
                         f"Odd orders have 1st-order sections not compatible with MFB biquads.")
    
    # Select coefficient table
    if ftype == 'butter':
        if N not in BUTTERWORTH_COEFFS:
            raise ValueError(f"Butterworth order {N} not in LUT")
        sections = BUTTERWORTH_COEFFS[N]
    elif ftype == 'bessel':
        if N not in BESSEL_COEFFS:
            raise ValueError(f"Bessel order {N} not in LUT")
        sections = BESSEL_COEFFS[N]
    elif ftype == 'cheby1':
        # Find closest ripple value
        available_ripples = list(CHEBYSHEV_COEFFS.keys())
        if rp not in available_ripples:
            closest = min(available_ripples, key=lambda x: abs(x - rp))
            print(f"Warning: Ripple {rp}dB not in LUT, using closest: {closest}dB")
            rp = closest
        if N not in CHEBYSHEV_COEFFS[rp]:
            raise ValueError(f"Chebyshev order {N} with {rp}dB ripple not in LUT")
        sections = CHEBYSHEV_COEFFS[rp][N]
    else:
        raise ValueError(f"Filter type '{ftype}' not in LUT. Use 'butter', 'bessel', or 'cheby1'")
    
    # Validate section index
    num_sections = len(sections)
    if section < 1 or section > num_sections:
        raise ValueError(f"Section must be 1 to {num_sections} for order {N}, got {section}")
    
    # Get the requested section (convert to 0-indexed)
    # All sections are 2nd-order biquads (even orders only)
    section_coeffs = sections[section - 1]
    
    # Build transfer function for 2nd-order biquad
    # H(s) = 1 / (1 + a1*s + a2*s²) -> [a2, a1, 1] in descending powers
    a1, a2 = section_coeffs
    b = np.array([1.0])
    a = np.array([a2, a1, 1.0])
    
    # Apply frequency scaling: s -> s/Wn
    # For H(s) = 1 / (1 + a1*s + a2*s²), substituting s -> s/Wn gives:
    # H(s) = 1 / (1 + a1*(s/Wn) + a2*(s/Wn)²) = 1 / (1 + (a1/Wn)*s + (a2/Wn²)*s²)
    a[0] = a2 / (Wn**2)  # a2 coefficient scaled by 1/Wn²
    a[1] = a1 / Wn       # a1 coefficient scaled by 1/Wn

    # Apply DC gain
    b = gp * b
    
    return b, a
# =========================================================================


def get_coefficients_scipy(N, Wn, rp, btype, ftype, gp, norm='phase', sos=True, section=1):
    """
    Get filter coefficients from scipy.signal in textbook style (a[-1] = 1).
    
    Wraps scipy.signal.iirfilter and converts output to textbook style where
    the constant term is normalized to 1. Applies appropriate DC gain correction
    based on filter type.
    
    Transfer function form depends on 'sos' parameter:
    
    When sos=False (default): Returns COMPLETE filter transfer function
    
                            b0
        H(s) = ----------------------------
                a_N·s^N + ... + a1·s + 1
                
    When sos=True: Returns individual biquad section coefficients
    
        H(s) = H1(s) · H2(s) · ... · H_{N/2}(s)
        
        where each biquad section has the form:
        
                         b0_k
        H_k(s) = -------------------
                  b1_k·s² + a1_k·s + 1
                  
        Use 'section' parameter to select which biquad (1-indexed).
    
    Args:
        N (int): Filter order (1, 2, 3, ...)
        Wn (float): Cutoff frequency in rad/s (use 1 for normalized prototype)
        rp (float): Passband ripple in dB (only for 'cheby1', 'cheby2', 'ellip')
        btype (str): 'lowpass', 'highpass', 'bandpass', 'bandstop'
        ftype (str): 'butter', 'bessel', 'cheby1', 'cheby2', 'ellip'
        gp (float): Desired passband gain (linear)
        norm (str): Normalization mode. Default is 'phase'.
                    - 'phase': Standard scipy normalization (default behavior)
                    - 'mag': Normalize to -3dB at Wn for all filter types
                      - Butterworth: no change (already -3dB normalized)
                      - Bessel: uses scipy.signal.bessel with norm='mag'
                      - Chebyshev: scales frequency so -3dB is at Wn
        sos (bool): If True, return biquad (second-order section) coefficients
                    using scipy.signal.tf2sos with analog=True.
                    If False (default), return complete transfer function.
        section (int): Which biquad section to return when sos=True (1-indexed).
                       Number of biquads = N / 2 (+ 1 first-order if N is odd).
                       Default is 1.
        
    Returns:
        tuple: (b, a) where:
            - If sos=False: b, a are complete filter coefficients
            - If sos=True: b, a are biquad section coefficients
            - b = numerator coefficients (includes DC gain)
            - a = denominator coefficients in descending powers, constant = 1
            
    Notes:
        - Coefficients are in textbook style with a[-1] = 1
        - For Chebyshev Type I/Elliptic (even order): DC gain is corrected for ripple
        - For Butterworth/Bessel/odd-order Chebyshev: no ripple correction needed
        - sos=True requires scipy >= 1.8.0 for analog tf2sos support
        - When sos=True, DC gain (gp) is applied to the requested section
        
    Example:
        # Get 2nd-order Butterworth lowpass prototype
        b, a = get_coefficients_scipy(N=2, Wn=1, rp=0, btype='lowpass', 
                                       ftype='butter', gp=1.0)
        
        # Get 2nd-order Bessel with -3dB at Wn (magnitude normalization)
        b, a = get_coefficients_scipy(N=2, Wn=1, rp=0, btype='lowpass',
                                       ftype='bessel', gp=1.0, norm='mag')
                                       
        # Get 2nd biquad of a 4th-order Butterworth as SOS
        b, a = get_coefficients_scipy(N=4, Wn=1, rp=0, btype='lowpass',
                                       ftype='butter', gp=1.0, sos=True, section=2)
    """
    
    # Get scipy coefficients
    if norm == 'mag':
        # Magnitude normalization: -3dB at Wn for all filter types
        if ftype == 'butter':
            # Butterworth is already -3dB normalized, no change needed
            b, a = scs.iirfilter(N=N, Wn=Wn, btype=btype, analog=True, ftype=ftype, output='ba')
        elif ftype == 'bessel':
            # Use scipy.signal.bessel with norm='mag' for -3dB normalization
            b, a = scs.bessel(N=N, Wn=Wn, btype=btype, analog=True, norm='mag', output='ba')
        elif ftype in ['cheby1', 'cheby2', 'ellip']:
            # 1. Calculate Standard Epsilon (Ripple depth)
            epsilon = np.sqrt(10**(rp/10) - 1)
    
            # 2. Define Attenuation Target relative to Peak
            # If N is Even: Target is (3dB + Ripple) below Peak
            # If N is Odd:  Target is 3dB below Peak (DC = Peak)
            if N % 2 == 0:
                target_db = 3.0 + rp
            else:
                target_db = 3.0
                
            # 3. Calculate "Stopband" Epsilon for that target
            epsilon_stop = np.sqrt(10**(target_db/10) - 1)
            
            # 4. Calculate Scaling Factor
            cosh_factor = np.cosh(1/N * np.arccosh(epsilon_stop/epsilon))

            # Scale the cutoff frequency
            Wn_scaled = Wn / cosh_factor
            b, a = scs.iirfilter(N=N, Wn=Wn_scaled, rp=rp, btype=btype, analog=True, ftype=ftype, output='ba')
        else:
            raise ValueError(f"Filter type '{ftype}' not supported with norm='mag'")
    else:
        # Standard scipy normalization (phase-matched)
        if ftype in ['cheby1', 'cheby2', 'ellip']:
            b, a = scs.iirfilter(N=N, Wn=Wn, rp=rp, btype=btype, analog=True, ftype=ftype, output='ba')
        else:
            # Butterworth and Bessel do not use ripple parameter
            b, a = scs.iirfilter(N=N, Wn=Wn, btype=btype, analog=True, ftype=ftype, output='ba')
    
    # Handle SOS (second-order sections) output
    if sos:
        # Convert transfer function to second-order sections (analog)
        # SOS format: each row is [b0, b1, b2, a0, a1, a2]
        # H_k(s) = (b0*s^2 + b1*s + b2) / (a0*s^2 + a1*s + a2)
        sos_array = scs.tf2sos(b, a, analog=True)
        
        # Validate section index
        num_sections = sos_array.shape[0]
        if section < 1 or section > num_sections:
            raise ValueError(f"Section must be 1 to {num_sections} for order {N}, got {section}")
        
        # Get the requested section (0-indexed internally)
        sos_section = sos_array[section - 1]
        b_sos = sos_section[:3]  # [b0, b1, b2]
        a_sos = sos_section[3:]  # [a0, a1, a2]
        
        # Convert to textbook style (normalize so a[-1] = 1)
        b, a = scipy_to_textbook(b_sos, a_sos)
        
        # Normalize section to unity DC gain (for lowpass, DC gain = b[-1])
        # This ensures each section behaves like LUT (unity gain before gp)
        section_dc_gain = b[-1]
        if section_dc_gain != 0:
            b = b / section_dc_gain
        
        # Apply DC gain to the requested section
        # Note: Ripple correction is NOT applied here - it's for the complete filter,
        # not individual biquad sections. Each section just gets gp.
        b = gp * b
        
        return b, a

    # Convert coefficients from scipy to textbook style (sos=False path)
    b, a = scipy_to_textbook(b, a)
    
    # Apply DC gain correction
    if ftype in ['cheby1', 'ellip'] and N % 2 == 0:
        # Even-order Chebyshev/Elliptic: compensate for ripple at DC
        ripple_linear = 10**(rp / 20.0)
        b = gp * b * ripple_linear
    else:
        # Butterworth, Bessel, odd-order Chebyshev: no ripple correction needed
        b = gp * b
    
    return b, a
# =========================================================================


def scipy_to_textbook(b, a):
    """
    Convert transfer function coefficients from scipy style to textbook style.
    
    Scipy style:     a[0] = 1  (leading coefficient, highest power of s)
    Textbook style:  a[-1] = 1 (constant term, s^0 coefficient)
    
    This is useful when comparing scipy.signal output with circuit-derived
    transfer functions where the constant term is typically normalized to 1.
    
    Args:
        b (array-like): Numerator coefficients [b_M, b_{M-1}, ..., b_0] (descending powers)
        a (array-like): Denominator coefficients [a_N, a_{N-1}, ..., a_0] (descending powers)
        
    Returns:
        tuple: (b_textbook, a_textbook) normalized so a[-1] = 1
    """

    # Convert to numpy arrays
    b = np.array(b)
    a = np.array(a)
    
    # Normalize by the constant term (last element)
    norm_factor = a[-1]
    b = b / norm_factor
    a = a / norm_factor

    # Only return the last b coefficient as a numpy array
    b = np.array([b[-1]])
    
    return b, a
# =========================================================================


def calc_biquad_mfb_components(w_pass, gp, a1, a2, C1, manual_C2=True):
    """
    Calculate 2nd-order Multiple Feedback (MFB) lowpass filter components.
    
    Uses design equations to synthesize resistor values from given filter coefficients and capacitor values. 
    Optionally prompts for manual C2 input to allow selection of standard capacitor values.
    
    Args:
        w_pass (float): Cutoff angular frequency in rad/s
        gp (float): Passband gain (linear, e.g., 1.0 for unity gain)
        a1 (float): Normalized filter coefficient from prototype (s^1 term)
        a2 (float): Normalized filter coefficient from prototype (s^2 term)
        C1 (float): Chosen capacitor C1 value in Farads
        manual_C2 (bool): If True, prompt for manual C2 input. If False, use minimum C2 value rounded up to the next 0.1pF.
                          Default is True.
        
    Returns:
        tuple: (R1, R2, R3, C1, C2) component values in Ohms and Farads (single-ended value for C2)
        
    Notes:
        - C2 must satisfy: C2 >= C1 * 4 * a2 * (1 + gp) / a1^2
        - For differential implementation: C_diff = C_se / 2
        - When manual_C2=True, the function prompts for manual C2 entry
        - When manual_C2=False, C2_min is rounded up to the next 0.1pF
    """

    # Calculate minimum C2 value
    C2_min = C1 * 4 * a2 * (1 + gp) / a1**2
    
    print("Chosen coefficients:")
    print("a1 = %.4f" % a1)
    print("a2 = %.4f" % a2)
    print("Chosen component values:")
    print("C1 = %.2f pF" % (C1/1e-12))
    print("C2_min (se) = %.2f pF" % (C2_min/1e-12))
    
    if manual_C2:
        # Wait for manual C2 input
        while True:
            try:
                C2_input = input("\nEnter C2 value in pF (must be > %.2f pF): " % (C2_min/1e-12))
                C2 = float(C2_input) * 1e-12  # Convert pF to F
                
                if C2 >= C2_min:
                    print("C2 = %.2f pF (valid, > C2_min)" % (C2/1e-12))
                    break
                else:
                    print("Error: C2 must be >= %.2f pF. Please try again." % (C2_min/1e-12))
            except ValueError:
                print("Error: Invalid input. Please enter a numeric value.")
    else:
        # Round C2_min up to the next tenth (0.1pF)
        C2_min_pF = C2_min / 1e-12
        C2_pF = np.ceil(C2_min_pF * 10) / 10
        C2 = C2_pF * 1e-12
        print("C2 = %.2f pF (rounded up from C2_min = %.2f pF)" % (C2_pF, C2_min_pF))
    
    # Continue with component calculations
    R2 = (a1 * C2 - np.sqrt(a1**2 * C2**2 - 4 * C1 * C2 * a2 * (1 + gp))) / (2 * w_pass * C1 * C2)
    R1 = R2 / gp
    R3 = a2 / (w_pass**2 * C1 * C2 * R2)
    print("\nCalculated values:")
    print("R1 = %.2f kOhm" % (R1/1e3))
    print("R2 = %.2f kOhm" % (R2/1e3))
    print("R3 = %.2f kOhm" % (R3/1e3))
    print("C1 = %.2f pF" % (C1/1e-12))
    print("C2 (se) = %.2f pF --> C2 (diff) = %.2f pF" % (C2/1e-12, C2/2/1e-12))

    return R1, R2, R3, C1, C2
# =========================================================================


def calc_biquad_mfb_coefficients(R1, R2, R3, C1, C2):
    """
    Calculate 2nd-order Multiple Feedback (MFB) lowpass filter transfer function coefficients.
    
    Derives the transfer function coefficients from component values using
    circuit analysis of the MFB topology. Returns coefficients in textbook
    style (constant term normalized to 1).
    
    Args:
        R1 (float): Input resistor in Ohms
        R2 (float): Feedback resistor in Ohms
        R3 (float): Resistor to inverting input in Ohms
        C1 (float): Capacitor from op-amp output to inverting input in Farads
        C2 (float): Capacitor to ground in Farads (single-ended value)
        
    Returns:
        tuple: (b, a) where:
            - b = [b0] numerator coefficients (DC gain = R2/R1)
            - a = [a2, a1, 1] denominator coefficients in descending powers of s
            
    Notes:
        Transfer function form (textbook style):
                        b0
        H(s) = --------------------
                 a2·s² + a1·s + 1
               
        where:
            b0 = R2 / R1 (DC gain)
            a1 = C1 * (R2 + R3 + R2*R3/R1)
            a2 = C1 * C2 * R2 * R3
    """

    b0 = float(R2 / R1)
    a1 = float(C1 * (R2 + R3 + R2 * R3 / R1))
    a2 = float(C1 * C2 * R2 * R3)

    return [b0], [a2, a1, 1]
# =========================================================================


def quantize_biquad_mfb_components(R1_ideal, R2_ideal, R3_ideal, C1_ideal, C2_ideal, w_rhigh, s_rhigh, l_rhigh_grid, CU):
    """
    Quantize ideal MFB filter components to realizable values.
    
    Resistors are quantized using the IHP130 rhigh resistor model with a fixed
    number of series sections (s_rhigh) for all resistors. For each ideal resistance
    value, the segment length (l) is calculated via calc_rhigh_length_ihp130 to
    achieve the target resistance with the given number of sections. The calculated
    lengths are then rounded to the nearest multiple of l_rhigh_grid for layout
    compatibility. The quantized resistance is obtained from
    calc_rhigh_resistance_ihp130 using the rounded lengths.
    Multiplicity m = 1 and bends b = 0 are used internally.
    
    Capacitors are quantized to the nearest even integer multiple of CU, useful for
    layout with unit cell arrays and common-centroid matching.
    
    Quantization Formulas:
        Resistors: l_exact = calc_rhigh_length_ihp130(w, R_ideal, s_rhigh)
                   l = round(l_exact / l_rhigh_grid) * l_rhigh_grid
                   R_quantized = calc_rhigh_resistance_ihp130(w, l, s_rhigh)
        Capacitors: n = round(C_ideal / CU / 2) * 2     (nearest even integer)
                    C_quantized = n * CU
    
    Args:
        R1_ideal (float): Ideal resistor R1 in Ohms
        R2_ideal (float): Ideal resistor R2 in Ohms
        R3_ideal (float): Ideal resistor R3 in Ohms
        C1_ideal (float): Ideal capacitor C1 in Farads
        C2_ideal (float): Ideal capacitor C2 in Farads
        w_rhigh (float): Width of the rhigh resistor in meters
        s_rhigh (int): Number of series sections (same for all resistors)
        l_rhigh_grid (float): Length grid for rounding segment lengths in meters
                              (e.g. 0.5e-6 for 0.5 um grid)
        CU (float): Unit capacitor value in Farads
        
    Returns:
        tuple: (R1, R2, R3, C1, C2, l_R1, l_R2, l_R3)
            - R1..R3: Quantized resistor values in Ohms
            - C1..C2: Quantized capacitor values in Farads
            - l_R1..l_R3: Quantized segment lengths in meters for each resistor
            
    Notes:
        - All resistors use the same number of series sections (s_rhigh)
        - Different segment lengths (l) are calculated per resistor to match R_ideal
        - Segment lengths are rounded to the nearest multiple of l_rhigh_grid
        - Resistor parameters: m = 1, b = 0 (defaults)
        - Capacitors are rounded to nearest EVEN integer multiplier for matching
        - Exception: if capacitor multiplier < 1, set to 1 (minimum 1 unit capacitor)
        - Prints summary of quantized values, segment lengths, and errors
        - Relative error = (quantized - ideal) / ideal * 100%
    """

    # Calculate segment length for each resistor using IHP130 rhigh model
    l_R1 = calc_rhigh_length_ihp130(w=w_rhigh, R=R1_ideal, s=s_rhigh, m=1, b=0)
    l_R2 = calc_rhigh_length_ihp130(w=w_rhigh, R=R2_ideal, s=s_rhigh, m=1, b=0)
    l_R3 = calc_rhigh_length_ihp130(w=w_rhigh, R=R3_ideal, s=s_rhigh, m=1, b=0)
    
    # Quantize segment lengths to nearest multiple of l_rhigh_grid
    l_R1 = round(l_R1 / l_rhigh_grid) * l_rhigh_grid
    l_R2 = round(l_R2 / l_rhigh_grid) * l_rhigh_grid
    l_R3 = round(l_R3 / l_rhigh_grid) * l_rhigh_grid

    # Calculate quantized resistor values from quantized segment lengths
    R1 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R1, s=s_rhigh, m=1, b=0)
    R2 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R2, s=s_rhigh, m=1, b=0)
    R3 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R3, s=s_rhigh, m=1, b=0)
    
    # Calculate capacitor integer multipliers (round to nearest EVEN number)
    # round(x / 2) * 2 gives the nearest even integer
    # Exception: if multiplier < 1, set to 1 (minimum 1 unit capacitor)
    n_C1 = max(1, round(C1_ideal / CU / 2) * 2)
    n_C2 = max(1, round(C2_ideal / CU / 2) * 2)
    
    # Calculate quantized capacitor values
    C1 = n_C1 * CU
    C2 = n_C2 * CU
    
    # Calculate relative errors (%)
    err_R1 = (R1 - R1_ideal) / R1_ideal * 100
    err_R2 = (R2 - R2_ideal) / R2_ideal * 100
    err_R3 = (R3 - R3_ideal) / R3_ideal * 100
    err_C1 = (C1 - C1_ideal) / C1_ideal * 100
    err_C2 = (C2 - C2_ideal) / C2_ideal * 100
    
    # Print summary
    print("Rhigh resistor parameters:")
    print("w_rhigh      = %.2f um" % (w_rhigh/1e-6))
    print("s_rhigh      = %d" % s_rhigh)
    print("l_rhigh_grid = %.2f um" % (l_rhigh_grid/1e-6))
    print("-" * 60)
    print("\nUnit capacitor:")
    print("CU = %.4f fF" % (CU/1e-15))
    print("-" * 60)
    print("\nQuantized component values:")
    print("R1: sections = %d, l = %.2f um, R = %.2f kOhm (ideal: %.2f kOhm, error: %+.2f%%)" % (s_rhigh, l_R1/1e-6, R1/1e3, R1_ideal/1e3, err_R1))
    print("R2: sections = %d, l = %.2f um, R = %.2f kOhm (ideal: %.2f kOhm, error: %+.2f%%)" % (s_rhigh, l_R2/1e-6, R2/1e3, R2_ideal/1e3, err_R2))
    print("R3: sections = %d, l = %.2f um, R = %.2f kOhm (ideal: %.2f kOhm, error: %+.2f%%)" % (s_rhigh, l_R3/1e-6, R3/1e3, R3_ideal/1e3, err_R3))
    print("C1 = %d x CU = %.2f pF (ideal: %.2f pF, error: %+.2f%%)" % (n_C1, C1/1e-12, C1_ideal/1e-12, err_C1))
    print("C2 = %d x CU = %.2f pF (ideal: %.2f pF, error: %+.2f%%)" % (n_C2, C2/1e-12, C2_ideal/1e-12, err_C2))
    
    return R1, R2, R3, C1, C2, l_R1, l_R2, l_R3
# =========================================================================


def plot_system_analysis(systems_dict, title_prefix, order, w_vec, w_pass, gp, show_plot=True):
    """
    Generate comprehensive filter analysis plots for one or multiple systems.
    
    Creates a 2x3 subplot figure containing:
    - Magnitude response (Bode plot, top-left)
    - Phase response (Bode plot, bottom-left)
    - Normalized step response (top-center)
    - Group delay (bottom-center)
    - Normalized pole-zero map (right, spans both rows)

    Args:
        systems_dict (dict): Dictionary of systems to plot, format {'Label': sys_object, ...}
                             where sys_object is a control.TransferFunction
        title_prefix (str): Title prefix for the figure suptitle
        order (int): Filter order, used to scale phase plot y-axis limits
        w_vec (array): Frequency vector in rad/s for Bode plot calculation
        w_pass (float): Cutoff angular frequency in rad/s for normalization
        gp (float): Target passband DC gain (linear) for step response normalization
        show_plot (bool): If True, generate and display the plot. If False, skip plotting.
                          Default is True.
        
    Notes:
        - Each system is plotted with a unique color from the default color cycle
        - Pole-zero map is normalized by w_pass for comparison
        - Step response is normalized by gp for comparison
        - Uses interactive matplotlib mode (plt.ion())
    """
    
    # Skip plotting if show_plot is False
    if not show_plot:
        return
    
    # Setup Figure (2 rows x 3 columns)
    # Adapt figure size to screen resolution
    try:
        import tkinter as tk
        root = tk.Tk()
        screen_width = root.winfo_screenwidth()
        screen_height = root.winfo_screenheight()
        root.destroy()
        dpi = plt.rcParams['figure.dpi']
        # Use 80% of screen width and 80% of screen height
        fig_width = screen_width * 0.80 / dpi
        fig_height = screen_height * 0.80 / dpi
    except Exception:
        # Fallback to default size if screen detection fails
        fig_width, fig_height = 20, 10
    
    fig = plt.figure(figsize=(fig_width, fig_height))
    
    # Escape LaTeX special characters in title
    title_safe = title_prefix.replace('&', r'\&').replace('%', r'\%').replace('_', r'\_')
    fig.suptitle("%s Comparison" % title_safe, fontsize=16, fontweight='bold', y=0.98)
    gs = fig.add_gridspec(2, 3, wspace=0.25, hspace=0.35, 
                          left=0.06, right=0.98, top=0.90, bottom=0.08)

    # Create Axes
    # Column 1: Bode Plot
    ax_mag = fig.add_subplot(gs[0, 0])
    ax_phase = fig.add_subplot(gs[1, 0], sharex=ax_mag)
    # Column 2: Step Response and Group Delay
    ax_step = fig.add_subplot(gs[0, 1])
    ax_gd = fig.add_subplot(gs[1, 1])
    # Column 3: Pole-Zero Map (spans both rows)
    ax_pz = fig.add_subplot(gs[:, 2])

    # Iterate through all systems in the dictionary
    # Get standard color cycle so each system has a unique color across all plots
    colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
    
    # Track maximum step response for y-axis scaling
    max_step_response = 0
    
    for i, (label, sys) in enumerate(systems_dict.items()):
        color = colors[i % len(colors)] # Cycle colors if more than 10 systems
        
        # ---------------------------------------------------------
        # A. Bode Plot
        # ---------------------------------------------------------
        # Calculate response (mag, phase, omega)
        mag, phase, omega = control.frequency_response(sys, omega=w_vec)
        
        # Convert to dB and Degrees
        mag_db = 20 * np.log10(mag)
        phase_rad = np.unwrap(phase)
        phase_deg = np.degrees(phase_rad)
        freq_hz = omega / (2 * np.pi)
        
        # Plot Magnitude
        ax_mag.semilogx(freq_hz, mag_db, color=color, linewidth=2, label=label)
        
        # Plot Phase
        ax_phase.semilogx(freq_hz, phase_deg, color=color, linewidth=2, label=label)

        # ---------------------------------------------------------
        # B. Normalized Step Response
        # ---------------------------------------------------------
        # Calculate time span based on the bandwidth
        t_span = np.linspace(0, (2*np.pi*5)/w_pass, 1001)
        
        # Calculate Step
        response = control.step_response(sys, T=t_span)
        
        # Normalize Amplitude by target dc gain (gp)
        y_norm = response.outputs / gp
        
        # Track maximum for y-axis scaling
        max_step_response = max(max_step_response, np.max(y_norm))
        
        ax_step.plot(response.time * 1e6, y_norm, color=color, linewidth=2, label=label)

        # ---------------------------------------------------------
        # C. Group Delay
        # ---------------------------------------------------------
        # Group delay = -d(phase)/d(omega)
        # Use numpy gradient for numerical differentiation
        group_delay = -np.gradient(phase_rad, omega)
        group_delay_us = group_delay * 1e6  # Convert to microseconds
        
        ax_gd.semilogx(freq_hz, group_delay_us, color=color, linewidth=2, label=label)

        # ---------------------------------------------------------
        # D. Normalized Pole-Zero Map
        # ---------------------------------------------------------
        poles, zeros = control.pole_zero_map(sys)
        
        # Normalize
        poles_norm = poles / w_pass
        zeros_norm = zeros / w_pass
        
        # Plot Poles (x)
        ax_pz.scatter(np.real(poles_norm), np.imag(poles_norm), 
                      marker='x', s=100, color=color, label=f"{label} Poles")
        
        # Plot Zeros (o) - Only if they exist
        if len(zeros_norm) > 0:
            ax_pz.scatter(np.real(zeros_norm), np.imag(zeros_norm), 
                          marker='o', s=100, color=color, facecolors='none', label=f"{label} Zeros")

    # Formatting & Legends
    # Bode Plot Formatting
    ax_mag.set_title("Amplitude Response", pad=15)
    ax_mag.set_ylabel("Magnitude (dB)")
    ax_mag.set_xlabel("Frequency (Hz)")
    ax_mag.set_ylim(-120, 20 * np.log10(gp) + 10) # Adjusted for typical view
    ax_mag.set_xlim(w_vec[0]/(2*np.pi), w_vec[-1]/(2*np.pi))
    ax_mag.grid(True, which='both', linestyle='--', alpha=0.5)
    ax_mag.legend(loc='lower left', fontsize=10)
    ax_phase.set_title("Phase Response", pad=15)
    ax_phase.set_ylabel("Phase (deg)")
    ax_phase.set_xlabel("Frequency (Hz)")
    ax_phase.yaxis.set_major_locator(ticker.MultipleLocator(45))
    ax_phase.set_ylim(-90 * order - 10, 10)
    ax_phase.grid(True, which='both', linestyle='--', alpha=0.5)

    # Step Response Formatting
    ax_step.set_title("Normalized Step Response", pad=15)
    ax_step.set_xlabel(r"Time ($\mu s$)")
    ax_step.set_ylabel("Amplitude (Normalized)")
    ax_step.grid(True, which='both', linestyle='--', alpha=0.7)
    ax_step.set_ylim(0, max_step_response + 0.1)
    ax_step.set_xlim(0, t_span[-1] * 1e6) 
    ax_step.legend(loc='lower right', fontsize=10)

    # Group Delay Formatting
    ax_gd.set_title("Group Delay", pad=15)
    ax_gd.set_xlabel("Frequency (Hz)")
    ax_gd.set_ylabel(r"Group Delay ($\mu s$)")
    ax_gd.set_xlim(w_vec[0]/(2*np.pi), w_vec[-1]/(2*np.pi))
    ax_gd.grid(True, which='both', linestyle='--', alpha=0.5)
    ax_gd.legend(loc='lower left', fontsize=10)

    # Pole-Zero Map Formatting
    # Draw Unit Circle
    theta = np.linspace(np.pi/2, 3*np.pi/2, 200)
    ax_pz.plot(np.cos(theta), np.sin(theta), 'k--', alpha=0.3, label='Unit Circle')
    
    ax_pz.set_title("Normalized Pole-Zero Map", pad=15)
    ax_pz.axhline(0, color='black', lw=1)
    ax_pz.axvline(0, color='black', lw=1)
    ax_pz.set_xlabel(r"Real Axis ($\sigma / \omega_c$)")
    ax_pz.set_ylabel(r"Imaginary Axis ($j\omega / \omega_c$)")
    ax_pz.grid(True, linestyle=':', alpha=0.6)
    ax_pz.legend(loc='upper left', fontsize=8)
    ax_pz.set_aspect('equal')
    ax_pz.set_xlim(-2.0, 0.0)
    ax_pz.set_ylim(-1.5, 1.5)

    plt.show()
# =========================================================================


def calc_rhigh_series_sections_ihp130(w, l, R, m=1, b=0):
    """
    Calculate the number of series sections (s) for a rhigh resistor given its parameters.
    
    Solves the IHP130 rhigh resistor equation for s (number of series sections):
    R = s * (1.6e-4 / w + 1360.0 * ((b + 1)*l + (1.081*(w - 0.04e-6) + 0.18e-6)*b) / (w - 0.04e-6)) / m
    
    Each series section is an identical rhigh resistor with width w, segment
    length l, multiplicity m, and b bends. The total resistance is s times the
    resistance of one section.
    
    Args:
        w (float): Width of the resistor in meters
        l (float): Length of one segment in meters
        R (float): Target resistance in Ohms
        m (int): Multiplicity (in parallel) factor (default: 1)
        b (int): Number of bends per section (default: 0)
        
    Returns:
        int: Number of series sections (s) as an integer
        
    Notes:
        - Based on IHP130 PDK rhigh resistor model: https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.tech/xschem/sg13g2_pr/rhigh.sym
        - Returns the rounded integer value of s
        - Formula: s = R / R_single, where R_single is the resistance of one section
    """

    # Calculate resistance of one section
    R_single = (1.6e-4 / w + 1360.0 * ((b + 1) * l + (1.081 * (w - 0.04e-6) + 0.18e-6) * b) / (w - 0.04e-6)) / m
    
    # Calculate number of series sections
    s = R / R_single
    
    # Return as integer
    return int(round(s))
# =========================================================================


def calc_rhigh_length_ihp130(w, R, s, m=1, b=0):
    """
    Calculate the segment length (l) for a rhigh resistor given a target resistance.
    
    Solves the IHP130 rhigh resistor equation for l (segment length per section):
    R = s * (1.6e-4 / w + 1360.0 * ((b + 1)*l + (1.081*(w - 0.04e-6) + 0.18e-6)*b) / (w - 0.04e-6)) / m
    
    This is useful when the number of series sections (s) is fixed (e.g. for
    layout matching) and the segment length is the design variable to achieve
    different resistance values.
    
    Args:
        w (float): Width of the resistor in meters
        R (float): Target resistance in Ohms
        s (int): Number of series sections (fixed)
        m (int): Multiplicity (in parallel) factor (default: 1)
        b (int): Number of bends per section (default: 0)
        
    Returns:
        float: Segment length l in meters
        
    Notes:
        - Based on IHP130 PDK rhigh resistor model: https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.tech/xschem/sg13g2_pr/rhigh.sym
        - Formula rearranged to:
          l = ((R*m/s - 1.6e-4/w) * (w - 0.04e-6) / 1360.0 - (1.081*(w - 0.04e-6) + 0.18e-6)*b) / (b + 1)
    """
    
    # Solve for l
    l = ((R * m / s - 1.6e-4 / w) * (w - 0.04e-6) / 1360.0 - (1.081 * (w - 0.04e-6) + 0.18e-6) * b) / (b + 1)

    return l
# =========================================================================


def calc_rhigh_resistance_ihp130(w, l, s, m=1, b=0):
    """
    Calculate the resistance (R) for s series sections of a rhigh resistor.
    
    Computes resistance using the IHP130 rhigh resistor equation:
    R = s * (1.6e-4 / w + 1360.0 * ((b + 1)*l + (1.081*(w - 0.04e-6) + 0.18e-6)*b) / (w - 0.04e-6)) / m
    
    Each series section is an identical rhigh resistor with width w, segment
    length l, multiplicity m, and b bends. The total resistance is s times the
    resistance of one section.
    
    Args:
        w (float): Width of the resistor in meters
        l (float): Length of one segment in meters
        s (int): Number of series sections
        m (int): Multiplicity (in parallel) factor (default: 1)
        b (int): Number of bends per section (default: 0)
        
    Returns:
        float: Resistance in Ohms
        
    Notes:
        - Based on IHP130 PDK rhigh resistor model: https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.tech/xschem/sg13g2_pr/rhigh.sym
    """
    
    # Calculate resistance of one section
    R_single = (1.6e-4 / w + 1360.0 * ((b + 1) * l + (1.081 * (w - 0.04e-6) + 0.18e-6) * b) / (w - 0.04e-6)) / m
    
    # Total resistance = s sections in series
    R = s * R_single
    
    return R
# =========================================================================


def calc_cmim_capacitance_ihp130(w, l, m):
    """
    Calculate the capacitance (C) for a MIM capacitor given its parameters.
    
    Computes capacitance using the IHP130 cmim capacitor equation:
    C = m * (w * l * 1.5e-3 + 2 * (w + l) * 40e-12)
    
    Args:
        w (float): Width of the capacitor in meters
        l (float): Length of the capacitor in meters
        m (int): Multiplicity factor
        
    Returns:
        float: Capacitance in Farads
        
    Notes:
        - Based on IHP130 PDK cmim capacitor model: https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.tech/xschem/sg13g2_pr/cap_cmim.sym
    """
    
    C = m * (w * l * 1.5e-3 + 2 * (w + l) * 40e-12)
    
    return C
# =========================================================================


def estimate_rc_chip_area_ihp130(r_tot=1e6, c_tot=10e-12, pdk_params=None):
    """
    Estimate chip area for resistors and capacitors in IHP130 PDK.
    
    Calculates layout area requirements for high-sheet-resistance poly resistors
    and M3 MIM (Metal-Insulator-Metal) capacitors.
    
    Args:
        r_tot (float): Total resistance in Ohms (default: 1 MOhm)
        c_tot (float): Total capacitance in Farads (default: 10 pF)
        pdk_params (dict): Dictionary with PDK parameters. If None, uses IHP130_PARAMS.
                           Expected keys: 'w_rpoly', 'r_sheet', 'c_prime'
        
    Returns:
        dict: Nested dictionary with area estimates:
            - 'msq': {'R': area_m2, 'C': area_m2} - areas in square meters
            - 'umsq': {'R': area_um2, 'C': area_um2} - areas in square micrometers
            
    Notes:
        - Resistor area: A_R = L * W, where L = R_tot * W / R_sheet
        - Capacitor area: A_C = C_tot / C' (capacitance density)
        - Default IHP130 params: W_poly = 0.50 um, R_sheet = 1360 Ohm/sq, C' = 1.5 fF/um²
    """

    # Get PDK Parameters
    if pdk_params is None:
        pdk_params = IHP130_PARAMS
    
    w_rpoly = pdk_params['w_rpoly']
    r_sheet = pdk_params['r_sheet']
    c_prime = pdk_params['c_prime']
    
    # Resistance Area: A = L * W, where L = R * W / Rsheet
    l_rtot = r_tot * w_rpoly / r_sheet
    a_rtot = l_rtot * w_rpoly
    a_rtot_umsq = a_rtot / 1e-12
    
    # Capacitance Area: A = C / C'
    a_ctot = c_tot / c_prime
    a_ctot_umsq = a_ctot / 1e-12

    return {'msq': {'R': a_rtot, 'C': a_ctot},
            'umsq': {'R': a_rtot_umsq, 'C': a_ctot_umsq}}
# =========================================================================


def main():

    # Print Transfer Function Definition
    print("\nTransfer Function Definition H(s) (Descending Powers):")
    print("=" * 60)
    print("        b[0]·s^M + b[1]·s^(M-1) + ... + b[M]         b_M·s^M + b_M-1·s^(M-1) + ... + b_0")
    print("H(s) = ---------------------------------------- = -----------------------------------------")
    print("        a[0]·s^N + a[1]·s^(N-1) + ... + a[N]         a_N·s^N + a_N-1·s^(N-1) + ... + a_0")
    print("=" * 60, "\n")

    # Draw Biquad MFB LPF
    draw_biquad_mfb_lpf()

    # --- 1. Filter & OTA Specifications ---
    print("\n         --- 1. Filter & OTA Specifications ---")
    print("=" * 60)

    # Filter Specifications
    area_max_umsq = (100e-6 * 100e-6) / 1e-12   # max available chip area

    f_start = 1                                 # start frequency
    f_end = 1e9                                 # end frequency
    f_pass_ideal = 400e3                        # -3dB corner frequency (ideal)
    
    # Note to Bessel Filter Coefficients:
    # The coefficients a1 = 1.3617, a2 = 0.6180 come from the magnitude-normalized (norm='mag') Bessel filter, 
    # where the group delay at DC is normalized to 1/wc and -3dB frequency is at wc.
    # Scipy's iirfilter(..., ftype='bessel') uses phase-matched (norm='phase') normalization by default, which gives a1 = 1.732, a2 = 1.0.

    # Note 1 to Chebyshev Filter Coefficients:
    # For even-order Chebyshev Type I, scipy normalizes so that the passband PEAK = 0dB (unity).
    # The dc gain (ω=0) is at a ripple MINIMUM, i.e., -ripple_dB below the peak.
    # To achieve dc gain = gp, scale: b0 = gp * ripple_pass
    # For odd-order Chebyshev, dc is at a peak (0dB), so no ripple correction needed.

    # Note 2 to Chebyshev Filter Coefficients:
    # Tietze-Schenk normalizes to the -3dB frequency at w = w_pass, 
    # whereas Scipy normalizes Chebyshev so the passband edge (where gain = -ripple_dB) is at w = w_pass.
    # This code accounts for this difference in the get_coefficients_scipy function when norm='mag' is used.

    gp_ideal_dB = -0.5                          # Passband gain in dB (ideal)
    gp_ideal = 10**(gp_ideal_dB / 20.0)         # Passband gain (ideal)
    ripple_pass_dB = 1                          # Passband ripple in dB (e.g. Chebyshev)
    ripple_pass = 10**(ripple_pass_dB / 20.0)   # Passband ripple (e.g. Chebyshev)

    filter_type = 'lowpass'                     # Select low-pass filter
    filter_order = 2                            # Order of the filter prototype
    filter_approx = 'butter'                    # Filter approximation type ('butter', 'cheby1', 'bessel')
    filter_section = 1                          # For SOS: which biquad section to analyze (1-indexed)
    filter_coeffs = 'LUT'                       # 'LUT' or 'SciPy'
    fully_differential = True                   # True = fully-differential, False = single-ended

    print("Filter Specifications:")
    print("-" * 60)
    print("Cutoff Frequency (ideal) = %.2fkHz" % (f_pass_ideal/1e3))
    print("Passband DC Gain (ideal) = %.2f (%.2fdB)" % (gp_ideal, gp_ideal_dB))
    print("Passband Ripple = %.2f (%.2fdB)" % (ripple_pass, ripple_pass_dB))
    print("Order = %d" % filter_order)
    print("Type = %s" % filter_type)
    print("Approximation = %s" % filter_approx)
    print("Section = %d" % filter_section)
    print("Coefficient Source = %s" % filter_coeffs)
    print("Fully Differential = %s" % fully_differential)
    print("-" * 60)

    # OTA Specifications
    aol_dB = 27.44                              # Open-Loop Gain in dB (simulated)
    # aol_dB = 27.44 - 6                        # Open-Loop Gain in dB (single-ended)
    aol = 10**(aol_dB / 20.0)                   # Open-Loop Gain (simulated)
    f_c = 4.04e6                                # Cutoff frequency of the OTA in Hz (simulated)
    GBWP = aol * f_c                            # Gain-Bandwidth Product

    print("\nOTA Specifications:")
    print("-" * 60)
    print("Open-Loop Gain: Aol = %.2f (%.2fdB)" % (aol, aol_dB))
    print("Cutoff Frequency: fc = %.2f MHz" % (f_c/1e6))
    print("Gain-Bandwidth Product: GBWP = %.2f MHz" % (GBWP/1e6))
    print("-" * 60)

    # Closed-Loop Gain Error Compensation
    # gp_real = aol / (1 + aol / gp_ideal)
    # gp_real_dB = 20 * np.log10(gp_real)
    # gain_error = 1 - gp_real / gp_ideal
    # gp_real_dB = gp_ideal_dB
    gp_real_dB = -1.23 # Simulated closed-loop gain in dB (with real OTA model)
    gp_real = 10**(gp_real_dB / 20.0)
    gp_dB = gp_ideal_dB + (gp_ideal_dB - gp_real_dB)
    gp = 10**(gp_dB / 20.0)
    print("\nGain Error Compensation:")
    print("-" * 60)
    print("Passband DC Gain (real) = %.2f (%.2fdB)" % (gp_real, gp_real_dB))
    # print("Gain Error = %.2f%%" % (gain_error * 100))
    print("Updated Passband DC Gain (taking OTA OL Gain into account) = %.2f (%.2fdB)" % (gp, gp_dB))
    print("-" * 60)

    # Cut-Off Frequency Error Compensation
    # f_pass_real = 192.35e3          # Simulated -3dB frequency in Hz (with real OTA model)
    # f_pass = f_pass_ideal
    f_pass = 2.0 * f_pass_ideal
    w_pass = 2 * pi * f_pass                    # w_pass = w_c in rad/s
    w_vec = 2 * np.pi * np.logspace(np.log10(f_start), np.log10(f_end), 1001)

    print("\nCut-Off Frequency Error Compensation:")
    print("-" * 60)
    # print("Cutoff Frequency (real) = %.2fkHz" % (f_pass_real/1e3))
    print("Updated Cutoff Frequency (taking OTA OL Gain into account) = %.2fkHz" % (f_pass/1e3))
    print("=" * 60, "\n")
    # =========================================================================


    # --- 2. SciPy vs LUT Coefficients and Responses
    print("\n     --- 2. SciPy vs LUT Coefficients and Responses ---")
    print("=" * 60)
    # Filter Type Comparison (SciPy) - norm = 'phase'
    print("Filter Type Comparison (SciPy) - norm = 'phase':")
    print("Printing coefficients with normalized corner frequency Wn=1...")
    b_proto_butter_scipy, a_proto_butter_scipy = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp, norm='phase', sos=True, section=filter_section)
    b_proto_bessel_scipy, a_proto_bessel_scipy = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp, norm='phase', sos=True, section=filter_section)
    b_proto_cheby_scipy, a_proto_cheby_scipy = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp, norm='phase', sos=True, section=filter_section)
    print("Butterworth (SciPy, norm='phase'): b =", np.array2string(b_proto_butter_scipy, precision=4), ", a =", np.array2string(a_proto_butter_scipy, precision=4))
    print("Bessel (SciPy, norm='phase'):      b =", np.array2string(b_proto_bessel_scipy, precision=4), ", a =", np.array2string(a_proto_bessel_scipy, precision=4))
    print("Chebyshev (SciPy, norm='phase'):   b =", np.array2string(b_proto_cheby_scipy, precision=4), ", a =", np.array2string(a_proto_cheby_scipy, precision=4))
    
    print("Plotting Filter Analysis with Wn=w_pass...")
    b_proto_butter_scipy, a_proto_butter_scipy = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp, norm='phase', sos=True, section=filter_section)
    b_proto_bessel_scipy, a_proto_bessel_scipy = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp, norm='phase', sos=True, section=filter_section)
    b_proto_cheby_scipy, a_proto_cheby_scipy = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp, norm='phase', sos=True, section=filter_section)
    sys_proto_butter_scipy = control.TransferFunction(b_proto_butter_scipy, a_proto_butter_scipy)
    sys_proto_bessel_scipy = control.TransferFunction(b_proto_bessel_scipy, a_proto_bessel_scipy)
    sys_proto_cheby_scipy = control.TransferFunction(b_proto_cheby_scipy, a_proto_cheby_scipy)
    plot_system_analysis({
        "Butterworth": sys_proto_butter_scipy,
        "Bessel": sys_proto_bessel_scipy,
        "Chebyshev (%.1fdB)" % ripple_pass_dB: sys_proto_cheby_scipy
    }, "Filter Type Comparison (SciPy) - norm = 'phase'", filter_order, w_vec, w_pass, gp, show_plot = True)
    print("-" * 60)
    
    # Filter Type Comparison (SciPy) - norm = 'mag'
    print("\nFilter Type Comparison (SciPy) - norm = 'mag':")
    print("Printing coefficients with normalized corner frequency Wn=1...")
    b_proto_butter_scipy, a_proto_butter_scipy = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp, norm='mag', sos=True, section=filter_section)
    b_proto_bessel_scipy, a_proto_bessel_scipy = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp, norm='mag', sos=True, section=filter_section)
    b_proto_cheby_scipy, a_proto_cheby_scipy = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp, norm='mag', sos=True, section=filter_section)
    print("Butterworth (SciPy, norm='mag'): b =", np.array2string(b_proto_butter_scipy, precision=4), ", a =", np.array2string(a_proto_butter_scipy, precision=4))
    print("Bessel (SciPy, norm='mag'):      b =", np.array2string(b_proto_bessel_scipy, precision=4), ", a =", np.array2string(a_proto_bessel_scipy, precision=4))
    print("Chebyshev (SciPy, norm='mag'):   b =", np.array2string(b_proto_cheby_scipy, precision=4), ", a =", np.array2string(a_proto_cheby_scipy, precision=4))

    print("Plotting Filter Analysis with Wn=w_pass...")
    b_proto_butter_scipy, a_proto_butter_scipy = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp, norm='mag', sos=True, section=filter_section)
    b_proto_bessel_scipy, a_proto_bessel_scipy = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp, norm='mag', sos=True, section=filter_section)
    b_proto_cheby_scipy, a_proto_cheby_scipy = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp, norm='mag', sos=True, section=filter_section)
    sys_proto_butter_scipy = control.TransferFunction(b_proto_butter_scipy, a_proto_butter_scipy)
    sys_proto_bessel_scipy = control.TransferFunction(b_proto_bessel_scipy, a_proto_bessel_scipy)
    sys_proto_cheby_scipy = control.TransferFunction(b_proto_cheby_scipy, a_proto_cheby_scipy)
    plot_system_analysis({
        "Butterworth": sys_proto_butter_scipy,
        "Bessel": sys_proto_bessel_scipy,
        "Chebyshev (%.1fdB)" % ripple_pass_dB: sys_proto_cheby_scipy
    }, "Filter Type Comparison (SciPy) - norm = 'mag'", filter_order, w_vec, w_pass, gp, show_plot = True)
    print("-" * 60)

    # Filter Type Comparison (LUT)
    print("\nFilter Type Comparison (LUT):")
    print("Printing coefficients with normalized corner frequency Wn=1...")
    b_proto_butter_lut, a_proto_butter_lut = get_biquad_coefficients_lut(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp, section=filter_section)
    b_proto_bessel_lut, a_proto_bessel_lut = get_biquad_coefficients_lut(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp, section=filter_section)
    b_proto_cheby_lut, a_proto_cheby_lut = get_biquad_coefficients_lut(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp, section=filter_section)
    print("Butterworth (LUT): b =", np.array2string(b_proto_butter_lut, precision=4), ", a =", np.array2string(a_proto_butter_lut, precision=4))
    print("Bessel (LUT):      b =", np.array2string(b_proto_bessel_lut, precision=4), ", a =", np.array2string(a_proto_bessel_lut, precision=4))
    print("Chebyshev (LUT):   b =", np.array2string(b_proto_cheby_lut, precision=4), ", a =", np.array2string(a_proto_cheby_lut, precision=4))

    print("Plotting Filter Analysis with Wn=w_pass...")
    b_proto_butter_lut, a_proto_butter_lut = get_biquad_coefficients_lut(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp, section=filter_section)
    b_proto_bessel_lut, a_proto_bessel_lut = get_biquad_coefficients_lut(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp, section=filter_section)
    b_proto_cheby_lut, a_proto_cheby_lut = get_biquad_coefficients_lut(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp, section=filter_section)
    sys_proto_butter_lut = control.TransferFunction(b_proto_butter_lut, a_proto_butter_lut)
    sys_proto_bessel_lut = control.TransferFunction(b_proto_bessel_lut, a_proto_bessel_lut)
    sys_proto_cheby_lut = control.TransferFunction(b_proto_cheby_lut, a_proto_cheby_lut)
    plot_system_analysis({
        "Butterworth": sys_proto_butter_lut,
        "Bessel": sys_proto_bessel_lut,
        "Chebyshev (%.1fdB)" % ripple_pass_dB: sys_proto_cheby_lut
    }, "Filter Type Comparison (LUT)", filter_order, w_vec, w_pass, gp, show_plot = True)

    # Set prototype filter for further analysis
    if filter_approx == 'butter':
        sys_prototype_filter = sys_proto_butter_lut
    elif filter_approx == 'bessel':
        sys_prototype_filter = sys_proto_bessel_lut
    elif filter_approx == 'cheby1':
        sys_prototype_filter = sys_proto_cheby_lut
    else:
        raise ValueError("Unsupported filter approximation type.")
    print("=" * 60, "\n")
    # =========================================================================


    # --- 3. Prototype Filter ---
    print("\n                 --- 3. Prototype Filter ---")
    print("=" * 60)
    print("Calculate Prototype Filter Coefficients H(s) = b / a:")
    # SciPy or LUT
    if filter_coeffs == 'SciPy':
        print("Using SciPy Coefficients!")
        b, a = get_coefficients_scipy(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype=filter_approx, gp=gp, norm='mag', sos=True, section=filter_section)
        b_prototype, a_prototype = get_coefficients_scipy(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype=filter_approx, gp=gp, norm='mag', sos=True, section=filter_section)
    else:
        print("Using LUT Coefficients!")
        b, a = get_biquad_coefficients_lut(N=filter_order, Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype=filter_approx, gp=gp, section=filter_section)
        b_prototype, a_prototype = get_biquad_coefficients_lut(N=filter_order, Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype=filter_approx, gp=gp, section=filter_section)
    print("b_prototype = [b0] =", b_prototype)
    print("a_prototype = [a2, a1, a0] =", a_prototype)
    print("-" * 60)

    # Plot Prototype Filter Analysis
    print("\nPlotting Prototype Filter Analysis...")
    sys_prototype_filter = control.TransferFunction(b_prototype, a_prototype)
    plot_system_analysis({"Prototype Filter": sys_prototype_filter}, "Prototype Filter", filter_order, w_vec, w_pass, gp, show_plot = False)
    print("=" * 60, "\n")

    # Export Prototype Filter Bode data for comparison with ngspice simulation
    # Uncommented since real / ideal gp / fc do not match yet.
    # print("\nExporting Prototype Filter Bode data...")
    # mag_prototype, phase_prototype, omega_prototype = control.frequency_response(sys_prototype_filter, omega=w_vec)
    # mag_prototype_dB = 20 * np.log10(mag_prototype)
    # phase_prototype_deg = np.degrees(np.unwrap(phase_prototype))
    # freq_prototype_hz = omega_prototype / (2 * np.pi)
    # export_dir = os.path.join(os.path.dirname(__file__), '..', 'plot_simulations', 'data')
    # os.makedirs(export_dir, exist_ok=True)
    # export_path = os.path.join(export_dir, 'biquad_mfb_lpf_prototype_bode.csv')
    # np.savetxt(export_path,
    #            np.column_stack((freq_prototype_hz, mag_prototype_dB, phase_prototype_deg)),
    #            comments="", header="frequency,mag_dB,phase_deg", delimiter=",")
    # print("Exported to: %s" % os.path.abspath(export_path))
    # print("=" * 60, "\n")
    # =========================================================================


    # --- 4. Ideal RC Filter ---
    print("\n                 --- 4. Ideal RC Filter ---")
    print("=" * 60)

    # Define unit cell values
    w_cmim = 20e-6   # Width of the MIM capacitor
    l_cmim = 20e-6   # Length of the MIM capacitor
    CU = calc_cmim_capacitance_ihp130(w=w_cmim, l=l_cmim, m=1)  # Unit capacitor in Farads (W = 20um, L = 20um, m = 1)

    # Calculate ideal RC Components
    print("Calculate Ideal RC Filter Components:")
    C1_se = CU
    R1_ideal, R2_ideal, R3_ideal, C1_se, C2_se = calc_biquad_mfb_components(w_pass, b[-1], a[1], a[0], C1=C1_se, manual_C2=True)
    print("-" * 60)

    # Calculate Ideal RC Filter Coefficients
    print("\nCalculate Ideal RC Filter Coefficients H(s) = b / a:")
    b_ideal_rc, a_ideal_rc = calc_biquad_mfb_coefficients(R1_ideal, R2_ideal, R3_ideal, C1_se, C2_se)
    print("b_ideal_rc = [b0] =", b_ideal_rc)
    print("a_ideal_rc = [a2, a1, a0] =", a_ideal_rc)
    print("-" * 60)

    # Plot Ideal RC Filter Analysis
    print("\nPlotting Ideal RC Filter Analysis...")
    sys_ideal_rc_filter = control.TransferFunction(b_ideal_rc, a_ideal_rc)
    plot_system_analysis({"Ideal RC Filter": sys_ideal_rc_filter}, "Ideal RC Filter", filter_order, w_vec, w_pass, gp, show_plot = False)
    print("=" * 60, "\n")
    # =========================================================================
    
    
    # --- 5. Real RC Filter ---
    print("\n          --- 5. Real RC Filter (Unit Cells) ---")
    print("=" * 60)

    # Quantize ideal values from section 3 to unit cell multiples
    # Fully-Differential Implementation
    print("Quantizing ideal RC values to unit cell multiples:")
    s_rhigh = 5  # Number of series sections (odd number for left / right contacts, same for all resistors)
    l_rhigh_grid = 1.0e-6  # Length grid for rounding segment lengths (e.g. 0.5 um)
    if fully_differential:
        R1_real, R2_real, R3_real, C1_real, C2_real, l_R1, l_R2, l_R3 = quantize_biquad_mfb_components(R1_ideal, R2_ideal, R3_ideal, C1_se, C2_se / 2, IHP130_PARAMS['w_rpoly'], s_rhigh, l_rhigh_grid, CU)
    else:
        R1_real, R2_real, R3_real, C1_real, C2_real, l_R1, l_R2, l_R3 = quantize_biquad_mfb_components(R1_ideal, R2_ideal, R3_ideal, C1_se, C2_se, IHP130_PARAMS['w_rpoly'], s_rhigh, l_rhigh_grid, CU)
    print("-" * 60)

    # Manual Adjustment of Quantized Values (if desired)
    # print("\nQuantized component values (manual adjustment):")
    # R1_real = 76 * RU
    # R2_real = 76 * RU
    # R3_real = 60 * RU
    # C1_real = 24 * CU
    # C2_real = 52 * CU
    # print("R1 = %.2f kOhm" % (R1_real/1e3))
    # print("R2 = %.2f kOhm" % (R2_real/1e3))
    # print("R3 = %.2f kOhm" % (R3_real/1e3))
    # print("C1 = %.2f pF" % (C1_real/1e-12))
    # print("C2 = %.2f pF" % (C2_real/1e-12))
    # print("-" * 60)

    print("\nPrint total length of all resistors:")
    total_res_length = l_R1 + l_R2 + l_R3
    print("Total Resistor length = %.2f um" % (total_res_length * 1e6))
    print("-" * 60)

    print("\nPrint total length of all capacitors:")
    total_cap_length = l_cmim * (C1_real + C2_real / 2) / CU
    print("Total Capacitor length = %.2f um" % (total_cap_length * 1e6))
    print("-" * 60)

    # Calculate Real RC Filter Coefficients
    print("\nCalculate Real RC Filter Coefficients H(s) = b / a:")
    if fully_differential:
        b_real_rc, a_real_rc = calc_biquad_mfb_coefficients(R1_real, R2_real, R3_real, C1_real, C2_real * 2)
    else:
        b_real_rc, a_real_rc = calc_biquad_mfb_coefficients(R1_real, R2_real, R3_real, C1_real, C2_real)
    print("b_real_rc = [b0] =", b_real_rc)
    print("a_real_rc = [a2, a1, a0] =", a_real_rc)
    print("-" * 60)

    # Plot Real RC Filter Analysis
    print("\nPlotting Real RC Filter Analysis...")
    sys_real_rc_filter = control.TransferFunction(b_real_rc, a_real_rc)
    plot_system_analysis({"Real RC Filter": sys_real_rc_filter}, "Real RC Filter", filter_order, w_vec, w_pass, gp, show_plot = False)
    print("=" * 60, "\n")
    # =========================================================================
    

    # --- 6. Filter Design Comparison ---
    print("\n      --- 6. Filter Design Comparison ---")
    print("=" * 60)

    print("Print Filter Coefficients H(s) = b / a:")
    print("b_prototype = [b0] =", b_prototype)
    print("a_prototype = [a2, a1, a0] =", a_prototype, "\n")
    print("b_ideal_rc = [b0] =", b_ideal_rc)
    print("a_ideal_rc = [a2, a1, a0] =", a_ideal_rc, "\n")
    print("b_real_rc = [b0] =", b_real_rc)
    print("a_real_rc = [a2, a1, a0] =", a_real_rc)
    print("-" * 60, "\n")

    print("Plotting Filter Design Comparison Analysis...")
    sys_filters = {
        "Ideal Prototype": sys_prototype_filter,
        "Ideal RC Filter": sys_ideal_rc_filter,
        "Real RC Filter": sys_real_rc_filter
    }
    plot_system_analysis(sys_filters, "Filter Design Comparison", filter_order, w_vec, w_pass, gp, show_plot = True)
    print("=" * 60, "\n")
    # =========================================================================


    # --- 7. Area Estimation (IHP130) ---
    print("\n           --- 7. Area Estimation (IHP130) ---")
    print("=" * 60)
    
    # RC Area Estimation (Fully-Differential)
    print("RC Area Estimation (Fully-Differential): ")
    r_vec = np.array([R1_real, R2_real, R3_real])
    # Assuming fully-differential (2 x resistors)
    r_tot = 2 * np.sum(r_vec)
    
    c_diff_vec = np.array([C2_real])
    c_se_vec = np.array([C1_real])
    # Total C area: 2x Single Ended Caps + 1x Differential Caps
    c_tot = 2 * np.sum(c_se_vec) + np.sum(c_diff_vec)
    
    res = estimate_rc_chip_area_ihp130(r_tot, c_tot)
    area_rtot_umsq = res['umsq']['R']
    area_ctot_umsq = res['umsq']['C']
    print("area_rtot_umsq = %.2f" % area_rtot_umsq, "um^2")
    print("area_ctot_umsq = %.2f" % area_ctot_umsq, "um^2")
    print("-" * 60)

    # Barthelemy / Manfredini Inverter-Based OTA Estimation
    print("\nBarthelemy / Manfredini Inverter-Based OTA Estimation: ")
    w_pmos_NF = 6 # in um
    w_nmos_NF = 1 # in um
    l_mos = 1.0   # in um
    
    # Area of Dummy Transistors
    # 2 x Fingers of PMOS + 2 x Fingers of NMOS
    area_dummies = 2 * w_pmos_NF * l_mos + 2 * w_nmos_NF * l_mos
    print("area_dummies = %.2f um^2" % (area_dummies))

    # Inverter Area = a * PMOS + NMOS
    area_inverter_NF20 = (20 * w_pmos_NF * l_mos) + (20 * w_nmos_NF * l_mos) + area_dummies
    print("area_inverter_NF20 = %.2f um^2" % (area_inverter_NF20))

    area_inverter_NF18 = (18 * w_pmos_NF * l_mos) + (18 * w_nmos_NF * l_mos) + area_dummies
    print("area_inverter_NF18 = %.2f um^2" % (area_inverter_NF18))

    area_inverter_NF10 = (10 * w_pmos_NF * l_mos) + (10 * w_nmos_NF * l_mos) + area_dummies
    print("area_inverter_NF10 = %.2f um^2" % (area_inverter_NF10))
    
    area_ota_umsq = 6 * area_inverter_NF20 + 1 * area_inverter_NF18 + 4 * area_inverter_NF10
    print("area_ota_umsq = %.2f um^2" % (area_ota_umsq))
    print("-" * 60)

    # Total Area Estimation
    print("\nTotal Area Estimation: ")
    # Resistors and MOSFETs often on same layer (Poly/Active)
    area_poly_umsq = area_rtot_umsq + area_ota_umsq
    print("area_poly_umsq = %.2f um^2" % area_poly_umsq)
    
    # Capacitors (MIM) often stacked above, so we take the max area
    # For a good layout, area_poly_umsq ~ area_ctot_umsq
    area_tot_umsq = max(area_poly_umsq, area_ctot_umsq)
    print("area_tot_umsq = max(area_poly_umsq, area_ctot_umsq) = %.2f um^2" % area_tot_umsq)
    
    print("area_max_umsq = %.2f um^2" % area_max_umsq)
    
    if area_tot_umsq > area_max_umsq:
        print("!!! Note! Design does not fit in available area! !!!")
    else:
        print("Design fits in available area.")
    print("=" * 60)
    # =========================================================================

    
# Main Execution
if __name__ == '__main__':
    main()

    # Keep plots open
    input("\nPress Enter to close plots and exit...")
# =========================================================================