class ddr4_monitor#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_monitor;

     `uvm_component_param_utils(ddr4_monitor#(ADDR_WIDTH, DATA_WIDTH))
	 bit [15:0] wr_ddr4_dq;
     /////////Analysis ports ////// 
     uvm_analysis_port#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH))  ddr4_wr_mon_ap_port;
     uvm_analysis_port#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH))  ddr4_rd_mon_ap_port;
     

     ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH) ddr4_req_wr,ddr4_req_rd;
	 virtual ddr4_interface ddr4_intf;
	ddr4_config_object ddr4_cfg;

     function new(string name="",uvm_component parent);
     super.new(name,parent);
	 ddr4_wr_mon_ap_port=new("ddr4_wr_mon_ap_port",this);
     ddr4_rd_mon_ap_port=new("ddr4_rd_mon_ap_port",this);
     endfunction
     

function void build_phase(uvm_phase phase);
		ddr4_cfg=ddr4_config_object::type_id::create("ddr4_cfg");
if(!uvm_config_db#(virtual ddr4_interface)::get(this,"","ddr4_interface",ddr4_intf))
		  `uvm_error(get_type_name,"Not able to get interface in the monitor")

if(!uvm_config_db#(ddr4_config_object)::get(this,"","ddr4_cfg",ddr4_cfg))
		  `uvm_error(get_type_name,"Not able to get config in the monitor")
	
     `uvm_info(get_name(),"----------MONITOR BUILD PHASE---------",UVM_NONE)
endfunction

task collected_write();
@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc)
 //ddr4_req_wr=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH) ::type_id::create("ddr4_req_wr");
  `uvm_info("","////////////////////////////////////////////////////////////////////",UVM_LOW)
  `uvm_info(get_name(),$sformatf("----WRITE_MODE_MONITOR:: INTF SIGNALS---ddr4_addr=%d,INPUT ddr4_dq=%d,ddr4_we_n=%d,ddr4_dm=%d",ddr4_intf.ddr4_addr,ddr4_intf.ddr4_dq,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dm),UVM_NONE)
  	    if(ddr4_intf.ddr4_we_n==0)begin
	  	ddr4_req_wr.ddr4_addr	=ddr4_intf.ddr4_addr;
        ddr4_req_wr.ddr4_cs_n	=ddr4_intf.ddr4_cs_n;
        ddr4_req_wr.ddr4_ras_n  =ddr4_intf.ddr4_ras_n;
        ddr4_req_wr.ddr4_cas_n  =ddr4_intf.ddr4_cas_n;
        ddr4_req_wr.ddr4_we_n   =ddr4_intf.ddr4_we_n;
        ddr4_req_wr.ddr4_dm     =ddr4_intf.ddr4_dm;
        ddr4_req_wr.ddr4_cke    =ddr4_intf.ddr4_cke;
		ddr4_req_wr.ddr4_ready  =ddr4_intf.ddr4_ready;
		//if(ddr4_req_wr.ddr4_dm==1)
        ddr4_req_wr.ddr4_dq     =ddr4_intf.ddr4_dq;
        end
		//ddr4_req_wr.print();
      `uvm_info(get_name(),$sformatf("----WRITE_MODE_MONITOR:: INTF TO MON---ddr4_addr=%d,INPUT ddr4_dq=%d,ddr4_we_n=%d,ddr4_dm=%d",ddr4_req_wr.ddr4_addr,ddr4_req_wr.ddr4_dq,ddr4_req_wr.ddr4_we_n,ddr4_req_wr.ddr4_dm),UVM_NONE)
  `uvm_info("","////////////////////////////////////////////////////////////////////",UVM_LOW)
endtask
  

task collected_read();
 @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc)
`uvm_info(get_name(),$sformatf("----READ_MODE_MONITOR:: INTF SIGNALS---ddr4_addr=%d,INPUT ddr4_dq=%d,ddr4_we_n=%d,ddr4_dm=%d",ddr4_intf.ddr4_addr,ddr4_intf.ddr4_dq,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dm),UVM_NONE)
       if(ddr4_intf.ddr4_we_n==1 )begin
		ddr4_req_rd.ddr4_addr =ddr4_intf.ddr4_addr;
        ddr4_req_rd.ddr4_cs_n =ddr4_intf.ddr4_cs_n;
        ddr4_req_rd.ddr4_ras_n=ddr4_intf.ddr4_ras_n;
        ddr4_req_rd.ddr4_cas_n=ddr4_intf.ddr4_cas_n;
        ddr4_req_rd.ddr4_we_n =ddr4_intf.ddr4_we_n;
        ddr4_req_rd.ddr4_dm   =ddr4_intf.ddr4_dm;
        ddr4_req_rd.ddr4_cke  =ddr4_intf.ddr4_cke;
		ddr4_req_rd.ddr4_ready=ddr4_intf.ddr4_ready;
	//	if(ddr4_req_rd.ddr4_dm==0)
        ddr4_req_rd.ddr4_dq=ddr4_intf.ddr4_dq;
        end
        `uvm_info(get_name(),$sformatf("----READ_MODE_MONITOR:: INTF TO MON---ddr4_addr=%d,INPUT ddr4_dq=%d,ddr4_we_n=%d,ddr4_dm=%d",ddr4_req_rd.ddr4_addr,ddr4_req_rd.ddr4_dq,ddr4_req_rd.ddr4_we_n,ddr4_req_rd.ddr4_dm),UVM_NONE)

endtask

task run_phase(uvm_phase phase);
 ddr4_req_wr=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH) ::type_id::create("ddr4_req_wr");
 
 ddr4_req_rd=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH) ::type_id::create("ddr4_req_rd");

forever
begin
//if(ddr4_intf.ddr4_we_n==0)	
if(ddr4_cfg.write_read_mode==WRITE)
collected_write();
//if(ddr4_intf.ddr4_we_n==1)	
if(ddr4_cfg.write_read_mode==READ)
collected_read();

if (ddr4_req_wr.ddr4_addr[1:0] != 2'b00 && ddr4_req_wr.ddr4_addr[1:0] != 2'b01)
`uvm_info(get_type_name(),"Invalid write_address(burst_len)",UVM_LOW)

if (ddr4_req_rd.ddr4_addr[1:0] != 2'b00 && ddr4_req_rd.ddr4_addr[1:0] != 2'b01)
`uvm_info(get_type_name(),"Invalid read_address(burst_len)",UVM_LOW)

if (ddr4_req_wr.ddr4_addr[7:3] > 5'd21)
`uvm_info(get_type_name(),"Invalid write_address(Latency)",UVM_LOW)

if (ddr4_req_rd.ddr4_addr[7:3] > 5'd21)
`uvm_info(get_type_name(),"Invalid read_address(latency)",UVM_LOW)

ddr4_wr_mon_ap_port.write(ddr4_req_wr);

ddr4_rd_mon_ap_port.write(ddr4_req_rd);

`uvm_info(get_name(),"---------MONITOR RUN PHASE---------",UVM_LOW)
end
endtask

endclass

