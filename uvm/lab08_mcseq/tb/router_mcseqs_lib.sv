class router_simple_mcseq extends uvm_sequence;

`uvm_object_utils(router_simple_mcseq)
`uvm_declare_p_sequencer(router_mcsequencer)

  function new(string name="router_simple_mcseq");
    super.new(name);
  endfunction
  
hbus_small_packet_seq h_small;
hbus_set_default_regs_seq h_default;
hbus_read_max_pkt_seq h_read;
yapp_012_seq y_012;
yapp_1_packet y_one; 


virtual task pre_body();
	if (starting_phase != null)
		starting_phase.raise_objection(this, get_type_name());
 endtask
 
 virtual task body();
	`uvm_do_on(h_small, p_sequencer.hbus_seqr)
	`uvm_do_on(h_read, p_sequencer.hbus_seqr)
	`uvm_do_on(y_012, p_sequencer.yapp_seqr)
	`uvm_do_on(y_012, p_sequencer.yapp_seqr)
	`uvm_do_on(h_default, p_sequencer.hbus_seqr)
	`uvm_do_on(h_read, p_sequencer.hbus_seqr)
	repeat(6)
		`uvm_do_on(y_one, p_sequencer.yapp_seqr)
 endtask
 
 
 virtual task post_body();
	if (starting_phase != null)
		starting_phase.drop_objection(this, get_type_name());
 endtask


endclass: router_simple_mcseq