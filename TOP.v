`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin   
// Engineer: Harsh Bakadia 
// 
// Create Date: 03/01/2024 03:05:05 PM
// Design Name: Top
// Module Name: Top
// Project Name: Parking meter
//
// Top file
//////////////////////////////////////////////////////////////////////////////////

module TOP(input clk,
           input reset,
           input U, input D, input L, input R,
           output[6:0] out,
           output sw0,
           output sw1
    );
    
    wire [15:0] val;
    
    buttons b0(.CLK(clk), .RESET(reset), .up(U), .down(D), .left(L), .right(R), 
               .SW0(sw0), .SW1(sw1), .t_meter(val));
    //Binary_to_BCD b1(.SYS_CLK(clk), .RESET(reset), .In_Bin16(val), .Out_BCD16(bcd16));
    Meter_Display m1(.SYS_CLK(clk), .RESET(reset), .Rem_Time(val), .Actv_Sel(), .Dspl_Out(out));
    
endmodule
