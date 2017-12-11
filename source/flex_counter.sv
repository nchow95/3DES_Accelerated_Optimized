// $Id: $
// File name:   flex_counter.sv
// Created:     9/12/2017
// Author:      Nathan Chow
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .
module flex_counter
#(
	NUM_CNT_BITS = 2
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [NUM_CNT_BITS-1:0] rollover_val,
	output wire [NUM_CNT_BITS-1:0] count_out,
	output wire rollover_flag
);

	reg [NUM_CNT_BITS-1:0]curr_count, next_count;
	reg next_rollover, curr_rollover;
	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			curr_count <= 0;
			curr_rollover <= 0;
		end
		else begin
			curr_count <= next_count;
			curr_rollover <= next_rollover;
		end
	end

	always_comb 
	begin: NEXT_STATE_LOGIC
	
		if(clear == 1) begin
			next_count = 0;
		end
		else if(count_enable == 1'b1 && curr_count == 0) begin
			next_count = 1;
		end
		else if(curr_count > 2'b00) begin
			next_count = curr_count +1;
			next_rollover = curr_count == rollover_val;
			if(next_rollover == 1) begin
				next_count = 0;
			end
		end
		else begin
			next_count = curr_count;
			next_rollover = curr_rollover;
		end
		if(curr_rollover == 1 ) begin
			next_rollover = 0;
		end
		else begin
			next_rollover = next_rollover;
		end
	end

	assign rollover_flag = curr_rollover;
	assign count_out = curr_count;

endmodule
