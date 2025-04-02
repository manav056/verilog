//---------------------------------------------------------------------------------
//FILE NAME : rom.v
//TYPE : module
//DEPARTMENT : Electronics and Communication Engineering
//AUTHOR : Manav Saini
//AUTHOR'S EMAIL : manav2231079@akgec.ac.in
//---------------------------------------------------------------------------------
//RELEASE HISTORY 
//VERSION   DATE    AUTHOR  DESCRIPTION
//1.0   19/10/2024  manav   Initial version
//---------------------------------------------------------------------------------
//KEYWORDS : memory module testing, rom,
//---------------------------------------------------------------------------------
//PURPOSE : Single port ROM testing

module rom(data,
            addr,
            cs);

    input [2:0] addr;   //3-bit wide address bus
    input cs;           //Control Signal

    output [7:0] reg data;        //8-bit wide data bus

    always(addr or cs)          //Asynchronous output 
        case(addr)

            0: data = 8'h00;
            1: data = 8'h01;
            2: data = 8'h02;
            3: data = 8'h03;
            4: data = 8'h04;
            5: data = 8'h05;
            6: data = 8'h06;
            7: data = 8'h07;
        endcase
endmodule