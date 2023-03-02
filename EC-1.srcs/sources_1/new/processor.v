`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 11:01:07 PM
// Design Name: 
// Module Name: processor
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


module processor(clock,reset,Input,Output,Halt);
    
    input clock,reset;
    
    input [7:0]Input;
	output wire [7:0]Output;
    
    output wire Halt;
    
    wire [2:0]IR;
    
    wire IRload,INmux,JNZmux,PCload,Aload,Adifz;
    
    controlunit cu0 (IR,IRload,PCload,clock,reset,Aload,INmux,JNZmux,Adifz,Halt);
			
	datapath dp0 (clock,reset,IRload,INmux,JNZmux,PCload,Aload,IR,Adifz,Input,Output);
endmodule
