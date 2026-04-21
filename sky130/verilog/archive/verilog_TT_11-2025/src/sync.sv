module sync (
    input logic         clk,
    input logic         reset_n,

    input logic [161:0] data,
    input logic         req_next_symbol,

    output logic [1:0]  symbol_out,
    output logic        symbol_valid
);

  localparam logic [161:0] sync_vector = 162'h302389780940b34686aa4b1a8824ecd1c14c06b18;
  logic [7:0] n;

  always_ff @(posedge clk) begin
     symbol_valid <= 0;

     if (req_next_symbol) begin
      symbol_out <= sync_vector[n] + (data[n] << 1);
      symbol_valid <= 1;

      if (n > 0) n <= n - 1;
    end

    if (reset_n == 0) begin
      symbol_valid <= 0;
      symbol_out <= 2'b00;
      n <= 8'd161;
    end
  end

endmodule
