//Environment class instantiates driver, monitor, generator and scoreboard

class env;

    drv d0;       //Driver Handle
    mon m0;       //Monitor Handle
    gen g0;       //Generator Handle
    scb s0;       //Scoreboard Handle

    mailbox drv_mbx;       //Connect GEN -> DRV
    mailbox scb_mbx;       //Connect MON -> SCB

    virtual dff_if vif;    //Virtual Interface

    function new();

        d0 = new;
        m0 = new;
        g0 = new;
        s0 = new;
        drv_mbx = new();
        scb_mbx = new();