module fulladder(sum,cout,x,y,cin);
    input x,y,cin;
    output sum,cout;
    wire w[3:0];

    /*assign {cout,sum}=x+y+cin;
    assign sum=x^y^cin;
    assign cout=(x&y)||(cin&(x|y));*/
    xor G1(w[0],x,y), G2(sum,w[0],cin);
    and G3(w[1],x,y), G4(w[2],w[0],cin);
    or G5(cout,w[2],w[1]);
endmodule