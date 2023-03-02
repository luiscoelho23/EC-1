`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 03:45:31 AM
// Design Name: 
// Module Name: ROM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ROM(
            clock, 
            address, 
            romOut
    );
    
    
    input clock;
	input [3:0]address;
	output reg[7:0]romOut;
	
	reg [7:0]ROM[15:0];
	
	
always@(posedge clock)
	 romOut <= ROM[address];

initial begin
     ROM[0] = 8'b01100000;   // IN A
     ROM[1] = 8'b10000000;   // OUT A <--
     ROM[2] = 8'b10100000;   // DEC A
     ROM[3] = 8'b11000001;   // JNZ -->
     ROM[4] = 8'b11111111;   // HALT
     ROM[5] = 8'b00000000;   
	 ROM[6] = 8'b00000000;
	 ROM[7] = 8'b00000000;
	 ROM[8] = 8'b00000000;
	 ROM[9] = 8'b00000000;
	 ROM[10] = 8'b00000000;
	 ROM[11] = 8'b00000000;
	 ROM[12] = 8'b00000000;
	 ROM[13] = 8'b00000000;
	 ROM[14] = 8'b00000000;
	 ROM[15] = 8'b00000000;
	end
	
	   
endmodule
