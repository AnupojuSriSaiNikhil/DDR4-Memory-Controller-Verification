`uvm_analysis_imp_decl(_act_rd)
`uvm_analysis_imp_decl(_exp_ref)

class ddr4_scoreboard#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_scoreboard;

`uvm_component_utils(ddr4_scoreboard#(ADDR_WIDTH, DATA_WIDTH))
 
 uvm_analysis_imp_act_rd#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH),ddr4_scoreboard#(ADDR_WIDTH, DATA_WIDTH)) ddr4_sc_ap_imp;
 uvm_analysis_imp_exp_ref#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH),ddr4_scoreboard#(ADDR_WIDTH, DATA_WIDTH)) ddr4_ref_ap_imp;
 ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH) ddr4_act_req,ddr4_exp_req;
 
 bit disable_compare;

virtual ddr4_interface ddr4_intf;
 

 function new(string name="",uvm_component parent);
 super.new(name,parent);
 ddr4_sc_ap_imp=new("ddr4_sc_ap_imp",this);
ddr4_ref_ap_imp=new("ddr4_ref_ap_imp",this);
 endfunction

 function void build_phase(uvm_phase phase);
if(!uvm_config_db#(virtual ddr4_interface)::get(this,"","ddr4_interface",ddr4_intf))
		  `uvm_error(get_type_name,"Not able to get interface in the scbd")
ddr4_exp_req=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_exp_req");
ddr4_act_req=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_act_req");
 endfunction

 function void write_act_rd(ddr4_mon_seq_item ddr4_act_req);
 this.ddr4_act_req=ddr4_act_req;
`uvm_info(get_name(),"----------SCORREBOARD ACT DATA-----------",UVM_NONE)
 ddr4_act_req.print();
 endfunction 

function void write_exp_ref(ddr4_mon_seq_item ddr4_exp_req);
 this.ddr4_exp_req=ddr4_exp_req;
`uvm_info(get_name(),"----------SCORREBOARD EXP DATA-----------",UVM_NONE)
 ddr4_exp_req.print();
 endfunction 


task run_phase(uvm_phase phase);
forever
begin
@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);

//if addrress is invalid no comparison takes place
if( (ddr4_act_req.ddr4_addr[1:0] != 2'b00 &&  ddr4_act_req.ddr4_addr[1:0] != 2'b01) || ddr4_act_req.ddr4_addr[7:3] > 5'd21 )
disable_compare=1;
else
disable_compare=0;

if(ddr4_intf.ddr4_we_n==1 && !disable_compare)
begin
	#1;
	if(ddr4_act_req.ddr4_dq===ddr4_exp_req.ddr4_dq)
	`uvm_info(get_name(),$sformatf("SCOREBOARD: TEST PASS---> Expected=%0d,Actual=%0d",ddr4_exp_req.ddr4_dq,ddr4_act_req.ddr4_dq),UVM_NONE)
	else
	`uvm_info(get_name(),$sformatf("SCOREBOARD: TEST FAIL---> Expected=%0d,Actual=%0d",ddr4_exp_req.ddr4_dq,ddr4_act_req.ddr4_dq),UVM_NONE)
end

else if(disable_compare)
	`uvm_info(get_type_name(),"disable_compare ADDRESS: No comparison in scoreboard", UVM_NONE)

end
endtask
endclass


