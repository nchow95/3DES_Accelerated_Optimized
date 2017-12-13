module mcu
(
  input clk,
  input n_rst,
  input [2:0]mode,
  output reg shift_out,
  output reg shift_in,
  output reg [2:0] mode3DES,
  output reg [3:0] count_in,
  output reg in_clear,
  output reg out_clear
);

  reg [3:0] next_count_in;
  reg [2:0] next_mode3DES;
  reg next_in_clear;
  reg next_out_clear;

  always_ff @ (negedge n_rst, posedge clk)
  begin
    if(1'b0 == n_rst)
    begin
      in_clear <= 0;
      out_clear <= 0;
      count_in <= 0;
      mode3DES <= 0;
    end
    else
    begin
      in_clear <= next_in_clear;
      out_clear <= next_out_clear;
      count_in <= next_count_in;
      mode3DES <= next_mode3DES;
    end
  end

  always_comb
  begin
    shift_in = 0;
    shift_out = 0;
    next_mode3DES = mode3DES;
    next_count_in = count_in;
    next_in_clear = 0;
    next_out_clear = 0;
    if(mode == 1)
    begin
      if(count_in != 8)
      begin
        next_mode3DES = 0;
        shift_in = 1;
        next_count_in = count_in + 1;
      end
    end
    else if(mode == 2)
    begin
      if(count_in != 8)
      begin
        next_mode3DES = 1;
        shift_in = 1;
        next_count_in = count_in + 1;
      end
    end 
    else if(mode == 3)
    begin
      next_mode3DES = 2;
      shift_in = 1;
    end 
    else if(mode == 4)
    begin
      next_mode3DES = 3;
      shift_in = 1;
    end 
    else if(mode == 5)
    begin
      next_mode3DES = 4;
      next_count_in = 0;
      next_in_clear = 1;
      next_out_clear = 1;
    end 
    else if(mode == 6)
    begin
      shift_out = 1;
      next_count_in = count_in - 1;
    end
  end

endmodule
