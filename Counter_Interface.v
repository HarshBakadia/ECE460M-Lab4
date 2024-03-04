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
    input UP, LEFT, RIGHT, DOWN,
    input SW0, SW1,
    output reg [15:0] Out_Bin16);
    
// Internal Variables
wire Decr_Clk;
reg  Decr_Clk_Enable;
reg[15:0] temp_Bin16;
Divider_1Hz Decr_Clk_Gen(SYS_CLK, Decr_Clk);

// Simulation Init    
initial begin
    Out_Bin16 <= 0;
    Decr_Clk_Enable <= 1;
end

// STUPID UGLY SMASH
always@(posedge RESET, posedge Decr_Clk, posedge UP, posedge LEFT, posedge RIGHT, posedge DOWN,
    posedge SW0, posedge SW1) begin
    
    
    if(RESET) begin       
        Out_Bin16 <= 'd0;
        temp_Bin16 <= 'd0;
    end
    
    else begin
        
        if(UP) begin         temp_Bin16 <= Out_Bin16 + 'd10;    end
        else if(LEFT) begin   temp_Bin16 <= Out_Bin16 + 'd180;  end
        else if(RIGHT) begin  temp_Bin16 <= Out_Bin16 + 'd200;  end
        else if(DOWN)  begin   temp_Bin16 <= Out_Bin16 + 'd550; end
        else if(SW0) begin
            temp_Bin16 <= 'd10;
            Decr_Clk_Enable <= 0;
        end
        else if(SW1) begin
            temp_Bin16 <= 'd205;
            Decr_Clk_Enable <= 0;
        end
        // Triggered by Decr_Clk
        else if(Decr_Clk_Enable) begin
            if(temp_Bin16 > 0) temp_Bin16 <= temp_Bin16 - 1;
            else temp_Bin16 <= 0;
        end
        
        Out_Bin16 <= temp_Bin16;
    end
end

// Can't be Combined for Stupid Reason...
always@(negedge SW0) Decr_Clk_Enable <= 1;
always@(negedge SW1) Decr_Clk_Enable <= 1;

endmodule