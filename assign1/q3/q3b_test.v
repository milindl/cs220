`timescale 1 ns/10 ps
module eq4_test;
   reg [3:0] m;
   reg 	     b_pushed;
   wire      c;
   eq4_pushbutton tst(.m(m), .button_pushed(b_pushed), .c(c));
   initial
     begin
	#200;
	b_pushed = 0;
	#200;
	m = 4'b1101;
	#200;
	b_pushed = 1;
	#200;
	b_pushed = 0;
	#200;
	m = 4'b1101;
	#200;
	b_pushed = 1;
	#200;
	$display(c);
	$stop;
     end
endmodule
