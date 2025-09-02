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
	`uvm_info(get_type_name(), "Printing UVM topology", UVM_LOW)
    uvm_top.print_topology();
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_5_packets::get_type());
	//this indicates that tb is a child of current class i.e. base_test.
	tb = router_tb::type_id::create("tb", this);
	`uvm_info(get_type_name(), $sformatf("build phase of the test is being executed"), UVM_HIGH)
endfunction

task run_phase(uvm_phase phase);
	uvm_objection obj = phase.get_objection(); 
	obj.set_drain_time(this, 200ns); 
endtask

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


function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_5_packets::get_type());
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


/*
class set_config_test extends base_test;

`uvm_component_utils(set_config_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	super.build_phase(phase);
	uvm_config_int::set( this, "*", "recording_detail", 1);
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_5_packets::get_type());
	uvm_config_int::set(this, "tb.env.agent", "is_active", UVM_PASSIVE);
	`uvm_info(get_type_name(), $sformatf("build phase of the set_config test is being executed"), UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : set_config_test


class incr_payload_test extends base_test;

`uvm_component_utils(incr_payload_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_incr_payload_seq::get_type());
	`uvm_info(get_type_name(), $sformatf("build phase of the incr_payload_test test is being executed"), UVM_HIGH)
	set_type_override_by_type( yapp_packet::get_type(), short_packet::get_type() );
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : incr_payload_test



class exhaustive_seq_test extends base_test;

`uvm_component_utils(exhaustive_seq_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_exhaustive_seq::get_type());
	`uvm_info(get_type_name(), $sformatf("build phase of the exhaustive_seq_test test is being executed"), UVM_HIGH)
	set_type_override_by_type( yapp_packet::get_type(), short_packet::get_type() );
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : exhaustive_seq_test



class yapp_012_test extends base_test;

`uvm_component_utils(yapp_012_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	`uvm_info(get_type_name(), "Printing UVM topology", UVM_LOW)
    uvm_top.print_topology();
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_012_seq::get_type());
	`uvm_info(get_type_name(), $sformatf("build phase of the yapp_012_test test is being executed"), UVM_HIGH)
	set_type_override_by_type( yapp_packet::get_type(), short_packet::get_type() );
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : yapp_012_test


class simple_test extends base_test;

`uvm_component_utils(simple_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	super.build_phase(phase);
	`uvm_info(get_type_name(), "Printing UVM topology", UVM_LOW)
    uvm_top.print_topology();
	uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", "default_sequence", yapp_012_seq::get_type());
	`uvm_info(get_type_name(), $sformatf("build phase of the simple_test test is being executed"), UVM_HIGH)
	set_type_override_by_type( yapp_packet::get_type(), short_packet::get_type() );
	uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::get_type());
	uvm_config_wrapper::set(this, "tb.car_env.agent.sequencer.run_phase", "default_sequence", clk10_rst5_seq::get_type());
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : simple_test
*/


class mc_test extends base_test;

`uvm_component_utils(mc_test)

function new(string name , uvm_component parent);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	//super indicates base class. build_phase() of base class will be
	//executd first
	uvm_config_int::set( this, "*", "recording_detail", 1);
	`uvm_info(get_type_name(), "Printing UVM topology", UVM_LOW)
    uvm_top.print_topology();
	`uvm_info(get_type_name(), $sformatf("build phase of the mc_test test is being executed"), UVM_HIGH)
	
	//set_type_override_by_type( yapp_packet::get_type(), short_packet::get_type() );
	
	uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::get_type());
	uvm_config_wrapper::set(this, "tb.car_env.agent.sequencer.run_phase", "default_sequence", clk10_rst5_seq::get_type());
	uvm_config_wrapper::set(this, "tb.mcseqr.run_phase", "default_sequence", router_simple_mcseq::get_type());
	super.build_phase(phase);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction

endclass : mc_test