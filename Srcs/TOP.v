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
    output [3:0] Actv_Sel,
    output [6:0] Dspl_Out);
    
// Interconnections
wire [15:0] Bin16;

// Module Instantiations
Counter_Interface Interface(.SYS_CLK(SYS_CLK), .RESET(RESET), .UP(UP), .LEFT(LEFT), .RIGHT(RIGHT), .DOWN(DOWN),
    .SW0(SW0), .SW1(SW1), .Out_Bin16(Bin16));
Meter_Display Meter(.SYS_CLK(SYS_CLK), .RESET(RESET), .Rem_Time(Bin16),
    .Actv_Sel(Actv_Sel), .Dspl_Out(Dspl_Out));    
endmodule
