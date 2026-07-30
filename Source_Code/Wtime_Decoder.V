module Wtime_Decoder (
    input wire [4:0] Wtime,
    output reg [7:0] Wtime_Decoded
);

always @(*) begin
  case(Wtime)
  5'd0:  Wtime_Decoded = 8'b0000_0000;
  5'd3:  Wtime_Decoded = 8'b0000_0011;
  5'd4:  Wtime_Decoded = 8'b0000_0100;
  5'd5:  Wtime_Decoded = 8'b0000_0101;
  5'd6:  Wtime_Decoded = 8'b0000_0110;
  5'd7:  Wtime_Decoded = 8'b0000_0111;
  5'd8:  Wtime_Decoded = 8'b0000_1000;
  5'd10: Wtime_Decoded = 8'b0001_0000;
  5'd12: Wtime_Decoded = 8'b0001_0010;
  5'd15: Wtime_Decoded = 8'b0001_0101;
  5'd18: Wtime_Decoded = 8'b0001_1000;
  5'd21: Wtime_Decoded = 8'b0010_0001;
  default: Wtime_Decoded = 8'b0000_0000;
  endcase
end
endmodule