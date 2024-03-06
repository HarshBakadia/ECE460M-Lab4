`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 02/28/2024 04:51:01 PM
// Design Name: Parking Meter
// Module Name: Binary_to_BCD
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

module Binary_to_BCD (
    input SYS_CLK,
    input [15:0] In_Bin16,
    output reg [15:0] Out_BCD16);

// Internal Variables
wire Mask_Clk;
Divider_1Hz Mask_Clk_Gen(SYS_CLK, Mask_Clk); 

// Simulation Init Block
initial begin
    Out_BCD16 = 0;
end


always @(*)begin
    // Raw Binary to BCD16
    // Flashing Mask Operation at 0
    if(In_Bin16 == 0) begin
        if(Mask_Clk) Out_BCD16 <= 0;
        else Out_BCD16 <= 'hAAAA;
    end    
    // Blank Out Odd Values < 199
    else if((In_Bin16 < 200) && In_Bin16[0]) Out_BCD16 <= 'hAAAA;
    // Normal Operation 200 - 9999
    else if(In_Bin16 < 9999) begin
        Out_BCD16[15:12] <= (In_Bin16/1000);
        Out_BCD16[11:8]  <= ((In_Bin16%1000)/100);
        Out_BCD16[7:4]   <= ((In_Bin16%100)/10);
        Out_BCD16[3:0]   <= (In_Bin16%10);
    end
    // OVERFLOW ERROR
    else Out_BCD16 <= 'h9999;
end
 
endmodule
