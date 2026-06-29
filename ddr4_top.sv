`define ADDR_WIDTH 32
`define DATA_WIDTH 16

`timescale 1ps/1ps
    `include "uvm_macros.svh"
    import uvm_pkg::*;
	`include "ddr4_agent_config.sv"
	
    // Include sequence items and sequences
    `include "ddr4_seq_item.sv"
    `include "ddr4_write_seq.sv"
    `include "ddr4_read_seq.sv"
	`include "ddr4_bl4_read_sequence.sv"
	`include "ddr4_invalid_wr_addr_seq.sv"
	`include "ddr4_invalid_rd_addr_seq.sv"

    // Include UVM components
    `include "ddr4_sequencer.sv"
    `include "ddr4_driver.sv"
    `include "ddr4_monitor.sv"
    `include "ddr4_agent.sv"
`include "ddr4_ref_model.sv"
    `include "ddr4_scoreboard.sv"
	`include "ddr4_coverage.sv"
    `include "ddr4_environment.sv"

    // Include testbench
    `include "ddr4_base_test.sv"
	`include "ddr4_write_test.sv"
	`include "ddr4_write_read_test.sv"
	`include "ddr4_invalid_addr_test.sv"
	`include "ddr4_interleave_burst4_random_read_test.sv"
	`include "ddr4_interleave_burst8_random_read_test.sv"
	`include "ddr4_nibble_burst4_random_read_test.sv"
	`include "ddr4_nibble_burst8_random_read_test.sv"
	`include "ddr4_bl8_write_bl4_read_test.sv"
	`include "ddr4_reset_test.sv"


`include "ddr4_interface.sv"
`include "ddr4_rtl.sv"
`include "ddr4_assertions.sv"


module ddr4_top;

bit ddr4_ckt,ddr4_ckc,ddr4_reset_n;
wire [15:0] temp_dq;

ddr4_interface ddr4_intf(ddr4_ckt,ddr4_ckc,ddr4_reset_n);
ddr4_rtl dut(.ddr4_ckt(ddr4_intf.ddr4_ckt), 
		.ddr4_ckc(ddr4_intf.ddr4_ckc), 
		.ddr4_reset_n(ddr4_intf.ddr4_reset_n),
		.ddr4_addr(ddr4_intf.ddr4_addr),
		.ddr4_cas_n(ddr4_intf.ddr4_cas_n),
		.ddr4_ras_n(ddr4_intf.ddr4_ras_n),
		.ddr4_we_n(ddr4_intf.ddr4_we_n),
		.ddr4_dm(ddr4_intf.ddr4_dm),
		.ddr4_cs_n(ddr4_intf.ddr4_cs_n),
		.ddr4_cke(ddr4_intf.ddr4_cke),
		.ddr4_ready(ddr4_intf.ddr4_ready)
//		.ddr4_command(ddr4_intf.ddr4_command)
	   );	

ddr4_assertions assertions(.ddr4_ckt(ddr4_ckt), 
		.ddr4_ckc(ddr4_ckc), 
		.ddr4_reset_n(ddr4_reset_n),
		.ddr4_addr(dut.ddr4_addr),
		.ddr4_cas_n(dut.ddr4_cas_n),
		.ddr4_ras_n(dut.ddr4_ras_n),
		.ddr4_we_n(dut.ddr4_we_n),
		.ddr4_dm(dut.ddr4_dm),
		.ddr4_cs_n(dut.ddr4_cs_n),
		.ddr4_ready(ddr4_intf.ddr4_ready),
		.ddr4_dq(ddr4_intf.ddr4_dq),
		.ddr4_command(dut.ddr4_command),
		.cas_RD_latency(dut.cas_RD_latency)
		);

assign dut.ddr4_dq=(dut.ddr4_dm==1)?ddr4_intf.ddr4_dq:16'hzzzz;

//bind ddr4_rtl ddr4_bind bind_inst();

assign temp_dq=(dut.ddr4_dm==0)?dut.ddr4_dq:16'hzzzz;

assign ddr4_intf.ddr4_dq=(dut.ddr4_dm==0)?temp_dq:16'hzzzz;

always #312 ddr4_ckt=~ddr4_ckt; 
always #312 ddr4_ckc=~ddr4_ckc;

initial 
begin
uvm_config_db#(virtual ddr4_interface)::set(null,"*","ddr4_interface",ddr4_intf);
		   ddr4_ckt=1'b1;
		   ddr4_ckc=1'b0;
		   ddr4_reset_n=1'b0;
		   #624;
		   ddr4_reset_n=1'b1;
		 //  #1500;
		 //  ddr4_reset_n=1'b0;
		 //  #1000;
		 //  ddr4_reset_n=1'b1;

		   
$display("TEMP DQ:= %0d",temp_dq);

end

 initial 
 begin
	 run_test("");
 end
 endmodule

