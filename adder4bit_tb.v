`include "adder4bit.v"
module adder4bit_tb;
    reg [3:0] X,Y;
    wire [3:0] S;
    wire Cout;

    adder4bit DUT(S,Cout,X,Y,1'b0);

    initial
        begin
            $dumpfile("adder4bit.vcd");
            $dumpvars(0,adder4bit_tb);
            $monitor($time,"Sum=%b, CarrY=%b, X=%b, Y=%b",S,Cout,X,Y);
            #5 X=4'b0001; Y=4'b0001;
            #5 X=4'b1000; Y=4'b1000;
            #5 X=4'b1000; Y=4'b1000;
            #5 $finish;
        end
endmodule 