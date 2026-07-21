module Top (
    input wire clk, rst,
    input wire [1:0] Tcount,
    input wire B_CELL, F_CELL,
    output wire [6:0] Pcount_D,
    output wire [6:0] Wtime_D0,
    output wire [6:0] Wtime_D1,
    output wire FULL_FLAG,
    output wire EMPTY_FLAG,
    output wire FULL_ALARM,
    output wire EMPTY_ALARM
);

//FSM input/output wires
wire f_cell_event, b_cell_event;
wire up_dn, En;
//Counter output wires
wire [2:0] Pcount;
//Wtim ROM output wire
wire [4:0] Wtime;
//Wtime Decoder wires
wire [3:0] ones_wire, tenths_wire;
 
//Edge Detector Integration
Edge_Detector Edge_Detector_B_cell (.SYNCIN(B_CELL), 
                                    .clk(clk),
                                    .rst(rst),
                                    .Edge_Out(b_cell_event));

Edge_Detector Edge_Detector_f_cell (.SYNCIN(F_CELL), 
                                    .clk(clk),
                                    .rst(rst),
                                    .Edge_Out(f_cell_event)); 

//FSM Integration
FSM_Controller FSM (.clk(clk), .rst(rst),
                    .b_cell_event(b_cell_event), .f_cell_event(f_cell_event),
                    .b_cell(B_CELL), .f_cell(F_CELL),
                    .Pcount(Pcount), .up_dn(up_dn),
                    .En(En), .full_flag(FULL_FLAG),
                    .empty_flag(EMPTY_FLAG),
                    .full_alarm(FULL_ALARM),
                    .empty_alarm(EMPTY_ALARM));     

//Counter Integration   
Up_Dn_cnt Up_Dn_cnt (.clk(clk), .rst(rst),
                     .up_dn(up_dn), .En(En),
                     .Pcount(Pcount));

//ROM Integration    
Wtime_ROM Wtime_ROM (.Pcount(Pcount), .Tcount(Tcount), .Wtime(Wtime));

//Wtime Decoder Integration
Wtime_Decoder Wtime_Decoder (.Wtime(Wtime), 
                             .Wtime_Decoded({tenths_wire, ones_wire}));

//Seven Segments Decoders Integration
seven_seg_D Pcount_Decoder (.In_Decoder({1'b0, Pcount}),
                            .Out_Decoder(Pcount_D));

seven_seg_D Wtime_ones_Decoder (.In_Decoder(ones_wire),
                                .Out_Decoder(Wtime_D0));

seven_seg_D Wtime_tenths_Decoder (.In_Decoder(tenths_wire),
                                  .Out_Decoder(Wtime_D1));

endmodule