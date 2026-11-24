
# CACE Summary for iqmod_mfb_lpf_ota_core_hybrid_bm

**netlist source**: schematic

|      Parameter       |         Tool         |     Result      | Min Limit  |  Min Value   | Typ Target |  Typ Value   | Max Limit  |  Max Value   |  Status  |
| :------------------- | :------------------- | :-------------- | ---------: | -----------: | ---------: | -----------: | ---------: | -----------: | :------: |
| Open-loop dc gain    | ngspice              | Adc_ol_dB            |           20 dB |  24.341 dB |          any |  25.915 dB |          any |  27.443 dB |   Pass ✅    |
| Upper -3dB cut-off frequency | ngspice              | fcu                  |      3000000 Hz | 3375600.000 Hz |          any | 4020640.000 Hz |          any | 6327630.000 Hz |   Pass ✅    |
| Common-mode Rejection Ratio | ngspice              | CMRR_dc_dB           |           45 dB |  49.893 dB |          any |  69.141 dB |          any |  87.233 dB |   Pass ✅    |
| Open-loop dc gain - Monte Carlo | ngspice              | Adc_ol_dB            |           20 dB |  25.599 dB |          any |  27.455 dB |          any |  28.109 dB |   Pass ✅    |
| Upper -3dB cut-off frequency - Monte Carlo | ngspice              | fcu                  |      3000000 Hz | 3425720.000 Hz |          any | 4024005.000 Hz |          any | 5426360.000 Hz |   Pass ✅    |
| Common-mode Rejection Ratio - Monte Carlo | ngspice              | CMRR_dc_dB           |           45 dB |  51.341 dB |          any |  64.938 dB |          any | 114.513 dB |   Pass ✅    |
| Open-loop dc gain - Mismatch | ngspice              | Adc_ol_dB            |           20 dB |  27.402 dB |          any |  27.440 dB |          any |  27.470 dB |   Pass ✅    |
| Upper -3dB cut-off frequency - Mismatch | ngspice              | fcu                  |      3000000 Hz | 4005910.000 Hz |          any | 4022220.000 Hz |          any | 4037300.000 Hz |   Pass ✅    |
| Common-mode Rejection Ratio - Mismatch | ngspice              | CMRR_dc_dB           |           45 dB |  64.647 dB |          any |  68.946 dB |          any |  75.935 dB |   Pass ✅    |

