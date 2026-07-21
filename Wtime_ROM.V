module Wtime_ROM (
    input wire [2:0] Pcount,
    input wire [1:0] Tcount,
    output wire [4:0] Wtime
);
reg [4:0] wtime_rom [0:31];

initial begin
  //{Pcount, Tcount}
  //Pcount = 0; Wtime = 0
  wtime_rom[5'b000_01] = 5'd0;
  wtime_rom[5'b000_10] = 5'd0;
  wtime_rom[5'b000_11] = 5'd0;
  //Tcount = 1; Pcount [1,7]
  wtime_rom[5'b001_01] = 5'd3;
  wtime_rom[5'b010_01] = 5'd6;
  wtime_rom[5'b011_01] = 5'd9;
  wtime_rom[5'b100_01] = 5'd12;
  wtime_rom[5'b101_01] = 5'd15;
  wtime_rom[5'b110_01] = 5'd18;
  wtime_rom[5'b111_01] = 5'd21;
  //Tcount = 2; Pcount[1,7]
  wtime_rom[5'b001_10] = 5'd3;
  wtime_rom[5'b010_10] = 5'd4;
  wtime_rom[5'b011_10] = 5'd6;
  wtime_rom[5'b100_10] = 5'd7;
  wtime_rom[5'b101_10] = 5'd9;
  wtime_rom[5'b110_10] = 5'd10;
  wtime_rom[5'b111_10] = 5'd12;
  //Tcount = 3; Pcount[1, 7]
  wtime_rom[5'b001_11] = 5'd3;
  wtime_rom[5'b010_11] = 5'd4;
  wtime_rom[5'b011_11] = 5'd5;
  wtime_rom[5'b100_11] = 5'd6;
  wtime_rom[5'b101_11] = 5'd7;
  wtime_rom[5'b110_11] = 5'd8;
  wtime_rom[5'b111_11] = 5'd9;
end

assign Wtime = wtime_rom[{Pcount, Tcount}];

endmodule