module ddr4_assertions#(parameter ADDR_WIDTH=32, DATA_WIDTH=16)(
  	input ddr4_ckt,
	input ddr4_ckc,
	input ddr4_reset_n,
	input ddr4_cs_n,
	input [ADDR_WIDTH-1:0] ddr4_addr,
	input ddr4_we_n,
	input ddr4_dm,
	input ddr4_ras_n,
	input ddr4_cas_n,
	input ddr4_ready,
	input [DATA_WIDTH-1:0] ddr4_dq,  
	input [71:0] ddr4_command,
	input [4:0] cas_RD_latency
	
	);

   	localparam IDLE    = "IDLE"; //0
	localparam ACTIVATE= "ACTIVATE"; //2
	localparam MRS = "MRS"; //1
	localparam READ    = "READ"; //3
	localparam WRITE   = "WRITE"; //4
	localparam PRECHARGE = "PRECHARGE";//5

    assert_reset_to_idle: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        !ddr4_reset_n |-> (ddr4_command == IDLE)
    ) 
	 $display("Assertion: time=%0t, ddr4_command= %s",$time,ddr4_command);
	else $error("Assertion failed: reset_n did not return system to IDLE");

    assert_ready_idle_or_activate: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc) disable iff(!ddr4_reset_n)
        (ddr4_command == IDLE || ddr4_command == ACTIVATE || ddr4_command == MRS || ddr4_command == WRITE)  |-> ddr4_ready == 0
    ) else $error("ddr4_ready should be HIGH in IDLE or ACTIVATE");

    assert_cmd_read: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        (ddr4_command == READ) |-> (ddr4_ras_n == 1 && ddr4_cas_n == 0 && ddr4_we_n == 1)
    ) 
	 $display("Assertion2: time=%0t, ddr4_command= %s",$time,ddr4_command);
	else $error("Invalid command encoding in READ");

    assert_cmd_write: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        (ddr4_command == WRITE) |-> (ddr4_ras_n == 1 && ddr4_cas_n == 0 && ddr4_we_n == 0)
    ) else;


	sequence dq_remains_invalid_read(int latency);
	(ddr4_command==READ) ##(2*latency+1) (!$isunknown(ddr4_dq)) ;
	endsequence

	always@(posedge ddr4_ckt or posedge ddr4_ckc)
	begin
	$display("latency=%0d time=%0t",cas_RD_latency, $time);
	if(ddr4_command==READ)
	case(cas_RD_latency)
	5'b00000:assert_dq_remains_invalid_read1: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(9));
	5'b00001:assert_dq_remains_invalid_read2: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(10));
	5'b00010:assert_dq_remains_invalid_read3: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(11));
	5'b00011:assert_dq_remains_invalid_read4: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(12));
	5'b00100:assert_dq_remains_invalid_read5: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(13));
	5'b00101:assert_dq_remains_invalid_read6: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(14));

	5'b00110:assert_dq_remains_invalid_read7: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(15));

	5'b00111:assert_dq_remains_invalid_read8: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(16));
	5'b01000:assert_dq_remains_invalid_read9: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(18));
	5'b01001:assert_dq_remains_invalid_read10: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(20));
	5'b01010:assert_dq_remains_invalid_read11: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(22));
	5'b01011:assert_dq_remains_invalid_read12: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(24));
	5'b01100:assert_dq_remains_invalid_read13: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(23));
	5'b01101:assert_dq_remains_invalid_read14: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(17));
	5'b01110:assert_dq_remains_invalid_read15: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(19));
	5'b01111:assert_dq_remains_invalid_read16: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(21));
	5'b10000:assert_dq_remains_invalid_read17: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(25));
	5'b10001:assert_dq_remains_invalid_read18: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(26));
	5'b10010:assert_dq_remains_invalid_read19: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(28));
	5'b10011:assert_dq_remains_invalid_read20: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(29));
	5'b10100:assert_dq_remains_invalid_read21: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(30));
	5'b10101:assert_dq_remains_invalid_read22: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(31));
	5'b10110:assert_dq_remains_invalid_read23: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(32));
	5'b11111:assert_dq_remains_invalid_read24: assert property(@(posedge ddr4_ckt or posedge ddr4_ckc)dq_remains_invalid_read(0));
	endcase
	end


	property dq_remains_invalid_write;
	@(posedge ddr4_ckt or posedge ddr4_ckc)
	(ddr4_command==WRITE) |=> ##1 (!$isunknown(ddr4_dq)) ;
	endproperty
	
	assert_dq_remains_invalid_write: assert property (dq_remains_invalid_write)
	else $error("Assertion failed: ddr4_dq must remain Z for cas_RD_latency cycles after WRITE, then become valid.");

	property cas_activate;
	@(posedge ddr4_ckt or posedge ddr4_ckc)
	(ddr4_command==ACTIVATE) |=> (ddr4_cas_n==0) ;
	endproperty

	assert_invalid_cas: assert property (cas_activate)
	else $error("Assertion failed: cas_activate");

	assert_ready_precharge: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        (ddr4_ready == 1) |-> (ddr4_command== PRECHARGE) )
     else $error("Invalid command encoding in WRITE");

	assert_ready_after_precharge: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        (ddr4_ready == 1) |=> (ddr4_command== IDLE) )
     else $error("Invalid command encoding in WRITE");



endmodule


/*   
 dq is not binded

	sequence read_latency_check;
        (ddr4_command == READ && ddr4_dm == 0) ##cas_RD_latency (ddr4_dq !== 16'hzzzz);
    endsequence

    assert_cas_latency: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        read_latency_check
    ) else $error("CAS latency check failed: data not valid after expected delay");

    assert_dq_valid_on_read: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
       (ddr4_command == READ && ddr4_dm == 0) |-> (ddr4_dq !== 16'hzzzz)
   ) else $error("ddr4_dq should carry data during READ when ddr4_dm == 0");

    assert_dq_highz_on_write: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        (ddr4_command == WRITE && ddr4_dm == 1) |-> (ddr4_dq !== 16'hzzzz)
    ) else $error("ddr4_dq should be high-Z during WRITE when ddr4_dm == 1");

      assert_cmd_precharge: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
       (ddr4_command == PRECHARGE) |-> (ddr4_ras_n == 1 && ddr4_cas_n == 1 && ddr4_we_n == 1) //everything needs to be 1

    ) else $error("Invalid command encoding in PRECHARGE");

   assert_cmd_activate: assert property (@(posedge ddr4_ckt or posedge ddr4_ckc)
        (ddr4_command == ACTIVATE) |-> (ddr4_ras_n == 1 && ddr4_cas_n == 0 )
    ) else $error("Invalid command encoding in ACTIVATE");

*/


