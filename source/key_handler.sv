module key_handler(input wire[1:0] count, input wire[191:0] round_keys, output wire[47:0] round_key);

	reg[47:0] out_key;
	always_comb begin
		if(count == 3'b000) 
			out_key = round_keys[191:144];
		else if(count == 2'b01)
			out_key = round_keys[143:96];
		else if(count == 2'b10)
			out_key = round_keys[95:48];
		else if(count == 2'b11)
			out_key = round_keys[47:0];
	end
	
	assign round_key = out_key;
endmodule
