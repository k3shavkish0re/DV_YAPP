class yapp_tx_monitor extends uvm_monitor;

//component utility macro
`uvm_component_utils(yapp_tx_monitor)
 
 //component constructor
 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction
 
 virtual task run_phase(uvm_phase phase);
	`uvm_info("MONITOR INFO", $sformatf("You are in the MONITOR"), UVM_LOW)
 endtask
 
endclass