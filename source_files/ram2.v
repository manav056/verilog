//---------------------------------------------------------------------------------
//FILE NAME : ram2.v
//TYPE : module
//DEPARTMENT : Electronics and Communication Engineering
//AUTHOR : Manav Saini
//AUTHOR'S EMAIL : manav2231079@akgec.ac.in
//---------------------------------------------------------------------------------
//RELEASE HISTORY 
//VERSION   DATE    AUTHOR  DESCRIPTION
//1.0   19/10/2024  manav   Initial version
//---------------------------------------------------------------------------------
//KEYWORDS : memory module testing, ram, asynchronous read and write
//---------------------------------------------------------------------------------
//PURPOSE : Single-port RAM of size 4KB with asynchronous read and write

module ram_2(       addr,
                    data,
                    rd,
                    wr,
                    cs  );

    inout [7:0] data;    //Single port for input and output 
    input [9:0] addr;    //Address lines for 4KB Single port RAM
    input rd,wr,cs;     //Control signals - Read, Write, Chip_select
    
    reg [7:0] mem[0:1023];  //Specifying memory as a array of 8-bit registers

    reg [7:0] d_out;    //Specifying output register

    assign data=(cs && rd)?d_out:8'bz;

    always @(data or addr or rd or wr or cs) //whenever any of inputs or control signals changes the always block will be triggered
        if(cs && rd && !wr) d_out=mem[addr];

        else if(cs && wr && !rd) mem[addr]=data; 

endmodule