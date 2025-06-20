`include "fulladder.v"
module fulladder_tb;
    reg x,y,cin;
    wire sum,cout;

    fulladder DUT(sum,cout,x,y,cin);

    initial
        begin
            $dumpfile("fulladder.vcd");
            $dumpvars(0,fulladder_tb);
            $monitor($time," Sum=%b, Cout=%b, X=%b, Y=%b, Cin=%b",sum,cout,x,y,cin);
            #5 x=1'b0; y=1'b0; cin=1'b0;
            #10 x=1'b0; y=1'b0; cin=1'b1;
            #15 x=1'b0; y=1'b1; cin=1'b0;
            #20 x=1'b0; y=1'b1; cin=1'b1;
            #25 x=1'b1; y=1'b0; cin=1'b0;
            #30 x=1'b1; y=1'b0; cin=1'b1;
            #35 x=1'b1; y=1'b1; cin=1'b0;
            #40 x=1'b1; y=1'b1; cin=1'b1;
            #45 $finish;
        end
endmodule
