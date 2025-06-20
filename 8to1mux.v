//8-to-1 Multiplexer
module mux8to1(in, sel, out);
    input [2:0] sel;
    input [7:0] in;
    output out;

    assign out=in[sel];

endmodule