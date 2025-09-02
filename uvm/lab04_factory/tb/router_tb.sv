class router_tb extends uvm_env;

`uvm_component_utils(router_tb)

function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

yapp_env env;


//virtual function declared in base class(in this case, testbench) so that it
//can be overriden later
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = yapp_env::type_id::create("env", this);
	`uvm_info(get_type_name(), $sformatf("build phase of the testbench is being executed."), UVM_HIGH);
endfunction

endclass
