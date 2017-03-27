`timescale 1 ns/10 ps
module add4_testbench;
   wire carry_out;
   wire [3:0] out;
   reg [3:0]  a,b;
   add4 uut (.a(a), .b(b), .sum(out), .carry(carry_out));

   initial
     begin
	a = 4'b1111;
	b = 4'b1111;
	#200;
	$display("Sum = %d, Carry = %d", out, carry_out);

	a = 4'b0011;
	b = 4'b0001;
	#200;
	$display("Sum = %d, Carry = %d", out, carry_out);

	a = 4'b1111;
	b = 4'b0001;
	#200;
	$display("Sum = %d, Carry = %d", out, carry_out);

	a = 4'b0111;
	b = 4'b0111;
	#200;
	$display("Sum = %d, Carry = %d", out, carry_out);

	$stop;
     end
endmodule
