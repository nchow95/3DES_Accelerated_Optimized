module box(input wire[47:0] in_48bit, input wire[31:0] left_block, output wire[31:0] out_32bit);

	wire[31:0] temp_out_32bit, p_permute;
	s1 one   (.in_6bit(in_48bit[47:42]), .out_4bit(temp_out_32bit[31:28]));
	s2 two   (.in_6bit(in_48bit[41:36]), .out_4bit(temp_out_32bit[27:24]));
	s3 three (.in_6bit(in_48bit[35:30]), .out_4bit(temp_out_32bit[23:20]));
	s4 four  (.in_6bit(in_48bit[29:24]), .out_4bit(temp_out_32bit[19:16]));
	s5 five  (.in_6bit(in_48bit[23:18]), .out_4bit(temp_out_32bit[15:12]));
	s6 six   (.in_6bit(in_48bit[17:12]), .out_4bit(temp_out_32bit[11:8]));
	s7 seven (.in_6bit(in_48bit[11:6]),  .out_4bit(temp_out_32bit[7:4]));
	s8 eight (.in_6bit(in_48bit[5:0]),   .out_4bit(temp_out_32bit[3:0]));
	assign p_permute[31:24] = {temp_out_32bit[16],temp_out_32bit[25], temp_out_32bit[12], temp_out_32bit[11], temp_out_32bit[3], temp_out_32bit[20], temp_out_32bit[4], temp_out_32bit[15]};
	assign p_permute[23:16] = {temp_out_32bit[31],temp_out_32bit[17], temp_out_32bit[9], temp_out_32bit[6], temp_out_32bit[27], temp_out_32bit[14], temp_out_32bit[1], temp_out_32bit[22]};
	assign p_permute[15:8]  = {temp_out_32bit[30],temp_out_32bit[24], temp_out_32bit[8], temp_out_32bit[18], temp_out_32bit[0], temp_out_32bit[5], temp_out_32bit[29], temp_out_32bit[23]};
	assign p_permute[7:0]   = {temp_out_32bit[13],temp_out_32bit[19], temp_out_32bit[2], temp_out_32bit[26], temp_out_32bit[10], temp_out_32bit[21], temp_out_32bit[28], temp_out_32bit[7]};
	assign out_32bit  = left_block ^ p_permute;

endmodule
