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
// Revision 0.03
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//TODO: Try converting inputs into a bit vector and using a case statement
//  instead of an if/else tree

module Counter_Interface(
    input SYS_CLK,
    input RESET,
    input Up, Left, Right, Down,
    input SW0, SW1,
    output reg [15:0] Out_Bin16);
    
// Internal Variables
wire Decr_Clk;
reg Decr_Clk_Enable;
Divider_1Hz Decr_Clk_Gen(SYS_CLK, Decr_Clk);


// Simulation Init    
initial begin
    Out_Bin16 <= 0;
    Decr_Clk_Enable <= 1;
end

/*
wire [7:0] Vector;
parameter V_RESET    = 8'b00000001;
parameter V_UP       = 8'b00000010;
parameter V_LEFT     = 8'b00000100;
parameter V_RIGHT    = 8'b00001000;
parameter V_DOWN     = 8'b00010000;
parameter V_SW0      = 8'b00100000;
parameter V_SW1      = 8'b01000000;
parameter V_Decr_Clk = 8'b10000000;

assign Vector[0] = RESET;
assign Vector[1] = UP;
assign Vector[2] = LEFT;
assign Vector[3] = RIGHT;
assign Vector[4] = DOWN;
assign Vector[5] = SW0;
assign Vector[6] = SW1;
assign Vector[7] = Decr_Clk && Decr_Clk_Enable;


always@(Vector) begin
    case(Vector)
        V_RESET:  Out_Bin16 <= 0;
        V_UP:     Out_Bin16 <= Out_Bin16 + 10;
        V_LEFT:   Out_Bin16 <= Out_Bin16 + 180;
        V_RIGHT:  Out_Bin16 <= Out_Bin16 + 200;
        V_DOWN:   Out_Bin16 <= Out_Bin16 + 550;
        V_SW0:    Out_Bin16 <= 10;
        V_SW1:    Out_Bin16 <= 205;
        
        V_Decr_Clk: begin
            if(Out_Bin16 > 0) Out_Bin16 <= Out_Bin16 - 1;
            else Out_Bin16 <= 0;
        end
        
        default: Out_Bin16 <= Out_Bin16;
    endcase
end

always@(SW0, SW1)begin 
    if(SW0 | SW1) Decr_Clk_Enable <= 0;
    else Decr_Clk_Enable <= 1;
end

*/




// STUPID UGLY SMASH
always@(posedge RESET, posedge Up, posedge Left, posedge Right, posedge Down,
    posedge SW0, posedge SW1, posedge Decr_Clk) begin
    
    if(RESET)       Out_Bin16 <= 0;
    else if(Up)     Out_Bin16 <= 10  + Out_Bin16;
    else if(Left)   Out_Bin16 <= 180 + Out_Bin16;
    else if(Right)  Out_Bin16 <= 200 + Out_Bin16;
    else if(Down)   Out_Bin16 <= 550 + Out_Bin16;
    else if(SW0)    Out_Bin16 <= 10;
    else if(SW1)    Out_Bin16 <= 205;
    // Triggered by Decr_Clk
    else if(Decr_Clk_Enable) begin
        if(Out_Bin16 > 0) Out_Bin16 <= Out_Bin16 - 1;
        else Out_Bin16 <= 0;
    end
end
// Prevent Decrementing While SW Active
always@(SW0, SW1)begin 
    if(SW0 | SW1) Decr_Clk_Enable <= 0;
    else Decr_Clk_Enable <= 1;
end



endmodule
