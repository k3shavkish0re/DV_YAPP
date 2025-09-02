/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module top;
// import the UVM library
import uvm_pkg::*;
// include the UVM macros
`include "uvm_macros.svh"
// import the YAPP package
import yapp_pkg::*;

//instance of yapp_packet
yapp_packet pkt;

// generate 5 random packets and use the print method
// to display the results
initial begin
	for(int i=0; i<5; i++) begin
		pkt = yapp_packet::type_id::create($sformatf("pkt_%0d", i));
		if(!pkt.randomize()) begin
			`uvm_error("RAND", $sformatf("Randomization failed for packet pkt_%0d", i));
		end
		pkt.print();
	end

end

// experiment with the copy, clone and compare UVM method
endmodule : top
