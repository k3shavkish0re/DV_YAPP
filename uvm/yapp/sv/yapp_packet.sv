/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit {BAD_PARITY , GOOD_PARITY} parity_type_e;

class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:
rand bit [5:0] length;
rand bit [1:0] addr;
rand bit [7:0] payload[];
bit      [7:0] parity;

// Define protocol data


// Define control knobs
rand int packet_delay;
rand parity_type_e parity_type;

// Enable automation of the packet's fields
`uvm_object_utils_begin(yapp_packet)
	`uvm_field_int(length , UVM_ALL_ON)
	`uvm_field_int(addr , UVM_ALL_ON)
	`uvm_field_array_int(payload , UVM_ALL_ON)
	`uvm_field_int(parity , UVM_ALL_ON)
	//`uvm_field_int(length , UVM_ALL_ON)
	//`uvm_field_int(length , UVM_ALL_ON)
	//`uvm_field_int(length , UVM_ALL_ON)
	//`uvm_field_int(length , UVM_ALL_ON)
	//`uvm_field_int(length , UVM_ALL_ON)
`uvm_object_utils_end


// Define packet constraints
constraint valid_address {addr >= 0; addr < 4;}
constraint payload_size {length == payload.size();}
constraint default_length {length > 0; length < 64;}
constraint pkt_delay {packet_delay > 0; packet_delay < 20;}
constraint parity_distribution {parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1}; }


// Add methods for parity calculation and class construction
function new (string name = "yapp_packet");
	super.new(name);
endfunction

function bit [7:0] calc_parity();
	bit [7:0] header = {length , addr};
	bit [7:0] result = header;

	for(int i=0; i<payload.size(); i++) begin
		result = result ^ payload[i];
	end
	
	
	return result;
endfunction

function void set_parity();
	parity = calc_parity();
	if (parity_type == BAD_PARITY) begin
		parity = ~parity;
	end
endfunction

function void post_randomize();
	set_parity();
endfunction

endclass: yapp_packet




class short_packet extends yapp_packet;

// utility macro
`uvm_object_utils(short_packet)


// Define short packet constraints
constraint short_default_length {length > 0; length < 15;}
constraint valid_address { addr inside {0, 1, 3}; }

// Add methods for parity calculation and class construction
function new (string name = "short_packet");
	super.new(name);
endfunction

function bit [7:0] calc_parity();
	bit [7:0] header = {length , addr};
	bit [7:0] result = header;

	for(int i=0; i<payload.size(); i++) begin
		result = result ^ payload[i];
	end
	
	
	return result;
endfunction

function void set_parity();
	parity = calc_parity();
	if (parity_type == BAD_PARITY) begin
		parity = ~parity;
	end
endfunction

function void post_randomize();
	set_parity();
endfunction

endclass: short_packet
