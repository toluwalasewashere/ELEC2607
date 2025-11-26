`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2025 06:46:39 PM
// Design Name: 
// Module Name: DSDO
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


module DSDO(
    input X,//bitstream we'll be checking for sequences 
    input clk, // clock signal input
    input RST,
    input EN, //Maintains the current state of the circuit
    output A, B, Z, //Output Z which should go to 1 when either sequence is detected
    output reg [3:0] state
    );
    
    /* This module DSDO represents a double sequence detector with overlap
     * the output should go to 1 (for the whole clock cycle) after the circuit 
     * detects sequences A = 10001 or B = 001100
     * Overlapped sequences must be detected, including sequences that overlap themselves.
    */
    parameter S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, S8 = 4'd8, S9 = 4'd9, S10 = 4'd10, S11 = 4'd11 ;
    reg [3:0] nxt_state; 
    
    //Combinational logic that defines what next state will be (State Transition Logic)
    always @ (*) begin
        case (state) 
            S0: nxt_state = (X == 1)? S1: S2;
            S1: nxt_state = (X == 1)? S1: S3;
            S2: nxt_state = (X == 1)? S1: S4;
            S3: nxt_state = (X == 1)? S1: S5;
            S4: nxt_state = (X == 1)? S7: S4;
            S5: nxt_state = (X == 1)? S7: S6;
            S6: nxt_state = (X == 1)? S8: S4;
            S7: nxt_state = (X == 1)? S9: S3;
            S8: nxt_state = (X == 1)? S9: S3;
            S9: nxt_state = (X == 1)? S1: S10;
            S10: nxt_state = (X == 1)? S1: S11;
            S11: nxt_state = (X == 1)? S7: S6;
            
            default nxt_state = S0;
        endcase
    end
    
    //Sequential logic needed to transition between states (State Flip-Flops)
    always @ (posedge clk or posedge RST) begin
        if (RST) state <= S0;
        else if (EN) state <= state;
        else state <= nxt_state;
        
    end
    
    //Output Logic 
    assign A = (state == S8);
    assign B = (state == S11); 
    assign Z = ( A | B );
endmodule
