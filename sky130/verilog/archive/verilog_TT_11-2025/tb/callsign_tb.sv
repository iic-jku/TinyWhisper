module callsign_tb ();

  logic        clk = 0;
  logic        reset_n = 1;

  // DL9MJ
  logic [35:0] callsign_in = {6'd13, 6'd21, 6'd9, 6'd22, 6'd19, 6'd36};
  logic [27:0] callsign_out;
  logic        valid;

  logic [27:0] a_mul, b_mul, mul_result;
  logic mul_valid;
  logic mul_reset_n;

  callsign dut (
      .clk(clk),
      .reset_n(reset_n),
      .callsign_in(callsign_in),
      .callsign_out(callsign_out),
      .valid(valid),
      .a_mul(a_mul),
      .b_mul(b_mul),
      .mul_result(mul_result),
      .mul_valid(mul_valid),
      .mul_reset_n(mul_reset_n)
  );

  // Assertion errors in combination with the array :/
  // typedef struct packed {
  //   logic [35:0] callsign;
  //   logic [27:0] encoded;
  // } test_t;

  logic [63:0] test_vector[9] = '{
      {6'd13, 6'd21, 6'd9, 6'd22, 6'd19, 6'd36, 28'd96436034},
      {6'd13, 6'd20, 6'd7, 6'd19, 6'd17, 6'd36, 28'd96197597},
      {6'd13, 6'd24, 6'd5, 6'd19, 6'd22, 6'd17, 28'd96945667},
      {6'd13, 6'd10, 6'd6, 6'd21, 6'd19, 6'd36, 28'd94211126},
      {6'd13, 6'd10, 6'd6, 6'd21, 6'd19, 6'd17, 28'd94211107},
      {6'd14, 6'd10, 6'd1, 6'd27, 6'd13, 6'd29, 28'd101202796},
      {6'd13, 6'd25, 6'd0, 6'd16, 6'd31, 6'd23, 28'd97042144},
      {6'd20, 6'd20, 6'd6, 6'd24, 6'd21, 6'd15, 28'd145782806},
      {6'd13, 6'd21, 6'd2, 6'd34, 6'd22, 6'd27, 28'd96307073}
  };

  initial begin
    forever #1 clk <= ~clk;
  end

  always_ff @(posedge clk) begin : multiplier
    mul_result <= a_mul * b_mul;
    mul_valid  <= 1;

    if (mul_reset_n == 0) begin
      mul_result <= 0;
      mul_valid  <= 0;
    end
  end

  initial begin
    $dumpfile("callsign_tb.vcd");
    $dumpvars(0, dut);


    foreach (test_vector[i]) begin
      callsign_in = test_vector[i][63:28];

      #2;
      reset_n <= 0;
      #6;
      reset_n <= 1;
      @(posedge valid);

      assert (callsign_out == test_vector[i][27:0])
      else $error("Fehler");
    end

    $finish;
  end
endmodule
