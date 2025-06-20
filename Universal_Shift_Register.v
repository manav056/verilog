//Universal Shift Register that allows Shift left, Shift Right, Serial Loading, Serial Output, Paralled Loading and Paralled Output
module usr(a,op,clk,out);
    input [2:0] a;       //Data Input
    input [1:0] op;     //operation to be performed
    input clk;          //Clock for synchronisation
    input b;            //Data Input for Serial Input
    output reg [2:0] out1;   //Output of the Universal Shift Register
    output reg out2;        //Output for Serial Shifting
    reg c,d,e;

    always @(negedge clk)
        begin
            case(op)
                2'b00: begin out1<=out1; out2<=out2; end       //No Change in Output
                2'b01: begin out2<=c; e<=b; d<=e; c<=d; end      //Value Stored in register shifted by 1 to left
                2'b10: begin out2<=e; e<=d; d<=c; c<=b; end     //Value stored in register shifted by 1 to right
                2'b11: begin out1[2]<=a[2]; out1[1]<=a[1]; out1<=a[0]; end          //Paralled loading of value
                default: out<=4'bxxxx;  //default Value = Don't Care
            endcase
        end
endmodule

