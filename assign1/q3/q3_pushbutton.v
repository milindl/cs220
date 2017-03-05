module eq4_pushbutton(
		input wire [3:0] m,
		input wire 	 button_pushed,
		output wire 	 c
		);
   reg [3:0] a, b;
   eq4 ts     (.a(a), .b(b), .c(c));
   reg 	     pushbutton;
   initial
     begin
	pushbutton = 0;
     end

   always@(posedge button_pushed)
     case(pushbutton)
       0:
	 begin
	    a = m;
	    pushbutton = 1;
	 end
       1:
	 begin
	    b = m;
	    pushbutton = 2;
	 end
       default:
	 #10;
     endcase
endmodule
