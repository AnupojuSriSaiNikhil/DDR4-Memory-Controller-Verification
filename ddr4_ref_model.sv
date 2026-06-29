`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)

class ddr4_ref_model#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_component;
`uvm_component_param_utils(ddr4_ref_model#(ADDR_WIDTH, DATA_WIDTH))
 
uvm_analysis_imp_wr#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH),ddr4_ref_model#(ADDR_WIDTH, DATA_WIDTH)) ddr4_ref_wr_ap_imp;
uvm_analysis_imp_rd#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH),ddr4_ref_model#(ADDR_WIDTH, DATA_WIDTH)) ddr4_ref_rd_ap_imp;

ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH) ddr4_wr_ref_req,ddr4_rd_ref_req,ddr4_ref_req;
virtual ddr4_interface ddr4_intf;
	bit[5:0] delay;
	logic [15:0] array[int];
	//bit [15:0] ddr4_ref_req.ddr4_dq;
     uvm_analysis_port#(ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH))  ddr4_ref_ap_port;

 
	function new(string name="",uvm_component parent);
    super.new(name,parent);
    ddr4_ref_wr_ap_imp=new("ddr4_ref_wr_ap_imp",this);
    ddr4_ref_rd_ap_imp=new("ddr4_ref_rd_ap_imp",this);
	ddr4_ref_ap_port=new("ddr4_ref_ap_port",this);
  	endfunction

	function void build_phase(uvm_phase phase);
	  if(!uvm_config_db#(virtual ddr4_interface)::get(this,"","ddr4_interface",ddr4_intf))
		  `uvm_error(get_type_name,"Not able to get interface in the ref_model")

     `uvm_info(get_name(),"----------REFERENCE MODEL BUILD PHASE---------",UVM_NONE)
		ddr4_wr_ref_req=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_wr_ref_req");
		ddr4_rd_ref_req=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_rd_ref_req");
		ddr4_ref_req=ddr4_mon_seq_item#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("ddr4_ref_req");


    endfunction

    function void write_wr(ddr4_mon_seq_item ddr4_wr_ref_req);
    this.ddr4_wr_ref_req=ddr4_wr_ref_req; 
	
 	`uvm_info(get_name(),"----------REFERENCE MODEL WRITE DATA-----------",UVM_NONE)   
 	ddr4_wr_ref_req.print();


    endfunction

    function void write_rd(ddr4_mon_seq_item ddr4_rd_ref_req);
 	   this.ddr4_rd_ref_req=ddr4_rd_ref_req;  

 	`uvm_info(get_name(),"----------REFERENCE MODEL READ DATA-----------",UVM_NONE)    
 	ddr4_rd_ref_req.print();

    endfunction

	task write_into_mem();
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_write 4th print  --->WRITE ---> time=%0t ",$time),UVM_LOW)
		ddr4_ref_req.ddr4_dq = 16'hzzzz;
		ddr4_ref_ap_port.write(ddr4_ref_req);
		if(ddr4_intf.ddr4_reset_n==1)
		case(ddr4_wr_ref_req.ddr4_addr[1:0])
				2'b00: begin	
					if(ddr4_wr_ref_req.ddr4_addr[2]==0)
							begin
								for(int i=0;i<8;i++)
								begin
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
								array[ddr4_wr_ref_req.ddr4_addr[17:2]+i]=ddr4_wr_ref_req.ddr4_dq;
								`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_write 5th print -- addr=%0d,dq=%0d",ddr4_wr_ref_req.ddr4_addr[17:2]+i,ddr4_wr_ref_req.ddr4_dq),UVM_LOW)
								
								end
							end

					else
							begin
					
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									array[ddr4_wr_ref_req.ddr4_addr[17:2]+0]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+2]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+4]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+3]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+1]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+5]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
				#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+7]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+6]=ddr4_wr_ref_req.ddr4_dq;							
							end
				end
	
				2'b01:begin
						if(ddr4_wr_ref_req.ddr4_addr[2]==0)
							begin
								for(int i=0;i<4;i++)
								begin
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
								array [ddr4_wr_ref_req.ddr4_addr[17:2]+i]=ddr4_wr_ref_req.ddr4_dq;
								end						
							end

							else
							begin
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);	
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+0]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+2]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+1]=ddr4_wr_ref_req.ddr4_dq;
								@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								#1;
									 array[ddr4_wr_ref_req.ddr4_addr[17:2]+3]=ddr4_wr_ref_req.ddr4_dq;
							end
				end

		endcase

	endtask

	task read_from_mem();
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT --"),UVM_LOW)
	//	ddr4_ref_req.ddr4_dq = 16'hzzzz;
						 case(ddr4_rd_ref_req.ddr4_addr[7:3])
									5'b00000:delay=9;
									5'b00001:delay=10;
									5'b00010:delay=11;
									5'b00011:delay=12;
									5'b00100:delay=13;
									5'b00101:delay=14;
									5'b00110:delay=15;
									5'b00111:delay=16;
									5'b01000:delay=18;
									5'b01001:delay=20;
									5'b01010:delay=22;
									5'b01011:delay=24;
									5'b01100:delay=23;
									5'b01101:delay=17;
									5'b01110:delay=19;
									5'b01111:delay=21;
									5'b10000:delay=25;
									5'b10001:delay=26;
									5'b10001:delay=28;
									5'b10010:delay=29;
									5'b10011:delay=30;
									5'b10100:delay=31;
									5'b10101:delay=32;
									5'b11111:delay=0;
									default: delay=9;
								endcase
							
							repeat(2*delay)
								begin
								@( ddr4_intf.ddr4_ckt or ddr4_intf.ddr4_ckc);
								end
				if(ddr4_intf.ddr4_reset_n==1)
			case(ddr4_rd_ref_req.ddr4_addr[1:0]) //Burst_length
							2'b00: begin //burst 8

									if(ddr4_rd_ref_req.ddr4_addr[2]==0)	 //Bursttype== nibble
									begin
									for(int i=0;i<8;i++)
									begin 
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+i];
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									ddr4_ref_ap_port.write(ddr4_ref_req);
									end
									
								//	@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								//	ddr4_ref_ap_port.write(ddr4_ref_req);
									end

									else  // Burst type= interleaved
											begin
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+0];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);

									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+2];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+1];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+7];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+3];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+6];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+4];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+5];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									

								//	@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
								//	ddr4_ref_ap_port.write(ddr4_ref_req);

									end

						end

					2'b01: begin  //  Burst length=4
									if(ddr4_rd_ref_req.ddr4_addr[2]==0)	
									for(int i=0;i<4;i++)
									begin 
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+i];								
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL 1st print ---> time=%0t  :ddr4_ref_req.ddr4_dq=%d",$time,ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									end

									else 
									begin
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+0];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+2];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+1];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
									ddr4_ref_req.ddr4_dq = array[ddr4_rd_ref_req.ddr4_addr[17:2]+3];	
									`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 4th PRINT--->:ddr4_ref_req.ddr4_dq=%d",ddr4_ref_req.ddr4_dq),UVM_LOW)
		ddr4_ref_ap_port.write(ddr4_ref_req);
									end
							end
			endcase
	endtask

	task ref_write();
 		@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc)
		#1;
	//	if(ddr4_wr_ref_req.ddr4_we_n==0)
