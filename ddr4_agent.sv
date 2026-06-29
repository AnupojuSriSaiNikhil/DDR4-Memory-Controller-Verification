class ddr4_agent#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_agent;

`uvm_component_param_utils(ddr4_agent#(ADDR_WIDTH,DATA_WIDTH))

ddr4_sequencer #(ADDR_WIDTH,DATA_WIDTH) ddr4_sqr;
ddr4_driver#(ADDR_WIDTH,DATA_WIDTH) ddr4_drv;
ddr4_monitor#(ADDR_WIDTH,DATA_WIDTH) ddr4_mon;

ddr4_config_object ddr4_cfg;

 function new(string name= "", uvm_component parent);
 super.new(name,parent);
 endfunction

function void build_phase(uvm_phase phase);
 //   ddr4_cfg=ddr4_config_object::type_id::create("ddr4_cfg");
//uvm_config_db#(ddr4_config_object)::set(this,"*","ddr4_config_object",ddr4_cfg);
	
    if(!uvm_config_db#(ddr4_config_object)::get(this,"","ddr4_cfg",ddr4_cfg))
   	`uvm_fatal("DDR4_agent","Not able to get the agent config in AGENT")

       ddr4_mon=ddr4_monitor#(ADDR_WIDTH,DATA_WIDTH)::type_id::create("ddr4_mon",this);
       
     if(ddr4_cfg.active_passive_mode==UVM_ACTIVE)
     begin
       ddr4_sqr=ddr4_sequencer#(ADDR_WIDTH,DATA_WIDTH)::type_id::create("ddr4_sqr",this);
       ddr4_drv=ddr4_driver#(ADDR_WIDTH,DATA_WIDTH)::type_id::create("ddr4_drv",this);
       `uvm_info(get_name(),"configure as Active",UVM_LOW)
       end
	else
        `uvm_info(get_name(),"configure as Passive",UVM_LOW)
   
     `uvm_info(get_name(),"----------AGENT BUILD PHASE---------",UVM_NONE)
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(ddr4_cfg.active_passive_mode==UVM_ACTIVE)begin
ddr4_drv.seq_item_port.connect(ddr4_sqr.seq_item_export);
end
`uvm_info(get_name(),"----------AGENT CONNECT PHASE---------",UVM_NONE)
endfunction

endclass





