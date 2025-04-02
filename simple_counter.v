module simple_counter(clk,rst,count);
    input clk, rst;
    output reg [2:0] count;

    /*initial
        begin
            clk=1'b0;
            #5 forever clk=~clk;
        end*/

    initial
        count=3'b000;
    
    always @(negedge clk)
        begin
            if(rst)
                count=3'b000;
            else
                count=count+1;
                $monitor($time," COUNT = %b",count);
      
        end
endmodule 