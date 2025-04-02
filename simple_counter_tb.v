`include "simple_counter.v"
module simple_counter_tb;
    reg clk,rst; 
    wire [2:0] count;
    simple_counter DUT(clk,rst,count);

    always #5 clk=~clk;

    initial 
        begin
            //count=32'h0000;
            $dumpfile("simple_counter.vcd");
            $dumpvars(0,simple_counter_tb);
            $monitor($time," CLOCK=%b, RESET=%b, COUNT=%b",clk,rst,count);
            clk=1; rst=1;
            #5 clk=0; rst=0;
            /*#5 clk=1; rst=0;
            #5 clk=1; rst=0;
            #5 clk=1; rst=0;
            #5 clk=1; rst=0;
            #5 clk=1; rst=0;
            #5 clk=1; rst=1;*/
            #150 $finish;
        end
endmodule

