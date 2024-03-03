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
    input U,
    input D,
    input L,
    input R,
    output reg up,
    output reg down, 
    output reg left, 
    output reg right,
    output reg[3:0] l
    );
    
    reg[1:0] state;
    
    always @(posedge CLK, posedge RESET) begin
         
         if(RESET) begin
            state <= 0;
            l <= 4'h0;
            /*up <= 0;
            down <= 0;
            left <= 0;
            right <= 0;*/
         end
         
         else begin
            if(!state && (U|R|L|D)) begin 
            //waiting for button press state
                state <= 1;
                
                if(U)        begin l[3] <= ~l[3]; up <= 1;  end
                else if(D)   begin l[2] <= ~l[2]; down <= 1;  end 
                else if(L)   begin l[1] <= ~l[1]; left <= 1;  end
                else if(R)   begin l[0] <= ~l[0]; right <= 1;  end
                           
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
