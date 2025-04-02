//---------------------------------------------------------------------------------
//FILE NAME : ram3.v
//TYPE : module
//DEPARTMENT : Electronics and Communication Engineering
//AUTHOR : Manav Saini
//AUTHOR'S EMAIL : manav2231079@akgec.ac.in
//---------------------------------------------------------------------------------
//RELEASE HISTORY 
//VERSION   DATE    AUTHOR  DESCRIPTION
//1.0   19/10/2024  manav   Initial version
//---------------------------------------------------------------------------------
//KEYWORDS : memory module testing, ram, separate data input and output ports
//---------------------------------------------------------------------------------
//PURPOSE : RAM module with separate input and output data lines

module ram_3(data_out,
             data_in,
             addr,
             wr,
             cs,
             reset);

    parameter addr_size=16, word_size = 8, memory_size = 1024; 
    integer k;

    input reset;
    input [addr_size - 1 : 0] addr;     //address lines
    input [word_size - 1 : 0] data_in;  //input data lines
    input wr,cs;                        //Control Signals 
    output [word_size - 1 : 0] data_out;    //Output data lines

    reg [word_size - 1 : 0] mem[addr_size - 1 : 0];     //Specifying memory

    assign data_out=mem[addr];

    always @(wr or cs)
        if(reset) 
            begin
                for(k=0; k<65536; k=k+1) mem[k] <= 0; 
            end
            
        else if(wr) mem[addr] = data_in;
endmodule
