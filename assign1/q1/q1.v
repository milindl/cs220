`timescale 1 ns/10 ps

module q1(
	  input wire clk,
	  output reg led
	  );
   initial
     led = 0;
   always@(posedge clk)
     // Can also keep a counter here to change timescales
     // Altrnatively change clock timing in test file
     begin
	led = !led;
     end
endmodule


