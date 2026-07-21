`timescale 1ms/1us

module dut_tb;
reg clk = 0, rst = 1;
reg [1:0] Tcount;
reg F_CELL, B_CELL;
wire [6:0] Pcount_D;
wire [6:0] Wtime_D0, Wtime_D1;
wire FULL_FLAG, EMPTY_FLAG;
wire FULL_ALARM, EMPTY_ALARM;

Top ITI_BQS (.clk(clk), .rst(rst), .Tcount(Tcount),
                    .F_CELL(F_CELL), .B_CELL(B_CELL),
                    .Pcount_D(Pcount_D), .Wtime_D0(Wtime_D0),
                    .Wtime_D1(Wtime_D1), .FULL_FLAG(FULL_FLAG),
                    .EMPTY_FLAG(EMPTY_FLAG), .FULL_ALARM(FULL_ALARM),
                    .EMPTY_ALARM(EMPTY_ALARM));

always #0.5 clk = ~clk;


initial begin
// 1 - Resetting the System -> Takes me to IDLE State
#10 rst = 0;
#90 rst = 1; 
//--------------------------------------------------------------

// IF No one Either Enters or Leaves , Should Stay at IDLE STATE
Tcount = 2'b1;
B_CELL = 1'b1; F_CELL = 1'b1; #10000; //PhotoCells are ShortCircuited for 10 sec
//--------------------------------------------------------------

// Some People Enter the Queue -> Moving to CNT_UP State and FUL_AL State
Tcount = 2'd2;
F_CELL = 1'b1; // No one is leaving the Queue
repeat(20) begin //Testing CNT_UP and FUL_AL
  B_CELL = 1'b0;
  #100; //Every Person take 0.1Sec on average to cross the Back Cell
  B_CELL = 1'b1;
  #2000; // B_CELL goes back to one for 2sec before some body else tries to Enter the Queue
end
//--------------------------------------------------------------

//Some Peole Leave The queue -> Moving to CNT_DN State & Testing EMPTY_AL State
Tcount = 2'd3;
B_CELL = 1'b1; // Back Cell is short Circuited no one is Entering
repeat(20) begin // Tesing CNT_DN and EMP_AL
  F_CELL = 1'b0;
  #100 //Every person takes 0.1sec on average to exit the Queue
  F_CELL = 1'b1;
  #2000; // F_CELL goes back short circuited for 2 seconds before somebody else exits the Queue
end
//---------------------------------------------------------------

//Go back to IDLE for 10sec
B_CELL = 1'b1; F_CELL = 1'b1; #10000;
//----------------------------------------------------------------

//Go to CNT_UP and then to NO_CHA STATE
Tcount = 2'd3;
repeat(3) begin
    B_CELL = 1'b0;
    #100;
    B_CELL = 1'b1;
    #1000;
end
B_CELL = 1'b1; F_CELL = 1'b1; #1000; // People Entering == People Leaving
B_CELL = 1'b0; F_CELL = 1'b1; #1000; // No pelpe Enter or Leave
//-----------------------------------------------------------------

//Randomizing
repeat(30) begin
  B_CELL = $urandom_range(1, 0); F_CELL = $urandom_range(1, 0);
  #300;
end
repeat(5) begin
   Tcount = $urandom_range(3, 1);
   #1800;
end
$stop;
end

initial begin
$timeformat(0, 1, " s", 6);
$monitor("rst = %b, Tellers = %d, People = %d, Wtime = %d, Full_Flag = %b, Empty_Flag = %b, Full_Alarm = %b, Empty_Alarm = %b, time = %0t",
          rst,      Tcount,   ITI_BQS.Pcount,  ITI_BQS.Wtime, FULL_FLAG,   EMPTY_FLAG,      FULL_ALARM,       EMPTY_ALARM,     $time);
end

endmodule