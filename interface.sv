//Interface between DUT and Testbench

`timescale 1ns/1ps

interface dff_intf(logic input clk);

    logic reset;
    logic din;
    logic dout;
endinterface