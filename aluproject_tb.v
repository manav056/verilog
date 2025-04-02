`include "aluproject.v"
module aluproject_tb;
    reg [7:0] a,b;
    reg [3:0] op;
    wire [8:0] out;

    alu DUT(a,b,op,out);

    //initial out<=9'b000000000;

    /*initial 
        begin 
            out=9'b000000000; a=8'b00000000; b=8'b00000000; op=4'b0000; 
        end*/

    initial 
        begin
            $dumpfile("aluproject.vcd");
            $dumpvars(0,aluproject_tb);
            $monitor($time," A=%b, B=%b, OP=%b, OUTPUT=%b",a,b,op,out);
            #5 a=8'b00000101; b=8'b00000101; op=4'b0000;
            #10 a=8'b00000101; b=8'b00000101; op=4'b0001;
            #15 a=8'b00000101; b=8'b00000101; op=4'b0010;
            #20 a=8'b00000101; b=8'b00000101; op=4'b0011;
            #25 a=8'b00000101; b=8'b00000100; op=4'b0100;
            #30 a=8'b00000101; b=8'b00000100; op=4'b0101;
            $finish;
        end
endmodule

