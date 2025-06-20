`timescale 1ns/1ps

module dff(clk, din, dout);
    input clk, din;
    output reg dout;

    always @(posedge clk) dout <= din;

endmodule