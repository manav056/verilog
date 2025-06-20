`timescale 1ns/1ps

module dff(
           clk,
           reset,
           din,
           dout);


    input clk,
          din,
          reset;

    output reg dout;

    always @(posedge clk)
        begin
          if(reset == 1'b1) dout <= 1'b0;

          else dout <= din;
        end

endmodule