`timescale 1ns / 1ps

`include "uvm_macros.svh"  //Contains all the UVM macros

import uvm_pkg::*;         //Contains all the UVM base classes

module top;

    logic clk;

    //Instantiation of lower modules mainly DUT, Interfaces

    dff dut(
      .clk(intf.clk),
      .din(intf.din),
      .reset(intf.reset),
      .dout(intf.dout)  
    );

    dff_intf intf(.clk(clk));  //Interface clk(Top module clk)

    initial clk = 0;

    always #10 clk = ~clk;
endmodule