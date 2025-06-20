`include "PIPO.v"
`include "MUX.v"
`include "SUB.v"
`include "COMPARE.v"
module datapath(gt,lt,eq,lda,ldb,sel1,sel2,sel_in,data_in,clk);
    input lda,ldb,sel1,sel2,sel_in,clk;
    input [15:0] data_in;
    output gt,lt,eq;
    wire [15:0] aout,bout,x,y,bus,subout;
    
    PIPO A(aout,bus,lda,clk);
    PIPO B(bout,bus,ldb,clk);
    MUX MUX_in1(x,aout,bout,sel1);
    MUX MUX_in2(y,aout,bout,sel2);
    MUX MUX_load(bus,subout,data_in,sel_in);
    SUB SB(subout,x,y);
    COMPARE COMP(lt,gt,eq,aout,bout);
endmodule
