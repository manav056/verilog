`include "sipo.v"

`timescale 1ns / 1ps

module sipo_tb;

    reg din,
        load,
        clk;

    wire [7:0] dout;

    sipo uut(.din(din),
             .load(load),
             .clk(clk),
             .dout(dout));

    initial
        begin
          clk  <= 1'b0;
          //load <= 1'b0;
          din  <= 1'b0;
        end

    initial
      begin
           load = 1'b0;
        #2 load = 1'b1;
      end

    always #1 clk = ~clk;

    always #5 din = ~din;

    initial
        begin
          $dumpfile("sipo.vcd");
          $dumpvars(0,sipo_tb);
          $monitor("Data In = %b | Data Out = %b",din,dout);
          #100 $finish;
        end

endmodule