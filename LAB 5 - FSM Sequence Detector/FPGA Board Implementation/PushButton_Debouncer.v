module PushButton_Debouncer(
	input clk,
	input PB, // glitchy and async
	
	// Synchronous outputs to clk
	output reg PB_state, // 1 while button is pressed
	output PB_down,	// 1 for one clock cycle when the button is pressed
	output PB_up // 1 for one clock cycle when button is released
);

initial PB_state = 0;

// Synchronize PB signal to clk
reg PB_sync_0; always @(posedge clk) PB_sync_0 <= PB;
reg PB_sync_1; always @(posedge clk) PB_sync_1 <= PB_sync_0;

// 20b counter
// Largest 20b number -> 1,048,576
// Operating at 100MHZ -> ~10.5ms
reg [19:0] PB_cnt = 0;

wire PB_idle = (PB_state == PB_sync_1);

wire PB_cnt_max = &PB_cnt; // True when all bits of PB_cnt are 1s (max reached)

always @(posedge clk) begin
	if (PB_idle) begin
		PB_cnt <= 0;
	end else begin
		PB_cnt <= PB_cnt + 1; 
		if (PB_cnt_max) PB_state <= ~PB_state;
	end
end

assign PB_down 	= ~PB_idle & PB_cnt_max & ~PB_state;
assign PB_up 	= ~PB_idle & PB_cnt_max & PB_state;
endmodule;
