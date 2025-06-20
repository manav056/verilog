`include "pipeline_ex.v"
module pipeline_test;
    parameter N = 10;

    reg [N - 1 : 0] A, B, C, D;
    reg clk;
    wire [N - 1 : 0] F;

    pipeline_ex DUT(.A(A), .B(B), .C(C), .D(D), .F(F), .clk(clk));

    initial clk = 1'b0;

    always #10 clk = ~clk;

    initial 
        begin
            #5 A = 10; B = 12; C = 6; D = 3;
            #20 A = 10; B = 10; C = 5; D = 3;
            #20 A = 20; B = 11; C = 1; D = 4;
            #20 A = 15; B = 10; C = 8; D = 2;
            #20 A = 8; B = 15; C = 5; D = 0;
            #20 A = 10; B = 20; C = 5; D = 3;
            #20 A = 10; B = 10; C = 30; D = 1;
            #20 A = 30; B = 1; C = 2; D = 4; 
        end

    initial
        begin
            $dumpfile("pipeline.vcd");
            $dumpvars(0, pipeline_test);
            $monitor("Time: %d, F = %d, ", $time, F);
            #300 $finish;
        end
endmodule