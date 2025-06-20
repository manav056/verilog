`include "uart_tx.v"
`timescale 1ns / 1ps

module uart_tx_tb;

    reg [7:0]din;
    reg       clk,
              load_done;

    wire dout;

    uart_tx uut(.din(din),
                .clk(clk),
                .load_done(load_done),
                .dout(dout));

    initial
        begin
            clk <= 1'b0;
            load_done <= 1'b0;
            //din       <= 1'b00000000;
        end

    always #1 clk = ~clk;

    initial
        begin
            din = 8'b00000000;
            #5 din = 8'b10101010; load_done = 1'b1;
        end

    initial
        begin
            $dumpfile("uart_tx.vcd");
            $dumpvars(0,uart_tx_tb);
            $monitor($time," Din = %b | Dout = %b | Input_register = %b | Output_register = %b | Count = %b | load_done = %b",din,dout,uut.data,uut.data_out,uut.count,load_done);
            #100 $finish;
        end

endmodule