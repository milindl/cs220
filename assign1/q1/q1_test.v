`timescale 1ns / 1ps

module q1Test;
   reg clk;
   wire led;
   q1 q (
	      .clk(clk),
	      .led(led)
	      );

   initial
     begin
	clk = 0;
	#100;
     end

   always
     begin
	#10 clk = !clk;
	$display(ledpin);
     end
endmodule
