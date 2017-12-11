module Triple_DES_Top(input wire clk, n_rst, enable, input wire[2:0] mode, input wire[63:0] data_in, output wire data_ready, output wire[63:0] data_out);

	wire enable_key1;
	wire enable_key2;
	wire enable_block;
	wire DES_data_ready;
	wire[63:0] DES_data_out;
	wire[63:0] key1, key2;

	assign enable_key1 = (mode == 3'b010) ? enable : 0;
	assign enable_key2 = (mode == 3'b011) ? enable : 0;
	assign enable_block = (mode == 3'b100 | mode == 3'b001 | mode == 3'b000) ? enable: 0;
	key_storage k1 (.clk(clk), .n_rst(n_rst), .enable(enable_key1), .in_key(data_in), .key_registers(key1));
	key_storage k2 (.clk(clk), .n_rst(n_rst), .enable(enable_key2), .in_key(data_in), .key_registers(key2));
	Triple_DES DUT(.clk(clk), .n_rst(n_rst), .key1(key1), .key2(key2), .mode(mode), .enable(enable_block), .data_in(data_in), .data_ready(DES_data_ready), .data_out(DES_data_out));
	assign data_ready = DES_data_ready;
	assign data_out = {DES_data_out[31:0],DES_data_out[63:32]};
endmodule
