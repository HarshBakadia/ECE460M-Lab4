`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin   
// Engineer: Harsh Bakadia 
// 
// Create Date: 03/01/2024 03:05:05 PM
// Design Name: Buttons
// Module Name: buttons
// Project Name: Parking meter
//
// Takes input and debounces the buttons 
//////////////////////////////////////////////////////////////////////////////////

module buttons(
    input CLK,
    input RESET,
    output up,
    output down,
    output left,
    output right,
    output SW0,
    output SW1
    );
    
    //internal signals
    wire up, down, left, right;
    wire switch0, switch1;
    wire temp_meter;
    reg[15:0]  t_meter;
    reg[1:0] state;
    
    //Combination logic to add value to the t_meter
    
    always @(posedge CLK, posedge RESET) begin
    
        if(RESET) begin
            state <= 0;
            t_meter <= 0;
        end
        
        else if(!state && (up|down|left|right)) begin
            state <= 1;
            
            if(up)          t_meter <= t_meter + 1;
            else if(down)   t_meter <= t_meter - 1;
            else if(left)   t_meter <= t_meter * 2;
            else if(right)  t_meter <= t_meter / 2;
            else            t_meter <= t_meter;
        end
        
        else begin
            if((up | down | left | right))
                state <= 1;
            else
                state <= 0;
        end
    end
    
    
endmodule
