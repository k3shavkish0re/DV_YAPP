/*-----------------------------------------------------------------
File name     : hw_top.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : lab06_vif hardware top module for acceleration
              : Instantiates clock generator and YAPP interface only for testing - no DUT
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;
  
  //HBUS signals
  logic            hen;
  logic            hwr_rd;
  logic      [15:0] haddr;
  logic      [7:0] hdata;

  // YAPP Interface to the DUT
  yapp_if in0(clock, reset);
  
  // Clock and reset interface
  clock_and_reset_if car_if(clock, reset, run_clock, clock_period);
  
  // HBUS interface
  hbus_if h_if(clock, reset);
  
  // Channel0 interface
  channel_if chan0(clock, reset);
  
  // Channel1 interface
  channel_if chan1(clock, reset);
  
  // Channel2 interface
  channel_if chan2(clock, reset);

  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );

  yapp_router dut(
    .reset(reset),
    .clock(clock),
    .error(),

    // YAPP interface
    .in_data(in0.in_data),
    .in_data_vld(in0.in_data_vld),
    .in_suspend(in0.in_suspend),

    // Output Channels
    //Channel 0
    .data_0(chan0.data),
    .data_vld_0(chan0.data_vld),
    .suspend_0(chan0.suspend),
    //Channel 1
    .data_1(chan1.data),
    .data_vld_1(chan1.data_vld),
    .suspend_1(chan1.suspend),
    //Channel 2
    .data_2(chan2.data),
    .data_vld_2(chan2.data_vld),
    .suspend_2(chan2.suspend),

    // HBUS Interface 
    .haddr(haddr),
    .hdata(h_if.hdata_w),
    .hen(hen),
    .hwr_rd(hwr_rd));

endmodule
