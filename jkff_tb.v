`include "jk_ff.v"
module jkff_tb;
    reg clk,j,k,preset,clear;
    wire q;

    jk_ff DUT(clk,j,k,preset,clear,q);

    always #5 clk=~clk;

    initial
        begin 
            $dumpfile("jk_ff.vcd");
            $dumpvars(0,jkff_tb);
            $monitor($time," CLOCK=%b ,J=%b, F=%b, PRESET=%b, CLEAR=%b, Q=%b",clk,j,k,preset,clear,q);
            clk=1; j=0; k=0; preset=1; clear=0;
            #8 preset=1; clear=1; j=1; k=1;
            /*#10 preset=1; clear=1; j=1; k=1;
            #15 preset=1; clear=1; j=1; k=1;
            #20 preset=1; clear=1; j=1; k=1;
            #30 preset=1; clear=1; j=1; k=1;
            #35 preset=1; clear=1; j=1; k=1;
            #40 preset=1; clear=1; j=1; k=1;
            #45 preset=1; clear=1; j=1; k=1;*/
        end
    initial 
        #100 $finish;
endmodule