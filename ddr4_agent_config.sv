typedef enum{WRITE,READ} agent_mode;

class ddr4_config_object extends uvm_object;

`uvm_object_utils(ddr4_config_object)

agent_mode write_read_mode;
uvm_active_passive_enum active_passive_mode;

function new(string name="ddr4_agent_cfg");
super.new(name);
endfunction

endclass

