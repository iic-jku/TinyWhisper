# JKU, IICQC
# (c) Simon Dorrer, 2025-2026
#
# Description: Design of 3rd-order multiple feedback (MFB) lowpass filters.
#              Supports Butterworth, Bessel, and Chebyshev Type I filter types.
#              Uses LUT-based coefficients (Tietze-Schenk style).
# 1.) Design of ideal filter prototype (LUT coefficients)
# 2.) Calculation of ideal RC values for each filter section
# 3.) Selection of real RC values from available component values
# 4.) Area estimation for IHP130 PDK (resistors and MIM capacitors)
# Created: 31.01.2026
# Updated: 11.02.2026

__version__ = "1.0.0"

# Imports
# ============================================
import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
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
# Coefficients for 3rd-order filters (if stages are buffered):
#   - 2nd order section (biquad): (a2, a3) --> H(s) = 1 / (1 + a2*s + a3*s²)
#   - 1st order section: (a1,) --> H(s) = 1 / (1 + a1*s)
# Combined 3rd-order transfer function form (if stages are not buffered):
#                                      b0
#        H(s) = ----------------------------------------------
#                a1·a3·s³ + (a1·a2 + a3)·s² + (a1 + a2)·s + 1
#
#                                 b0
#        H(s) = --------------------------------------
#                alpha3·s³ + alpha2·s² + alpha1·s + 1
# =========================================================================


# Butterworth Coefficients (maximally flat, -3dB at wc)
BUTTERWORTH_COEFFS = {
    1: [(1.0000, )],
    2: [(1.4142, 1.0000)],
    3: [(1.0000, ), (1.0000, 1.0000)],
    4: [(1.8478, 1.0000), (0.7654, 1.0000)],
}
# =========================================================================

# Bessel Coefficients (delay-normalized, maximally flat group delay)
BESSEL_COEFFS = {
    1: [(1.0000, )],
    2: [(1.3617, 0.6180)],
    3: [(0.7560, ), (0.9996, 0.4772)],
    4: [(1.3397, 0.4889), (0.7743, 0.3890)],
}
# =========================================================================

# Chebyshev Type I Coefficients (equiripple passband)
CHEBYSHEV_COEFFS = {
    0.1: {
        1: [(1.0000, )],
        2: [(1.4049, 1.1622)],
        3: [(1.4328, ), (0.7969, 1.1418)],
        4: [(2.4920, 2.3779), (0.4834, 1.1137)],
    },
    0.5: {
        1: [(1.0000, )],
        2: [(1.3614, 1.3827)],
        3: [(1.8636, ), (0.6402, 1.1931)],
        4: [(2.6282, 3.4341), (0.3648, 1.1509)],
    },
    1.0: {
        1: [(1.0000, )],
        2: [(1.3022, 1.5515)],
        3: [(2.2156, ), (0.5442, 1.2057)],
        4: [(2.5904, 4.1301), (0.3039, 1.1697)],
    },
    3.0: {
        1: [(1.0000, )],
        2: [(1.0650, 1.9305)],
        3: [(3.3496, ), (0.3559, 1.1923)],
        4: [(2.1853, 5.5339), (0.1964, 1.2009)],
    },
}
# =========================================================================


def draw_3rd_order_mfb_lpf():
    import schemdraw as sd
    sd.svgconfig.svg2 = False
    import schemdraw.elements as elm

    with sd.Drawing() as d:
        d.config(unit=2, fontsize=16)

        # R1 & C1
        elm.Dot(open=True).label(r'$V_\mathrm{in,p}$', loc='left')
        elm.Line().right().length(1.0)
        elm.Resistor().label('$R_1$')
        dot0a = elm.Line().right().length(1.0).dot()
        elm.Line().down().length(1.5)
        elm.Capacitor().down().label('$C_1$').reverse()
        dot0b = elm.Line().down().length(1.5).dot()
        elm.Line().left().length(1.0)
        elm.Resistor().label('$R_1$')
        elm.Line().left().length(1.0)
        elm.Dot(open=True).label(r'$V_\mathrm{in,n}$', loc='left')

        # R2 & C2
        elm.Line().at(dot0a.end).right().length(1.0)
        elm.Resistor().label('$R_2$')
        dot1a = elm.Line().right().length(1.0).dot()
        elm.Line().down().length(1.5)
        elm.Capacitor().down().label('$C_2$').reverse()
        dot1b = elm.Line().down().length(1.5).dot()
        elm.Line().left().length(1.0)
        elm.Resistor().label('$R_2$')
        elm.Line().left().length(1.0)

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

        # C3
        elm.Line().at(dot3a.end).right().length(1.0)
        elm.Capacitor().label('$C_3$')
        elm.Line().right().tox(dot2a).dot()
        elm.Line().down().toy(dot2a)
        elm.Line().at(dot3b.end).right().length(1.0)
        elm.Capacitor().label('$C_3$')
        elm.Line().right().tox(dot2b).dot()
        elm.Line().up().toy(dot2b)

        # R4
        elm.Line().at(dot1a.end).up().length(2.0)
        elm.Line().right().length(1.0)
        elm.Resistor().label('$R_4$')
        elm.Line().right().tox(dot2a)
        elm.Line().down().toy(dot2a)
        elm.Line().at(dot1b.end).down().length(2.0)
        elm.Line().right().length(1.0)
        elm.Resistor().label('$R_4$')
        elm.Line().right().tox(dot2b)
        elm.Line().up().toy(dot2b)

        # Save the schematic
        _dir = os.path.dirname(os.path.abspath(__file__))
        _fig_dir = os.path.join(_dir, 'figures')
        os.makedirs(_fig_dir, exist_ok=True)
        d.save(os.path.join(_fig_dir, '3rd_order_mfb_lpf_circuit.svg'))
        d.save(os.path.join(_fig_dir, '3rd_order_mfb_lpf_circuit.pdf'))


