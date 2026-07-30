module FSM_Controller (
    input wire clk, rst,
    input wire b_cell_event, f_cell_event,
    input wire b_cell, f_cell,
    input wire [2:0] Pcount,
    output wire up_dn, En,
    output reg full_flag, empty_flag,
    output reg full_alarm, empty_alarm
);

localparam IDLE =   3'b000,
           CNT_UP = 3'b001,
           CNT_DN = 3'b010,
           EMP_AL = 3'b011,
           FUL_AL = 3'b100,
           NO_CHA = 3'b101;
// Mixed Design
reg [2:0] state, next_state;

//next_state Logic
always @(*) begin
  case(state)
  IDLE: begin
    if((b_cell_event == f_cell_event) && (Pcount == 3'd0 || Pcount == 3'd7)) begin
      next_state = IDLE;
    end
    else if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount != 3'd7) begin
      next_state = CNT_UP;
    end
    else if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount != 3'd0) begin
      next_state = CNT_DN;
    end
    else if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount == 3'd0) begin
      next_state = EMP_AL;
    end
    else if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount == 3'd7) begin
      next_state = FUL_AL;
    end
  end
  CNT_UP: begin
    if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount != 3'd7) begin
      next_state = CNT_UP;
    end
    else if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount != 3'd0) begin
      next_state = CNT_DN;
    end
    else if((b_cell_event == f_cell_event) && (Pcount == 3'd7)) begin
      next_state = IDLE;
    end
    else if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount == 3'd7) begin
      next_state = FUL_AL;
    end
    else if((b_cell_event == f_cell_event) && (Pcount != 3'd7)) begin
      next_state = NO_CHA;
    end
  end
  CNT_DN: begin
    if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount != 3'd0) begin
      next_state = CNT_DN;
    end
    else if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount != 3'd7) begin
      next_state = CNT_UP;
    end
    else if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount == 3'd0) begin
      next_state = EMP_AL;
    end
    else if((b_cell_event == f_cell_event) && (Pcount != 3'd0)) begin
      next_state = NO_CHA;
    end
    else if((b_cell_event == f_cell_event) && (Pcount == 3'd0)) begin
      next_state = IDLE;
    end
  end
  EMP_AL: begin
    if(b_cell == 1'b1 && f_cell == 1'b0 && Pcount == 3'd0) begin
      next_state = EMP_AL;
    end
    else if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount != 3'd7) begin
      next_state = CNT_UP;
    end
    else if((b_cell_event == f_cell_event) && (Pcount == 3'd0)) begin
      next_state = IDLE;
    end
  end
  FUL_AL: begin
    if(b_cell == 1'b0 && f_cell == 1'b1 && Pcount == 3'd7) begin
      next_state = FUL_AL;
    end
    else if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount != 3'd0) begin
      next_state = CNT_DN;
    end
    else if((b_cell_event == f_cell_event) && (Pcount == 3'd7)) begin
      next_state = IDLE;
    end
  end
  NO_CHA: begin
     if((f_cell_event == b_cell_event) && (Pcount != 3'd0 && Pcount != 3'd7)) begin
       next_state = NO_CHA;
     end
     else if(b_cell_event == 1'b1 && f_cell_event == 1'b0 && Pcount != 3'd7) begin
       next_state = CNT_UP;
     end
     else if(b_cell_event == 1'b0 && f_cell_event == 1'b1 && Pcount != 3'd0) begin
       next_state = CNT_DN;
     end
   end
  default: next_state = IDLE;
  endcase
end

// State Registers
always @(posedge clk or negedge rst) begin
  if(!rst) begin
    state <= IDLE;
  end
  else begin
    state <= next_state;
  end
end

// output logic -- MOORE/Mealy (Mixed) MACHINE
always @(*) begin
  case(state)
  IDLE: begin
    if(Pcount == 3'd7) begin
      full_flag = 1'b1;
      empty_flag = 1'b0;
      full_alarm = 1'b0;
      empty_alarm = 1'b0;
    end
    else if(Pcount == 3'd0) begin
      full_flag = 1'b0;
      empty_flag = 1'b1;
      full_alarm = 1'b0;
      empty_alarm = 1'b0;
    end
  end
  CNT_UP: begin
    full_flag = 1'b0;
    empty_flag = 1'b0;
    full_alarm = 1'b0;
    empty_alarm = 1'b0;
  end
  CNT_DN: begin
    full_flag = 1'b0;
    empty_flag = 1'b0;
    full_alarm = 1'b0;
    empty_alarm = 1'b0;
  end
  EMP_AL:begin
  full_flag = 1'b0;
  empty_flag = 1'b1;
  full_alarm = 1'b0;
  empty_alarm = 1'b1;
  end
  FUL_AL: begin
    full_flag = 1'b1;
    empty_flag = 1'b0;
    full_alarm = 1'b1;
    empty_alarm = 1'b0;
  end
  NO_CHA: begin
    full_flag = 1'b0;
    empty_flag = 1'b0;
    full_alarm = 1'b0;
    empty_alarm = 1'b0;
  end
  endcase
end

//Eenable and up_dn combinational signals
assign En =
       (b_cell_event && !f_cell_event && (Pcount != 3'd7))
    || (!b_cell_event && f_cell_event && (Pcount != 3'd0));

assign up_dn =
       (b_cell_event && !f_cell_event && (Pcount != 3'd7)) ? 1'b1 :
       (!b_cell_event && f_cell_event && (Pcount != 3'd0)) ? 1'b0 :
                                                 1'b0;
endmodule