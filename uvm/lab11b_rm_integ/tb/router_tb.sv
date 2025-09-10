class router_tb extends uvm_env;

//`uvm_component_utils(router_tb)
yapp_router_regs_vendor_Cadence_Design_Systems_library_Yapp_Registers_version_1_5 yapp_rm;

//automation
`uvm_component_utils_begin(router_tb)
 `uvm_field_object(yapp_rm, UVM_ALL_ON)
`uvm_component_utils_end

function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

yapp_env env;
channel_env chan0, chan1, chan2;
hbus_env h_env;
clock_and_reset_env car_env;
router_mcsequencer mcseqr;
router_scoreboard scoreboard;


hbus_reg_adapter    reg2hbus;

typedef yapp_router_regs_vendor_Cadence_Design_Systems_library_Yapp_Registers_version_1_5 yapp_router_regs_t;




//virtual function declared in base class(in this case, testbench) so that it
//can be overriden later
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//configure before creation to prevent race condition
	//because we are directly setting the value 0,1,2 for channel_id, we don't need configuration object
	uvm_config_int::set(this, "chan0", "channel_id", 0); 
	uvm_config_int::set(this, "chan1", "channel_id", 1); 
	uvm_config_int::set(this, "chan2", "channel_id", 2); 
	uvm_config_int::set(this, "h_env", "num_masters", 1);
    uvm_config_int::set(this, "h_env", "num_slaves", 0);
	
	//environment handle creation
	env = yapp_env::type_id::create("env", this);
	chan0 = channel_env::type_id::create("chan0", this);
	chan1 = channel_env::type_id::create("chan1", this);
	chan2 = channel_env::type_id::create("chan2", this);
	h_env = hbus_env::type_id::create("h_env", this);
	car_env = clock_and_reset_env::type_id::create("car_env", this); 
	mcseqr = router_mcsequencer::type_id::create("mcseqr",this);
	scoreboard = router_scoreboard::type_id::create("scoreboard", this);
	yapp_rm = yapp_router_regs_t::type_id::create("yapp_rm", this);
	yapp_rm.build();
	yapp_rm.lock_model();
	yapp_rm.default_map.set_auto_predict(1);
	yapp_rm.set_hdl_path_root("hw_top.dut");
	reg2hbus = hbus_reg_adapter::type_id::create("reg2hbus",this);
	`uvm_info(get_type_name(), $sformatf("build phase of the testbench is being executed."), UVM_HIGH);
	`uvm_info(get_type_name(), "Printing UVM topology", UVM_LOW)
    uvm_top.print_topology();
endfunction

virtual function void connect_phase(uvm_phase phase);
	mcseqr.hbus_seqr= h_env.masters[0].sequencer;
	mcseqr.yapp_seqr= env.agent.sequencer;
	env.agent.monitor.yapp_out.connect(scoreboard.yapp_in);
	chan0.rx_agent.monitor.item_collected_port.connect(scoreboard.chan0_in);
	chan1.rx_agent.monitor.item_collected_port.connect(scoreboard.chan1_in);
	chan2.rx_agent.monitor.item_collected_port.connect(scoreboard.chan2_in);
	//h_env.masters[0].monitor.hbus_out.connect(scoreboard.hbus_in);
	
	yapp_rm.default_map.set_sequencer(h_env.masters[0].sequencer, reg2hbus);
 endfunction: connect_phase

endclass
