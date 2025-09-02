class router_scoreboard extends uvm_scoreboard;

`uvm_component_utils(router_scoreboard)

 //object creation
`uvm_analysis_imp_decl(_yapp)
`uvm_analysis_imp_decl(_chan0)
`uvm_analysis_imp_decl(_chan1)
`uvm_analysis_imp_decl(_chan2)


 // Declare analysis imp handles
  uvm_analysis_imp_yapp #(yapp_packet, router_scoreboard) yapp_in;
  uvm_analysis_imp_chan0 #(channel_packet, router_scoreboard) chan0_in;
  uvm_analysis_imp_chan1 #(channel_packet, router_scoreboard) chan1_in;
  uvm_analysis_imp_chan2 #(channel_packet, router_scoreboard) chan2_in;

int num_packets_received;
int num_packets_unmatched;
int num_packets_matched;

yapp_packet q0[$], q1[$], q2[$];

 //component constructor
 function new(string name, uvm_component parent);
	super.new(name, parent);
	//instance creation
	yapp_in = new("yapp_in", this);
	chan0_in = new("chan0_in", this);
	chan1_in = new("chan1_in", this);
	chan2_in = new("chan2_in", this);
 endfunction
 
 
 function void write_yapp(input yapp_packet packet);
	yapp_packet ypkt;
	// Make a clone for storing in scoreboard
	$cast( ypkt,  packet.clone() );
	case (ypkt.addr)
		2'b00:q0.push_back(ypkt);
		2'b01:q1.push_back(ypkt);
		2'b10:q2.push_back(ypkt);
	endcase
	num_packets_received++;
 endfunction
 
 function void write_chan0(input channel_packet packet);
	yapp_packet ypkt;
	case (packet.addr)
		2'b00:ypkt = q0.pop_front();
	endcase
	if(comp_equal(ypkt , packet)) num_packets_matched++;
	else num_packets_unmatched++;
 endfunction
 
 function void write_chan1(input channel_packet packet);
 	yapp_packet ypkt;
	case (packet.addr)
		2'b01:ypkt = q1.pop_front();
	endcase
	if(comp_equal(ypkt , packet)) num_packets_matched++;
	else num_packets_unmatched++;
 endfunction
 
 function void write_chan2(input channel_packet packet);
 	yapp_packet ypkt;
	case (packet.addr)
		2'b10:ypkt = q2.pop_front();
	endcase
	if(comp_equal(ypkt , packet)) num_packets_matched++;
	else num_packets_unmatched++;
 endfunction

 // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: Number of packets received: %0d", num_packets_received), UVM_LOW)
	`uvm_info(get_type_name(), $sformatf("Report: Number of wrong packets(compare failed): %0d", num_packets_unmatched), UVM_LOW)
	`uvm_info(get_type_name(), $sformatf("Report: Number of matched packets: %0d", num_packets_matched), UVM_LOW)
	`uvm_info(get_type_name(), $sformatf("Report: Packets left in q0=%0d, q1=%0d, q2=%0d", q0.size(), q1.size(), q2.size()), UVM_LOW)
  endfunction : report_phase


    // custom packet compare function using inequality operators
   function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
          `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
      if (yp.parity != cp.parity) begin
        `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
        return(0);
      end
      return(1);
   endfunction



endclass : router_scoreboard