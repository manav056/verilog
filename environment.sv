//environment class

class dff_env extends uvm_env:
    `uvm_component_utils(dff_env);
    
    function new(string name="dff_env", uvm_component parent);

    super.new(name, parent);

    `uvm_info("Environment Class", "Constructor", UVM_MEDIUM);

    endfunction

endclass