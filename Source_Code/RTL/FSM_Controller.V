module FSM_Controller (
    input wire clk, rst,
    input wire b_cell_event, f_cell_event,
    input wire [2:0] Pcount,
    output reg up_dn, En,
    output reg full_flag, empty_flag,
    output reg full_alarm, empty_alarm
);

localparam Empty = 2'b00,
           Count = 2'b01,
           Full  = 2'b10;

reg [1:0] state, next_state;

// next_state logic
always @(*) begin
    
    empty_flag = 0;
    empty_alarm = 0;
    full_flag = 0;
    full_alarm = 0;
    En = 0;
    up_dn = 0;

    case(state)

    Empty : begin
        empty_flag = 1;

        if(f_cell_event) begin
            next_state  = Empty;
            empty_alarm = 1; 
        end

        else if(b_cell_event) begin
            En = 1;
            up_dn = 1;
            next_state = Count;
        end

    end

    Count : begin
        En = 1;

        if(b_cell_event && (Pcount < 3'd7)) begin
            up_dn = 1;
            next_state = Count;    
        end

        else if(f_cell_event && (Pcount > 3'd0)) begin
            up_dn = 0;
            next_state = Count;
        end
        
        else if(Pcount == 3'd7) begin
            En = 0;
            next_state = Full;
        end

        else if(Pcount == 3'd0) begin
            En = 0;
            next_state = Empty;
        end

        else begin
            En = 0;
            next_state = Count;
        end

    end

    Full : begin
        full_flag = 1;

        if(b_cell_event && (Pcount == 3'd7)) begin
            full_alarm = 1;
            next_state = Full;
        end

        else if(f_cell_event) begin
            En = 1;
            up_dn = 0;
            next_state = Count;
        end

    end

    default : next_state = Empty;

    endcase
end


always @(posedge clk or negedge rst) begin
    if(!rst) begin
        state <= Empty;
    end
    else begin
        state <= next_state;   
    end
end

endmodule