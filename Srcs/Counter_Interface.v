`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 03/02/2024 09:14:14 PM
// Design Name: Parking Meter
// Module Name: Counter_Interface
// Project Name: Lab 4
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.02
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Counter_Interface(
    input SYS_CLK,
    input RESET,
    input UP,
    input LEFT,
    input RIGHT,
    input DOWN,
    input SW0,
    input SW1,
    output reg [15:0] Out_Bin16);
    
// Internal Variables
wire Decr_Clk;
reg  Decr_Clk_Enable;
Divider_1Hz Decr_Clk_Gen(SYS_CLK, Decr_Clk); 

// Simulation Init    
initial begin
    Out_Bin16 = 0;
    
    Decr_Clk_Enable <= 1;
end

// STUPID UGLY SMASH
always@(posedge RESET, posedge Decr_Clk, posedge UP, posedge LEFT, posedge RIGHT, posedge DOWN,
    posedge SW0, posedge SW1) begin
    
    if(RESET) Out_Bin16 <= 0;
    else if(UP)     Out_Bin16 <= Out_Bin16 + 10;
    else if(LEFT)   Out_Bin16 <= Out_Bin16 + 180;
    else if(RIGHT)  Out_Bin16 <= Out_Bin16 + 200;
    else if(DOWN)   Out_Bin16 <= Out_Bin16 + 550;
    else if(SW0) begin
        Out_Bin16 <= 10;
        Decr_Clk_Enable <= 0;
    end
    else if(SW1) begin
        Out_Bin16 <= 205;
        Decr_Clk_Enable <= 0;
    end    else if(Decr_Clk_Enable) begin
        if(Out_Bin16 > 0) Out_Bin16 <= Out_Bin16 - 1;
        else Out_Bin16 <= 0;
    end
end

// Can't be Combined for Stupid Reason...
always@(negedge SW0) Decr_Clk_Enable <= 1;
always@(negedge SW1) Decr_Clk_Enable <= 1;

endmodule
