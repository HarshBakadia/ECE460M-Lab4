`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 03/02/2024 09:41:35 PM
// Design Name: Parking Meter
// Module Name: tb_Top
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
module tb_Top();

//Global
reg SYS_CLK;
reg RESET;
reg UP, LEFT, RIGHT, DOWN;
reg SW0, SW1;
wire [3:0] LED;
wire [3:0] Actv_Sel;
wire [6:0] Dspl_Out;

// Interconnections
wire Up_D, Left_D, Right_D, Down_D; // Debounced Button Pulse
wire [15:0] Bin16;


// Simulation Init
initial begin
    UP = 0;
    LEFT = 0;
    RIGHT = 0; 
    DOWN = 0;
    SW0 = 0;
    SW1 = 0;
    RESET = 1;
    #1 RESET = 0; 
end

initial begin
    SYS_CLK = 0;
    forever #2 SYS_CLK = ~SYS_CLK;
end

// Simulation Stimulus
initial begin
    #1000000 UP = 1;
    #1100000 UP = 0;
    #1200000 UP = 1;
    #1300000 UP = 0;
    #1400000 UP = 1;
    #1500000 UP = 0;    
end

// Module Test Bench
Buttons tb_Debouncer(.SYS_CLK(SYS_CLK), .RESET(RESET), .U(UP), .D(DOWN), .L(LEFT), .R(RIGHT),
    .up(Up_D), .down(Down_D), .left(Left_D), .right(Right_D), .LED(LED));
Counter_Interface tb_interface(.SYS_CLK(SYS_CLK), .RESET(RESET), .UP(Up_D), .LEFT(Left_D), .RIGHT(Right_D), .DOWN(Down_D),
    .SW0(SW0), .SW1(SW1), .Out_Bin16(Bin16));
Meter_Display tb_Meter(.SYS_CLK(SYS_CLK), .RESET(RESET), .Rem_Time(Bin16),
    .Actv_Sel(Actv_Sel), .Dspl_Out(Dspl_Out));
endmodule

