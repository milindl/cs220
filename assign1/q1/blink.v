`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Kanpur
// Engineer:
//   Milind Luthra
//   Subhdeep Saha
//   Yash Srivastav
//
// Create Date:    11:48:05 03/17/2017
// Design Name:
// Module Name:    blink
// Project Name: Q1
// Target Devices: Xilinx Spartan-3e Starter
// Description:
//   Blinks LED periodically
//
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////
module blink(
             input wire clk,
             output reg ledpin
    );

   initial
     ledpin = 0;

   reg [25:0]           counter = 50_000_000;

   always @(posedge clk)
     if (counter == 0) begin
        counter <= 50_000_000;
        ledpin <= !ledpin;
     end else begin
        counter <= counter - 1;
     end

endmodule
