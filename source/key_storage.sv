module key_storage(input wire clk, n_rst, enable, input wire [63:0] in_key, output reg[63:0] key_registers);
	reg[63:0] next_key_register;
	always_ff @(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			key_registers <= 63'd0;
		end
		else begin
			key_registers <= next_key_register;
		end
	end
	
	always_comb begin
		if(enable) begin
			next_key_register = in_key;
		end
		else begin
			next_key_register = key_registers;
		end
	end	
endmodule
