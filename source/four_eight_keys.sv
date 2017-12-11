module four_eight_keys(input wire[1:0] count, input wire[1151:0] round_keys, output wire[47:0] round_key1, round_key2, round_key3, round_key4, round_key5, round_key6, round_key7, round_key8);

	reg[47:0] out_key1, out_key2, out_key3, out_key4, out_key5, out_key6;
	always_comb begin
		if(count == 2'b00) begin
			out_key1 = round_keys[1151:1104];
			out_key2 = round_keys[1103:1056];
			out_key3 = round_keys[1055:1008];
			out_key4 = round_keys[1007:960];
			out_key5 = round_keys[959:912];
			out_key6 = round_keys[911:864];
		end
		else if (count == 2'b01) begin
			out_key1 = round_keys[863:816];
			out_key2 = round_keys[815:768];
			out_key3 = round_keys[767:720];
			out_key4 = round_keys[719:672];
			out_key5 = round_keys[671:624];
			out_key6 = round_keys[623:576];
		end
		else if(count == 2'b10) begin
			out_key1 = round_keys[575:528];
			out_key2 = round_keys[527:480];
			out_key3 = round_keys[479:432];
			out_key4 = round_keys[431:384];
			out_key5 = round_keys[383:336];
			out_key6 = round_keys[335:288];
		end
		else if(count == 2'b11) begin
			out_key1 = round_keys[287:240];
			out_key2 = round_keys[239:192];
			out_key3 = round_keys[191:144];
			out_key4 = round_keys[143:96];
			out_key5 = round_keys[95:48];
			out_key6 = round_keys[47:0];
		end
	end
	
	assign round_key1 = out_key1;
	assign round_key2 = out_key2;
	assign round_key3 = out_key3;
	assign round_key4 = out_key4;
	assign round_key5 = out_key5;
	assign round_key6 = out_key6;
endmodule