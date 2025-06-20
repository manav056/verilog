module clockgenerator;
    output reg clk;

    initial
        //$dumpfile("clock_gen.vcd");
        //$dumpvars(0,clockgenerator);
            clk=1'b0;

    always
        begin
            $monitor("CLOCK = %d",clk); 
            #16.66 clk=~clk; 
        end

    initial
        #100 $finish;
endmodule
