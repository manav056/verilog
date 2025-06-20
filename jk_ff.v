//JK-FF with Active Low Asynchronous Preset and Clear
module jk_ff(clk,j,k,preset,clear,q);
    input clk,j,k,preset,clear;
    output reg q;

    always @(negedge clk , preset, clear)
        begin
            if(!preset)         //Active Low Asynchronous Preset
                begin
                    q<=1;
                    //qbar<=0;
                end
            else if(!clear)     //Active Low Asynchronous Clear
                begin
                    q<=0;
                    //qbar<=1;
                end
            else 
                begin
                    case({j,k})
                        2'b00: q<=q;    //No Change
                        2'b01: q<=0;    //Reset
                        2'b10: q<=1;    //Set
                        2'b11: q<=~q;   //Toggle Case
                    endcase
                    //qbar<=~q;
                end
            //qbar<=~q;
        end
        
endmodule 
            
            