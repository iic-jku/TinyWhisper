module spi_tb ();
  logic        clk = 0;
  logic        reset = 0;

  logic [15:0] buffer = 16'hDEAD;
  logic        req;
  logic        cs;
  logic        sclk;
  logic        mosi;
  logic master_busy, slave_busy, slave_valid;

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

  logic [7:0] read_addr, read_data;
  spi_slave slave (
      .sclk(sclk),
      .reset(reset),
      .cs(cs),
      .mosi(mosi),
      .addr(read_addr),
      .data(read_data),
      .busy(slave_busy),
      .valid(slave_valid)
  );

  always begin
    clk <= ~clk;
    #1;
  end

  initial begin
    $dumpfile("spi_tb.vcd");
    $dumpvars(0, slave, master);
    req = 0;

    #30;
    reset = 1;
    req   = 1;

    @(posedge slave_valid);
    #6;
    $finish;
  end
endmodule
