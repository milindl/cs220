//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:32 03/06/2017 
// Design Name: 
// Module Name:    blink 
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
`timescale 1ns / 1ps

module blink(
	input wire clk,	// clock signal
	output reg ledpin	// LED pin
    );

	initial
		ledpin = 0;	

	// internal variable
	reg [25:0] counter = 50_000_000;	// 26 bit variable

	always @(posedge clk)
		if (counter == 0) begin			// at 1 second
			counter <= 50_000_000;		// reset counter
			ledpin <= !ledpin;		// invert ledpin
		end else begin
			counter <= counter - 1;		// decrease
		end

endmodule
