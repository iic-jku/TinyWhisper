
# CACE Summary for iqmod_mfb_lpf

**netlist source**: schematic

|      Parameter       |         Tool         |     Result      | Min Limit  |  Min Value   | Typ Target |  Typ Value   | Max Limit  |  Max Value   |  Status  |
| :------------------- | :------------------- | :-------------- | ---------: | -----------: | ---------: | -----------: | ---------: | -----------: | :------: |
| Closed-loop dc gain  | ngspice              | Adc_cl_dB            |           -1 dB |  -0.515 dB |          any |  -0.499 dB |         1 dB |  -0.451 dB |   Pass ✅    |
| Upper -3dB cut-off frequency | ngspice              | fcu                  |       350000 Hz | 416996.000 Hz |          any | 433510.000 Hz |          any | 437424.000 Hz |   Pass ✅    |
| Common-mode Rejection Ratio | ngspice              | CMRR_dc_dB           |           25 dB |  29.286 dB |          any |  30.001 dB |          any |  45.899 dB |   Pass ✅    |
| Closed-loop dc gain - Monte Carlo | ngspice              | Adc_cl_dB            |           -1 dB |  -0.596 dB |          any |  -0.454 dB |         1 dB |  -0.388 dB |   Pass ✅    |
| Upper -3dB cut-off frequency - Monte Carlo | ngspice              | fcu                  |       350000 Hz | 358222.000 Hz |          any | 434325.000 Hz |          any | 519078.000 Hz |   Pass ✅    |
| Common-mode Rejection Ratio - Monte Carlo | ngspice              | CMRR_dc_dB           |           25 dB |  30.957 dB |          any |  43.669 dB |          any |  82.769 dB |   Pass ✅    |
| Closed-loop dc gain - Mismatch | ngspice              | Adc_cl_dB            |           -1 dB |  -0.561 dB |          any |  -0.450 dB |         1 dB |  -0.297 dB |   Pass ✅    |
| Upper -3dB cut-off frequency - Mismatch | ngspice              | fcu                  |       350000 Hz | 430758.000 Hz |          any | 433446.500 Hz |          any | 437105.000 Hz |   Pass ✅    |
| Common-mode Rejection Ratio - Mismatch | ngspice              | CMRR_dc_dB           |           25 dB |  41.789 dB |          any |  45.746 dB |          any |  52.575 dB |   Pass ✅    |

