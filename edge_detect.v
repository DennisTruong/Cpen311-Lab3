module edge_detect (input async_sig,
                    input clk,
                    output reg rise,
                    output reg fall);

  reg [1:3] resync;

  always @(posedge clk)
  begin
    // detect rising and falling edges.
    rise <= resync[2] & !resync[3];
    fall <= resync[3] & !resync[2];
    // update history shifter.
    resync <= {async_sig , resync[1:2]};
  end

endmodule

//---------------TB-----------------------------
module edge_tb;

  reg clk, async, rise, fall = 0;

  UUT edge_detect
       (.async_sig(async),
        .clk(clk),
        .rise(rise),
        .fall(fall));

initial begin
  while ($time < 1000) begin
    clk <= not clk;
    wait for 5 ns;
  end
end

// Produce a randomly-changing async signal.

  integer seed;
  time delay;

initial
begin
  while ($time < 1000) begin
    @(negedge Clk);
    // wait for a random number of ns
    delay = $dist_uniform(seed, 50 100);
    #delay;
    async = ~ async;
  end
end

endmodule
