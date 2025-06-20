module mul_datapath(eqz,lda,ldb,ldp,clrp,decb,data_in,clk);
    input lda,ldb,ldp,clrp,decb,clk;
    input [15:0] data_in;
    output eqz;
    wire [15:0] x,y,z,bout,bus;

    pipo A(x,bus,lda,clk);
    pipo b(y,z,ldp,clrp,clk);
    cntr b(bout,bus,ldb,decb,clk);
    add AD(z,x,y);
    eqz COMP();
endmodule
