module toplevel_tb ();
  logic        clk = 0;
  logic        reset = 1;

  logic [15:0] buffer;
  logic        req = 0;
  logic        cs;
  logic        sclk;
  logic        mosi;
  logic master_busy, slave_busy, slave_valid;
  logic start_transmission = 0;

  spi_master master (
      .clk(clk),
      .reset(reset),
      .buffer(buffer),
      .req(req),
      .sclk(sclk),
      .cs(cs),
      .mosi(mosi),
      .busy(master_busy)
  );

  logic encoding_valid;
  toplevel dut (
      .clk(clk),
      .reset(reset),
      .cs(cs),
      .mosi(mosi),
      .start_transmission(start_transmission),
      .encoding_valid(encoding_valid)
  );

  logic [7:0] to_send[] = '{
      8'd0,  // Reset
      8'd13,  // C1
      8'd21,  // C2
      8'd9,  // C3
      8'd22,  // C4
      8'd19,  // C5
      8'd36,  // C6
      8'd9,  // L1
      8'd13,  // L2
      8'd4,  // L3
      8'd9,  // L4
      8'd25,  // Power
      8'd0  // Start encoding
  };

  always begin
    clk <= ~clk;
    #1;
  end

  initial begin
    $dumpfile("toplevel_tb.vcd");
    $dumpvars(0, dut, master);
    reset = 0;
    req   = 0;
    #6;
    reset = 1;
    #40;
    foreach (to_send[i]) begin
      buffer = {8'(i), to_send[i]};
      req = 1;
      #2;
      // @(posedge master_busy);
      req = 0;
      #2;
      @(negedge master_busy);
      #2;
    end

    @(posedge encoding_valid);
    start_transmission = 1;
    #10;
    start_transmission = 0;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;
    #100000;

    #6;
    $finish;
  end
endmodule
