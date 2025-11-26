module seven_seg_controller(
    input  wire         CLK100MHZ,
	// TODO - Include Button
	input BTNL,
	input BTNR,	
    input  [15:0]       SW,
    output [15:0]       LED,
    output              CA,
	output				CB,
	output				CC,
	output				CD,
	output				CE,
	output				CF,
	output				CG,
    output [7:0]        AN);
    
    wire clkButtonPressed;
    wire rstButtonPressed;
    
    // TODO - reg(s) to display digits state value
    wire [3:0] DSDOState;

    // TODO - LED to indicate A, B, Z 
    wire A = LED[0];
    wire B = LED[1];
    wire Z = LED[2];
    
    

    // TODO - Button debouncer modules
    PushButton_Debouncer clkButton (CLK100MHZ,BTNL,clkButtonPressed);
    PushButton_Debouncer rstButton (CLK100MHZ,BTNR,rstButtonPressed);
    //Note to Self - You can't pass the instantiation of a module as input to another module ...?

    // TODO - DSDO module
    DSDO myDetector(.X(SW[0]),.clk(clkButtonPressed),.RST(rstButtonPressed),.EN(SW[15]),.A(A),.B(B),.Z(Z),.state(DSDOState));
    

	reg [7:0]  segment_state = 8'b00000001;
	reg [31:0] segment_counter = 32'b0;
	reg [3:0]  routed_vals = 4'b0;
	wire [6:0] cat_out = {CG,CF,CE,CD,CC,CB,CA};

	binary_to_seven_segment converter(routed_vals,cat_out);

	assign AN = ~segment_state;

    // Refresh LEDs
	always @(posedge CLK100MHZ ) begin		
        if (segment_counter == 32'd100_000) begin
            segment_counter <= 32'd0;
            segment_state <= {segment_state[6:0], segment_state[7]};
        end else begin
            segment_counter <= segment_counter + 1;
        end
    end

    // Set the value to be displayed in each digit
	always @(posedge CLK100MHZ) begin   	
		case(segment_state)
            // TODO - display correct values
			8'b00000001: routed_vals = DSDOState;
			8'b00000010: routed_vals = 0;
			8'b00000100: routed_vals = 0;
			8'b00001000: routed_vals = 0;
			8'b00010000: routed_vals = 0;
			8'b00100000: routed_vals = 0;
			8'b01000000: routed_vals = 0;
			8'b10000000: routed_vals = 0;
			default: routed_vals = 4'b0000;
		endcase
	end
    
endmodule