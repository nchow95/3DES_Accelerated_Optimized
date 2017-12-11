module DES (
	input wire clk, 
	input wire n_rst,
	input wire enable, 
	input wire[2:0] mode,
	input wire [63:0] data_in, 
	input wire [47:0] r1_key, r2_key, r3_key, r4_key, r5_key, r6_key, r7_key, r8_key, r9_key, r10_key, r11_key, r12_key, r13_key, r14_key, r15_key, r16_key,
	output wire data_ready,
	output wire [63:0] final_data_out
);	
		
		wire[63:0] first_data_out, second_data_out, third_data_out;
		wire enable2, enable3, enable4, busy1, busy2, busy3;
		 
		Four_Round_Processing R1 (.clk(clk), .n_rst(n_rst), .enable(enable), .mode(mode), .data_block(data_in), .round_keys({r1_key, r2_key, r3_key, r4_key}), .data_ready(enable2), .data_out(first_data_out));
		Four_Round_Processing R2 (.clk(clk), .n_rst(n_rst), .enable(enable2), .mode(mode), .data_block(first_data_out),  .round_keys({r5_key, r6_key, r7_key, r8_key}), .data_ready(enable3), .data_out(second_data_out));
		Four_Round_Processing R3 (.clk(clk), .n_rst(n_rst), .enable(enable3), .mode(mode), .data_block(second_data_out),  .round_keys({r9_key, r10_key, r11_key, r12_key}), .data_ready(enable4), .data_out(third_data_out));
		Four_Round_Processing R4 (.clk(clk), .n_rst(n_rst), .enable(enable4), .mode(mode), .data_block(third_data_out),   .round_keys({r13_key, r14_key, r15_key, r16_key}), .data_ready(data_ready), .data_out(final_data_out));
	
endmodule 
