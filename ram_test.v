//---------------------------------------------------------------------------------
//FILE NAME : ram_test.v
//TYPE : module
//DEPARTMENT : Electronics and Communication Engineering
//AUTHOR : Manav Saini
//AUTHOR'S EMAIL : manav2231079@akgec.ac.in
//---------------------------------------------------------------------------------
//RELEASE HISTORY 
//VERSION   DATE    AUTHOR  DESCRIPTION
//1.0   19/10/2024  manav   Initial version
//1.1   25/10/2024  manav   made changes to data writing initial block
//---------------------------------------------------------------------------------
//KEYWORDS : ram, test bench
//---------------------------------------------------------------------------------
//PURPOSE : Test bench for ram3 module

`include "ram3.v"
//`timescale 1ns/1ps  

module ram_test;
    reg [7:0] data_in;
    reg [15:0] addr;
    reg wr,cs,reset;
    wire [7:0] data_out;
    integer k, myseed;

    ram_3 DUT(.data_in(data_in), 
              .addr(addr),
              .wr(wr), 
              .cs(cs),
              .data_out(data_out),
              .reset(reset));

    initial
        begin
            #2 reset=1; wr=1; cs=1;
            #5 reset=0;
        end

    initial 
        begin
            #10
            for(k=0; k<65536; k=k+1)
                begin
                    wr=1; cs=1;
                    addr = k;
                    data_in = k*10; 
                    #8 wr=0; cs=0;
                end

                #20 wr=0;

                for(k=0; k<65536; k=k+1)
                begin
                    addr = k;
                    $display(" Address = %h, Data = %h,",addr,data_out);
                end

                #500 $finish;
        end

endmodule