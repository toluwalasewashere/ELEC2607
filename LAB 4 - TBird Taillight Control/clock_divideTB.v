`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 11:00:55 PM
// Design Name: 
// Module Name: clock_divideTB
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


module clock_divideTB;

//module inputs
reg clock, reset;

//module outputs
wire clk_out;

//Instantiate clock_divide module 
 clock_divide divide_by_two(.clk(clock),.reset(reset),.clk_out(clk_out));

always #10 clock =~ clock;

initial  clock = 0;
initial reset = 0;

initial begin
    
    #15
    reset = 1;
    #25
    reset = 0;
    #105
    reset = 1;
    #5
    $finish;
end

endmodule
