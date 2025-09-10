/*-----------------------------------------------------------------
File name     : run.f
Description   : lab01_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/
-timescale 1ns/1ns

// 64 bit option for AWS labs
-64


 -uvmhome $UVMHOME

// include directories
//*** add incdir include directories here
-incdir ../sv
-incdir ../../hbus
-incdir ../../hbus/sv
-incdir ../../clock_and_reset
-incdir ../../clock_and_reset/sv
-incdir ../../channel
-incdir ../../channel/sv
-incdir ../../yapp
-incdir ../../yapp/sv



// compile files
//*** add compile files here
hw_top.sv
clkgen.sv
yapp_router_regs_rdb.sv
cdns_uvmreg_utils_pkg.sv 
../../yapp/sv/yapp_pkg.sv
../../yapp/sv/yapp_if.sv
../../router_rtl/yapp_router.sv
../../hbus/sv/hbus_pkg.sv
../../hbus/sv/hbus_if.sv
../../clock_and_reset/sv/clock_and_reset_pkg.sv
../../clock_and_reset/sv/clock_and_reset_if.sv
../../channel/sv/channel_pkg.sv
../../channel/sv/channel_if.sv

tb_top.sv
