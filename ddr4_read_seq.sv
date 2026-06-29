class ddr4_read_sequence#(parameter ADDR_WIDTH=32, DATA_WIDTH=16)  extends uvm_sequence#(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH));

`uvm_object_param_utils(ddr4_read_sequence#(ADDR_WIDTH, DATA_WIDTH))
ddr4_seq_item #(ADDR_WIDTH, DATA_WIDTH) ddr4_req;
ddr4_write_sequence#(ADDR_WIDTH, DATA_WIDTH) ddr4_wr_seq;

bit [31:0] address;

function new(string name="ddr4_read_sequence");
super.new(name);
endfunction

virtual task body();
ddr4_req=ddr4_seq_item #(ADDR_WIDTH, DATA_WIDTH) ::type_id::create("ddr4_req");
 if(!uvm_config_db#(ddr4_write_sequence#(ADDR_WIDTH,DATA_WIDTH))::get(null, "", "ddr4_write_sequence", ddr4_wr_seq))
 begin
 `uvm_error(get_type_name,"Not able to get WRITE_SEQUENCE in the READ_SEQUENCE")
end
//ddr4_wr_seq = ddr4_write_sequence#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_wr_seq");
//`uvm_info(get_type_name(),$sformatf("READ_SEQUENCE........................................read_address=%p",ddr4_wr_seq.wr_addr_q),UVM_NONE)

start_item(ddr4_req);

//ddr4_req.ddr4_dq.rand_mode(0);
//ddr4_req.ddr4_addr.rand_mode(0);
//ddr4_req.ddr4_addr=wr_seq.wr_addr_q.pop_front();

address=ddr4_wr_seq.wr_addr_q.pop_front();

`uvm_info(get_type_name(),$sformatf("READ_SEQUENCE_ADDRESS FROM QUEUE:read_address=%d",address),UVM_NONE)


ddr4_req.randomize() with {ddr4_req.ddr4_we_n==1;
							ddr4_req.ddr4_addr==address;	};

`uvm_info(get_type_name(),"----------------------READ_SEQUENCE-------------",UVM_NONE)
`uvm_info(get_type_name(),$sformatf("read_address=%d",ddr4_req.ddr4_addr),UVM_NONE)
finish_item(ddr4_req);

endtask

endclass



