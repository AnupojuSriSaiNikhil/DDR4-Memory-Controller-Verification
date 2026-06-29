class ddr4_sequencer#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_sequencer#(ddr4_seq_item#(ADDR_WIDTH,DATA_WIDTH));

//bit[15:0] dq_queue[$];

       `uvm_component_param_utils(ddr4_sequencer#(ADDR_WIDTH,DATA_WIDTH))

       function new(string name="",uvm_component parent);
       super.new(name,parent);
       endfunction

endclass

