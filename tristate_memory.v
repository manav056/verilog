//---------------------------------------------------------------------------------
//FILE NAME : tristate_buff.v
//TYPE : module
//DEPARTMENT : Electronics and Communication Engineering
//AUTHOR : Manav Saini
//AUTHOR'S EMAIL : manav2231079@akgec.ac.in
//---------------------------------------------------------------------------------
//RELEASE HISTORY 
//VERSION   DATE    AUTHOR  DESCRIPTION
//1.0   19/10/2024  manav   Initial version
//---------------------------------------------------------------------------------
//KEYWORDS : tristate, buffer
//---------------------------------------------------------------------------------
//PURPOSE : Tristate buffer for memory interfacing

module tristate_buff(bus,           
                     data_in,
                     data_out,
                     read,
                     write);

    tri [7:0] bus;      //Tristate bus
    wire [7:0] data_in,data_out;    //Separate input and output buses
    assign bus = read ? data_out : 8'hzz;   //if read=1 then data available otherwise high impedance
    assign data_in = write ? bus : 8'hzz;   //if write=1 then data can be written otherwise high impedance
endmodule