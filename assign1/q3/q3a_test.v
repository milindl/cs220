`timescale 1 ns/10 ps
module eq1_test;
   reg a, b;
   eq1 ts     (.a(a), .b(b), .c(c));
   initial
     begin
	a = 1'b0;
	b = 1'b0;
	#500;
	$display(c);
	a = 1'b1;
	b = 1'b0;
	#500;
	$display(c);
	a = 1'b0;
	b = 1'b1;
	#500;
	$display(c);
	a = 1'b1;
	b = 1'b1;
	#500;
	$display(c);
	$stop;
     end // initial begin
endmodule