def get_3rd_order_coefficients_lut(Wn, rp, btype, ftype, gp):
    """
    Get 3rd-order filter coefficients from Tietze-Schenk style look-up table.
    
    Retrieves normalized filter coefficients from LUT for 1st-order and 2nd-order
    (biquad) sections, combines them into the overall 3rd-order transfer function,
    and returns the result as a single (beta, alpha) coefficient tuple.
    
    3rd-order transfer function form (buffered):
    
        H(s) = H_first(s) · H_biquad(s)
        
        where:
                          1
        H_first(s) = ----------
                      a1·s + 1
                       
                              b0
        H_biquad(s) = ------------------
                       a3·s² + a2·s + 1
                       
    Combined form (unbuffered):
    
                                    b0
        H(s) = ---------------------------------------------
                a1·a3·s³ + (a1·a2 + a3)·s² + (a1 + a2)·s + 1

                                b0
        H(s) = --------------------------------------
                alpha3·s³ + alpha2·s² + alpha1·s + 1

        where:
            alpha1 = a1 + a2
            alpha2 = a1·a2 + a3
            alpha3 = a1·a3
            b0 = 1.0 (before gain scaling)

    Args:
        Wn (float): Cutoff angular frequency in rad/s. Use Wn=1 for normalized
                    prototype coefficients.
        rp (float): Passband ripple in dB. Only used for Chebyshev filters.
                    Available values: 0.1, 0.5, 1.0, or 3.0 dB.
        btype (str): Filter band type. Only 'lowpass' is currently supported.
        ftype (str): Filter approximation type:
                     - 'butter': Butterworth (maximally flat magnitude)
                     - 'bessel': Bessel (maximally flat group delay)
                     - 'cheby1': Chebyshev Type I (equiripple passband)
        gp (float): Desired passband DC gain (linear scale, e.g., 1.0 for unity).
        
    Returns:
        tuple: (beta, alpha) coefficient arrays for the combined 3rd-order
               transfer function:
            - beta = [b0] numerator coefficient array
                  b0 = gp (the specified DC gain)
            - alpha = [alpha3, alpha2, alpha1, 1] denominator coefficients derived from
              the LUT values according to:
                  - alpha1 = a1 + a2
                  - alpha2 = a1·a2 + a3
                  - alpha3 = a1·a3
                  
        Note on naming convention (Tietze-Schenk LUT vs. output arrays):
            - LUT coefficients (a1, a2, a3): Per-section coefficients from
              Tietze-Schenk tables. These describe individual filter sections:
                  * a1: 1st-order section coefficient
                  * a2, a3: 2nd-order biquad section coefficients
            - Output arrays (beta, alpha): Combined transfer function
              coefficients for the entire 3rd-order filter.
            
    Raises:
        ValueError: If btype is not 'lowpass', ftype is not recognized,
                    or the requested order/ripple combination is not in LUT.
        
    Notes:
        - Coefficients are returned in textbook style with alpha[-1] = 1.
        - For normalized prototype (Wn=1), alpha values equal the combined
          coefficients directly from the LUT.
        - Frequency scaling transforms s → s/Wn, shifting the cutoff frequency.
        - The DC gain gp is applied only to the numerator (beta).
        
    Example:
        >>> # Get normalized 3rd-order Butterworth prototype
        >>> beta, alpha = get_3rd_order_coefficients_lut(Wn=1, rp=0, btype='lowpass', ftype='butter', gp=1.0)
        >>> print(beta)   # [1.0]
        >>> print(alpha)  # [1.0, 2.0, 2.0, 1.0] for Butterworth
        
        >>> # Get coefficients scaled to 1 kHz cutoff with unity gain
        >>> beta, alpha = get_3rd_order_coefficients_lut(Wn=2*np.pi*1e3, rp=0, btype='lowpass', ftype='butter', gp=1.0)
    """
    
    # Validate inputs
    if btype != 'lowpass':
        raise ValueError(f"Only 'lowpass' supported in LUT, got '{btype}'")
    
    # Select coefficient table
    if ftype == 'butter':
        if 3 not in BUTTERWORTH_COEFFS:
            raise ValueError("Butterworth order 3 not in LUT")
        sections = BUTTERWORTH_COEFFS[3]
    elif ftype == 'bessel':
        if 3 not in BESSEL_COEFFS:
            raise ValueError("Bessel order 3 not in LUT")
        sections = BESSEL_COEFFS[3]
    elif ftype == 'cheby1':
        # Find closest ripple value
        available_ripples = list(CHEBYSHEV_COEFFS.keys())
        if rp not in available_ripples:
            closest = min(available_ripples, key=lambda x: abs(x - rp))
            print(f"Warning: Ripple {rp}dB not in LUT, using closest: {closest}dB")
            rp = closest
        if 3 not in CHEBYSHEV_COEFFS[rp]:
            raise ValueError(f"Chebyshev order 3 with {rp}dB ripple not in LUT")
        sections = CHEBYSHEV_COEFFS[rp][3]
    else:
        raise ValueError(f"Filter type '{ftype}' not in LUT. Use 'butter', 'bessel', or 'cheby1'")
    
    # Extract coefficients from list of tuples
    # 3rd order: sections = [(a1,), (a2, a3)]
    a1 = sections[0][0]     # First-order section: H(s) = 1 / (1 + a1*s)
    a2, a3 = sections[1]    # Biquad section: H(s) = 1 / (1 + a2*s + a3*s²)
    
    # Calculate combined alpha coefficients
    alpha1 = a1 + a2
    alpha2 = a1 * a2 + a3
    alpha3 = a1 * a3

    # b0 is unity before gain scaling
    b0 = gp

    # Build coefficient arrays
    beta = np.array([b0])
    alpha = np.array([alpha3, alpha2, alpha1, 1.0])

    # Apply frequency scaling: s -> s/Wn
    alpha[0] = alpha[0] / Wn**3  # alpha3 coefficient scaled by 1/Wn^3
    alpha[1] = alpha[1] / Wn**2  # alpha2 coefficient scaled by 1/Wn^2
    alpha[2] = alpha[2] / Wn     # alpha1 coefficient scaled by 1/Wn
    
    return beta, alpha
