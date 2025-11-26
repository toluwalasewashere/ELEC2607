`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 08:25:26 PM
// Design Name: 
// Module Name: tBird
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


module tBird(input wire CLK100MHZ,// connect clock input from FPGA
             output [7:0] LED,  // connect output LEDs 0-7 on FPGA
             input [7:0] SW    // connect input switches 0-7 on FPGA
        );
        
    	// This block creates the slower clock
	/*reg [25:0] = count;
	reg slowCLK = 0;
	always @(posedge CLK100MHZ) begin
		count <= count + 1;
		if (count == 50_000_000) begin
			count <= 0;
			slowCLK = ~slowCLK;
		end
	end*/

	// Wires for lightbulb equations and dive by two clock Q0
	wire BULB_L1, BULB_L2, BULB_L3, BULB_R1, BULB_R2, BULB_R3, Q0;

	// Set reset to preferred switch on board
	wire RST = SW[4];

	// TODO - set Emerg and Lite 1/2/3 equations
	wire Emerg = 0;
	wire Lite_1 = 0;
	wire Lite_2 = 0;
	wire Lite_3 = 0;

	// Connect wire to preferred switches on board for left, right and brake
	wire L = SW[2]; // Left
	wire B = SW[1]; // Brake
	wire R = SW[0]; // Right

	// TODO - Create the divide by two module (seperate design source file), make sure module name matches here
	divideByTwo clock_divide(); // TODO - Connect ports according to your module (clk, reset, Q0)

	// TODO - Write the equations for left-hand lights
	assign BULB_L1 = 0;
	assign BULB_L2 = 0;
	assign BULB_L3 = 0;

	// TODO - Write the equations for right-hand lights
	assign BULB_R1 = 0;
	assign BULB_R2 = 0;
	assign BULB_R3 = 0;

	// Assign left and right lights to preferred LEDs on board
	assign LED[7] = BULB_L3;
	assign LED[6] = BULB_L2;
	assign LED[5] = BULB_L1;

	assign LED[2] = BULB_R1;
	assign LED[1] = BULB_R2;
	assign LED[0] = BULB_R3;
endmodule