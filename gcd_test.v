`include "gcd_datapath.v"
`include "gcd_controller.v"
module gcd_test;
    reg [15:0] data_in,a,b;
    reg clk, start;
    wire done;
    
    datapath DP(gt,lt,eq,lda,ldb,sel1,sel2,sel_in,data_in,clk);
    
    controller CON(lda,ldb,sel1,sel2,sel_in,done,clk,lt,gt,eq,start);
    
    initial
        begin
            clk=1'b0;
            #3 start=1'b1;
            #1000 $finish;
        end
        
    always #5 clk=~clk;
    
    initial
        begin
            #10 data_in=78;
            #11 data_in=143;
        end
        
    initial
        begin
            $dumpfile("gcd.vcd");
            $dumpvars(0,gcd_test);
            $monitor($time," %d %b",DP.aout, done);
        end
endmodule