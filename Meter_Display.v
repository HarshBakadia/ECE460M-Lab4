`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 02/28/2024 04:51:01 PM
// Design Name: Parking Meter
// Module Name: Meter_Display
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


module Meter_Display(
    input SYS_CLK,
    input RESET,
    input [15:0] Rem_Time,
    output reg [3:0] Actv_Sel,
    output reg [6:0] Dspl_Out);

// Display Refresh Logic
reg [1:0] Dspl_Sel;
wire Dspl_Clk;
Divider_30kHz Sel_Clk(SYS_CLK, Dspl_Clk);

// Binary to BCD Converter 
wire [15:0] BCD16;
Binary_to_BCD Bin_2_BCD(.SYS_CLK(SYS_CLK), .In_Bin16(Rem_Time), .Out_BCD16(BCD16));
    
// Simulation Init Block
initial begin
    Actv_Sel = 0;
    Dspl_Sel = 0;
    Dspl_Out = 0;
end


// Set Active 7-Seg
// Allocate BCD16 Into the respective 7-Seg
reg [3:0] BCD4;
 
always@(posedge Dspl_Clk, posedge RESET) begin
    if(RESET) Dspl_Sel <= 0;
    else Dspl_Sel <= Dspl_Sel + 1;
end

// 4-bit BCD -> Displayed value
// 7-Segment Display Patterns 
always@(posedge SYS_CLK)
begin
    case(Dspl_Sel)
        2'b00: begin
            Actv_Sel <= 4'b0111;
            BCD4 <= BCD16[15:12];
        end
        2'b01: begin
            Actv_Sel <= 4'b1011;
            BCD4 <= BCD16[11:8];
        end
        2'b10: begin
            Actv_Sel <= 4'b1101;
            BCD4 <= BCD16[7:4];
        end            
        2'b11: begin
            Actv_Sel <= 4'b1110;
            BCD4 <= BCD16[3:0];
        end          
    endcase
    case(BCD4)
        4'b0000: Dspl_Out <= 7'b0000001; // "0"     
        4'b0001: Dspl_Out <= 7'b1001111; // "1" 
        4'b0010: Dspl_Out <= 7'b0010010; // "2" 
        4'b0011: Dspl_Out <= 7'b0000110; // "3" 
        4'b0100: Dspl_Out <= 7'b1001100; // "4" 
        4'b0101: Dspl_Out <= 7'b0100100; // "5" 
        4'b0110: Dspl_Out <= 7'b0100000; // "6" 
        4'b0111: Dspl_Out <= 7'b0001111; // "7" 
        4'b1000: Dspl_Out <= 7'b0000000; // "8"     
        4'b1001: Dspl_Out <= 7'b0000100; // "9"
        4'b1010: Dspl_Out <= 7'b1111111; // "blank"  
        4'b1111: Dspl_Out <= 7'b0110000; // "E" Indicating Error
        default: Dspl_Out <= 7'b1111111; // "blank"
    endcase
end    
    
    
endmodule