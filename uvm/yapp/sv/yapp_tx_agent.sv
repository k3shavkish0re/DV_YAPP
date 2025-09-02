class yapp_tx_agent extends uvm_agent;

yapp_tx_monitor monitor;
yapp_tx_driver driver;
yapp_tx_sequencer sequencer;

//component utility macro
//`uvm_component_utils(yapp_tx_agent)
 
//We don't have to double declare utility macros. It will throw error.
//component field macro
`uvm_component_utils_begin(yapp_tx_agent)
	`uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
`uvm_component_utils_end 
 
 //component constructor
 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction
 
 //build_phase, connect_phase are declared as functions because functions don't consume simulation time
 //only task can consume simulation time
 
 function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executed first
	super.build_phase(phase);
	//this indicates that lhs is a child of current class i.e. yapp_tx_agent.
	monitor = yapp_tx_monitor::type_id::create("monitor", this);
	if (is_active == UVM_ACTIVE) begin
		driver = yapp_tx_driver::type_id::create("driver", this);
		sequencer = yapp_tx_sequencer::type_id::create("sequencer", this);
	end
endfunction
 
virtual function void connect_phase(uvm_phase phase);
	if (is_active == UVM_ACTIVE)
		driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
 
endclass