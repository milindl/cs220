module eq4wrapper
  (
   input wire clk,
   input wire [3:0] sw,
   input wire       pb1, pb2,
   output wire      ledpin
   );
	reg [3:0] a = 4'b0000;
	reg [3:0] b = 4'b0000;
	

	
	always @(posedge clk)
	begin
		if (pb1 == 1)
			a = sw;
		if (pb2 == 1)
			b = sw;
	end
	
	eq4 eq_unit (.a(a), .b(b), .aeqb(ledpin));

endmodule
