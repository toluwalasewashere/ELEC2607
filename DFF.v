`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 11:42:39 PM
// Design Name: 
// Module Name: DFF
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


module DFF_async_reset(
    input clk,
    input d,
    input reset,
    output reg q
    );
    
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end
endmodule
