class ddr4_driver#(parameter ADDR_WIDTH=32, DATA_WIDTH=16)  extends uvm_driver#(ddr4_seq_item#(ADDR_WIDTH, DATA_WIDTH) );

         `uvm_component_utils(ddr4_driver#(ADDR_WIDTH, DATA_WIDTH))
		
		  virtual ddr4_interface ddr4_intf;
          ddr4_config_object ddr4_cfg;

          function new(string name="",uvm_component parent);
          super.new(name,parent);
          endfunction


          function void build_phase(uvm_phase phase);
          super.build_phase(phase);
			ddr4_cfg=ddr4_config_object::type_id::create("ddr4_cfg");
		  if(!uvm_config_db#(virtual ddr4_interface)::get(this,"","ddr4_interface",ddr4_intf))
		  `uvm_error(get_type_name,"Not able to get interface in the driver")

		  if(!uvm_config_db#(ddr4_config_object)::get(this,"","ddr4_cfg",ddr4_cfg))
		  `uvm_error(get_type_name,"Not able to get config in the driver")

		`uvm_info(get_name(),"----------DRIVER BUILD PHASE---------",UVM_HIGH)
 
            
          endfunction

			task reset();

               ddr4_intf.ddr4_addr<=0;
               ddr4_intf.ddr4_dq  <=16'hzzzz;
               ddr4_intf.ddr4_cke <=1;
			    ddr4_intf.ddr4_cs_n<=0;
                ddr4_intf.ddr4_ras_n<=0;
                ddr4_intf.ddr4_cas_n<=0;
                ddr4_intf.ddr4_we_n<=0;
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<RESET TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n),UVM_HIGH)

               
               endtask

               task idle();
                ddr4_intf.ddr4_cs_n<=0;
                ddr4_intf.ddr4_ras_n<=0;
                ddr4_intf.ddr4_cas_n<=0;
                ddr4_intf.ddr4_we_n<=0;
                ddr4_intf.ddr4_addr<=req.ddr4_addr;
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<IDLE TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n),UVM_HIGH)
              
               endtask

			     task mrs();
               ddr4_intf.ddr4_dq  <=16'hzzzz;
                ddr4_intf.ddr4_cas_n<=1;
                ddr4_intf.ddr4_we_n<=req.ddr4_we_n; 
				ddr4_intf.ddr4_dm<=~req.ddr4_we_n;
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<MRS TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n),UVM_HIGH)

				endtask


               task activate();
               ddr4_intf.ddr4_dq  <=16'hzzzz;
                ddr4_intf.ddr4_ras_n<=1;
                ddr4_intf.ddr4_cas_n<=0;
                ddr4_intf.ddr4_we_n<=req.ddr4_we_n; 
				ddr4_intf.ddr4_dm<=~req.ddr4_we_n;
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<ACTIVATE TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n),UVM_HIGH)

               
               endtask

               task write();

                ddr4_intf.ddr4_ras_n<=1;
                ddr4_intf.ddr4_cas_n<=0;

			if(ddr4_intf.ddr4_addr[1:0]==0)
				for(int i=0; i<8; i++)
				begin
				 `uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<WRITE TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  dq=%0p",$time,req.ddr4_dq),UVM_HIGH)

             	 ddr4_intf.ddr4_dq<=req.ddr4_dq[i];
      		 	 @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
				 `uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<WRITE TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d,dq=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dq),UVM_HIGH)

				end
			else if(ddr4_intf.ddr4_addr[1:0]==1)
				for(int i=0; i<4; i++)
				begin
             	 ddr4_intf.ddr4_dq<=req.ddr4_dq[i];
      		 	 @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
				 	`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<WRITE TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d,dq=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dq),UVM_HIGH)

				end



			`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<WRITE TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d,dq=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dq),UVM_HIGH)
				
               endtask

               task read();

                ddr4_intf.ddr4_ras_n<=1;
                ddr4_intf.ddr4_cas_n<=0;


				if(ddr4_intf.ddr4_addr[1:0]==0)
				for(int i=0; i<8; i++)
				begin
				 `uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<READ TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  dq=%0p",$time,req.ddr4_dq),UVM_HIGH)

      		 	 @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
				 `uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<READ TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d,dq=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dq),UVM_HIGH)

				end
			else if(ddr4_intf.ddr4_addr[1:0]==1)
				for(int i=0; i<4; i++)
				begin
      		 	 @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
				 	`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<READ TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d,dq=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dq),UVM_HIGH)

				end

				
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<<READ TASK-----Time==%0t--------->>>>>>>>>>>>>>>>>  ras=%0d,cas=%0d,cs=%0d,we_n=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n),UVM_HIGH)


               endtask

               task precharge();

                ddr4_intf.ddr4_ras_n<=1;
                ddr4_intf.ddr4_cas_n<=1;
                ddr4_intf.ddr4_we_n<=1;
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<PRECHARGE TASK-----Time==%0t--------->>>>>>>>>>>> ras=%0d,cas=%0d,cs=%0d,we_n=%0d",$time,ddr4_intf.ddr4_ras_n,ddr4_intf.ddr4_cas_n,ddr4_intf.ddr4_cs_n,ddr4_intf.ddr4_we_n),UVM_HIGH)

                endtask


task drive_write();
`uvm_info("DRIVE_WRITE", "WRITE_TASK IS STARTING",UVM_HIGH)
if(req.ddr4_we_n==0)
begin
	`uvm_info("DRIVE_WRITE", "WRITE_STATES IS STARTING",UVM_HIGH)
			     idle();
        @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
			    mrs();
		else
				reset();
		@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
                activate();
		else
				reset();
      @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
		begin
                write();
				@(ddr4_intf.ddr4_ready==1);
		end
		else
				reset();

        @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
end
endtask


task drive_read();
`uvm_info("DRIVE_READ", "READ_TASK IS STARTING",UVM_HIGH)
if(req.ddr4_we_n==1)
begin

	`uvm_info("DRIVE_READ", "READ_STATES IS STARTING",UVM_HIGH)

                 idle();
        @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
				 mrs();
		else
				reset();
		@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
                 activate();
		else
				reset();
        @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
      			read();
       else
				reset();
	   @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		if(ddr4_intf.ddr4_reset_n)
                 precharge();
		else
				reset();
		@(ddr4_intf.ddr4_ready==1);
        @(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
end
endtask

/////////////////////RUN PHASE///////////////////////

task run_phase(uvm_phase phase);
forever
begin	
seq_item_port.get_next_item(req);
`uvm_info(get_type_name(),$sformatf("%s",req.sprint),UVM_HIGH)
`uvm_info(get_type_name(),	$sformatf("<<<<<<<<<<<<<<<<< TASK RUN PHASE-----Time==%0t--------->>>>>>>>>>>>>>>>>  dq=%0p",$time,req.ddr4_dq),UVM_HIGH)

if(!ddr4_intf.ddr4_reset_n)
begin
@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
`uvm_info("DRIVER_wr", "RESETING...........  ",UVM_HIGH)
reset();
end
else   
begin
////////////////////WRITE/////////////////////          
if(ddr4_cfg.write_read_mode==WRITE)
begin
`uvm_info("DRIVER_wr", "WRITE_STATES IS STARTING",UVM_HIGH)
drive_write();
end
///////////////////READ//////////////////////
if (ddr4_cfg.write_read_mode==READ)
begin
`uvm_info("DRIVER_rd", "READ_STATES IS STARTING",UVM_HIGH)
drive_read();
end
end

seq_item_port.item_done(req);
`uvm_info(get_name(),$sformatf("----DRV SIGNALS---ddr4_addr=%d,ddr4_dq=%p,ddr4_we_n=%d",req.ddr4_addr,req.ddr4_dq,req.ddr4_we_n),UVM_HIGH)
`uvm_info(get_name(),"---------DRIVER RUN PHASE---------",UVM_HIGH)
#1;
`uvm_info(get_name(),$sformatf("----DRV to INTERFACE---ddr4_addr=%d,ddr4_dq=%d,ddr4_we_n=%d,ddr4_dm=%d",ddr4_intf.ddr4_addr,ddr4_intf.ddr4_dq,ddr4_intf.ddr4_we_n,ddr4_intf.ddr4_dm),UVM_HIGH)

end
endtask

endclass




