//Design Arithmatic and logic unit of a cpu
module alu(a, b, op, out);
    input [7:0] a;
    input [7:0] b;
    input [3:0] op;
    parameter n=1;
    output reg [8:0] out;

    always @(*)
        begin
            case(op)
                //Arithmetic Operations
                4'b0000:  out=a+b;    //Addition
                4'b0001:  out=a-b;       //Subtraction
                4'b0010:  out=a*b;       //Multiplication
                4'b0011:  out=a/b;       //Division

                //Bitwise Operations
                4'b0100:  out=a&b;       //Logical AND
                4'b0101:  out=a|b;       //Logical OR
                4'b0110:  out=a^b;       //Logical EXOR
                4'b0111:  out=a~^b;       //Logical EXNOR
                4'b1000:  out=a<<n;      //Bitwise Leftshift
                4'b1001:  out=a>>n;      //Bitwise Rightshift

                //Comparison Operation
                4'b1010:  out=a>b;       //Greater than
                4'b1011:  out=(a==b);    //Equals 

                default:  out=8'bxxxxxxxx;       //Default Case: Don't Care
            endcase
        end
endmodule