// 8_to_1 MUX Testbench
`include "8to1MUX.v"
//`include "simple_counter.v"
module mux8to1_tb;
    reg [7:0] in;
    reg [2:0] sel;
    wire out;

    mux8to1 DUT(in,sel,out);

    initial 
        begin
            $dumpfile("8to1mux.vcd");
            $dumpvars(0,mux8to1_tb);
            $monitor($time," Input=%h, Select=%h, Output=%h",in,sel,out);
            in=8'b01010101; sel=3'b000;
            #5 sel=3'b001;
            #10 sel=3'b010;

            #50 $finish;
        end
endmodule



