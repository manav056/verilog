//Designing 8-bit ripple carry adder using generate command
`include "fulladder.v"
module adder8bit(a,b,cin,cout,out);         //ANSI-C style Port declaration

    parameter n=8;
    input [n-1:0] a,b;
    input cin;
    output [n-1:0] out;
    output cout;
    wire [n:0] carry;

    assign carry[0]=cin;                    //Assigning input carry 
    assign cout=carry[n];                   //Assigning output carry

    genvar i;                              //generate variable

    generate for(i=0; i<n; i=i+1)          //generate for loop to create 8 Full adders
        begin
            fulladder FA0 (out[i],carry[i+1],a[i],b[i],carry[i]);           //Instantiating Full Adder module
        end
    endgenerate
endmodule