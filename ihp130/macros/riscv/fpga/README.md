# ihp-sg13g2 RISC-V FPGA Flow

> [!IMPORTANT]
> This flow is intended to run inside the `ihp130/macros/riscv/fpga/` directory and requires an FPGA toolchain with `verilator`, `yosys`, `nextpnr-ice40`, `icepack`, `dfu-util`, `netlistsvg`, `svgo`, and `rsvg-convert`.
>
> The default synthesis flow targets iCE40 (`TARGET=synth_ice40`).

The FPGA flow uses RTL sources from `../rtl/` (`constants.sv` plus all synthesis modules listed in `MODULES_SYNTH`).

## Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```


## Clean

Remove generated files:

```sh
make clean
```


## Lint

Run Verilator lint checks:

```sh
make lint-verilog                        # lint the full riscv_top design
make lint-verilog CELL=dsmod             # lint a single module
make lint-verilog-all                    # lint dsmod, cordic_iterative, lo_gen, and riscv_top
```

`make lint-verilog` defaults to `CELL=riscv_top` and checks `constants.sv` plus all synthesis sources.
`make lint-verilog CELL=<cell>` checks a single cell together with `constants.sv`; the correct extension (`.sv` or `.v`) is detected automatically.
`make lint-verilog-all` runs the four lint checks in sequence and is the lint step used by `make all`.


## Synthesis

Run technology-mapped synthesis for iCE40:

```sh
make synthesis
```

Use a custom Yosys synthesis command by overriding `TARGET`:

```sh
make synthesis TARGET=synth_ice40
```

Generate a generic synthesis netlist and Yosys graph:

```sh
make synthesis_generic
```


## Netlist Visualization

Generate a PDF from the iCE40 synthesized netlist:

```sh
make visualize_ice40
```

Generate a PDF from the generic synthesized netlist:

```sh
make visualize_generic
```


## Place-and-Route

Run place-and-route with nextpnr:

```sh
make pr
```

Run place-and-route in GUI mode:

```sh
make pr-gui
```

The constraints file used by this flow is `pico-ice.pcf`.


## Bitstream Generation and Flash

Generate a bitstream:

```sh
make gen_bitstream
```

Flash the generated bitstream:

```sh
make flash_bitstream
```

> [!NOTE]
> `flash_bitstream` is intentionally not part of `make all`.
> Use `make flash_bitstream` explicitly when you want to program the FPGA.

> [!NOTE]
> Flashing uses `dfu-util`, not `iceprog`. Both flash iCE40 bitstreams, but they target different interfaces:
> - **`iceprog`** speaks directly over SPI via an FTDI USB bridge (iCEstick, iCEBreaker, …).
> - **`dfu-util`** uses the USB DFU standard — the pico-ice's RP2040 co-processor acts as the DFU bootloader and forwards the bitstream to the iCE40 flash. `iceprog` does not work on this board.


## Convert to Verilog

Convert the SystemVerilog top module to Verilog:

```sh
make convert
```


## Build All

Run the full FPGA flow target from the Makefile:

```sh
make all
```

The current `all` recipe executes these steps in order:

1. `make lint-verilog-all`
2. `make synthesis`
3. `make pr`
4. `make gen_bitstream`

> [!NOTE]
> `make all` intentionally stops after bitstream generation and does not call `flash_bitstream`.
