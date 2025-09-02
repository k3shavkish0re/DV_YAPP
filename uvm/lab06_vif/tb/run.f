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

// compile files
//*** add compile files here
hw_top.sv
clkgen.sv
../sv/yapp_pkg.sv
../sv/yapp_if.sv
../../router_rtl/yapp_router.sv
tb_top.sv
