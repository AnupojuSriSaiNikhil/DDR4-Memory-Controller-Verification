`include "ddr4_rtl.sv"

module ddr4_rtl_tb();
	reg ckt;
	reg ckc;
	reg reset_n;
	reg cs_n;
	reg [31:0] addr;
	reg we_n;
	reg dm;
	reg ras_n;
	reg cas_n;
	wire ddr4_ready;
	wire [15:0] ddr4_dq; 

	reg [1:0]burst_len;
	reg burst_type;
	reg [4:0]latency;

	reg[31:0] queue[$];


ddr4_rtl ddr4_tb(.ddr4_ckt(ckt),.ddr4_ckc(ckc),.ddr4_reset_n(reset_n),.ddr4_cs_n(cs_n),.ddr4_addr(addr),.ddr4_we_n(we_n),.ddr4_dm(dm),.ddr4_ras_n(ras_n),.ddr4_cas_n(cas_n),.ddr4_ready(ddr4_ready),.ddr4_dq(ddr4_dq) ); 

always #5 ckt=~ckt;
always #5 ckc=~ckc;

initial begin

//IDLE

	ckt=0;
	ckc=1;
	reset_n=0;
	cs_n=0;
//	cke=1;
	
	#10

//MRS

repeat(5)
begin

	reset_n=1;
	{ras_n,cas_n,we_n}=3'b000;

	burst_len=$urandom_range(0,1);
	burst_type=$random;
	latency=$urandom_range(0,21);
	

	addr[12:11]=2'b00;
	addr[7:3]=latency;
	addr[2]=burst_type;
	addr[1:0]=burst_len;
	addr[10:8]=$random;
	addr[17:13]=$random;
	addr[31:18]=0;
	ddr4_dq=$random;

	queue.push_back(addr);

//ACTIVATE

	#5;
	dm=1;

//WRITE
	repeat(10)
	begin
  	@(posedge ckt);
	end	
end
	
//READ
	
repeat(5)
begin

	dm=0;
	addr=queue.pop_front();

	repeat(40)
	begin
  	@(posedge ckt);
	end	
end
	$finish;

end





endmodule


