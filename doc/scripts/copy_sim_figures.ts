// SPDX-FileCopyrightText: 2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Description: Quarto pre-render script, copies the macro figures the documentation shows into fig/sim/.

// The figures stay committed next to the testbench, design script or render that writes them, and are copied
// before every render, so the site always shows the current results. Quarto bundles Deno, so this needs no extra tool.

const project = Deno.env.get("QUARTO_PROJECT_DIR") ?? ".";
const repo = `${project}/..`;
const dst = `${project}/fig/sim`;

const iqmod = "ihp130/macros/iqmod";
const riscv = "ihp130/macros/riscv";

const figures = [
  `${iqmod}/scripts/filter_designer/figures/3rd_order_mfb_lpf_circuit.svg`,
  `${iqmod}/scripts/sizing/figures/inverter_based_ota_hybrid_bm_circuit.svg`,
  `${iqmod}/testbenches/xschem/plot_simulations/figures/iqmod_mfb_lpf_tb_ac_cl.svg`,
  `${iqmod}/testbenches/xschem/plot_simulations/figures/iqmod_mfb_lpf_riscv_tb_tran.svg`,
  `${iqmod}/testbenches/xschem/plot_simulations/figures/iqmod_mfb_lpf_riscv_tb_tran_fft.svg`,
  `${iqmod}/render/img/iqmod_top_white.png`,
  `${riscv}/testbenches/cocotb/dsmod/results/psd/dsmod_psd_ord2_osr64_amp-3dBFS.png`,
  `${riscv}/testbenches/cocotb/dsmod/results/sndr/dsmod_sndr_ord2_osr64.png`,
  `${riscv}/render/img/riscv_top_librelane.png`,
];

Deno.mkdirSync(dst, { recursive: true });
for (const path of figures) {
  // a missing figure throws and stops the render, rather than publishing a page with a broken image
  Deno.copyFileSync(`${repo}/${path}`, `${dst}/${path.split("/").pop()}`);
}
