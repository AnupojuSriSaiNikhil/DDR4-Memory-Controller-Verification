class ddr4_environment#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_env;

`uvm_component_param_utils(ddr4_environment#(ADDR_WIDTH, DATA_WIDTH))

ddr4_agent#(ADDR_WIDTH,DATA_WIDTH) ddr4_wr_act_agt,ddr4_rd_act_agt;
ddr4_ref_model ddr4_ref;
ddr4_scoreboard#(ADDR_WIDTH,DATA_WIDTH) ddr4_scbd;
ddr4_coverage#(ADDR_WIDTH,DATA_WIDTH) ddr4_cvg;
virtual ddr4_interface ddr4_intf;

function new(string name ="", uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
if(!uvm_config_db#(virtual ddr4_interface)::get(this,"","ddr4_interface",ddr4_intf))
	`uvm_error(get_type_name,"Not able to get interface in the env")

ddr4_wr_act_agt=ddr4_agent#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_wr_act_agt",this);
	ddr4_rd_act_agt=ddr4_agent#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_rd_act_agt",this);
	ddr4_ref=ddr4_ref_model#(ADDR_WIDTH,DATA_WIDTH)::type_id::create("ddr4_ref",this);
    ddr4_scbd=ddr4_scoreboard#(ADDR_WIDTH,DATA_WIDTH)::type_id::create("ddr4_scbd",this);
    ddr4_cvg=ddr4_coverage#(ADDR_WIDTH,DATA_WIDTH)::type_id::create("ddr4_cvg",this);
`uvm_info(get_name(),"----------ENVIRONMENT BUILD PHASE---------",UVM_NONE)
  endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
ddr4_wr_act_agt.ddr4_mon.ddr4_wr_mon_ap_port.connect(ddr4_ref.ddr4_ref_wr_ap_imp);
ddr4_rd_act_agt.ddr4_mon.ddr4_rd_mon_ap_port.connect(ddr4_ref.ddr4_ref_rd_ap_imp);
ddr4_rd_act_agt.ddr4_mon.ddr4_rd_mon_ap_port.connect(ddr4_scbd.ddr4_sc_ap_imp);
ddr4_ref.ddr4_ref_ap_port.connect(ddr4_scbd.ddr4_ref_ap_imp);
ddr4_wr_act_agt.ddr4_mon.ddr4_wr_mon_ap_port.connect(ddr4_cvg.analysis_export);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction

endclass

