module out_buffer
(
  input clk,
  input n_rst,
  input [63:0] data_in,
  input data_in_ready,
  input output_data,
  input clear,
  output reg [31:0] data_out,
  output reg [3:0] count
);

  reg [7:0] [31:0] buff_data;
  reg [7:0] [31:0] next_buff_data;
  reg [3:0] next_count;
  integer i;

  always_ff @ (negedge n_rst, posedge clk)
  begin
    if(1'b0 == n_rst)
    begin
      buff_data <= 0;
      count <= 0;
      data_out <= 0;
    end
    else
    begin
      buff_data <= next_buff_data;
      count <= next_count;
      data_out <= buff_data[0];
    end
  end

  always_comb
  begin
    next_count = count;
    next_buff_data = buff_data;
    if(!data_in_ready && !output_data) 
    begin
      next_count = count;
      next_buff_data = buff_data;
    end
    else if(data_in_ready && !output_data)
    begin
      next_count = count + 2;
      for(i = 0; i < 8; i = i + 1)
      begin
        if(i == count)
	begin
	  next_buff_data[i] = data_in[31:0];
	end
	else if(i == count + 1)
	begin
	  next_buff_data[i] = data_in[63:32];
	end
      end
    end
    else if(!data_in_ready && output_data)
    begin
      next_count = count - 1;
      for(i = 0; i < 8; i = i + 1)
      begin
        if(i < count - 1)
	begin
	  next_buff_data[i] = buff_data[i+1];
	end
      end
    end
    else
    begin
      next_count = count + 1;
      for(i = 0; i < 8; i = i + 1)
      begin
        if(i < count - 1)
	begin
	  next_buff_data[i] = buff_data[i+1];
	end
        else if(i == count - 1)
	begin
	  next_buff_data[i] = data_in[31:0];
	end 
	else if(i == count)
	begin
	  next_buff_data[i] = data_in[63:32];
	end 
      end
    end
    if(clear)
    begin
      next_count = 0;
    end
  end

endmodule
