`timescale 1ns / 1ps
module add4_wrapper
  (
   input wire [3:0] sw,
   input wire       pb1, pb2, clk,
   output reg       sf_e, e, rs, rw, d, c, b, a,
   output wire      ledpin
   );

   reg [26:0]       count = 0;
   reg [5:0]        code;
   reg              refresh;

   reg              val1, val2;

   reg [3:0]        a = 4'b0000;
	 reg [3:0]        b = 4'b0000;
   wire [3:0]       sum;
   wire             carry;

   assign ledpin = carry;

	 add4 add_unit (.a(a), .b(b), .sum(sum), .carry(carry));

   always @ (posedge clk)
     begin

        if (pb1 == 1)
          a = sw;
        if (pb2 == 1)
          b = sw;

        case (sum)
          0:
            begin
               val1 = 6b'100011;
               val2 = 6b'100000;
            end
          1:
            begin
               val1 = 6b'100011;
               val2 = 6b'100001;
            end
          2:
            begin
               val1 = 6b'100011;
               val2 = 6b'100010;
            end
          3:
            begin
               val1 = 6b'100011;
               val2 = 6b'100011;
            end
          4:
            begin
               val1 = 6b'100011;
               val2 = 6b'100100;
            end
          5:
            begin
               val1 = 6b'100011;
               val2 = 6b'100101;
            end
          6:
            begin
               val1 = 6b'100011;
               val2 = 6b'100110;
            end
          7:
            begin
               val1 = 6b'100011;
               val2 = 6b'100111;
            end
          8:
            begin
               val1 = 6b'100011;
               val2 = 6b'101000;
            end
          9:
            begin
               val1 = 6b'100011;
               val2 = 6b'101001;
            end
          10:
            begin
               val1 = 6b'100100;
               val2 = 6b'100001;
            end
          11:
            begin
               val1 = 6b'100100;
               val2 = 6b'100010;
            end
          12:
            begin
               val1 = 6b'100100;
               val2 = 6b'100011;
            end
          13:
            begin
               val1 = 6b'100100;
               val2 = 6b'100100;
            end
          14:
            begin
               val1 = 6b'100011;
               val2 = 6b'100101;
            end
          15:
            begin
               val1 = 6b'100100;
               val2 = 6b'100110;
            end
        endcase // case (sum)

        count <= count + 1;

        case (count[26:21])
          0: code <= 6'h03;	// power-on init sequence
          1: code <= 6'h03;	// this is needed at least once
          2: code <= 6'h03;	// when LCD's powered on
          3: code <= 6'h02;	// it flickers existing char dislay
          4: code <= 6'h02; // Function Set, upper nibble 0010
          5: code <= 6'h08; // lower nibble 1000 (10xx)
          6: code <= 6'h00; // see table, upper nibble 0000, then lower nibble:
          7: code <= 6'h06; // 0110: Incr, Shift disabled
          8: code <= 6'h00; // Display On/Off, upper nibble 0000
          9: code <= 6'h0C; // lower nibble 1100 (1 D C B)
          10: code <= 6'h00; // Clear Display, 00 and upper nibble 0000
          11: code <= 6'h01; // then 00 and lower nibble 0001

          12: code <= val1;
          13: code <= val2;

          default: code <= 6'h10;
        endcase // case (count[26:21])

        refresh <= count[20];
        sf_e <= 1;
        e <= refresh;
        rs <= code[5];
        rw <= code[4];

        d <= code[3];
        c <= code[2];
        b <= code[1];
        a <= code[0];
     end // always @ (posedge clk)

endmodule // add4_wrapper
