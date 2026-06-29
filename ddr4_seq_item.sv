class ddr4_seq_item#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_sequence_item;

rand bit [ADDR_WIDTH-1:0] ddr4_addr;
bit ddr4_cs_n;
bit ddr4_ras_n;
bit ddr4_cas_n;
rand bit ddr4_we_n;
bit ddr4_cke;
bit ddr4_ready;
rand bit [DATA_WIDTH-1:0] ddr4_dq [];
bit ddr4_dm;

function new(string name="ddr4_seq_item");
super.new(name);
endfunction

`uvm_object_utils_begin(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH))

`uvm_field_int(ddr4_addr, UVM_ALL_ON)
`uvm_field_int(ddr4_cs_n, UVM_ALL_ON)
`uvm_field_int(ddr4_ras_n, UVM_ALL_ON)
`uvm_field_int(ddr4_cas_n, UVM_ALL_ON)
`uvm_field_int(ddr4_we_n, UVM_ALL_ON)
`uvm_field_int(ddr4_cke, UVM_ALL_ON)
`uvm_field_int(ddr4_ready, UVM_ALL_ON)
`uvm_field_array_int(ddr4_dq, UVM_ALL_ON)
`uvm_field_int(ddr4_dm, UVM_ALL_ON)
`uvm_object_utils_end

endclass




/////////////////MONITOR sequence-item//////////////
class ddr4_mon_seq_item#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_sequence_item;
rand bit [ADDR_WIDTH-1:0] ddr4_addr;
logic ddr4_cs_n;
logic ddr4_ras_n;
logic ddr4_cas_n;
rand logic ddr4_we_n;
logic ddr4_cke;
logic ddr4_ready;
rand logic [DATA_WIDTH-1:0] ddr4_dq;
logic ddr4_dm;

function new(string name="ddr4_mon_seq_item");
super.new(name);
endfunction

`uvm_object_utils_begin(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH))

`uvm_field_int(ddr4_addr, UVM_ALL_ON)
`uvm_field_int(ddr4_cs_n, UVM_ALL_ON)
`uvm_field_int(ddr4_ras_n, UVM_ALL_ON)
`uvm_field_int(ddr4_cas_n, UVM_ALL_ON)
`uvm_field_int(ddr4_we_n, UVM_ALL_ON)
`uvm_field_int(ddr4_cke, UVM_ALL_ON)
`uvm_field_int(ddr4_ready, UVM_ALL_ON)
`uvm_field_int(ddr4_dq, UVM_ALL_ON)
`uvm_field_int(ddr4_dm, UVM_ALL_ON)
`uvm_object_utils_end

endclass

