`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 03/03/2024 06:12:58 PM
// Design Name: Parking Meter
// Module Name: Synch_Debouncer
// Project Name: Lab 4
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Referencing https://www.fpga4student.com/2017/04/simple-debouncing-verilog-code-for.html
// 
//////////////////////////////////////////////////////////////////////////////////

module Synch_Debouncer(
    input SYS_CLK,
    input BTTN,
    output Bttn_D);
    
// Internal Variables
wire Q1, Q2;
wire Synch_Clk;
Divider_20Hz Synch_Clk_Gen(SYS_CLK, Synch_Clk);


D_FF FF1(Synch_Clk, BTTN, Q1);
D_FF FF2(Synch_Clk, Q1, Q2);

assign Bttn_D = Q1 & ~Q2;
    
endmodule

//////////////////////////////////////////////////////////////////////////////////
module D_FF(
    input Clk,
    input D,
    output reg Q);
    
initial Q =0;    
    
always@(posedge Clk) Q <= D;    
    
endmodule