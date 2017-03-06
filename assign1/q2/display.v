`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:02 03/06/2017 
// Design Name: 
// Module Name:    display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module display(
	input wire clk,
	output reg sf_e,
	output reg e,
	output reg rs,
	output reg rw,
	output reg d,
	output reg c,
	output reg b,
	output reg a
	);

// (* LOC = "C9" *) input clk; // pin C9 is the 50-MHz on-board clock
//(* LOC = "D16" *) output reg sf_e; // 1 LCD access (0 strataFlash access)
//(* LOC = "M18" *) output reg e; // enable (1)
//(* LOC = "L18" *) output reg rs;	// Register Select (1 data bits for R/W)
//(* LOC = "L17" *) output reg rw;	// Read/Write 1/0
//(* LOC = "M15" *) output reg d;	// 4th data bits (to form a nibble)
//(* LOC = "P17" *) output reg c;	// 3rd data bits (to form a nibble)
//(* LOC = "R16" *) output reg b;	// 2nd data bits (to form a nibble)
//(* LOC = "R15" *) output reg a;	// 1st data bits (to form a nibble)

reg [26:0] count = 0;	// 27-bit count, 0-(128M-1), over 2 secs
reg [5:0] code;	         // 6-bits different signals to give out
reg refresh;	               // refresh LCD rate @ about 25Hz

always @ (posedge clk) begin
	count <= count + 1;

	case (count [26:21])	// as top 6 bits change
		0: code <= 6'b000000;	// power-on init sequence
		1: code <= 6'b001100;	// this is needed at least once
		// 2: code <= 6'h03;	// when LCD's powered on
		// 3: code <= 6'h02;	// it flickers existing char dislay
	
		// Function Set 
		2: code <= 6'b000010; // Function Set, upper nibble 0010 
		3: code <= 6'b001000; // lower nibble 1000 (10xx)
		
		// Table 5-3, Entry Mode 
		// send 00 and upper nibble: I/D bit (Incr 1, Decr 0), S bit (Shift 1, 0 no) 
		4: code <= 6'b000000;    // see table, upper nibble 0000, then lower nibble: 
		5: code <= 6'b000110;    // 0110: Incr, Shift disabled
		
		// Table 5-3, Display On/Off 
		// send 00 and upper nibble 0000, then 00 and lower nibble 1 DCB 
		// D: 1, show char represented by code in DDR, 0 don't, but code remains 
		// C: 1, show cursor, 0 don't 
		// B: 1, cursor blinks (if shown), 0 don't blink (if shown) 
		6: code <= 6'b000000; // Display On/Off, upper nibble 0000 
		7: code <= 6'b001100; // lower nibble 1100 (1 D C B)
		
		// Table 5-3 Clear Display, 00 and upper nibble 0000, 00 and lower nibble 0001 
		8: code <= 6'b000000; // Clear Display, 00 and upper nibble 0000 
		9: code <= 6'b000001; // then 00 and lower nibble 0001
		
		// Chararters are then given out, the cursor will advance to the right 
		
		10: code <= 6'b100100; // 'C' high nibble 
		11: code <= 6'b100011; // 'C' low nibble
		
		12: code <= 6'b100110; // o 
		13: code <= 6'b101111; 

		14: code <= 6'b100110; // m 
		15: code <= 6'b101101; 

		16: code <= 6'b100111; // p 
		17: code <= 6'b100000;

		18: code <= 6'b100111; // u 
		19: code <= 6'b100101; 
		
		20: code <= 6'b100111; // t
		21: code <= 6'b100100;
		
		22: code <= 6'b100110; // e
		23: code <= 6'b100101;
		
		24: code <= 6'b100111; // r
		25: code <= 6'b100010;
		
		
		26: code <= 6'b001100; // pos cursor to 2nd line upper nibble 
		27: code <= 6'b000000; // lower nibble: h0 
		
		28: code <= 6'b100100; // O
		29: code <= 6'b101111;
		
		30: code <= 6'b100111; // r
		31: code <= 6'b100010;
		
		32: code <= 6'b100110; // g
		33: code <= 6'b100111;
		
		34: code <= 6'b100110; // a
		35: code <= 6'b100001;
		
		36: code <= 6'b100101; // n
		37: code <= 6'b101110;
		
		38: code <= 6'b100110; // i
		39: code <= 6'b101001;
		
		40: code <= 6'b100111; // z
		41: code <= 6'b101010;
		
		42: code <= 6'b100110; // a
		43: code <= 6'b100001;
		
		44: code <= 6'b100111; // t
		45: code <= 6'b100100;
		
		46: code <= 6'b100110; // i
		47: code <= 6'b101001;
		
		48: code <= 6'b100110; // o 
		49: code <= 6'b101111; 

		50: code <= 6'b100101; // n
		51: code <= 6'b101110;
		
		
		53: code <= 6'b011000; // Table 5-3, Read Busy Flag and Address
		54: code <= 6'b010000;
		
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
