`timescale 1ns / 1ps

module norgate(in,
           out);

    input [31:0] in;
    output out;

    assign out = (in)~|(in);

endmodule