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
reg t_SYS_CLK;
reg t_RESET;
reg t_UP, t_LEFT, t_RIGHT, t_DOWN;
reg t_SW0, t_SW1;
wire [3:0] t_Actv_Sel;
wire [6:0] t_Dspl_Out;

// Interconnections
//wire [15:0] t_Bin16;


// Simulation Init
initial begin
    t_UP = 0;
    t_LEFT = 0;
    t_RIGHT = 0; 
    t_DOWN = 0;
    t_SW0 = 0;
    t_SW1 = 0;
    t_RESET = 1;
    #1 t_RESET = 0; 
end

initial begin
    t_SYS_CLK = 0;
    forever #2 t_SYS_CLK = ~t_SYS_CLK;
end

// Simulation Stimulus
initial begin
    #10  t_UP = 1;
    #10  t_UP = 0;
end

// Module Test Bench
TOP t1(.SYS_CLK(t_SYS_CLK), .RESET(t_RESET), .UP(t_UP), .LEFT(t_LEFT), .RIGHT(t_RIGHT), .DOWN(t_DOWN), .SW0(t_SW0), .SW1(t_SW1), .Actv_Sel(t_Actv_Sel), .Dspl_Out(t_Dspl_Out));
endmodule