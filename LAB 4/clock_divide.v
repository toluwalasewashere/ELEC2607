`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 10:56:44 PM
// Design Name: 
// Module Name: clock_divide
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


module clock_divide(
    input clk,
    input reset,
    output reg clk_out
    );

    
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            clk_out <= 0;
        end else begin
            clk_out <= ~clk_out;
        end
    end
    
endmodule
