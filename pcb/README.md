# Application Board

- PCB design with [KiCad](https://www.kicad.org/)
- 3.3V LDO (I/O + external peripherals supply)
- 1.5V LDO (chip core supply)
- 56MHz clock source for TinyWhisper chip
- 12MHz clock source for Raspberry Pi RP2040
- SRAM + Flashing: https://github.com/tinyvision-ai-inc/pico-ice
    - Look into https://github.com/tinyvision-ai-inc/pico-ice & https://github.com/TinyTapeout/pcb-files
    - Raspberry Pi RP2040 + MicroPython + Microphone → SSB TX?
    - SRAM: https://www.mouser.at/ProductDetail/AP-Memory/APS6404L-3SQN-SN?qs=IS%2B4QmGtzzqCot9%2BeIJwKw%3D%3D
- I²C I/O Extender: https://www.nxp.com/docs/en/brochure/75016535.pdf
- I²C Display: https://www.az-delivery.de/products/1-3zoll-i2c-oled-display
- Rotary Encoder: https://github.com/simi1505/60W-2m-FM-TRX-OE3SDE
- RF PIN Diode Switches: https://github.com/simi1505/60W-2m-FM-TRX-OE3SDE
- RF Bandpass Filters: https://github.com/simi1505/5-Band-50W-PA-OE3SDE
- RF Power Amplifier: https://www.radio-kits.co.uk/radio-related/Linear_PA/RD06HHF1_REV040402.pdf