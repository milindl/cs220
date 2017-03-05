module eq2(
	   input wire [1:0] a, b,
	   output wire c
	   );
   wire 	       out1, out2;
   eq1 cmp1 (.a(a[0]), .b(b[0]), .c(out1));
   eq1 cmp2 (.a(a[1]), .b(b[1]), .c(out2));
   assign c = out1 & out2;
endmodule
