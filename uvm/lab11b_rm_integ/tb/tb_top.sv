/*-----------------------------------------------------------------
File name     : tb_top.sv
Description   : lab06_data tb_top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module tb_top;
// import the UVM library
import uvm_pkg::*;
// include the UVM macros
`include "uvm_macros.svh"


// import the yapp package
import yapp_pkg::*;
import clock_and_reset_pkg::*;
import hbus_pkg::*;
import channel_pkg::*;
import yapp_router_reg_pkg::*;

// import the router_tb
`include "router_mcsequencer.sv"
`include "router_mcseqs_lib.sv"
//`include "yapp_router_regs_rdb.sv"
//`include "cdns_uvmreg_utils_pkg.sv"
`include "../sv/router_scoreboard.sv"
`include "router_tb.sv"
`include "router_test_lib.sv"


initial begin
yapp_vif_config::set(null, "uvm_test_top.tb.env.*", "vif", hw_top.in0);
hbus_vif_config::set(null, "uvm_test_top.tb.h_env.*", "vif", hw_top.h_if);
clock_and_reset_vif_config::set(null, "uvm_test_top.tb.car_env.*", "vif", hw_top.car_if);
channel_vif_config::set(null, "uvm_test_top.tb.chan0.*", "vif", hw_top.chan0);
channel_vif_config::set(null, "uvm_test_top.tb.chan1.*", "vif", hw_top.chan1);
channel_vif_config::set(null, "uvm_test_top.tb.chan2.*", "vif", hw_top.chan2);
run_test("uvm_reset_test");
uvm_root::get().print_topology();
end

initial begin
  $monitor("DUT_INFO: time=%0t, hw_in_data=%h", $time, hw_top.in0.in_data);
end


// experiment with the copy, clone and compare UVM method
endmodule : tb_top
