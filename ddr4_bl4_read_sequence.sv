class ddr4_bl4_read_sequence#(parameter ADDR_WIDTH=32, DATA_WIDTH=16)  extends uvm_sequence#(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH));

`uvm_object_param_utils(ddr4_bl4_read_sequence#(ADDR_WIDTH, DATA_WIDTH))
ddr4_seq_item #(ADDR_WIDTH, DATA_WIDTH) ddr4_req;
ddr4_write_sequence#(ADDR_WIDTH, DATA_WIDTH) ddr4_wr_seq;

bit [31:0] address;
bit [1:0]burst_length;
function new(string name="ddr4_read_sequence");
super.new(name);
endfunction

virtual task body();
ddr4_req=ddr4_seq_item #(ADDR_WIDTH, DATA_WIDTH) ::type_id::create("ddr4_req");
 if(!uvm_config_db#(ddr4_write_sequence#(ADDR_WIDTH,DATA_WIDTH))::get(null, "", "ddr4_write_sequence", ddr4_wr_seq))
 begin
 `uvm_error(get_type_name,"Not able to get WRITE_SEQUENCE in the READ_SEQUENCE")
end


start_item(ddr4_req);
address=ddr4_wr_seq.wr_addr_q.pop_front();
`uvm_info(get_type_name(),$sformatf("READ_SEQUENCE_ADDRESS FROM QUEUE:read_address=%d",address),UVM_NONE)

ddr4_req.randomize() with {ddr4_req.ddr4_we_n==1;
                           ddr4_req.ddr4_addr[31:2]==address[31:2];
                           ddr4_req.ddr4_addr[1:0]==burst_length;
                           };
						   
                            
`uvm_info(get_type_name(),"--READ_SEQUENCE------------",UVM_NONE)
`uvm_info(get_type_name(),$sformatf("--read_seq--busrt_len:%d",burst_length),UVM_NONE)
`uvm_info(get_type_name(),$sformatf("read_address=%d",ddr4_req.ddr4_addr),UVM_NONE)
finish_item(ddr4_req);

endtask

endclass



