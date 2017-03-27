module add4
  (
	 input wire [3:0]  a,b,
	 output wire [3:0] sum,
	 output wire       carry
   );

	 wire [4:0]        t;
	 assign t = a + b;
	 assign sum = t[3:0];
	 assign carry = t[4];

endmodule
