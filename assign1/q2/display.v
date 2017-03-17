`timescale 1ns / 1ps
module display(clk, sf_e, e, rs, rw, d, c, b, a);

   (* LOC = "C9" *) input clk;
   (* LOC = "D16" *) output reg sf_e;
   (* LOC = "M18" *) output reg e;
   (* LOC = "L18" *) output reg rs;
   (* LOC = "L17" *) output reg rw;
   (* LOC = "M15" *) output reg d;
   (* LOC = "P17" *) output reg c;
   (* LOC = "R16" *) output reg b;
   (* LOC = "R15" *) output reg a;

   reg [26:0] count = 0;
   reg [5:0]  code;
   reg        refresh;

   always @ (posedge clk) begin
      count <= count + 1;

      case (count [26:21])
        // power-on init can be carried out befor this loop to avoid the flickers
        0: code <= 6'h03;	// power-on init sequence
        1: code <= 6'h03;	// this is needed at least once
        2: code <= 6'h03;	// when LCD's powered on
        3: code <= 6'h02;	// it flickers existing char dislay
        // Table 5-3, Function Set
        // Send 00 and upper nibble 0010, then 00 and lower nibble 10xx
        4: code <= 6'h02; // Function Set, upper nibble 0010
        5: code <= 6'h08; // lower nibble 1000 (10xx)
        // Table 5-3, Entry Mode
        // send 00 and upper nibble: I/D bit (Incr 1, Decr 0), S bit (Shift 1, 0 no)
        6: code <= 6'h00; // see table, upper nibble 0000, then lower nibble:
        7: code <= 6'h06; // 0110: Incr, Shift disabled
        // Table 5-3, Display On/Off
        // send 00 and upper nibble 0000, then 00 and lower nibble 1 DCB
        // D: 1, show char represented by code in DDR, 0 don't, but code remains
        // C: 1, show cursor, 0 don't
        // B: 1, cursor blinks (if shown), 0 don't blink (if shown)
        8: code <= 6'h00; // Display On/Off, upper nibble 0000
        9: code <= 6'h0C; // lower nibble 1100 (1 D C B)
        // Table 5-3 Clear Display, 00 and upper nibble 0000, 00 and lower nibble 0001
        10: code <= 6'h00; // Clear Display, 00 and upper nibble 0000
        11: code <= 6'h01; // then 00 and lower nibble 0001
        // Chararters are then given out, the cursor will advance to the right
        // Table 5-3, Write Data to DD RAM (or CG RAM)
        // Fig 5-4, 'H' send 10 and upper nibble 0100, then 10 and lower nibble

        12: code <= 6'b100100; // 'C' high nibble
        13: code <= 6'b100011; // 'C' low nibble

        14: code <= 6'b100110; // o
        15: code <= 6'b101111;

        16: code <= 6'b100110; // m
        17: code <= 6'b101101;

        18: code <= 6'b100111; // p
        19: code <= 6'b100000;

        20: code <= 6'b100111; // u
        21: code <= 6'b100101;

        22: code <= 6'b100111; // t
        23: code <= 6'b100100;

        24: code <= 6'b100110; // e
        25: code <= 6'b100101;

        26: code <= 6'b100111; // r
        27: code <= 6'b100010;


        28: code <= 6'b001100; // pos cursor to 2nd line upper nibble
        29: code <= 6'b000000; // lower nibble: h0

        30: code <= 6'b100100; // O
        31: code <= 6'b101111;

        32: code <= 6'b100111; // r
        33: code <= 6'b100010;

        34: code <= 6'b100110; // g
        35: code <= 6'b100111;

        36: code <= 6'b100110; // a
        37: code <= 6'b100001;

        38: code <= 6'b100101; // n
        39: code <= 6'b101110;

        40: code <= 6'b100110; // i
        41: code <= 6'b101001;

        42: code <= 6'b100111; // z
        43: code <= 6'b101010;

        44: code <= 6'b100110; // a
        45: code <= 6'b100001;

        46: code <= 6'b100111; // t
        47: code <= 6'b100100;

        48: code <= 6'b100110; // i
        49: code <= 6'b101001;

        50: code <= 6'b100110; // o
        51: code <= 6'b101111;

        52: code <= 6'b100101; // n
        53: code <= 6'b101110;

        54: code <= 6'h21; // Table 5-3, Read Busy Flag and Address
        // send 01 BF (Busy Flag) x x x, then 01xxxx
        // idling

        default: code <= 6'h10; // the restun-used time
      endcase
      // refresh (enable) the LCD when bit 20 of the count is 1
      // (it flips when counted upto 2M, and flips again after another 2M)
      refresh <= count[ 20 ]; // flip rate about 25 (50MHz/2*21=2M)
      sf_e <= 1;
      e <= refresh;
      rs <= code[5];
      rw <= code[4];
      d <= code[3];
      c <= code[2];
      b <= code[1];
      a <= code[0];
   end // always

endmodule

