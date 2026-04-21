module wspr_encoder (
    input logic        clk,
    input logic        reset_n,

    input logic [35:0] callsign_in, // C1, C2, ...
    input logic [19:0] locator_in,
    input logic [ 5:0] power_in,

    input logic        req_next_symbol,

    output logic [1:0] symbol_out,
    output logic       ready,
    output logic       symbol_valid
);

  localparam int WIDTH = 28;
  logic [WIDTH-1:0] a, b;
  logic [2*WIDTH-1:0] mult_result;
  logic               mul_reset_n;
  logic               mult_valid;

  // All stages require some form of multiplication.
  // This requires lots of area, so we ensure that the
  // synthesis only uses one multiplier
  // TODO: @Jonathan try with fixed shifts and adders (smaller??)
  multiplier #(
      .WIDTH(WIDTH)
  ) mult (
      .clk(clk),
      .reset_n(mul_reset_n),
      .a(a),
      .b(b),
      .result(mult_result),
      .valid(mult_valid)
  );

  logic [27:0] callsign_encoded;
  logic        callsign_valid;
  logic        callsign_reset;
  logic [27:0] callsign_a, callsign_b;
  logic callsign_mul_reset;

  callsign call_encoder (
      .clk(clk),
      .reset_n(callsign_reset),
      .callsign_in(callsign_in),
      .callsign_out(callsign_encoded),
      .valid(callsign_valid),

      .a_mul(callsign_a),
      .b_mul(callsign_b),
      .mul_reset_n(callsign_mul_reset),
      .mul_result(mult_result[27:0]),
      .mul_valid(mult_valid)
  );

  logic [21:0] M;
  logic        M_valid;
  logic        loc_pwr_reset;
  logic [27:0] M_a, M_b;
  logic M_mul_reset;

  loc_pwr loc_pwr_encoder (
      .clk(clk),
      .reset_n(loc_pwr_reset),
      .locator(locator_in),
      .power(power_in),
      .M(M),
      .valid(M_valid),

      .a_mul(M_a),
      .b_mul(M_b),
      .mul_reset_n(M_mul_reset),
      .mul_result(mult_result),
      .mul_valid(mult_valid)
  );

  logic [ 80:0] fec_in;
  logic [161:0] fec_out;
  logic         fec_reset;
  logic         fec_valid;

  assign fec_in = {callsign_encoded, M, 31'b0};

  conv fec (
      .clk(clk),
      .reset_n(fec_reset),
      .data(fec_in),
      .encoded_data(fec_out),
      .valid(fec_valid)
  );

  logic [161:0] interleave_out;
  logic sync_reset;

  sync sync (
      .clk(clk),
      .reset_n(sync_reset),
      .data(interleave_out),
      .req_next_symbol(req_next_symbol),
      .symbol_out(symbol_out),
      .symbol_valid(symbol_valid)
  );

  typedef enum {
    CALLSIGN,
    LOC_PWR,
    FEC,
    // INTERLEAVE,
    SYNC,
    VALID
  } encoding_state_t;

  encoding_state_t state;

  // Main state machine for transitions
  always_ff @(posedge clk) begin
    unique case (state)
      CALLSIGN: begin
        if (callsign_valid) state <= LOC_PWR;
      end

      LOC_PWR: begin
        if (M_valid) state <= FEC;
      end

      FEC: begin
        if (fec_valid) state <= SYNC;
      end

      SYNC: begin
        // if (sync_valid) state <= VALID;
      end

      VALID: begin
        state <= VALID;
      end
    endcase

    if (reset_n == 0) begin
      state <= CALLSIGN;
    end
  end

  // Multiplexer for multiplier ports
  always_comb begin
    mul_reset_n = callsign_mul_reset;
    a = callsign_a;
    b = callsign_b;

    callsign_reset = 0;
    loc_pwr_reset = 0;
    fec_reset = 0;
    sync_reset = 0;

    unique case (state)
      CALLSIGN: begin
        mul_reset_n = callsign_mul_reset;
        a = callsign_a;
        b = callsign_b;

        callsign_reset = 1;
      end

      LOC_PWR: begin
        mul_reset_n = M_mul_reset;
        a = M_a;
        b = M_b;

        callsign_reset = 1;
        loc_pwr_reset = 1;
      end

      FEC: begin
        callsign_reset = 1;
        loc_pwr_reset = 1;
        fec_reset = 1;
      end

      SYNC: begin
        callsign_reset = 1;
        loc_pwr_reset = 1;
        fec_reset = 1;
        sync_reset = 1;
      end

      VALID: begin
        callsign_reset = 1;
        loc_pwr_reset = 1;
        fec_reset = 1;
        sync_reset = 1;
      end

      default: begin
        mul_reset_n = 0;
        a = 0;
        b = 0;
      end
    endcase

    if (reset_n == 0) begin
      callsign_reset = 0;
      loc_pwr_reset = 0;
      fec_reset = 0;
      sync_reset = 0;
    end
  end

  assign ready = (state == SYNC) ? 1 : 0;

  // Interleave
    assign interleave_out[161] = fec_out[161];
    assign interleave_out[33] = fec_out[160];
    assign interleave_out[97] = fec_out[159];
    assign interleave_out[129] = fec_out[158];
    assign interleave_out[1] = fec_out[157];
    assign interleave_out[65] = fec_out[156];
    assign interleave_out[145] = fec_out[155];
    assign interleave_out[17] = fec_out[154];
    assign interleave_out[81] = fec_out[153];
    assign interleave_out[113] = fec_out[152];
    assign interleave_out[49] = fec_out[151];
    assign interleave_out[153] = fec_out[150];
    assign interleave_out[25] = fec_out[149];
    assign interleave_out[89] = fec_out[148];
    assign interleave_out[121] = fec_out[147];
    assign interleave_out[57] = fec_out[146];
    assign interleave_out[137] = fec_out[145];
    assign interleave_out[9] = fec_out[144];
    assign interleave_out[73] = fec_out[143];
    assign interleave_out[105] = fec_out[142];
    assign interleave_out[41] = fec_out[141];
    assign interleave_out[157] = fec_out[140];
    assign interleave_out[29] = fec_out[139];
    assign interleave_out[93] = fec_out[138];
    assign interleave_out[125] = fec_out[137];
    assign interleave_out[61] = fec_out[136];
    assign interleave_out[141] = fec_out[135];
    assign interleave_out[13] = fec_out[134];
    assign interleave_out[77] = fec_out[133];
    assign interleave_out[109] = fec_out[132];
    assign interleave_out[45] = fec_out[131];
    assign interleave_out[149] = fec_out[130];
    assign interleave_out[21] = fec_out[129];
    assign interleave_out[85] = fec_out[128];
    assign interleave_out[117] = fec_out[127];
    assign interleave_out[53] = fec_out[126];
    assign interleave_out[133] = fec_out[125];
    assign interleave_out[5] = fec_out[124];
    assign interleave_out[69] = fec_out[123];
    assign interleave_out[101] = fec_out[122];
    assign interleave_out[37] = fec_out[121];
    assign interleave_out[159] = fec_out[120];
    assign interleave_out[31] = fec_out[119];
    assign interleave_out[95] = fec_out[118];
    assign interleave_out[127] = fec_out[117];
    assign interleave_out[63] = fec_out[116];
    assign interleave_out[143] = fec_out[115];
    assign interleave_out[15] = fec_out[114];
    assign interleave_out[79] = fec_out[113];
    assign interleave_out[111] = fec_out[112];
    assign interleave_out[47] = fec_out[111];
    assign interleave_out[151] = fec_out[110];
    assign interleave_out[23] = fec_out[109];
    assign interleave_out[87] = fec_out[108];
    assign interleave_out[119] = fec_out[107];
    assign interleave_out[55] = fec_out[106];
    assign interleave_out[135] = fec_out[105];
    assign interleave_out[7] = fec_out[104];
    assign interleave_out[71] = fec_out[103];
    assign interleave_out[103] = fec_out[102];
    assign interleave_out[39] = fec_out[101];
    assign interleave_out[155] = fec_out[100];
    assign interleave_out[27] = fec_out[99];
    assign interleave_out[91] = fec_out[98];
    assign interleave_out[123] = fec_out[97];
    assign interleave_out[59] = fec_out[96];
    assign interleave_out[139] = fec_out[95];
    assign interleave_out[11] = fec_out[94];
    assign interleave_out[75] = fec_out[93];
    assign interleave_out[107] = fec_out[92];
    assign interleave_out[43] = fec_out[91];
    assign interleave_out[147] = fec_out[90];
    assign interleave_out[19] = fec_out[89];
    assign interleave_out[83] = fec_out[88];
    assign interleave_out[115] = fec_out[87];
    assign interleave_out[51] = fec_out[86];
    assign interleave_out[131] = fec_out[85];
    assign interleave_out[3] = fec_out[84];
    assign interleave_out[67] = fec_out[83];
    assign interleave_out[99] = fec_out[82];
    assign interleave_out[35] = fec_out[81];
    assign interleave_out[160] = fec_out[80];
    assign interleave_out[32] = fec_out[79];
    assign interleave_out[96] = fec_out[78];
    assign interleave_out[128] = fec_out[77];
    assign interleave_out[0] = fec_out[76];
    assign interleave_out[64] = fec_out[75];
    assign interleave_out[144] = fec_out[74];
    assign interleave_out[16] = fec_out[73];
    assign interleave_out[80] = fec_out[72];
    assign interleave_out[112] = fec_out[71];
    assign interleave_out[48] = fec_out[70];
    assign interleave_out[152] = fec_out[69];
    assign interleave_out[24] = fec_out[68];
    assign interleave_out[88] = fec_out[67];
    assign interleave_out[120] = fec_out[66];
    assign interleave_out[56] = fec_out[65];
    assign interleave_out[136] = fec_out[64];
    assign interleave_out[8] = fec_out[63];
    assign interleave_out[72] = fec_out[62];
    assign interleave_out[104] = fec_out[61];
    assign interleave_out[40] = fec_out[60];
    assign interleave_out[156] = fec_out[59];
    assign interleave_out[28] = fec_out[58];
    assign interleave_out[92] = fec_out[57];
    assign interleave_out[124] = fec_out[56];
    assign interleave_out[60] = fec_out[55];
    assign interleave_out[140] = fec_out[54];
    assign interleave_out[12] = fec_out[53];
    assign interleave_out[76] = fec_out[52];
    assign interleave_out[108] = fec_out[51];
    assign interleave_out[44] = fec_out[50];
    assign interleave_out[148] = fec_out[49];
    assign interleave_out[20] = fec_out[48];
    assign interleave_out[84] = fec_out[47];
    assign interleave_out[116] = fec_out[46];
    assign interleave_out[52] = fec_out[45];
    assign interleave_out[132] = fec_out[44];
    assign interleave_out[4] = fec_out[43];
    assign interleave_out[68] = fec_out[42];
    assign interleave_out[100] = fec_out[41];
    assign interleave_out[36] = fec_out[40];
    assign interleave_out[158] = fec_out[39];
    assign interleave_out[30] = fec_out[38];
    assign interleave_out[94] = fec_out[37];
    assign interleave_out[126] = fec_out[36];
    assign interleave_out[62] = fec_out[35];
    assign interleave_out[142] = fec_out[34];
    assign interleave_out[14] = fec_out[33];
    assign interleave_out[78] = fec_out[32];
    assign interleave_out[110] = fec_out[31];
    assign interleave_out[46] = fec_out[30];
    assign interleave_out[150] = fec_out[29];
    assign interleave_out[22] = fec_out[28];
    assign interleave_out[86] = fec_out[27];
    assign interleave_out[118] = fec_out[26];
    assign interleave_out[54] = fec_out[25];
    assign interleave_out[134] = fec_out[24];
    assign interleave_out[6] = fec_out[23];
    assign interleave_out[70] = fec_out[22];
    assign interleave_out[102] = fec_out[21];
    assign interleave_out[38] = fec_out[20];
    assign interleave_out[154] = fec_out[19];
    assign interleave_out[26] = fec_out[18];
    assign interleave_out[90] = fec_out[17];
    assign interleave_out[122] = fec_out[16];
    assign interleave_out[58] = fec_out[15];
    assign interleave_out[138] = fec_out[14];
    assign interleave_out[10] = fec_out[13];
    assign interleave_out[74] = fec_out[12];
    assign interleave_out[106] = fec_out[11];
    assign interleave_out[42] = fec_out[10];
    assign interleave_out[146] = fec_out[9];
    assign interleave_out[18] = fec_out[8];
    assign interleave_out[82] = fec_out[7];
    assign interleave_out[114] = fec_out[6];
    assign interleave_out[50] = fec_out[5];
    assign interleave_out[130] = fec_out[4];
    assign interleave_out[2] = fec_out[3];
    assign interleave_out[66] = fec_out[2];
    assign interleave_out[98] = fec_out[1];
    assign interleave_out[34] = fec_out[0];

endmodule
