module Triple_DES (
	input wire clk, 
	input wire n_rst,
	input wire[63:0] key1, key2,
	input wire[2:0] mode,
	input wire enable,
	input wire[63:0] data_in,
	output wire data_ready,
	output wire[63:0] data_out
);
	wire [47:0] r1_01, r1_02, r1_03, r1_04, r1_05, r1_06, r1_07, r1_08, r1_09, r1_10, r1_11, r1_12, r1_13, r1_14, r1_15, r1_16;  //key 1 round keys
	wire [47:0] r2_01, r2_02, r2_03, r2_04, r2_05, r2_06, r2_07, r2_08, r2_09, r2_10, r2_11, r2_12, r2_13, r2_14, r2_15, r2_16;  //key 2 round keys
	wire dr1, dr2, busy1, busy2;  //intermediate data_ready and busy signals
	wire[63:0] data_out1, data_out2;  //intermediate data_out values
	

	//generate the round keys
	generate_round_keys Round_Key1	(.clk(clk), .n_rst(n_rst), .key(key1), .mode(mode[1:0]), .round1(r1_01), .round2(r1_02), .round3(r1_03), .round4(r1_04), 
					.round5(r1_05), .round6(r1_06), .round7(r1_07), .round8(r1_08), .round9(r1_09), .round10(r1_10), .round11(r1_11), 
					.round12(r1_12), .round13(r1_13), .round14(r1_14), .round15(r1_15), .round16(r1_16));

	generate_round_keys Round_Key2	(.clk(clk), .n_rst(n_rst), .key(key2), .mode({mode[1], ~mode[0]}), .round1(r2_01), .round2(r2_02), .round3(r2_03), .round4(r2_04), 
					.round5(r2_05), .round6(r2_06), .round7(r2_07), .round8(r2_08), .round9(r2_09), .round10(r2_10), .round11(r2_11), 
					.round12(r2_12), .round13(r2_13), .round14(r2_14), .round15(r2_15), .round16(r2_16));


	//3DES
	DES des1	(.clk(clk), .n_rst(n_rst), .enable(enable), .data_in(data_in), .mode(mode), .r1_key(r1_01), .r2_key(r1_02), .r3_key(r1_03), .r4_key(r1_04), 
			.r5_key(r1_05), .r6_key(r1_06), .r7_key(r1_07), .r8_key(r1_08), .r9_key(r1_09), .r10_key(r1_10), .r11_key(r1_11), .r12_key(r1_12), 
			.r13_key(r1_13), .r14_key(r1_14), .r15_key(r1_15), .r16_key(r1_16), .data_ready(dr1), .final_data_out(data_out1));

	DES des2	(.clk(clk), .n_rst(n_rst), .enable(dr1), .data_in(data_out1), .mode(mode), .r1_key(r2_01), .r2_key(r2_02), .r3_key(r2_03), .r4_key(r2_04), 
			.r5_key(r2_05), .r6_key(r2_06), .r7_key(r2_07), .r8_key(r2_08), .r9_key(r2_09), .r10_key(r2_10), .r11_key(r2_11), .r12_key(r2_12), 
			.r13_key(r2_13), .r14_key(r2_14), .r15_key(r2_15), .r16_key(r2_16), .data_ready(dr2), .final_data_out(data_out2));

	DES des3	(.clk(clk), .n_rst(n_rst), .enable(dr2), .data_in(data_out2), .mode(mode), .r1_key(r1_01), .r2_key(r1_02), .r3_key(r1_03), .r4_key(r1_04), 
			.r5_key(r1_05), .r6_key(r1_06), .r7_key(r1_07), .r8_key(r1_08), .r9_key(r1_09), .r10_key(r1_10), .r11_key(r1_11), .r12_key(r1_12), 
			.r13_key(r1_13), .r14_key(r1_14), .r15_key(r1_15), .r16_key(r1_16), .data_ready(data_ready), .final_data_out(data_out));

endmodule 