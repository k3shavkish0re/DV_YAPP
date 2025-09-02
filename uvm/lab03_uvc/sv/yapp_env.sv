class yapp_env extends uvm_env;

//component utility macro
`uvm_component_utils(yapp_env)
 
 //component constructor
 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction
 
 yapp_tx_agent agent;
 
  function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executed first
	super.build_phase(phase);
	//this indicates that lhs is a child of current class i.e. yapp_tx_agent.
	agent = new("agent", this);
endfunction
 
endclass