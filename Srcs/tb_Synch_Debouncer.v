`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Brandon King
// 
// Create Date: 03/03/2024 8:50:09 PM
// Design Name: Parking Meter
// Module Name: tb_Synch_Debouncer
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
module tb_Synch_Debouncer();

//Global
reg SYS_CLK;
reg BTTN;
wire Bttn_D;


// Simulation Init
initial begin
    BTTN = 0;
end

initial begin
    SYS_CLK = 0;
    forever #2 SYS_CLK = ~SYS_CLK;
end

// Simulation Stimulus
initial begin
    #1000000 BTTN = 1;
    #1100000 BTTN = 0;
    #1200000 BTTN = 1;
    #1300000 BTTN = 0;
    #1400000 BTTN = 1;
    #1500000 BTTN = 0;    
end

// Module Test Bench
Synch_Debouncer tb_Synch_Debouncer(.SYS_CLK(SYS_CLK), .BTTN(BTTN), .Bttn_D(Bttn_D));

endmodule
