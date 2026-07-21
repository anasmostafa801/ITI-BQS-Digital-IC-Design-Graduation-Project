module Up_Dn_cnt (
    input wire clk, rst,
    input wire up_dn, En,
    output reg [2:0] Pcount
);

always @(posedge clk or negedge rst) begin
  if(!rst) begin
    Pcount <= 3'b0;
  end
  else if(En) 
  case(up_dn)
  1'b1: begin
    Pcount <= Pcount + 1'b1;
  end
  1'b0: begin
    Pcount <= Pcount - 1'b1;
  end
  endcase
end
endmodule
