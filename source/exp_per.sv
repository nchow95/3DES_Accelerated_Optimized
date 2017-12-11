module exp_per(input wire[47:0] key, input wire[31:0] data_in, output wire[47:0] data_out);

	wire[47:0] xor_val;
	
	assign xor_val[47:40] = {data_in[0],  data_in[31], data_in[30], data_in[29], data_in[28], data_in[27], data_in[28], data_in[27] }; 
	assign xor_val[39:32] = {data_in[26], data_in[25], data_in[24], data_in[23], data_in[24], data_in[23], data_in[22], data_in[21]};
	assign xor_val[31:24] = {data_in[20], data_in[19], data_in[20], data_in[19], data_in[18], data_in[17], data_in[16], data_in[15]}; 
	assign xor_val[23:16] = {data_in[16], data_in[15], data_in[14], data_in[13], data_in[12], data_in[11], data_in[12], data_in[11]};
	assign xor_val[15:8]  = {data_in[10], data_in[9], data_in[8],   data_in[7],  data_in[8],  data_in[7],  data_in[6],  data_in[5]};
	assign xor_val[7:0]   = {data_in[4],  data_in[3], data_in[4],   data_in[3],  data_in[2],  data_in[1],  data_in[0],  data_in[31]};
	
	assign data_out = xor_val ^ key;
endmodule
