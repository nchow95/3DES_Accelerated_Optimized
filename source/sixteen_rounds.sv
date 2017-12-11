module sixteen_rounds(input wire clk, n_rst, enable, input wire[2:0] mode, input wire[63:0] data_block, input wire[767:0] round_keys, output wire data_ready, output wire[63:0] data_out);

	wire[47:0] round_key1, round_key2, round_key3, round_key4;
	wire[47:0] exp_to_box1, exp_to_box2, exp_to_box3, exp_to_box4;
	wire[1:0] count;
	wire[31:0] box_out1, box_out2, box_out3, box_out4, right_bus, left_bus;
	wire count_enable;
	wire clear;
	wire rollover_flag;
	reg[31:0] right_block, left_block;
	
	assign clear = (mode == 3'b100);
	flex_counter timer(.clk(clk), .n_rst(n_rst), .count_enable(enable), .clear(clear), .rollover_val(2'd3), .rollover_flag(rollover_flag), .count_out(count));
	key_handler key_cont(.count(count), .round_keys(round_keys), .round_key1(round_key1), .round_key2(round_key2), .round_key3(round_key3), .round_key4(round_key4));
	assign left_bus = (enable == 1'b1 && count == 2'b00) ? data_block[63:32] :  left_block;
	assign right_bus = (enable == 1'b1 && count == 2'b00) ? data_block[31:0] :  right_block;
	
	exp_per expand_block1(.key(round_key1), .data_in(right_bus), .data_out(exp_to_box1));
	box box_block1(.in_48bit(exp_to_box1), .left_block(left_bus), .out_32bit(box_out1));

	exp_per expand_block2(.key(round_key2), .data_in(box_out1), .data_out(exp_to_box2));
	box box_block2(.in_48bit(exp_to_box2), .left_block(right_bus), .out_32bit(box_out2));

	exp_per expand_block3(.key(round_key3), .data_in(box_out2), .data_out(exp_to_box3));
	box box_block3(.in_48bit(exp_to_box3), .left_block(box_out1), .out_32bit(box_out3));

	exp_per expand_block4(.key(round_key4), .data_in(box_out3), .data_out(exp_to_box4));
	box box_block4(.in_48bit(exp_to_box4), .left_block(box_out2), .out_32bit(box_out4));

	round_controller cont(.clk(clk), .n_rst(n_rst), .clear(clear), .data_in({box_out3, box_out4}), .left_block(left_block), .right_block(right_block));
	
	assign data_out = ( rollover_flag == 1'b1) ? {left_block, right_block} : 64'd0; 
	assign data_ready = rollover_flag;

endmodule 