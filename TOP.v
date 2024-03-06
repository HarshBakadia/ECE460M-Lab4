`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 03/02/2024 10:40:37 PM
// Design Name: Parking Meter
// Module Name: TOP
// Project Name: Lab 4
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP(
    input SYS_CLK,
    input RESET,
    input UP, LEFT, RIGHT, DOWN,
    input SW0, SW1,
    output [15:0] LED,
    output [3:0] Actv_Sel,
    output [6:0] Dspl_Out);
    
// Interconnections
wire Up_D, Left_D, Right_D, Down_D; // Debounced Button Pulse
wire [15:0] Bin16;

//DEBUG Debouncer
//reg [15:0] Count;
//always@(posedge RESET, posedge Up_D, posedge Left_D, posedge Right_D,posedge Down_D) begin
//    if(RESET) Count = 0;
//    else Count <= Count + 1;
//end
//assign LED = Count;

//DEBUG Bin16
assign LED = Bin16;

// Tie LED to Debounced Button Pulse
//assign LED[3] = Up_D;
//assign LED[2] = Left_D;
//assign LED[1] = Right_D;
//assign LED[0] = Down_D;
// Module Instantiations
Synch_Debouncer S_D_UP(.SYS_CLK(SYS_CLK), .BTTN(UP), .Bttn_D(Up_D));
Synch_Debouncer S_D_LEFT(.SYS_CLK(SYS_CLK), .BTTN(LEFT), .Bttn_D(Left_D));
Synch_Debouncer S_D_RIGHT(.SYS_CLK(SYS_CLK), .BTTN(RIGHT), .Bttn_D(Right_D));
Synch_Debouncer S_D_DOWN(.SYS_CLK(SYS_CLK), .BTTN(DOWN), .Bttn_D(Down_D));
Counter_Interface Interface(.SYS_CLK(SYS_CLK), .RESET(RESET), .Up(Up_D), .Left(Left_D), .Right(Right_D),
    .Down(Down_D), .SW0(SW0), .SW1(SW1), .Out_Bin16(Bin16));
Meter_Display Meter(.SYS_CLK(SYS_CLK), .RESET(RESET), .Rem_Time(Bin16),
    .Actv_Sel(Actv_Sel), .Dspl_Out(Dspl_Out));    
endmodule