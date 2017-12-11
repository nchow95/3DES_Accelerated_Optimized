module accelerator
(
  input PCLK,
  input PRESETn,
  input [2:0] PADDR,
  input PSEL,
  input PENABLE,
  input PWRITE,
  input [31:0] PWDATA,
  output reg PREADY,
  output reg [31:0] PRDATA,
  output PSLVERR
);

  reg [3:0] data_in_cnt;
  reg [3:0] data_out_cnt;
  reg [31:0] data_out;
  reg [2:0] mode;
  reg data_out_ready;
  reg shift_out;
  reg shift_in;
  reg [2:0] mode3DES;
  reg [63:0] _3DES_input_data;
  reg _3DES_input_ready;
  reg [63:0] _3DES_output_data;
  reg _3DES_output_ready;
  reg in_clear;
  reg out_clear;

  assign PREADY = 1;
  apb_interface APB (PCLK, PRESETn, PADDR, PSEL, PWRITE, data_in_cnt,
	data_out_cnt, data_out, PRDATA, PSLVERR, mode);
  mcu MCU (PCLK, PRESETn, mode, shift_out, shift_in, mode3DES,
	data_in_cnt, in_clear, out_clear);
  in_buffer INBUFF (PCLK, PRESETn, PWDATA, shift_in, in_clear, _3DES_input_data,
	_3DES_input_ready);
  out_buffer OUTBUFF (PCLK, PRESETn, _3DES_output_data, _3DES_output_ready,
	shift_out, out_clear, data_out, data_out_cnt);
  Triple_DES_Top PIPE_TOP (PCLK, PRESETn, _3DES_input_ready, mode3DES,
	_3DES_input_data, _3DES_output_ready, _3DES_output_data);

endmodule
