`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2022 12:51:34 AM
// Design Name: 
// Module Name: register_master
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


module register_master(load,clear,clock,dataIn,dataOut);

    parameter size = 1;
    
    input load,clear,clock;
    input [size-1:0]dataIn;
    output reg [size-1:0]dataOut;
    
    always@(posedge clock,negedge clear)
	if(!clear)
		dataOut <= 0;
	else//no reset
		if(load)
			dataOut <= dataIn;
		else
			dataOut <= dataOut;
    
endmodule
