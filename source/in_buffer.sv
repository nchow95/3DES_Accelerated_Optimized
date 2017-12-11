module in_buffer
(
  input clk,
  input n_rst,
  input [31:0] data_in,
  input input_data_ready,
  input clear,
  output reg [63:0] data_out,
  output reg output_data_ready
);

  reg block_number;
  reg next_block_number;
  reg next_data_ready;
  reg [63:0] next_data_out;

  always_ff @ (negedge n_rst, posedge clk)
  begin
    if(1'b0 == n_rst)
    begin
      output_data_ready <= 0;
      data_out <= 0;
      block_number <= 0;
    end
    else
    begin
      output_data_ready <= next_data_ready;
      data_out <= next_data_out;	
      block_number <= next_block_number;
    end
  end

  always_comb
  begin
    next_data_out = data_out;
    next_data_ready = 0;
    next_block_number = block_number;
    if(input_data_ready)
    begin
      if(block_number == 0)
      begin
        next_block_number = 1;
        next_data_out[31:0] = data_in;
      end
      else
      begin
        next_block_number = 0;
        next_data_out[63:32] = data_in;
        next_data_ready = 1;
      end
    end
    if(clear)
    begin
      next_block_number = 0;
      next_data_ready = 0;
    end
  end

endmodule
