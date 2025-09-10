typedef enum bit{COV_ENABLE, COV_DISABLE} cover_t;

class yapp_tx_monitor extends uvm_monitor;

//component utility macro
`uvm_component_utils(yapp_tx_monitor)
 
uvm_analysis_port #(yapp_packet) yapp_out;

//enable coverage
cover_t enable_cover = COV_ENABLE;
  
// Collected Data handle
yapp_packet pkt;

// Count packets collected
int num_pkt_col;

covergroup collected_pkts_cg;
	//REQ1
	pkt_len : coverpoint pkt.length {
		illegal_bins zero  = {0};
		bins MIN = {1};
		bins MAX = {63};
		bins SMALL  = {[2:10]};
		bins MEDIUM  = {[11:40]};
		bins LARGE = {[41:62]};
	}
	
	//REQ2
	pkt_addr : coverpoint pkt.addr {
		bins all = {[0:3]};
	}
	pkt_parity_type : coverpoint pkt.parity_type {
		bins all = {BAD_PARITY , GOOD_PARITY};
	}
	
	//REQ3
	REQ3 : cross pkt_len, pkt_addr, pkt_parity_type iff (pkt.addr == 2'd2 && pkt.parity_type == BAD_PARITY);
endgroup
 
 //component constructor
 function new(string name, uvm_component parent);
	super.new(name, parent);
	yapp_out = new("yapp_out", this);
	if (enable_cover == COV_ENABLE)
		collected_pkts_cg = new();
 endfunction
 
 virtual interface yapp_if vif;

  // UVM connect_phase
  function void connect_phase(uvm_phase phase);
		if (!yapp_vif_config::get(this,"","vif", vif)) 
		`uvm_error("NOVIF","vif not set") 
  endfunction : connect_phase

 
 virtual task run_phase(uvm_phase phase);
	`uvm_info("MONITOR INFO", $sformatf("You are in the MONITOR"), UVM_LOW)
	
	    // Look for packets after reset
    @(posedge vif.reset)
    @(negedge vif.reset)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_MEDIUM)
    forever begin 
      // Create collected packet instance
      pkt = yapp_packet::type_id::create("pkt", this);

      // concurrent blocks for packet collection and transaction recording
      fork
        // collect packet
        vif.collect_packet(pkt.length, pkt.addr, pkt.payload, pkt.parity);
		
        // trigger transaction at start of packet
        @(posedge vif.monstart) void'(begin_tr(pkt, "Monitor_YAPP_Packet"));
      join
	
	  yapp_out.write(pkt);
      pkt.parity_type = (pkt.parity == pkt.calc_parity()) ? GOOD_PARITY : BAD_PARITY;
      // End transaction recording
	  
	  //sampling coverage manually after packet is collected
	  collected_pkts_cg.sample();
	  
      end_tr(pkt);
      `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt.sprint()), UVM_LOW)
      num_pkt_col++;
    end

 endtask
 
 
  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  endfunction : report_phase

endclass