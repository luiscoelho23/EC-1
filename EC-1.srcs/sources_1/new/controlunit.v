`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2022 08:55:08 PM
// Design Name: 
// Module Name: controlunit
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


module controlunit(
       irIn,
	   IRload,
	   PCload,
	   clock,
       reset,
       Aload,
       INmux,
       JNZmux,
	   Adifz,
	   Halt
       );


input [2:0] irIn;
input Adifz;
input clock, reset;
output reg IRload, JNZmux, PCload, Aload, Halt;
output reg INmux;

    
//=============Internal Constants======================
parameter s_start  = 3'b000, s_fetch = 3'b001, s_decode = 3'b010,
		  s_input = 3'b011, s_output = 3'b100, s_dec = 3'b101,
		  s_jnz = 3'b110, s_halt = 3'b111;
//=============Internal Variables======================
reg [2:0]state;  
reg [2:0]next_state;// Seq part of the FSM

initial
    begin
        state = 3'b000;
        next_state = 3'b000;
    end
//==========Code startes Here==========================

// FSM ENCODER //

always@(posedge clock, negedge reset)
begin
    if(!reset)
        state = s_start;
    else
        state = next_state;
end

always@(state , irIn)
begin
    case(state)
            s_start :
				next_state = s_fetch;
			
			s_fetch :
				next_state = s_decode;

			s_decode: 
			    case(irIn)
				    3'b011:
					   next_state = s_input;
				
                    3'b100:
					   next_state = s_output;
				
				    3'b101:
					   next_state = s_dec;
				
				    3'b110:
					   next_state = s_jnz;
				
				    3'b111:
					   next_state = s_halt;
					   
				    default:
				       next_state = s_start;
	            endcase		 
			s_input :
				next_state = s_start;
			
			s_output :
				next_state = s_start;

			s_dec : 
				next_state = s_start;

			s_jnz : 
				next_state = s_start;

			s_halt :
				next_state = s_halt;

            s_input:
                next_state = s_start;
             
            s_output:
                next_state = s_start;
            
            s_dec:
                next_state = s_start;    
            
            s_jnz:
                next_state = s_start;
                
            s_halt:
                next_state = s_halt;
                    
			default: 
				next_state = s_start;
    endcase				
end
               
always@(state, Adifz)
begin
    case(state)
        s_start: begin 
			         IRload = 1'd0;
			         PCload = 1'd0;
			         INmux  = 1'b0; 
			         Aload  = 1'd0; 
			         JNZmux = 1'd0; 
			         Halt   = 1'd0;
			     end
			
		s_fetch: begin
			         IRload = 1'd1;
			         PCload = 1'd1;   
			         INmux  = 1'b0; 
			         Aload  = 1'd0;
			         JNZmux = 1'd0; 
			         Halt   = 1'd0;
			     end	
		
		s_decode: begin
		             IRload  = 1'd0; 
		             PCload  = 1'd0; 
			         INmux   = 1'b0; 
			         Aload   = 1'd0; 
			         JNZmux  = 1'd0;
			         Halt    = 1'd0;
			      end
			 
		s_input: begin
			         IRload  = 1'd0;
			         PCload  = 1'd0;
			         INmux   = 1'b1; 
			         Aload   = 1'd1; 
			         JNZmux  = 1'd0;
			         Halt    = 1'd0;
			     end
	   
	   s_output: begin
	                 IRload  = 1'd0;
	                 PCload  = 1'd0;
	                 INmux   = 1'd0;
	                 Aload   = 1'd0;
	                 JNZmux  = 1'd0;
	                 Halt    = 1'd0;
                 end
       
       s_dec:    begin
                     IRload  = 1'd0;
	                 PCload  = 1'd0;
	                 INmux   = 1'd0;
	                 Aload   = 1'd1;
	                 JNZmux  = 1'd0;
	                 Halt    = 1'd0;     
			     end
			     
	   s_jnz:    begin
                     IRload  = 1'd0;
	                 PCload  = Adifz;
	                 INmux   = 1'd0;
	                 Aload   = 1'd0;
	                 JNZmux  = 1'd1;
	                 Halt    = 1'd0;     
			     end	     
		 
		s_halt:  begin
                     IRload  = 1'd0;
	                 PCload  = 1'd0;
	                 INmux   = 1'd0;
	                 Aload   = 1'd0;
	                 JNZmux  = 1'd0;
	                 Halt    = 1'd1;     
			     end	     
			     
			     
        default: begin
			         IRload  = 1'd0; 
			         JNZmux  = 1'd0; 
			         PCload  = 1'd0; 
			         INmux   = 1'b0; 
			         Aload   = 1'd0; 
			         Halt    = 1'd0;
			     end	
    endcase
end
                
endmodule


//// START STATE //
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;


//// FETCH STATE //
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;


//// DECODE STATE//
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;


//// INPUT STATE //
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;


//// OUTPUT STATE //
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;


//// DEC STATE//
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;


//// JNZ STATE //
//assign IRLoad;
//assign JNZmux;
//assign PCLoad;
//assign Aload = (state == s_input) ? 1'b1:1'b0;
//assign INmux = (state == s_input) ? 1'b1:1'b0;
//assign HALT;

//// HALT STATE //
//assign IRLoad = 0;
//assign JNZmux = 0;
//assign PCLoad = 0;
//assign Aload = 0;
//if(state == s_halt)
//begin
//end
//assign INmux = (state == s_halt) ? 1'b0:;
//assign HALT = (state == s_halt) ? 1'b1:;


//always @ (posedge clock)
//begin : FSM
//	if (reset == 1'b1) 
//	// RESET
//	begin 
//		state <= s_start;   
//	end 
//	else begin
//		case(state)
//			s_start :
//				state <= s_fetch;
			
//			s_fetch :
//				state <= s_decode;

//			s_decode: 
//				if(IR[7:5] == 3'b011)
//				begin
//					state <= s_input;
//				end
//				else
//				if(IR[7:5] == 3'b100)
//				begin
//					state <= s_output;
//				end
//				else
//				if(IR [7:5] == 3'b101)
//				begin
//					state <= s_dec;
//				end
//				else
//				if(IR[7:5] == 3'b110)
//				begin
//					state <= s_jnz;
//				end
//				else
//				if(IR[7:5] == 3'b111)
//				begin
//					state <= s_halt;
//				end
			
//			s_input :
//				state <= s_start;
			
//			s_output :
//				state <= s_start;

//			s_dec : 
//				state <= s_start;

//			s_jnz : 
//				state <= s_start;

//			s_halt :
//				state <= s_halt;

//			default : 
//				state <= s_start;
//		endcase
//	end	
//end
 
//endmodule