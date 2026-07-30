vlib work
vlog *.v
vlog *.sv
vsim -voptargs=+acc dut_tb 
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -label {System Clock} /dut_tb/clk
add wave -noupdate -height 30 -label {Async. System RST} /dut_tb/rst
add wave -noupdate -height 30 -label Tellers -radix unsigned /dut_tb/Tcount
add wave -noupdate -height 30 -label Back_Cell_Beam /dut_tb/B_CELL
add wave -noupdate -color {Orange Red} -height 30 -label Back_CELL_Event /dut_tb/ITI_BQS/b_cell_event
add wave -noupdate -height 30 -label Front_Cell_Beam /dut_tb/F_CELL
add wave -noupdate -color {Orange Red} -height 30 -label Front_CELL_Event /dut_tb/ITI_BQS/f_cell_event
add wave -noupdate -color Coral -height 30 -label People -radix unsigned /dut_tb/ITI_BQS/Pcount
add wave -noupdate -height 30 -label People_Count_7_seg -radix binary /dut_tb/Pcount_D
add wave -noupdate -color Gold -height 30 -label {Waiting Time} -radix unsigned /dut_tb/ITI_BQS/Wtime
add wave -noupdate -height 30 -label ones_Wtime_7_seg -radix binary /dut_tb/Wtime_D0
add wave -noupdate -height 30 -label Tenths_Wtime_7_seg -radix binary /dut_tb/Wtime_D1
add wave -noupdate -color Orchid -height 30 -label Current_State -radix unsigned /dut_tb/ITI_BQS/FSM/state
add wave -noupdate -color {Orange Red} -height 30 -label Full_Flag /dut_tb/FULL_FLAG
add wave -noupdate -color Green -height 30 -label Empty_Flag /dut_tb/EMPTY_FLAG
add wave -noupdate -color Firebrick -height 30 -label Full_Queue_Alarm /dut_tb/FULL_ALARM
add wave -noupdate -color {Medium Orchid} -height 30 -label Empty_Queue_Alarm /dut_tb/EMPTY_ALARM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {78374487 us} 0}
quietly wave cursor active 1
configure wave -namecolwidth 185
configure wave -valuecolwidth 83
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {75360384 us} {80175744 us}
run -all