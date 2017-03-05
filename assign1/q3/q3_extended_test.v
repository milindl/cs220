`timescale 1 ns/10 ps
module eq2_test;
   reg [1:0] a, b;
   eq2 ts     (.a(a), .b(b), .c(c));
   initial
     begin
	a = 2'b00;
	b = 2'b00;
	#500;
	$display(c);
	a = 2'b10;
	b = 2'b01;
	#500;
	$display(c);
	a = 2'b01;
	b = 2'b11;
	#500;
	$display(c);
	a = 2'b01;
	b = 2'b01;
	#500;
	$display(c);
	$stop;
     end // initial begin
endmodule
