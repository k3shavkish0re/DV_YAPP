class base_test extends uvm_test;

`uvm_component_utils(base_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

//testbench handle
router_tb tb;

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_5_packets::get_type());
	//this indicates that tb is a child of current class i.e. base_test.
	tb = router_tb::type_id::create("tb", this);
	`uvm_info(get_type_name(), $sformatf("build phase of the test is being executed"), UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : base_test

class short_packet_test extends base_test;

`uvm_component_utils(short_packet_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

//testbench handle
router_tb tb_short;

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "tb_short.env.agent.sequencer.run_phase", "default_sequence", yapp_5_packets::get_type());
	//this indicates that tb_short is a child of current class i.e. base_test.
	tb_short = router_tb::type_id::create("tb_short", this);
	set_type_override_by_type( yapp_packet::get_type(), short_packet::get_type() );
	`uvm_info(get_type_name(), $sformatf("build phase of the short packet test is being executed"), UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : short_packet_test


class set_config_test extends base_test;

`uvm_component_utils(set_config_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

//testbench handle
router_tb tb_set_config;

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	super.build_phase(phase);
	uvm_config_int::set( this, "*", "recording_detail", 1);
	uvm_config_wrapper::set(this, "tb_set_config.env.agent.sequencer.run_phase", "default_sequence", yapp_5_packets::get_type());
	uvm_config_int::set(this, "tb_set_config.env.agent", "is_active", UVM_PASSIVE);
	//this indicates that tb_set_config is a child of current class i.e. base_test.
	tb_set_config = router_tb::type_id::create("tb_set_config", this);
	`uvm_info(get_type_name(), $sformatf("build phase of the set_config test is being executed"), UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : set_config_test