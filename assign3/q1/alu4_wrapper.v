`timescale 1ns/10ps
module alu4_wrapper (
		     output reg        sf_e, e, rs, rw, d, c, b, a,
		     input 	       pb1, pb2, pb3, clk,
		     input wire [3:0]  sw,
		     output wire       carry_led, sign_led, zero_led,
		     output wire [3:0] result
		     );
   reg [26:0] 			       count;
   reg [5:0] 			       code;
   reg 				       refresh;
   wire [3:0] 			       out;
   wire 			       carry, sign, zero;
   assign result = out;
   assign carry_led = carry;
   assign sign_led = sign;
   assign zero_led = zero;
   reg [3:0] 			       A = 4'b0000;
   reg [3:0] 			       B = 4'b0000;
   reg [1:0] 			       C = 2'b00;
   alu4 a_unit(C, A, B, result, zero_led, carry_led, sign_led);

   always@(posedge clk) begin
      if (pb1 == 1)
	A = sw;
      if (pb2 == 1)
	B = sw;
      if (pb3 == 1)
	C = sw[2:0];

      count <= count + 1;

      case (count [26:21]) // as top 6 bits change
	0: code <= 6'h03; // power-on init sequence
	1: code <= 6'h03; // this is needed at least once
	2: code <= 6'h03; // when LCD's powered on
	3: code <= 6'h02; // it flickers existing char dislay
	4: code <= 6'h02; // Function Set, upper nibble 0010
	5: code <= 6'h08; // lower nibble 1000 (10xx)
	6: code <= 6'h00; // see table, upper nibble 0000, then lower nibble:
	7: code <= 6'h06; // 0110: Incr, Shift disabled
	8: code <= 6'h00; // Display On/Off, upper nibble 0000
	9: code <= 6'h0C; // lower nibble 1100 (1 D C B)
	10: code <= 6'h00; // Clear Display, 00 and upper nibble 0000
	11: code <= 6'h01; // then 00 and lower nibble 0001
	12:
	  begin
	     case (result)
	       0: code <= 6'b100011;
	       1: code <= 6'b100011;
	       2: code <= 6'b100011;
               3: code <= 6'b100011;
               4: code <= 6'b100011;
               5: code <= 6'b100011;
               6: code <= 6'b100011;
               7: code <= 6'b100011;
               8: code <= 6'b100011;
               9: code <= 6'b100011;
               10:code <= 6'b100100;
               11:code <= 6'b100100;
               12:code <= 6'b100100;
               13:code <= 6'b100100;
               14:code <= 6'b100100;
               default: code <= 6'b100100;
	     endcase
	  end
	13:
	  begin
	     case (result)
	       0: code <= 6'b100000;
	       1: code <= 6'b100001;
	       2: code <= 6'b100010;
	       3: code <= 6'b100011;
	       4: code <= 6'b100100;
	       5: code <= 6'b100101;
	       6: code <= 6'b100110;
	       7: code <= 6'b100111;
	       8: code <= 6'b101000;
	       9: code <= 6'b101001;
	       10:code <= 6'b100001;
	       11:code <= 6'b100010;
	       12:code <= 6'b100011;
	       13:code <= 6'b100100;
	       14:code <= 6'b100101;
	       default: code <= 6'b100110;
	     endcase
	  end
	14: code <= 6'h21; // Table 5-3, Read Busy Flag and Address
	// send 01 BF (Busy Flag) x x x, then 01xxxx
	// idling

	default: code <= 6'h10; // the restun-used time
      endcase

      refresh <= count[ 20 ]; // flip rate about 25 (50MHz/2*21=2M)
      sf_e <= 1; e <= refresh;
      rs <= code[5]; rw <= code[4];
      d <= code[3]; c <= code[2];
      b <= code[1]; a <= code[0];
   end // always @ (posedge clk)

endmodule
