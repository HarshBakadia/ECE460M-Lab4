`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 02/28/2024 11:20:09 PM
// Design Name: Parking Meter
// Module Name: tb_Meter_Display
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
module tb_Meter_Display();

//Global
reg SYS_CLK;
reg RESET;
reg [15:0] Rem_Time;
wire [3:0] Actv_Sel;
wire [6:0] Dspl_Out;


// Simulation Init
initial begin
    RESET = 1;
    #1 RESET = 0; 
end

initial begin
    SYS_CLK = 0;
    forever #2 SYS_CLK = ~SYS_CLK;
end

// Module Test Bench
Meter_Display tb_Meter(.SYS_CLK(SYS_CLK), .RESET(RESET), .Rem_Time(Rem_Time),
    .Actv_Sel(Actv_Sel), .Dspl_Out(Dspl_Out));

endmodule
