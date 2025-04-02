module SUB(dout,din1,din2);
    input [15:0] din1,din2;
    output [15:0] dout;
    
    assign dout=din1-din2;
endmodule