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
    input up,
    input down,
    input left,
    input right,
    //input SW0,
    //input SW1,
    //output reg[15:0] t_meter,
    output reg[3:0] l
    );
    
    //internal signals
    //wire up, down, left, right;
    //wire switch0, switch1;
    reg state;
    reg[15:0] t_meter;

    
    //Combination logic to add value to the t_meter
    
    always @(up, down, left, right /*posedge SW0, posedge SW1,*/) begin
        
        l = {t_meter[3:0]};
    
        if(up && !state)     begin   t_meter <= t_meter + 1;  end
        if(down && !state)   begin   t_meter <= t_meter - 1;  end
        if(left && !state)   begin   t_meter <= t_meter * 2;  end
        if(right && !state)  begin   t_meter <= t_meter / 2;  end


        if((up | down | left | right))
            state <= 1;
        else
            state <= 0;
end
    
    
endmodule
