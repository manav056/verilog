module MUX(dout,in0,in1,select);
    input select;
    input [15:0] in0,in1;
    output[15:0] dout;
    
    assign dout=select?in1:in0;
endmodule
