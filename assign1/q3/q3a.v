module eq1(
	   input wire a, b,
	   output wire c
	   );
   wire 	       p1, p2;
   assign c = p1 | p2;
   assign p1 = a & b;
   assign p2 = ~a & ~b;
endmodule
