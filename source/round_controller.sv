module round_controller(input wire clk, n_rst, clear, input wire[63:0] data_in,
			 output reg[31:0] left_block,  right_block);
		
	always_ff @(posedge clk, negedge n_rst) begin
		if (n_rst == 0) begin
			left_block <= 32'd0;			
			right_block <= 32'd0;			
		end
		else begin
			if (clear) begin
				right_block <= 32'd0;
				left_block <= 32'd0;
			end
			else begin
				right_block <= data_in[31:0];
				left_block <= data_in[63:32];
			end
		end
	end
endmodule

