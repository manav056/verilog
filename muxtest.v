`include "mux16to1.v"
module muxtest_tb;
    reg[15:0] A; reg[3:0] S; wire F;
    mux16to1 DUT(A,S,F);

    initial 
        begin
            $dumpfile("mux16to1.vcd");
            $dumpvars(0,muxtest_tb);
            $monitor($time," A=%h, S=%h, F=%b",A,S,F);
            #5 A=16'h3f0a; S=4'h0;
            #5 S=4'h1;
            #5 S=4'h6;
            #5 S=4'hc;
            #5 $finish;
        end
endmodule