# =========================================================================


def calc_3rd_order_mfb_components(w_pass, beta0, alpha1, alpha2, alpha3, k, R1, C1, C3):
    """
    Calculate 3rd-order MFB lowpass filter components for both sections.
    
    Combines calculation for unbuffered first-order passive section (R1, C1) and 
    biquad active section (R2-R4, C2-C3). Given the filter coefficients (alpha) and
    pre-selected component values (R1, C1, C3), calculates the remaining
    components (R2, R3, R4, C2) to realize the desired transfer function.
    
    Design Equations:
        wp = w_pass / alpha1                    (first-order section frequency)
        w0 = sqrt(alpha1 / alpha3) * w_pass     (biquad frequency)
        Q = alpha1 * alpha3 * sqrt(alpha1/alpha3) / (alpha1*alpha2 - alpha3)
        
        R2 = k * R1
        R4 = -beta0 * (R1 + R2)
        R3 = [(R1+R2) - wp*((R1+R2)*R4*C3 + R1*R2*C1)] / [(R1+R2+R4)*C3*wp]
        C2 = [(R1*(R3+R4) + R2*(R3+R4) + R3*R4)*C3 + R1*R2*C1] / [R1*R2*R3*R4*C1*C3*w0²]
    
    Args:
        w_pass (float): Cutoff angular frequency in rad/s
        beta0 (float): Numerator coefficient (DC gain, typically 1.0 for unity)
        alpha1 (float): Normalized coefficient for s^1 term (from LUT)
        alpha2 (float): Normalized coefficient for s^2 term (from LUT)
        alpha3 (float): Normalized coefficient for s^3 term (from LUT)
        k (float): Ratio R2/R1, design parameter for component scaling
        R1 (float): Chosen resistor R1 value in Ohms (first-order section)
        C1 (float): Chosen capacitor C1 value in Farads (first-order section, to GND)
        C3 (float): Chosen capacitor C3 value in Farads (biquad feedback cap)
        
    Returns:
        tuple: (R1, R2, R3, R4, C1, C2, C3) component values in Ohms and Farads
            - R1, C1: First-order passive section components
            - R2: Biquad input resistor (= k * R1)
            - R3: Biquad resistor to inverting input
            - R4: Biquad feedback resistor
            - C2: Biquad capacitor to GND (calculated)
            - C3: Biquad capacitor in feedback (given)
            
    Raises:
        ValueError: If C3 exceeds C3_max (constraint for positive R3)
        ValueError: If any calculated component (R2, R3, R4, C2) is non-positive
        
    Notes:
        - C3 must satisfy: C3 < C3_max = (R1+R2 - wp*R1*R2*C1) / (wp*(R1+R2)*R4)
        - For differential implementation: C_diff = C_se / 2
        - Prints intermediate values: wp, w0, Q, C3_max, Zin_dc
    """

    print("Chosen coefficients:")
    print("k      = %.3f" % k)
    print("beta0  = %.3f" % beta0)
    print("alpha1 = %.3f" % alpha1)
    print("alpha2 = %.3f" % alpha2)
    print("alpha3 = %.3f" % alpha3)
    print("-" * 60, "\n")

    print("Chosen component values:")
    print("R1 = %.2f kOhm" % (R1/1e3))
    print("C1 (se) = %.2f pF --> C1 (diff) = %.2f pF" % (C1/1e-12, C1/2/1e-12))
    print("C3 = %.2f pF" % (C3/1e-12))
    print("-" * 60, "\n")

    # Calculate wp (angular frequency of the first-order section) based on the desired cutoff frequency w_pass and the alpha coefficients
    wp = w_pass / alpha1

    # Calculate w0 (angular frequency of the biquad section) based on the desired cutoff frequency w_pass and the alpha coefficients
    w0 = np.sqrt(alpha1 / alpha3) * w_pass

    # Calculate Q (quality factor) based on the alpha coefficients
    Q = alpha1 * alpha3 * np.sqrt(alpha1 / alpha3) / (alpha1 * alpha2 - alpha3)
    
    print("Angular frequencies & quality factor:")
    print("wp = %.3f Hz" % wp)
    print("w0 = %.3f Hz" % w0)
    print("Q = %.3f" % Q)
    print("-" * 60, "\n")

    # 1. Calculate R2
    R2 = k * R1
    
    # 2. Calculate R4
    R4 = beta0 * (R1 + R2)
    
    # 3. Calculate R3
    R3 = ((R1 + R2) - wp * ((R1 + R2) * R4 * C3 + R1 * R2 * C1)) / ((R1 + R2 + R4) * C3 * wp)
    
    # 4. Calculate C2
    # Based on the derived equation for alpha3 = a1 * a3
    C2 = ((R1 * (R3 + R4) + R2 * (R3 + R4) + R3 * R4) * C3 + R1 * R2 * C1) / (R1 * R2 * R3 * R4 * C1 * C3 * (w0**2))
    
    # 5. Condition for C3
    print("Condition for C3:")
    C3_max = (R1 + R2 - wp * R1 * R2 * C1) / (wp * (R1 + R2) * R4)
    print("C3_max = %.2f pF" % (C3_max/1e-12))
    if C3 > C3_max:
        raise ValueError(
            f"C3 = {C3:.4e}F exceeds maximum allowed value C3_max = {C3_max:.4e}F.\n"
            f"To ensure positive R3, reduce C3 or adjust R1, C1 values."
        )
    print("-" * 60, "\n")

    # 6. Calculate Input Impedance at dc
    print("Input Impedance at dc:")
    Zin_dc = R1 + R2 + R3
    print("Zin_dc = %.2f MOhm" % (Zin_dc/1e6))
    # Input impedance transfer function coming soon...
    # TODO: Calculate Zin(w) over frequency
    print("-" * 60, "\n")

    # 7. Error handling for negative component values
    invalid_components = []
    if R2 <= 0:
        invalid_components.append(("R2", R2))
    if R3 <= 0:
        invalid_components.append(("R3", R3))
    if R4 <= 0:
        invalid_components.append(("R4", R4))
    if C2 <= 0:
        invalid_components.append(("C2", C2))
    
    if invalid_components:
        error_msg = "Invalid component values (must be positive):\n"
        for name, value in invalid_components:
            error_msg += f"  {name} = {value:.4e}\n"
        error_msg += "Check input parameters: beta0, alpha coefficients, k, R1, C1, C3."
        raise ValueError(error_msg)
    
    print("Calculated values:")
    print("R1       = %.2f kOhm" % (R1/1e3))
    print("C1 (se)  = %.2f pF --> C1 (diff) = %.2f pF" % (C1/1e-12, C1/2/1e-12))
    print("R2       = %.2f kOhm" % (R2/1e3))
    print("R3       = %.2f kOhm" % (R3/1e3))
    print("R4       = %.2f kOhm" % (R4/1e3))
    print("C2 (se)  = %.2f pF --> C2 (diff) = %.2f pF" % (C2/1e-12, C2/2/1e-12))
    print("C3       = %.2f pF" % (C3/1e-12))

    return R1, R2, R3, R4, C1, C2, C3
