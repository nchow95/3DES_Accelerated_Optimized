module key_handler(input wire[1:0] count, input wire[767:0] round_keys, output wire[47:0] round_key1, round_key2, round_key3, round_key4);

	reg[47:0] out_key1, out_key2, out_key3, out_key4;
	always_comb begin
		
		if(count == 3'b000) begin
			out_key1 = round_keys[767:720];
			out_key2 = round_keys[719:672];
			out_key3 = round_keys[671:624];
			out_key4 = round_keys[623:576];
		end
		else if(count == 2'b01) begin
			out_key1 = round_keys[575:528];
			out_key2 = round_keys[527:480];
			out_key3 = round_keys[479:432];
			out_key4 = round_keys[431:384];
		end
		else if(count == 2'b10) begin
			out_key1 = round_keys[383:336];
			out_key2 = round_keys[335:288];
			out_key3 = round_keys[287:240];
			out_key4 = round_keys[239:192];
		end
		else if(count == 2'b11) begin
			out_key1 = round_keys[191:144];
			out_key2 = round_keys[143:96];
			out_key3 = round_keys[95:48];
			out_key4 = round_keys[47:0];
		end
	end
	
	assign round_key1 = out_key1;
	assign round_key2 = out_key2;
	assign round_key3 = out_key3;
	assign round_key4 = out_key4;
endmodule
