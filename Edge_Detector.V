module D_ff (
    input wire clk, rst, D,
    output reg Q
);

always @(posedge clk or negedge rst) begin
  if(!rst) 
    Q <= 1'b0;
  else 
    Q <= D;
end
endmodule

module Edge_Detector (
    input wire SYNCIN, clk, rst,
    output wire Edge_Out
);

wire Q_wire;

D_ff D_ff0 (.clk(clk), .rst(rst),
            .D(SYNCIN), .Q(Q_wire));

assign Edge_Out = ~SYNCIN & Q_wire;

endmodule