# =========================================================================


def calc_3rd_order_mfb_coefficients(w_pass, R1, R2, R3, R4, C1, C2, C3):
    """
    Calculate 3rd-order MFB lowpass filter transfer function coefficients.
    
    Derives the transfer function coefficients from component values using
    circuit analysis of the combined, unbuffered first-order passive and biquad active
    MFB topology. Returns coefficients in textbook style (constant term normalized to 1).
    
    Two sets of alpha coefficients are computed:
    
    1. Normalized coefficients (alpha_rc_wc): Multiplying by w_pass powers, used for
       calculating wp, w0, Q verification:
       
        alpha1_rc_wc = w_pass * [(R1*(R3+R4) + R2*(R3+R4) + R3*R4)*C3 + R1*R2*C1] / (R1+R2)
        alpha2_rc_wc = w_pass² * [R3*R4*(R1+R2)*C2*C3 + R1*(R2*R3+R2*R4+R3*R4)*C1*C3] / (R1+R2)
        alpha3_rc_wc = w_pass³ * [R1*R2*R3*R4*C1*C2*C3] / (R1+R2)
        
    2. Frequency-scaled coefficients (alpha): Divided by w_pass powers, used for
       transfer function construction consistent with prototype coefficients:
       
        alpha1 = alpha1_rc / w_pass
        alpha2 = alpha2_rc / w_pass²
        alpha3 = alpha3_rc / w_pass³
        
    Derived quantities (from normalized coefficients):
        wp = w_pass / alpha1_rc_wc                             (first-order section frequency)
        w0 = np.sqrt(alpha1_rc_wc / alpha3_rc_wc) * w_pass     (biquad resonance frequency)
        Q = alpha1_rc_wc * alpha3_rc_wc * np.sqrt(alpha1_rc_wc/alpha3_rc_wc) / (alpha1_rc_wc*alpha2_rc_wc - alpha3_rc_wc)
    
    Args:
        w_pass (float): Cutoff angular frequency in rad/s
        R1 (float): First-order section resistor in Ohms
        R2 (float): Biquad input resistor in Ohms
        R3 (float): Biquad resistor to inverting input in Ohms
        R4 (float): Biquad feedback resistor in Ohms
        C1 (float): First-order section capacitor to ground in Farads (single-ended)
        C2 (float): Biquad capacitor to ground in Farads (single-ended)
        C3 (float): Biquad capacitor in feedback in Farads
        
    Returns:
        tuple: (beta, alpha) where:
            - beta = [beta0] numerator coefficient (DC gain = R4/(R1+R2))
            - alpha = [alpha3_rc, alpha2_rc, alpha1_rc, 1] frequency-scaled denominator coefficients
            
    Notes:
        Transfer function form (textbook style):
        
                           beta0
        H(s) = ------------------------------------
                alpha3·s³ + alpha2·s² + alpha1·s + 1
               
        The returned frequency-scaled alpha coefficients can be directly compared with
        the prototype coefficients from get_3rd_order_coefficients_lut(Wn=1, ...).
        
        Prints calculated wp, w0, Q values for verification against the design targets from calc_3rd_order_mfb_components.
    """

    # Calculate beta & alpha coefficients from RC values
    beta0_rc = float(R4 / (R1 + R2))
    alpha1_rc_wc = float(w_pass * ((R1 * (R3 + R4) + R2 * (R3 + R4) + R3 * R4) * C3 + R1 * R2 * C1) / (R1 + R2))
    alpha2_rc_wc = float(w_pass**2 * (R3 * R4 * (R1 + R2) * C2 * C3 + R1 * (R2 * R3 + R2 * R4 + R3 * R4) * C1 * C3) / (R1 + R2))
    alpha3_rc_wc = float(w_pass**3 * (R1 * R2 * R3 * R4 * C1 * C2 * C3) / (R1 + R2))

    print("Beta & alpha coefficients (from RC values):")
    print("beta0  = %.4f" % beta0_rc)
    print("alpha1 = %.4f" % alpha1_rc_wc)
    print("alpha2 = %.4f" % alpha2_rc_wc)
    print("alpha3 = %.4f" % alpha3_rc_wc)
    print("-" * 60, "\n")

    # Calculate wp (angular frequency of the first-order section) based on the desired cutoff frequency w_pass and the RC values
    wp_rc = w_pass / alpha1_rc_wc

    # Calculate w0 (angular frequency of the biquad section) based on the desired cutoff frequency w_pass and the RC values
    w0_rc = np.sqrt(alpha1_rc_wc / alpha3_rc_wc) * w_pass

    # Calculate Q (quality factor) based on the alpha coefficients
    Q_rc = alpha1_rc_wc * alpha3_rc_wc * np.sqrt(alpha1_rc_wc / alpha3_rc_wc) / (alpha1_rc_wc * alpha2_rc_wc - alpha3_rc_wc)
    
    print("Angular frequencies & quality factor (from RC values):")
    print("wp = %.3f Hz" % wp_rc)
    print("w0 = %.3f Hz" % w0_rc)
    print("Q = %.3f" % Q_rc)
    print("-" * 60, "\n")

    # Scale alpha coefficients with w_pass for plotting consistency
    alpha1_rc = alpha1_rc_wc / w_pass
    alpha2_rc = alpha2_rc_wc / (w_pass**2)
    alpha3_rc = alpha3_rc_wc / (w_pass**3)

    return [beta0_rc], [alpha3_rc, alpha2_rc, alpha1_rc, 1]
