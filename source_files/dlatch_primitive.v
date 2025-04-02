primitive dlatch(q,d,clk,clr);
    output reg q;
    input d,clk,clr;

    initial q=0;    //Intial State

    table
    //  d   clk     clr     :   present_state   :   next_state
        ?   ?       1       :       ?           :       0;
        0   1       0       :       ?           :       0;
        1   1       0       :       ?           :       1;
        ?   0       0       :       ?           :       -;
    endtable
endprimitive