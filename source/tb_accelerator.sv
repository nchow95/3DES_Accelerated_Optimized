`timescale 1ns / 100ps
module tb_accelerator();

	localparam CLK_PERIOD = 10;
	localparam CLK_DELAY = 2;
	reg tb_PCLK;
	reg [2:0] tb_PADDR;
	reg tb_PSEL;
	reg tb_PWRITE;
	reg [31:0] tb_PWDATA;
	reg tb_PREADY;
	reg [31:0] tb_PRDATA;
	reg tb_PSLVERR;
	reg tb_PENABLE;
	reg tb_PRESETn;
	reg[767:0] tb_text;
	string test;
	
	always
	begin : CLK_GEN
		tb_PCLK = 1'b0;
		#(CLK_PERIOD / 2.0);
		tb_PCLK = 1'b1;
		#(CLK_PERIOD / 2.0);
	end
	
	accelerator DUT(
		tb_PCLK,
		tb_PRESETn,
		tb_PADDR,
		tb_PSEL,
		tb_PENABLE,
		tb_PWRITE,
		tb_PWDATA,
		tb_PREADY,
		tb_PRDATA,
		tb_PSLVERR);

	initial begin
		tb_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisl ante, molestie et quam amet.";
		test = "RESET";
		tb_PRESETn = 0;
		tb_PSEL = 0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "KEY CHANGE1";
		tb_PRESETn = 1;
		tb_PADDR = 2;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = 32'b01100001011011100011000100110111;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 0;
		tb_PWDATA = 32'b01101110011000010111010001101000;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "KEY CHANGE2";
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = 32'b01101001011001010011000100111000;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 0;
		tb_PWDATA = 32'b01101010011001010111001101110011;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 1.1";
		tb_PADDR = 0;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = tb_text[735:704];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 1.2";
		tb_PENABLE = 0;
		tb_PWDATA = tb_text[767:736];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 2.1";
		tb_PADDR = 0;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = tb_text[671:640];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 2.2";
		tb_PENABLE = 0;
		tb_PWDATA = tb_text[703:672];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 3.1";
		tb_PADDR = 0;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = tb_text[607:576];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 3.2";
		tb_PENABLE = 0;
		tb_PWDATA = tb_text[639:608];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 4.1";
		tb_PADDR = 0;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = tb_text[543:512];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "ENCRYPTION BLOCK 4.2";
		tb_PENABLE = 0;
		tb_PWDATA = tb_text[575:544];
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "CHECK INPUT COUNT";
		tb_PADDR = 5;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "CHECK OUTPUT COUNT";
		tb_PADDR = 6;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "CHECK OUTPUT COUNT";
		tb_PADDR = 6;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		test = "BLOCK 1.1 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 1.2 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 2.1 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 2.2 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 3.1 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 3.2 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 4.1 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 4.2 ENCRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "READING EMPTY BUFFER";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 1.1";
		tb_PADDR = 1;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = 766199477;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 1.2";
		tb_PENABLE = 0;
		tb_PWDATA = 32'd1486300376;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 2.1";
		tb_PADDR = 1;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = 32'd1322138288;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 2.2";
		tb_PENABLE = 0;
		tb_PWDATA = 32'd668398162;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 3.1";
		tb_PADDR = 1;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = 32'd3737987807;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 3.2";
		tb_PENABLE = 0;
		tb_PWDATA = 32'd2435500546;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 4.1";
		tb_PADDR = 1;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 1;
		tb_PWDATA = 32'd3670739262;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "DECRYPTION BLOCK 4.2";
		tb_PENABLE = 0;
		tb_PWDATA = 32'd3361169811;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "CHECK INPUT COUNT";
		tb_PADDR = 5;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "CHECK OUTPUT COUNT";
		tb_PADDR = 6;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 1.1 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 1.2 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 2.1 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 2.2 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 3.1 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 3.2 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 4.1 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "BLOCK 4.2 DECRYPTED";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		test = "READING EMPTY BUFFER";
		tb_PADDR = 4;
		tb_PSEL = 1;
		tb_PENABLE = 0;
		tb_PWRITE = 0;
		tb_PWDATA = 32'd0;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PENABLE = 1;
		#(CLK_PERIOD);
		@(posedge tb_PCLK);
		tb_PSEL = 0;
	end
endmodule
