class ddr4_write_sequence#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_sequence#(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH));
`uvm_object_param_utils(ddr4_write_sequence#(ADDR_WIDTH, DATA_WIDTH))

ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH) ddr4_req[2];

//`uvm_declare_p_sequencer(ddr4_sequencer#(ADDR_WIDTH,DATA_WIDTH))

static bit [31:0] wr_addr_q [$];
bit burst_type;
bit [1:0] burst_len;
bit [4:0] latency;
bit [31:0] temp_addr;
bit[15:0] dq_queue[$];

rand bit [31:0] address;

function new(string name="ddr4_write_seq");
super.new(name);
endfunction

virtual task body();
ddr4_req[0]=ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_req[0]");
ddr4_req[1]=ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_req[1]");
//$cast(p_sequencer,m_sequencer);
begin
	start_item(ddr4_req[0]);
	
	ddr4_req[0].randomize() with {ddr4_req[0].ddr4_addr[12:11] == 2'b00;
							ddr4_req[0].ddr4_addr[7:3] == latency;
							ddr4_req[0].ddr4_addr[2] == burst_type;
							ddr4_req[0].ddr4_addr[1:0] ==burst_len;
							ddr4_req[0].ddr4_addr[31:18]== 0; 
							ddr4_req[0].ddr4_we_n==0;
							ddr4_req[0].dddq_queue.push_back(ddr4_req[1].ddr4_dq);r4_dq==0;	};
	`uvm_info(get_type_name(),$sformatf("----------------------*******NO BURST WRITE_SEQUENCE-------------time=%0t",$time),UVM_NONE)
	
	temp_addr<=ddr4_req[0].ddr4_addr;
	
	wr_addr_q.push_back(ddr4_req[0].ddr4_addr);
	
	finish_item(ddr4_req[0]);
	
	if(ddr4_req[0].ddr4_addr[1:0]==0)
	begin
			start_item(ddr4_req[1]);
			repeat(8)
			begin

			ddr4_req[1].randomize() with {ddr4_req[1].ddr4_addr==temp_addr;
								ddr4_req[1].ddr4_we_n==0;
				
								};
								
			`uvm_info(get_type_name(),$sformatf("----------------------BURST 8 WRITE_SEQUENCE-------------time=%0t",$time),UVM_NONE)
		//	p_sequencer.dq_queue.push_back(ddr4_req[1].ddr4_dq);
			dq_queue.push_back(ddr4_req[1].ddr4_dq);
	`uvm_info(get_type_name(), $sformatf("SEQUENCE:::    DQ VALUES PRESENT IN QUEUE: %0p",dq_queue),UVM_NONE)



			`uvm_info(get_type_name(),$sformatf("ddr4_write_addr=%0d,ddr4_write_dq=%0d",ddr4_req[1].ddr4_addr,ddr4_req[1].ddr4_dq),UVM_NONE)

			end
			finish_item(ddr4_req[1]);
		end
		
		else if(ddr4_req[0].ddr4_addr[1:0]==1)
		repeat(4)
		begin
		start_item(ddr4_req[1]);
		
		ddr4_req[1].randomize() with {ddr4_req[1].ddr4_addr==temp_addr;
								ddr4_req[1].ddr4_we_n==0;
								};
	`uvm_info(get_type_name(),"----------------------BURST 4 WRITE_SEQUENCE-------------",UVM_NONE)
	
		finish_item(ddr4_req[1]);
		end	
end


//`uvm_info(get_type_name(),$sformatf("ddr4_write_addr=%0d,ddr4_write_dq=%0d",ddr4_req[0].ddr4_addr,ddr4_req.ddr4_dq),UVM_NONE)


endtask

endclass







