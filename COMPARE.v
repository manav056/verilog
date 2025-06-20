module COMPARE(lt,gt,eq,din1,din2);
    input [15:0] din1,din2;
    output lt,gt,eq;
    
    assign lt=din1<din2;
    assign gt=din1>din2;
    assign eq=din1==din2;
endmodule