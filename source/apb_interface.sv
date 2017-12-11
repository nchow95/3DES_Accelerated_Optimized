module apb_interface
(
  input clk,
  input n_rst,
  input [2:0] PADDR,
  input PSEL,
  input PWRITE,
  input [3:0] data_in_cnt,
  input [3:0] data_out_cnt,
  input [31:0] data_out,
  output reg [31:0] PRDATA,
  output reg PSLVERR,
  output reg [2:0] mode
);

  typedef enum bit [4:0] {IDLE, CHECK_OUT, CHECK_IN,
	ENCDEC, KEY_CHANGE, RESET, READ_MODE, NO_DATA,
	IN_FULL, KC_ENABLE,
	KEY_CHANGE2, KC_2ENABLE, _2KEY_CHANGE, _2KC_ENABLE, _2KEY_CHANGE2}		stateType;
  stateType state;
  stateType nxt_state;

  always_ff @ (negedge n_rst, posedge clk)
  begin
    if(1'b0 == n_rst)
      state <= IDLE;
    else
      state <= nxt_state;
  end

  always_comb
  begin
    nxt_state = state;
    case(state)
    IDLE:
    begin
      if(PSEL && (PADDR == 0 || PADDR == 1) && PWRITE && data_in_cnt != 8)
	nxt_state = ENCDEC;
      else if(PSEL && (PADDR == 0 || PADDR == 1) && PWRITE && data_in_cnt == 8)
	nxt_state = IN_FULL;
      else if(PSEL && PADDR == 2 && PWRITE)
	nxt_state = KEY_CHANGE;
      else if(PSEL && PADDR == 3 && PWRITE)
	nxt_state = RESET;
      else if(PSEL && PADDR == 4 && !PWRITE && data_out_cnt != 0)
	nxt_state = READ_MODE;
      else if(PSEL && PADDR == 4 && !PWRITE && data_out_cnt == 0)
	nxt_state = NO_DATA;
      else if(PSEL && PADDR == 5 && !PWRITE)
	nxt_state = CHECK_IN;
      else if(PSEL && PADDR == 6 && !PWRITE)
	nxt_state = CHECK_OUT;
    end
    ENCDEC:
    begin
      nxt_state = IDLE;
    end
    KEY_CHANGE:
    begin
      nxt_state = KC_ENABLE;
    end
    RESET:
    begin
      nxt_state = IDLE;
    end
    READ_MODE:
    begin
      nxt_state = IDLE;
    end
    NO_DATA:
    begin
      nxt_state = IDLE;
    end
    CHECK_IN:
    begin
      nxt_state = IDLE;
    end
    CHECK_OUT:
    begin
      nxt_state = IDLE;
    end
    KC_ENABLE:
    begin
      if(PSEL && PADDR == 2 && PWRITE)
	nxt_state = KEY_CHANGE2;
    end
    KEY_CHANGE2:
    begin
      nxt_state = KC_2ENABLE;
    end
    IN_FULL:
    begin
      nxt_state = IDLE;
    end
    KC_2ENABLE:
    begin
      if(PSEL && PADDR == 2 && PWRITE)
	nxt_state = _2KEY_CHANGE;
    end
    _2KEY_CHANGE:
    begin
      nxt_state = _2KC_ENABLE;
    end
    _2KC_ENABLE:
    begin
      if(PSEL && PADDR == 2 && PWRITE)
	nxt_state = _2KEY_CHANGE2;
    end
    _2KEY_CHANGE2:
    begin
      nxt_state = IDLE;
    end
    endcase
  end

  always_comb
  begin
    PRDATA = 0;
    PSLVERR = 0;
    mode = 0; 
    case(state)
    IDLE:
    begin
      mode = 0; 
    end
    ENCDEC:
    begin
      if(PADDR == 0)
	mode = 1;
      else
	mode = 2;
    end
    KEY_CHANGE:
    begin
      mode = 3;
    end
    KEY_CHANGE2:
    begin
      mode = 3;
    end
    RESET:
    begin
      mode = 5;
    end
    READ_MODE:
    begin
      mode = 6;
      PRDATA=data_out;
    end
    NO_DATA:
    begin
      mode = 0;
      PSLVERR = 1;
    end
    _2KEY_CHANGE:
    begin
      mode = 4;
    end
    _2KEY_CHANGE2:
    begin
      mode = 4;
    end
    IN_FULL:
    begin
      PSLVERR = 1;
    end
    CHECK_IN:
    begin
      PRDATA = {28'b0, data_in_cnt};
    end
    CHECK_OUT:
    begin
      PRDATA = {28'b0, data_out_cnt};
    end
    endcase
  end
endmodule
