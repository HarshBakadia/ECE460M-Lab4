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

module Buttons(
    input SYS_CLK, 
    input RESET,
    input U,
    input D,
    input L,
    input R,
    output reg up,
    output reg down, 
    output reg left, 
    output reg right,
    output reg[3:0] LED);
    
    reg[1:0] state;
    
    always @(posedge SYS_CLK, posedge RESET) begin
         
         if(RESET) begin
            state <= 0;
            LED <= 4'h0;
            /*up <= 0;
            down <= 0;
            left <= 0;
            right <= 0;*/
         end
         
         else begin
            if(!state && (U|R|L|D)) begin 
            //waiting for button press state
                state <= 1;
                
                if(U)        begin LED[3] <= ~LED[3]; up <= 1;  end
                else if(D)   begin LED[2] <= ~LED[2]; down <= 1;  end 
                else if(L)   begin LED[1] <= ~LED[1]; left <= 1;  end
                else if(R)   begin LED[0] <= ~LED[0]; right <= 1;  end
                           
            end
            
            else begin
                if(U | D | L | R)   state <= 1;
                else begin
                    state <= 0; //Waits for release
                    
                    up <= 0;
                    down <= 0;
                    left <= 0;
                    right <= 0;
                end
            end
           
         end
    end
    
endmodule
