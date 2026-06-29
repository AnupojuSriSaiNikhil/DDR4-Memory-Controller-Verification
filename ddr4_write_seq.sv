class ddr4_write_sequence#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_sequence#(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH));
`uvm_object_param_utils(ddr4_write_sequence#(ADDR_WIDTH, DATA_WIDTH))

ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH) ddr4_req;

bit [31:0] wr_addr_q [$];
rand bit burst_type;
rand bit [1:0] burst_len;
rand bit [4:0] latency;

rand bit [31:0] temp_addr;
rand bit temp_we_n;

constraint burst_type_con { soft burst_type == 0; };
constraint burst_len_con { soft burst_len == 0; };
constraint latency_con { soft latency == 3; };


function new(string name="ddr4_write_sequence");
super.new(name);
endfunction

virtual task body();
ddr4_req=ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_req");

//if (!randomize()) 
//`uvm_error(get_type_name(), "Randomization failed for burst_type, burst_len, latency")

`uvm_info(get_type_name(),$sformatf("BURST LENGTH IN WRITE_SEQUENCE----------------->BURST LENGTH==%0d",burst_len),UVM_NONE);

begin
			
start_item(ddr4_req);
ddr4_req.randomize() with {ddr4_addr[12:11]==2'b00;
                       ddr4_addr[7:3]==latency;
                       ddr4_addr[2]==burst_type;
                       ddr4_addr[1:0]==burst_len;
                             ddr4_we_n==0;		 }; 
                       
if(burst_len==0)
begin
ddr4_req.ddr4_dq=new[8];
`uvm_info(get_type_name(),$sformatf("SIZE IN WRITE_SEQUENCE----------------->ARRAY_SIZE==%0d",ddr4_req.ddr4_dq.size()),UVM_NONE);
end

else if (burst_len==1)
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



end


endtask

endclass
