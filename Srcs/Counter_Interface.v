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
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Counter_Interface(
    input RESET,
    input UP,
    input LEFT,
    input RIGHT,
    input DOWN,
    input SW1,
    input SW2,
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

// Reset Condition
always@(posedge RESET) Out_Bin16 <= 0;

// Constant Countdown Condition
always@(posedge Decr_Clk) begin
    if(Decr_Clk_Enable) begin
        if(Out_Bin16 > 0) Out_Bin16 <= Out_Bin16 - 1;
        else Out_Bin16 <= 0;
    end    
end

// Time Interval Additions
always@(posedge UP, posedge LEFT, posedge RIGHT, posedge DOWN) begin
    if(UP)          Out_Bin16 <= Out_Bin16 + 10;
    else if(LEFT)   Out_Bin16 <= Out_Bin16 + 180;
    else if(RIGHT)  Out_Bin16 <= Out_Bin16 + 200;
    else if(DOWN)   Out_Bin16 <= Out_Bin16 + 550;
end

// Time Interval Assignments
always@(SW1, SW2) begin
    if(SW1) begin
        Out_Bin16 <= 10;
        Decr_Clk_Enable <= 0;
    end
    else if(SW2) begin
        Out_Bin16 <= 205;
        Decr_Clk_Enable <= 0;
    end
    // Re-Enable Decrement Clock
    else Decr_Clk_Enable <= 1;
end
    
    
endmodule
