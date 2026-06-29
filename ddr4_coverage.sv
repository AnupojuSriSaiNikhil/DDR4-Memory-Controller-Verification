class ddr4_coverage#(parameter ADDR_WIDTH=32, DATA_WIDTH=16) extends uvm_subscriber#(ddr4_mon_seq_item);
	`uvm_component_param_utils(ddr4_coverage#(ADDR_WIDTH, DATA_WIDTH))
	
		logic [ADDR_WIDTH-1:0] ddr4_addr;
		logic [DATA_WIDTH-1:0] ddr4_dq; 
		logic ddr4_we_n;
        logic ddr4_dm;
        logic ddr4_cs_n;
   

	 covergroup input_addr_dq_cg;
                       cp_addr:coverpoint ddr4_addr{
                       	 bins low_range={[0:100]};
		 	         	 bins medium_range={[101:400],[401:600],[601:1000]};
			     		 bins High_range={[1001:2000],[2001:5000],[5001:$]};    }                                                             
                       cp_latency: coverpoint ddr4_addr[7:3]{illegal_bins ib_latency = {[31:22]};}
                       cp_burstlen: coverpoint ddr4_addr[1:0]{illegal_bins ib_burstlength = {[3:2]}; }
                       cp_ig_burst: coverpoint ddr4_addr[12:11]{ignore_bins ig_burst = {[3:1]}; }
                       cp_ig_latency: coverpoint ddr4_addr[1:0] {ignore_bins ig_latency = {[2:3]}; }
              
	                  cp_dq:coverpoint ddr4_dq{
                       bins low_range_1[3]={[0:100],[101:200],[301:400]};
			           bins medium_range_1[]={[401:700],[701:900]};
			           bins high_range_1={[901:$]};   }	       	          	   				          
     endgroup

    covergroup control_signals_cg;
	             cp_we_n:coverpoint ddr4_we_n{
                 bins we_n_zero_to_one[]=(0=>1);
				 bins we_n_one_to_zero[]=(1=>0);
				 bins we_n_one_to_one[]=(1=>1);
				 bins we_n_zero_to_zero[]=(0=>0);
                 bins we_n_one={1};
				 bins we_n_zero={0};
				 }

	             cp_dm:coverpoint ddr4_dm{
                 bins dm_zero_or_one={0,1};
		 		 bins dm_zero_occurance={0};
		 		 bins dm_one_occurance={1};
		 	     }
	endgroup	


    covergroup configurations_cg;
        cp_burst_len:coverpoint ddr4_addr[1:0]{  bins burst_len[]={[1:0]}; }
        cp_latency:coverpoint ddr4_addr[7:3]{  bins latency[]={[21:0]}; }
        cp_burst_type:coverpoint ddr4_addr[2]{  bins burst_type[]={[1:0]}; }
     endgroup


	function new(string name ,uvm_component parent);
	super.new(name,parent);
     input_addr_dq_cg=new();
	 control_signals_cg=new();
     configurations_cg=new();
	endfunction
    
	virtual function void write(ddr4_mon_seq_item t);
	      
         ddr4_addr=t.ddr4_addr;
		 ddr4_dq=t.ddr4_dq;
		 ddr4_cs_n=t.ddr4_cs_n;
		 ddr4_we_n=t.ddr4_we_n;
		 ddr4_dm=t.ddr4_dm;
       

		 input_addr_dq_cg.sample();
		 control_signals_cg.sample();
         configurations_cg.sample();
    endfunction

endclass