# =========================================================================


def quantize_3rd_order_mfb_components(R1_ideal, R2_ideal, R3_ideal, R4_ideal, C1_ideal, C2_ideal, C3_ideal, w_rhigh, s_rhigh, l_rhigh_grid, CU):
    """
    Quantize ideal 3rd-order MFB filter components to realizable values.
    
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
        R4_ideal (float): Ideal resistor R4 in Ohms
        C1_ideal (float): Ideal capacitor C1 in Farads
        C2_ideal (float): Ideal capacitor C2 in Farads
        C3_ideal (float): Ideal capacitor C3 in Farads
        w_rhigh (float): Width of the rhigh resistor in meters
        s_rhigh (int): Number of series sections (same for all resistors)
        l_rhigh_grid (float): Length grid for rounding segment lengths in meters
                              (e.g. 0.5e-6 for 0.5 um grid)
        CU (float): Unit capacitor value in Farads
        
    Returns:
        tuple: (R1, R2, R3, R4, C1, C2, C3, l_R1, l_R2, l_R3, l_R4)
            - R1..R4: Quantized resistor values in Ohms
            - C1..C3: Quantized capacitor values in Farads
            - l_R1..l_R4: Quantized segment lengths in meters for each resistor
            
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
    l_R4 = calc_rhigh_length_ihp130(w=w_rhigh, R=R4_ideal, s=s_rhigh, m=1, b=0)
    
    # Quantize segment lengths to nearest multiple of l_rhigh_grid
    l_R1 = round(l_R1 / l_rhigh_grid) * l_rhigh_grid
    l_R2 = round(l_R2 / l_rhigh_grid) * l_rhigh_grid
    l_R3 = round(l_R3 / l_rhigh_grid) * l_rhigh_grid
    l_R4 = round(l_R4 / l_rhigh_grid) * l_rhigh_grid

    # Calculate quantized resistor values from quantized segment lengths
    R1 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R1, s=s_rhigh, m=1, b=0)
    R2 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R2, s=s_rhigh, m=1, b=0)
    R3 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R3, s=s_rhigh, m=1, b=0)
    R4 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R4, s=s_rhigh, m=1, b=0)
    
    # Calculate capacitor integer multipliers (round to nearest EVEN number)
    # round(x / 2) * 2 gives the nearest even integer
    # Exception: if multiplier < 1, set to 1 (minimum 1 unit capacitor)
    n_C1 = max(1, round(C1_ideal / CU / 2) * 2)
    n_C2 = max(1, round(C2_ideal / CU / 2) * 2)
    n_C3 = max(1, round(C3_ideal / CU / 2) * 2)
    
    # Calculate quantized capacitor values
    C1 = n_C1 * CU
    C2 = n_C2 * CU
    C3 = n_C3 * CU
    
    # Calculate relative errors (%)
    err_R1 = (R1 - R1_ideal) / R1_ideal * 100
    err_R2 = (R2 - R2_ideal) / R2_ideal * 100
    err_R3 = (R3 - R3_ideal) / R3_ideal * 100
    err_R4 = (R4 - R4_ideal) / R4_ideal * 100
    err_C1 = (C1 - C1_ideal) / C1_ideal * 100
    err_C2 = (C2 - C2_ideal) / C2_ideal * 100
    err_C3 = (C3 - C3_ideal) / C3_ideal * 100
    
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
    print("R4: sections = %d, l = %.2f um, R = %.2f kOhm (ideal: %.2f kOhm, error: %+.2f%%)" % (s_rhigh, l_R4/1e-6, R4/1e3, R4_ideal/1e3, err_R4))
    print("C1 = %d x CU = %.2f pF (ideal: %.2f pF, error: %+.2f%%)" % (n_C1, C1/1e-12, C1_ideal/1e-12, err_C1))
    print("C2 = %d x CU = %.2f pF (ideal: %.2f pF, error: %+.2f%%)" % (n_C2, C2/1e-12, C2_ideal/1e-12, err_C2))
    print("C3 = %d x CU = %.2f pF (ideal: %.2f pF, error: %+.2f%%)" % (n_C3, C3/1e-12, C3_ideal/1e-12, err_C3))
    
    return R1, R2, R3, R4, C1, C2, C3, l_R1, l_R2, l_R3, l_R4
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


def main():

    # Print Transfer Function Definition
    print("\n3rd-Order MFB Lowpass Filter Designer")
    print("=" * 60)
    print("Transfer Function: H(s) = H_first(s) · H_biquad(s)")
    print("")
    print("                   1")
    print("H_first(s)  = ----------")
    print("               a1·s + 1")
    print("")
    print("                       b0")
    print("H_biquad(s) = ------------------")
    print("               a3·s² + a2·s + 1")
    print("")
    print("                                                         b0")
    print("H(s) = H_first(s) · H_biquad(s) = ----------------------------------------------")
    print("                                   a1·a3·s³ + (a1·a2 + a3)·s² + (a1 + a2)·s + 1")
    print("=" * 60, "\n")

    # Draw Biquad MFB LPF
    draw_3rd_order_mfb_lpf()

    # --- 1. Filter & OTA Specifications ---
    print("\n         --- 1. Filter & OTA Specifications ---")
    print("=" * 60)

    # Filter Specifications
    area_max_umsq = (100e-6 * 100e-6) / 1e-12   # max available chip area

    f_start = 1                                 # start frequency
    f_end = 1e9                                 # end frequency
    f_pass_ideal = 400e3                        # -3dB corner frequency (ideal)
    
    gp_ideal_dB = -0.5                          # Passband gain in dB (ideal)
    gp_ideal = 10**(gp_ideal_dB / 20.0)         # Passband gain (ideal)
    ripple_pass_dB = 1                          # Passband ripple in dB (e.g. Chebyshev)
    ripple_pass = 10**(ripple_pass_dB / 20.0)   # Passband ripple (e.g. Chebyshev)

    filter_type = 'lowpass'                     # Select low-pass filter
    filter_order = 3                            # Order of the filter prototype
    filter_approx = 'butter'                    # Filter approximation type ('butter', 'cheby1', 'bessel')
    fully_differential = True                   # True = fully-differential, False = single-ended

    print("Filter Specifications:")
    print("-" * 60)
    print("Cutoff Frequency (ideal) = %.2fkHz" % (f_pass_ideal/1e3))
    print("Passband DC Gain (ideal) = %.2f (%.2fdB)" % (gp_ideal, gp_ideal_dB))
    print("Passband Ripple = %.2f (%.2fdB)" % (ripple_pass, ripple_pass_dB))
    print("Order = %d" % filter_order)
    print("Approximation = %s" % filter_approx)
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
    f_pass = 1.96 * f_pass_ideal
    w_pass = 2 * pi * f_pass        # w_pass = w_c in rad/s
    w_vec = 2 * np.pi * np.logspace(np.log10(f_start), np.log10(f_end), 1001)

    print("\nCut-Off Frequency Error Compensation:")
    print("-" * 60)
    # print("Cutoff Frequency (real) = %.2fkHz" % (f_pass_real/1e3))
    print("Updated Cutoff Frequency (taking OTA OL Gain into account) = %.2fkHz" % (f_pass/1e3))
    print("=" * 60, "\n")
    # =========================================================================


    # --- 2. Filter Type Comparison ---
    print("\n             --- 2. Filter Type Comparison ---")
    print("=" * 60)
    print("Printing coefficients with normalized corner frequency Wn=1...")
    b_proto_butter_lut, a_proto_butter_lut = get_3rd_order_coefficients_lut(Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp)
    b_proto_bessel_lut, a_proto_bessel_lut = get_3rd_order_coefficients_lut(Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp)
    b_proto_cheby_lut, a_proto_cheby_lut = get_3rd_order_coefficients_lut(Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp)
    print("Butterworth (LUT): beta =", np.array2string(b_proto_butter_lut, precision=4), ", alpha =", np.array2string(a_proto_butter_lut, precision=4))
    print("Bessel (LUT):      beta =", np.array2string(b_proto_bessel_lut, precision=4), ", alpha =", np.array2string(a_proto_bessel_lut, precision=4))
    print("Chebyshev (LUT):   beta =", np.array2string(b_proto_cheby_lut, precision=4), ", alpha =", np.array2string(a_proto_cheby_lut, precision=4))

    print("Plotting Filter Analysis with Wn=w_pass...")
    b_proto_butter_lut, a_proto_butter_lut = get_3rd_order_coefficients_lut(Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='butter', gp=gp)
    b_proto_bessel_lut, a_proto_bessel_lut = get_3rd_order_coefficients_lut(Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='bessel', gp=gp)
    b_proto_cheby_lut, a_proto_cheby_lut = get_3rd_order_coefficients_lut(Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype='cheby1', gp=gp)
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
    print("\n                --- 3. Prototype Filter ---")
    print("=" * 60)
    print("Calculate Prototype Filter Coefficients from LUT:")
    
    # Get Coefficients for Wn=1 and Wn=w_pass
    beta, alpha = get_3rd_order_coefficients_lut(Wn=1, rp=ripple_pass_dB, btype=filter_type, ftype=filter_approx, gp=gp)
    beta_prototype, alpha_prototype = get_3rd_order_coefficients_lut(Wn=w_pass, rp=ripple_pass_dB, btype=filter_type, ftype=filter_approx, gp=gp)
    print("beta_prototype  = [beta0] =", beta_prototype)
    print("alpha_prototype = [alpha3, alpha2, alpha1] =", alpha_prototype)
    print("-" * 60)

    # Plot Prototype Filter Analysis
    print("\nPlotting Prototype Filter Analysis...")
    sys_prototype_filter = control.TransferFunction(beta_prototype, alpha_prototype)
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
    # export_path = os.path.join(export_dir, '3rd_order_mfb_lpf_prototype_bode.csv')
    # np.savetxt(export_path,
    #            np.column_stack((freq_prototype_hz, mag_prototype_dB, phase_prototype_deg)),
    #            comments="", header="frequency,mag_dB,phase_deg", delimiter=",")
    # print("Exported to: %s" % os.path.abspath(export_path))
    # print("=" * 60, "\n")
    # =========================================================================


    # --- 4. Ideal RC Filter ---
    print("\n                --- 4. Ideal RC Filter ---")
    print("=" * 60)

    # Define unit cell values
    w_cmim = 8e-6   # Width of the MIM capacitor
    l_cmim = 8e-6   # Length of the MIM capacitor
    CU = calc_cmim_capacitance_ihp130(w=w_cmim, l=l_cmim, m=1)  # Unit capacitor in Farads (W = 8um, L = 8um, m = 1)

    # Calculate ideal RC Components
    print("Calculate Ideal RC Filter Components:")
    k = 1.16  # Scaling factor to adjust component values for better area occupation (k increases --> alpha2 decreases)
    w_rhigh = IHP130_PARAMS['w_rpoly']
    l_rhigh_R1 = 27e-6
    s_rhigh = 3  # Number of series sections (odd number for left / right contacts, same for all resistors)
    # print("s_rhigh = %0.2f" % (calc_rhigh_series_sections_ihp130(w_rhigh, l_rhigh_R1, 226e3, m=1, b=0)))
    print("R per section = %0.2f" % (calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_rhigh_R1, s=1, m=1, b=0)/1e3), "kOhm")
    R1 = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_rhigh_R1, s=s_rhigh, m=1, b=0) # 4 x rhigh resistors in series with W = 0.5um, L = 20um for R1
    C3 = CU
    C1_se = 20 * C3
    R1_ideal, R2_ideal, R3_ideal, R4_ideal, C1_se, C2_se, C3 = calc_3rd_order_mfb_components(w_pass, beta[-1], alpha[2], alpha[1], alpha[0], k, R1, C1_se, C3)
    print("-" * 60, "\n")

    # Calculate Ideal RC Filter Coefficients
    beta_ideal_rc, alpha_ideal_rc = calc_3rd_order_mfb_coefficients(w_pass, R1_ideal, R2_ideal, R3_ideal, R4_ideal, C1_se, C2_se, C3)
    print("beta_ideal_rc = [b0] =", beta_ideal_rc)
    print("alpha_ideal_rc = [alpha3, alpha2, alpha1, 1] =", alpha_ideal_rc)
    print("-" * 60)

    # Plot Ideal RC Filter Analysis
    print("\nPlotting Ideal RC Filter Analysis...")
    sys_ideal_rc_filter = control.TransferFunction(beta_ideal_rc, alpha_ideal_rc)
    plot_system_analysis({"Ideal RC Filter": sys_ideal_rc_filter}, "Ideal RC Filter", filter_order, w_vec, w_pass, gp, show_plot = False)
    print("=" * 60, "\n")
    # =========================================================================
    
    
    # --- 5. Real RC Filter ---
    print("\n          --- 5. Real RC Filter (Unit Cells) ---")
    print("=" * 60)
    
    # Quantize ideal values from section 4 to unit cell multiples
    # Fully-Differential Implementation
    print("Quantizing ideal RC values to unit cell multiples:")
    l_rhigh_grid = 1.0e-6  # Length grid for rounding segment lengths (e.g. 0.5 um)
    if fully_differential:
        R1_real, R2_real, R3_real, R4_real, C1_real, C2_real, C3_real, l_R1, l_R2, l_R3, l_R4 = quantize_3rd_order_mfb_components(R1_ideal, R2_ideal, R3_ideal, R4_ideal, C1_se / 2, C2_se / 2, C3, IHP130_PARAMS['w_rpoly'], s_rhigh, l_rhigh_grid, CU)
    else:
        R1_real, R2_real, R3_real, R4_real, C1_real, C2_real, C3_real, l_R1, l_R2, l_R3, l_R4 = quantize_3rd_order_mfb_components(R1_ideal, R2_ideal, R3_ideal, R4_ideal, C1_se, C2_se, C3, IHP130_PARAMS['w_rpoly'], s_rhigh, l_rhigh_grid, CU)
    print("-" * 60)

    # Manual Adjustment of Quantized Values (if desired)
    print("\nQuantized component values (manual adjustment):")
    # R1_real = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R1, s=s_rhigh, m=1, b=0)
    # R2_real = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R2, s=s_rhigh, m=1, b=0)
    # R3_real = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R3, s=s_rhigh, m=1, b=0)
    # R4_real = calc_rhigh_resistance_ihp130(w=w_rhigh, l=l_R4, s=s_rhigh, m=1, b=0)
    # C1_real = 70 * CU
    # C2_real = 42 * CU
    # C3_real = 1 * CU
    # print("R1 = %.2f kOhm" % (R1_real/1e3))
    # print("R2 = %.2f kOhm" % (R2_real/1e3))
    # print("R3 = %.2f kOhm" % (R3_real/1e3))
    # print("R4 = %.2f kOhm" % (R4_real/1e3))
    # print("C1 = %.2f pF" % (C1_real/1e-12))
    # print("C2 = %.2f pF" % (C2_real/1e-12))
    # print("C3 = %.2f pF" % (C3_real/1e-12))
    print("-" * 60)

    print("\nPrint total length of all resistors:")
    total_res_length = l_R1 + l_R2 + l_R3 + l_R4
    print("Total Resistor length = %.2f um" % (total_res_length * 1e6))
    print("-" * 60)

    print("\nPrint total length of all capacitors:")
    total_cap_length = l_cmim * (C1_real / 2 + C2_real / 2 + C3_real) / CU
    print("Total Capacitor length = %.2f um" % (total_cap_length * 1e6))
    print("-" * 60)

    # 90% - 10% Plot Rise Time & Slope of Passive RC Lowpass Filter
    # As long as the slope (dV/dt) of the passive RC filter output is lower than the Slew Rate (SR) of the OTA, 
    # the OTA remains in its linear region (closed loop) at all times.
    print(f"\n90% - 10% Rise Time of Passive RC Lowpass Filter:")
    rise_time = 2.20 * R1_real * (2 * C1_real)
    print("tr ~ 2.20 * R1 * C1 = %.2f us" % (rise_time * 1e6))
    VDD = 1.8
    dV = (0.9 - 0.1) * VDD
    slope = dV / rise_time
    print("Slope = dV / tr = %.2f V/us" % (slope * 1e-6))
    print("-" * 60)

    # Calculate Real RC Filter Coefficients
    print("\nCalculate Real RC Filter Coefficients H(s) = b / a:")
    if fully_differential:
        beta_real_rc, alpha_real_rc = calc_3rd_order_mfb_coefficients(w_pass, R1_real, R2_real, R3_real, R4_real, C1_real * 2, C2_real * 2, C3_real)
    else:
        beta_real_rc, alpha_real_rc = calc_3rd_order_mfb_coefficients(w_pass, R1_real, R2_real, R3_real, R4_real, C1_real, C2_real, C3_real)
    print("beta_real_rc = [b0] =", beta_real_rc)
    print("alpha_real_rc = [alpha3, alpha2, alpha1, 1] =", alpha_real_rc)
    print("-" * 60)

    # Plot Real RC Filter Analysis
    print("\nPlotting Real RC Filter Analysis...")
    sys_real_rc_filter = control.TransferFunction(beta_real_rc, alpha_real_rc)
    plot_system_analysis({"Real RC Filter": sys_real_rc_filter}, "Real RC Filter", filter_order, w_vec, w_pass, gp, show_plot = False)
    print("=" * 60, "\n")
    # =========================================================================
    

    # --- 6. Filter Design Comparison ---
    print("\n      --- 6. Filter Design Comparison ---")
    print("=" * 60)

    print("Print Filter Coefficients H(s) = beta / alpha:")
    print("beta_prototype = [beta0] =", beta_prototype)
    print("alpha_prototype = [alpha3, alpha2, alpha1, 1] =", alpha_prototype, "\n")
    print("beta_ideal_rc = [beta0] =", beta_ideal_rc)
    print("alpha_ideal_rc = [alpha3, alpha2, alpha1, 1] =", alpha_ideal_rc, "\n")
    print("beta_real_rc = [beta0] =", beta_real_rc)
    print("alpha_real_rc = [alpha3, alpha2, alpha1, 1] =", alpha_real_rc)
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
    r_vec = np.array([R1_real, R2_real, R3_real, R4_real])
    # Assuming fully-differential (2 x resistors)
    r_tot = 2 * np.sum(r_vec)
    
    c_diff_vec = np.array([C1_real, C2_real])
    c_se_vec = np.array([C3_real])
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
    print("area_dummies = %.2fum^2" % (area_dummies))

    # Inverter Area = a * PMOS + NMOS
    area_inverter_NF20 = (20 * w_pmos_NF * l_mos) + (20 * w_nmos_NF * l_mos) + area_dummies
    print("area_inverter_NF20 = %.2fum^2" % (area_inverter_NF20))

    area_inverter_NF18 = (18 * w_pmos_NF * l_mos) + (18 * w_nmos_NF * l_mos) + area_dummies
    print("area_inverter_NF18 = %.2fum^2" % (area_inverter_NF18))

    area_inverter_NF10 = (10 * w_pmos_NF * l_mos) + (10 * w_nmos_NF * l_mos) + area_dummies
    print("area_inverter_NF10 = %.2fum^2" % (area_inverter_NF10))
    
    area_ota_umsq = 6 * area_inverter_NF20 + 1 * area_inverter_NF18 + 4 * area_inverter_NF10
    print("area_ota_umsq = %.2fum^2" % (area_ota_umsq))
    print("-" * 60)

    # Total Area Estimation
    print("\nTotal Area Estimation: ")
    # Resistors and MOSFETs often on same layer (Poly/Active)
    area_poly_umsq = area_rtot_umsq + area_ota_umsq
    print("area_poly_umsq = %.2fum^2" % area_poly_umsq)
    
    # Capacitors (MIM) often stacked above, so we take the max area
    # For a good layout, area_poly_umsq ~ area_ctot_umsq
    area_tot_umsq = max(area_poly_umsq, area_ctot_umsq)
    print("area_tot_umsq = max(area_poly_umsq, area_ctot_umsq) = %.2fum^2" % area_tot_umsq)
    
    print("area_max_umsq = %.2fum^2" % area_max_umsq)
    
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
