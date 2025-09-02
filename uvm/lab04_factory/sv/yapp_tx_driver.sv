class yapp_tx_driver extends uvm_driver #(yapp_packet);

//parameterization creates a yapp_packet object handle req automatically which can be used

//component utility macro
`uvm_component_utils(yapp_tx_driver)
 
 //component constructor
 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction
 
 virtual task run_phase(uvm_phase phase);
	forever begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
 endtask

virtual task send_to_dut(yapp_packet packet);
`uvm_info("PACKET INFO", $sformatf("Packet is \n%s", req.sprint()), UVM_LOW)
#10;
endtask

endclass