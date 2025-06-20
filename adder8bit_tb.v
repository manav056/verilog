`include "adder8bit.v"
module adder8bit_tb;
    reg [7:0] a,b;
    reg cin;
    wire [7:0] out;
    wire cout;
    integer i;

    adder8bit DUT(.a(a), .b(b), .cin(cin), .cout(cout), .out(out));

    initial
        begin
            $dumpfile("adder8bit_generate.vcd");
            $dumpvars(0,adder8bit_tb);
            $monitor($time," A=%h | B=%h | Carry_in=%b | OUTPUT=%h | Carry_out=%b",a,b,cin,out,cout);
            a=8'h01; b=8'h01; cin=1'b0;
            for(i=0; i<87; i=i+1)
                begin
                    a=i; b=i+1; #1;
                end
            $finish;
            //$finish;
        end
endmodule