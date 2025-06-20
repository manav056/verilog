//---------------------------------------------------------------------------------
//FILE NAME : ram1.v
//TYPE : module
//DEPARTMENT : Electronics and Communication Engineering
//AUTHOR : Manav Saini
//AUTHOR'S EMAIL : manav2231079@akgec.ac.in
//---------------------------------------------------------------------------------
//RELEASE HISTORY 
//VERSION   DATE    AUTHOR  DESCRIPTION
//1.0   19/10/2024  manav   Initial version
//---------------------------------------------------------------------------------
//KEYWORDS : memory module testing, ram, synchronous read and write
//---------------------------------------------------------------------------------
//PURPOSE : Single-port RAM of size 4KB with synchronous read and write

module memory_model(addr,
                    data,
                    clk,
                    rd,
                    wr,
                    cs);

    inout [7:0] data;    //Single port for input and output 
    input [9:0] addr;    //Address lines for 4KB Single port RAM
    input clk;          //Clock Signals
    input rd,wr,cs;     //Control signals - Read, Write, Chip_select
    
    reg [7:0] mem[0:1023];  //Specifying memory as a array of 8-bit registers

    reg [7:0] d_out;    //Specifying output register

    assign data=(cs && rd)?d_out:8'bz;

    always @(posedge clk)
        if(cs && wr && !rd) mem[addr] = data;   //when cs=wr=1 and rd=0, write data

    always @(posedge clk)
        if(cs && rd && !wr) d_out = mem[addr];  //when cs=rd=1 and wr=0, read data

endmodule