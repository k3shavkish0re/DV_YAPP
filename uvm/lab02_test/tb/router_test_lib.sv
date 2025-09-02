class base_test extends uvm_test;

`uvm_component_utils(base_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

//testbench handle
router_tb tb;

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executed first
	super.build_phase(phase);
	//this indicates that tb is a child of current class i.e. base_test.
	tb = new("tb", this);
	`uvm_info(get_type_name(), $sformatf("build phase of the test is being executed"), UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

endclass
