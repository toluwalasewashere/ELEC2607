`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2025 08:59:25 PM
// Design Name: 
// Module Name: SequenceA_Detector
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


module SequenceA_Detector(
    input X,
    input CLK, 
    input RST,
    output Z
    );
    
    //State & Next State Registers
    reg [2:0] state, next_state;
    
    //Parameters for each state
    parameter A0 = 3'd0, A1 = 3'd1, A2 = 3'd2, A3 = 3'd3, A4 = 3'd4;
    
    //State Transition Logic
    always @ (*) begin 
        case (state) 
            A0: next_state = (X==1)? A1:A0;
            A1: next_state = (X==1)? A1:A2;
            A2: next_state = (X==1)? A1:A3;
            A3: next_state = (X==1)? A1:A4;
            A4: next_state = (X==1)? A1:A0;
            
            default: next_state = A0;
        endcase
    end
    
    always @ (posedge CLK or posedge RST) begin
        if (RST) state <= A0;
        else state <= next_state;
    end
    
    assign Z = (state == A4);
endmodule
