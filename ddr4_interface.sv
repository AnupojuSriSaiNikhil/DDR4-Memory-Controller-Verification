interface ddr4_interface#(parameter ADDR_WIDTH=32, DATA_WIDTH=16)(input bit ddr4_ckt, ddr4_ckc, ddr4_reset_n);
	logic ddr4_ras_n;
	logic [ADDR_WIDTH-1:0] ddr4_addr;
	logic ddr4_cas_n;
	logic ddr4_dm;
	logic ddr4_we_n;
    logic ddr4_cs_n;
	logic ddr4_cke;	//inputs to ddr4 controller
	logic ddr4_ready;
	logic [DATA_WIDTH-1:0] ddr4_dq; //inout signal
	
clocking mon_cb@(posedge ddr4_ckt or posedge ddr4_ckc);
input ddr4_addr;
input ddr4_cs_n;
input ddr4_ras_n;
input ddr4_cas_n;
input ddr4_we_n;
input ddr4_cke;
input ddr4_ready;
input ddr4_dq;
input ddr4_dm;
endclocking

modport mon_mp(clocking mon_cb, input ddr4_reset_n);

endinterface