//	if(ddr4_intf.ddr4_reset_n==1)
	//	begin
		if(ddr4_intf.ddr4_we_n==0 )
		begin
		
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_write 1st PRINT --"),UVM_LOW)
		@(posedge ddr4_wr_ref_req.ddr4_cas_n);
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_write 2st PRINT --"),UVM_LOW)
		@(posedge ddr4_wr_ref_req.ddr4_ras_n);	
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_write 3rd print --"),UVM_LOW)
		write_into_mem();
		repeat(2)
		begin
 		@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		end
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read last PRINT --"),UVM_LOW)
		end
//		end
//	else
//		`uvm_info(get_name(),"RESETTING IN REF_MODEL-----------",UVM_NONE)
	

	endtask
	

	task ref_read();
 		@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc)
//		if(ddr4_rd_ref_req.ddr4_we_n==1)
		if(ddr4_intf.ddr4_we_n==1)
		begin
		
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 1st PRINT --"),UVM_LOW)
		@(posedge ddr4_rd_ref_req.ddr4_ras_n);
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 2nd PRINT --"),UVM_LOW)
		repeat(1)
		begin
 		@(posedge ddr4_intf.ddr4_ckt or posedge ddr4_intf.ddr4_ckc);
		end
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL ref_read 3rd PRINT --"),UVM_LOW)
		read_from_mem();
		end
	endtask

	task run_phase(uvm_phase phase);
	forever
	begin
		`uvm_info(get_name(),$sformatf("REFERENCE _MODEL CALLLING ref --"),UVM_LOW)
	//	if( ddr4_intf.ddr4_reset_n==1)
		fork	
		ref_write();
		ref_read();
		//ddr4_ref_ap_port.write(ddr4_ref_req);
		join
 	ddr4_ref_req.print();
	end
	endtask

endclass





