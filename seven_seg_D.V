module seven_seg_D (
    input wire [3:0] In_Decoder,
    output reg [6:0] Out_Decoder
);

always @(*) begin
  case(In_Decoder)
  4'b0000: Out_Decoder = 7'b111_1110;
  4'b0001: Out_Decoder = 7'b011_0000;
  4'b0010: Out_Decoder = 7'b110_1101;
  4'b0011: Out_Decoder = 7'b111_1001;
  4'b0100: Out_Decoder = 7'b011_0011;
  4'b0101: Out_Decoder = 7'b101_1011;
  4'b0110: Out_Decoder = 7'b101_1111;
  4'b0111: Out_Decoder = 7'b111_0000;
  4'b1000: Out_Decoder = 7'b111_1111;
  4'b1001: Out_Decoder = 7'b111_1011;
  default: Out_Decoder = 7'b111_1110;
  endcase
end
endmodule
