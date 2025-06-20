//Moduel       : nor_tb.v
//Description  : Testbench to test nor gate to check a bus for all zeros
//Version      : 1.0
//Last Updated : 29-01-2025
//Writer       : Manav Saini


//Defining timescale :- Unit = 1ns , Precision = 1ps
`timescale 1ns / 1ps

//Defining input and output ports
module nortb;
    reg [31:0] din;
    wire result;

    norgate U1(.in(din),
               .out(result));

    initial
        begin
            $dumpfile("nortest.vcd");
            $dumpvars(0,nor_tb);
            $monitor(" Input = %b | Result = %b",din,result);
            #100 $finish;
        end
    
    initial
        begin
            #10 din <= 32'h00000000;
            #10 din <= 32'h01000100;
        end

endmodule