`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2025 06:53:06 PM
// Design Name: 
// Module Name: DSDO_testbench
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


module DSDO_testbench;
reg X = 0;
reg clk = 0;
reg RST, EN; 
wire A,B,Z;

/* Test Cases: 
 *  a.) Detect Sequence A
 *  b.) Detect Sequence B
 *  c.) Detect A overlapped w/ itself
 *  d.) Detect B overlapped w/ itself
 *  e.) Detect A overlapped w/ B
 *  f.) Detect B overlapped w/ A
 *  g.) Enable Test
*/
DSDO sequence_detector (.X(X),.clk(clk),.RST(RST), .EN(EN),.A(A), .B(B), .Z(Z));
//SequenceA_Detector sqd (.X(X), .CLK(clk),.RST(RST), .Z(Z));

always  #10 clk = ~clk;  
 
initial begin
   RST = 1; EN = 1;
   @(posedge clk); 
   RST = 0; EN = 0;
   
   //Test Case A
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   $display("Test Case A done at time%0t",$time);
   //Test Case B
   #20
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   $display("Test Case B done at time%0t",$time);
   //Test Case C
   #20
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   $display("Test Case C done at time%0t",$time);
   //Test Case D
   #20
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   $display("Test Case D done at time%0t",$time);
   //Test Case E
   #20
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   $display("Test Case E done at time%0t",$time);
   //Test Case F
   #20
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   $display("Test Case F done at time%0t",$time);
   //Test Case G
   #20
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 0;
   @(posedge clk); X = 1;
   @(posedge clk); X = 0;
   @(posedge clk); EN = 1;
   #100
   $display("Test Case G done at time%0t",$time);
   $finish;
   
end

endmodule


