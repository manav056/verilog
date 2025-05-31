//test class

class dff_test extends uvm_test:       //uvm_test is the base test class
    `uvm_component_utils(dff_test);    //Register dff_test to UVM Factory

    
    //Standard Contructor
    function new(string name="dff_test", uvm_component parent);

    super.new(name, parent);

    `uvm_info("Test Class", "Constructor", UVM_MEDIUM);

    endfunction

endclass