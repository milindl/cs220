module eq4(
	   input wire [3:0] a, b,
	   output wire c
	   );
   wire 	       out1, out2;
   eq2 cmp1 (.a(a[1:0]), .b(b[1:0]), .c(out1));
   eq2 cmp2 (.a(a[3:2]), .b(b[3:2]), .c(out2));
   assign c = out1 & out2;
endmodule
