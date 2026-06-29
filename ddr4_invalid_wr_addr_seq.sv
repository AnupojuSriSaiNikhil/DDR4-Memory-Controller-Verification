class ddr4_invalid_wr_addr_sequence#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_sequence#(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH));
`uvm_object_param_utils(ddr4_invalid_wr_addr_sequence#(ADDR_WIDTH, DATA_WIDTH))

ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH) ddr4_req;
bit [31:0] wr_addr_q [$];

function new(string name="ddr4_invalid_addr_seq");
super.new(name);
endfunction

virtual task body();
ddr4_req=ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_req");

start_item(ddr4_req);
ddr4_req.randomize() with {   ddr4_we_n==0;	}; 

if(ddr4_req.ddr4_addr[1:0]==0)
begin
ddr4_req.ddr4_dq=new[8];
`uvm_info(get_type_name(),$sformatf("SIZE IN WRITE_SEQUENCE----------------->ARRAY_SIZE==%0d",ddr4_req.ddr4_dq.size()),UVM_NONE);
end

else if (ddr4_req.ddr4_addr[1:0]==1)
begin
ddr4_req.ddr4_dq=new[4];
`uvm_info(get_type_name(),$sformatf("SIZE IN WRITE_SEQUENCE----------------->ARRAY_SIZE==%0d",ddr4_req.ddr4_dq.size()),UVM_NONE);
end

foreach(ddr4_req.ddr4_dq[i])
    ddr4_req.ddr4_dq[i] = $random;

wr_addr_q.push_back(ddr4_req.ddr4_addr);
`uvm_info(get_type_name(),$sformatf("WRITE_SEQUENCE----------------->ARRAY_SIZE==%0d,,,ddr4_write_addr=%0d,ddr4_write_dq=%0p",ddr4_req.ddr4_dq.size(),ddr4_req.ddr4_addr,ddr4_req.ddr4_dq),UVM_NONE)
`uvm_info(get_type_name(),$sformatf("WRITE_SEQUENCE   QUEUE........................................read_address=%p",wr_addr_q),UVM_NONE)


finish_item(ddr4_req);



//end


endtask

endclass






	

