`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2022 10:08:41 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
       clock,
	   reset,
	   IRload,
	   INmux,
	   JNZmux,
       PCload,
       Aload,
       IR,
	   Adifz,
	   Input,
	   Output
       );

input clock, reset;

input IRload, INmux, JNZmux, PCload, Aload;

input [7:0] Input;
output[7:0] Output;

output [2:0]IR;
output Adifz;

wire [7:0]ROMout;
wire [7:0]IRout;

wire [3:0]PCin;
wire [3:0]PCoutInc;
wire [3:0]PCoutRom;
wire [3:0]PCinmux;

wire [7:0] Aout;
wire [7:0] Ain;

assign Output[7:0] = Aout[7:0];

or(OR1,Aout[0],Aout[1],Aout[2],Aout[3]);
or(OR2,Aout[4],Aout[5],Aout[6],Aout[7]);
or(Adifz,OR1,OR2);

assign PCinmux = PCoutInc + 4'd1;

assign Ain[7:0] = INmux?Input[7:0]:(Aout[7:0] - 8'd1);

assign PCin[3:0] = JNZmux?IRout[3:0]:PCinmux[3:0];

assign PCoutInc = PCoutRom;

assign IR[2:0] = IRout[7:5];

ROM rom (clock,PCoutRom,ROMout);

register_master #(.size(8))R_IR (.load(IRload),.clear(reset),.clock(clock),.dataIn(ROMout),.dataOut(IRout));
register_master #(.size(4))R_PC (.load(PCload),.clear(reset),.clock(clock),.dataIn(PCin),.dataOut(PCoutRom));
register_master #(.size(8))R_A  (.load(Aload) ,.clear(reset),.clock(clock),.dataIn(Ain),.dataOut(Aout));

endmodule

//reg [3:0] PC;
//reg [7:0] IR;
//reg [7:0] A;

//always @(posedge clock)
//begin 
//	// --RESET-- Reset = 1 //
//	if(reset == 1'b1)
//	begin
//		A = 8'd0;
//	end
//end

//always @(posedge clock)
//begin
//	// --INPUT A-- ALoad = 1 e INmux = 1 //
//	if(Aload==1'b1 && INmux==1'b1)
//	begin
//		A = INPUT;
//	end
//	else 
//	// --DEC A-- Aload = 1 e INmux = 0 //
//	if(Aload == 1'b1 && INmux == 1'b0)
//	begin 
//		if(A > 8'd0)
//		begin
//			A = A - 8'd1;
//		end
//	end  
//end 

//// A diff from 0 //
//assign Adifz = (A == 8'd0) ? 1'b0:1'b1;

//always @(posedge clock)
//begin
//	// --IR-- //
//	if(PCLoad==1'b1 && JNZmux==1'b1)
//	begin
//		PC = IR[3:0];
//	end
//	else 
//	// --PC+4-- //
//	if(PCLoad == 1'b1 && JNZmux == 1'b0)
//	begin 
//		PC = PC + 4'd4;
//	end  
//end 

//reg [7:0] ROM[15:0];

//always @(posedge clock)
//begin
//	if(IRLoad == 1'b1)
//	begin 
//		IR = ROM[PCLoad];
//	end
//end

//endmodule