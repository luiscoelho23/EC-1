`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2022 12:05:28 AM
// Design Name: 
// Module Name: processor_tb
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


module processor_tb();
    
    reg clock,reset;
    reg [7:0]Input;
    wire [7:0]Output;
    wire Halt;
    
    initial
	begin
	 clock = 0;
	 reset = 1;
	 #2 reset = 0;
	 #3 reset = 1;
	 Input = 8'd7;
	 forever #2 clock = ~clock;
	end
    
    processor p0 (clock,reset,Input,Output,Halt);
    
endmodule
