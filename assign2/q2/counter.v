module counter
  (
   input wire [3:0] init,
   input wire       clk, set, reset,
   output reg [3:0] out
   );

   initial
     out = 4'b0000;

   reg [25:0]       counter = 50_000_000;

   always @(posedge clk)
     begin
        if (set == 1)
          out = init;
        if (reset == 1)
          out = 4'b0000;

        if (counter == 0)
          begin
             counter <= 50_000_000;
             out <= out + 1;
          end
        else
          counter <= counter - 1;
     end // always @ (posedge clk)

endmodule // counter
