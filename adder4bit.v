`include "fulladder.v"
module adder4bit(s,cout,x,y,cin);
    input [3:0] x,y; 
    input cin;
    output [3:0] s;
    output cout;
    wire c[3:1];

    //assign {cout,s}=x+y+cin;
    fulladder f1(s[0],c[1],x[0],y[0],cin);
    fulladder f2(s[1],c[2],x[1],y[1],c[1]);
    fulladder f3(s[2],c[3],x[2],y[2],c[2]);
    fulladder f4(s[3],cout,x[3],y[3],c[3]);
endmodule
