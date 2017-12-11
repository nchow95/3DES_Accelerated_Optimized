module s4(input wire[5:0] in_6bit, output wire[3:0] out_4bit);

	reg[1:0] row;
	reg[3:0] col, out;

	always_comb begin
		row = {in_6bit[5], in_6bit[0]};
		col = in_6bit[4:1];	
		out = 4'b0000;	//0
		if(((row==2'b00)&(col==4'b1000))||((row==2'b01)&(col==4'b1100))||((row==2'b10)&(col==4'b1001))||((row==2'b11)&(col==4'b0101)))		//1
			out = 4'b0001;
		else if(((row==2'b00)&(col==4'b1001))||((row==2'b01)&(col==4'b1010))||((row==2'b10)&(col==4'b1101))||((row==2'b11)&(col==4'b1110)))	//2
			out = 4'b0010;
		else if(((row==2'b00)&(col==4'b0011))||((row==2'b01)&(col==4'b0111))||((row==2'b10)&(col==4'b1010))||((row==2'b11)&(col==4'b0000)))	//3
			out = 4'b0011;
		else if(((row==2'b00)&(col==4'b1110))||((row==2'b01)&(col==4'b1000))||((row==2'b10)&(col==4'b1111))||((row==2'b11)&(col==4'b1001)))	//4
			out = 4'b0100;
		else if(((row==2'b00)&(col==4'b1011))||((row==2'b01)&(col==4'b0011))||((row==2'b10)&(col==4'b1100))||((row==2'b11)&(col==4'b1010)))	//5
			out = 4'b0101;
		else if(((row==2'b00)&(col==4'b0101))||((row==2'b01)&(col==4'b0100))||((row==2'b10)&(col==4'b0001))||((row==2'b11)&(col==4'b0011)))	//6
			out = 4'b0110;
		else if(((row==2'b00)&(col==4'b0000))||((row==2'b01)&(col==4'b1001))||((row==2'b10)&(col==4'b0110))||((row==2'b11)&(col==4'b1101)))	//7
			out = 4'b0111;
		else if(((row==2'b00)&(col==4'b1010))||((row==2'b01)&(col==4'b0001))||((row==2'b10)&(col==4'b1110))||((row==2'b11)&(col==4'b0111)))	//8
			out = 4'b1000;
		else if(((row==2'b00)&(col==4'b0110))||((row==2'b01)&(col==4'b1111))||((row==2'b10)&(col==4'b0010))||((row==2'b11)&(col==4'b1000)))	//9
			out = 4'b1001;
		else if(((row==2'b00)&(col==4'b0111))||((row==2'b01)&(col==4'b1101))||((row==2'b10)&(col==4'b0000))||((row==2'b11)&(col==4'b0100)))	//10
			out = 4'b1010;
		else if(((row==2'b00)&(col==4'b1100))||((row==2'b01)&(col==4'b0010))||((row==2'b10)&(col==4'b0101))||((row==2'b11)&(col==4'b1011)))	//11
			out = 4'b1011;
		else if(((row==2'b00)&(col==4'b1101))||((row==2'b01)&(col==4'b1011))||((row==2'b10)&(col==4'b0100))||((row==2'b11)&(col==4'b1100)))	//12
			out = 4'b1100;
		else if(((row==2'b00)&(col==4'b0001))||((row==2'b01)&(col==4'b0000))||((row==2'b10)&(col==4'b0111))||((row==2'b11)&(col==4'b0110)))	//13
			out = 4'b1101;
		else if(((row==2'b00)&(col==4'b0010))||((row==2'b01)&(col==4'b1110))||((row==2'b10)&(col==4'b1011))||((row==2'b11)&(col==4'b1111)))	//14
			out = 4'b1110;
		else if(((row==2'b00)&(col==4'b1111))||((row==2'b01)&(col==4'b0101))||((row==2'b10)&(col==4'b1000))||((row==2'b11)&(col==4'b0001)))	//15
			out = 4'b1111;
	end
	assign out_4bit = out;
endmodule