//4-to-1 Multiplexer using User Defined Primitives
primitive mux4to1(out,s1,s0,i3,i2,i1,i0);
    output out;
    input s1,s0,i3,i2,i1,i0;

    table
    // s1   s0  i3  i2  i1  i0  :   out
        0   0   ?   ?   ?   0   :   0;
        0   0   ?   ?   ?   1   :   1;
        0   1   ?   ?   0   ?   :   0;
        0   1   ?   ?   1   ?   :   1;
        1   0   ?   0   ?   ?   :   0;
        1   0   ?   1   ?   ?   :   1;
        1   1   0   ?   ?   ?   :   0;
        1   1   1   ?   ?   ?   :   1;
    endtable
endprimitive
