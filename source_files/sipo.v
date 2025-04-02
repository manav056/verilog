`timescale 1ns / 1ps

module sipo(din,
            clk,
            load,
            dout);

            input din,
                  clk,
                  load;

            output [7:0] dout;

            reg [7:0] temp;
            reg [2:0] bit_index;

            always @(posedge clk)
                begin
                    while (load)
                        begin
                            if(bit_index == 3'b111)
                                begin
                                  bit_index <= 3'b000;
                                  temp      <= 3'b000;
                                end

                            else
                                begin
                                    bit_index       <= bit_index + 1;
                                    temp[bit_index] <= din;
                                end
                        end  
                end
                
            assign dout = temp;

endmodule