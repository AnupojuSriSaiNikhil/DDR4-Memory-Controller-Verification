# Create the working library
# ddr4_invalid_addr_test
# ddr4_write_read_test
# ddr4_interleave_burst8
# ddr4_interleave_burst4
# ddr4_nibble_burst4
# ddr4_nibble_burst8
# ddr4_bl8_write_bl4_read_test
# ddr4_reset_test

.main clear
transcript file runnew.log
vlib work
vlog \
+acc \
-sv \
+incdir+../sequence/ \
+incdir+../components/ \
+incdir+../testcases/ \
+incdir+../top/ \
+incdir+../rtl/ \
+incdir+C:/questasim64_10.7c/verilog_src/uvm-1.1d/src \
../top/ddr4_top.sv 

vsim -assertdebug work.ddr4_top \
-sv_lib C:/questasim64_10.7c/uvm-1.1d/win64/uvm_dpi \
+UVM_TESTNAME=ddr4_write_read_test \
-l run1.log

# Optional: add waveforms to waveform window
#add wave -position insertpoint \
#sim:/ddr4_top/ddr4_intf/ADDR_WIDTH \
#sim:/ddr4_top/ddr4_intf/DATA_WIDTH\
#sim:/ddr4_top/ddr4_intf/ddr4_ckt \
#sim:/ddr4_top/ddr4_intf/ddr4_ckc \
#sim:/ddr4_top/ddr4_intf/ddr4_reset_n \
#sim:/ddr4_top/ddr4_intf/ddr4_ras_n \
#sim:/ddr4_top/ddr4_intf/ddr4_addr \
#sim:/ddr4_top/ddr4_intf/ddr4_cas_n \
#sim:/ddr4_top/ddr4_intf/ddr4_dm \
#sim:/ddr4_top/ddr4_intf/ddr4_we_n \
#sim:/ddr4_top/ddr4_intf/ddr4_cs_n \
#sim:/ddr4_top/ddr4_intf/ddr4_cke \
#sim:/ddr4_top/ddr4_intf/ddr4_ready \
#sim:/ddr4_top/ddr4_intf/ddr4_dq \
#sim:/ddr4_top/dut/ddr4_command \
#sim:/ddr4_top/dut/next_ddr4_command \
#sim:/ddr4_top/dut/mem
# Run simulation
#run -all
transcript file runnew.log
add wave /uvm_pkg::uvm_reg_map::do_write/#ublk#215181159#1731/immed__1735 /uvm_pkg::uvm_reg_map::do_read/#ublk#215181159#1771/immed__1775 /ddr4_top/assertions/assert_reset_to_idle /ddr4_top/assertions/assert_ready_idle_or_activate /ddr4_top/assertions/assert_cmd_read /ddr4_top/assertions/assert_cmd_write /ddr4_top/assertions/assert_dq_remains_invalid_read1 /ddr4_top/assertions/assert_dq_remains_invalid_read2 /ddr4_top/assertions/assert_dq_remains_invalid_read3 /ddr4_top/assertions/assert_dq_remains_invalid_read4 /ddr4_top/assertions/assert_dq_remains_invalid_read5 /ddr4_top/assertions/assert_dq_remains_invalid_read6 /ddr4_top/assertions/assert_dq_remains_invalid_read7 /ddr4_top/assertions/assert_dq_remains_invalid_read8 /ddr4_top/assertions/assert_dq_remains_invalid_read9 /ddr4_top/assertions/assert_dq_remains_invalid_read10 /ddr4_top/assertions/assert_dq_remains_invalid_read11 /ddr4_top/assertions/assert_dq_remains_invalid_read12 /ddr4_top/assertions/assert_dq_remains_invalid_read13 /ddr4_top/assertions/assert_dq_remains_invalid_read14 /ddr4_top/assertions/assert_dq_remains_invalid_read15 /ddr4_top/assertions/assert_dq_remains_invalid_read16 /ddr4_top/assertions/assert_dq_remains_invalid_read17 /ddr4_top/assertions/assert_dq_remains_invalid_read18 /ddr4_top/assertions/assert_dq_remains_invalid_read19 /ddr4_top/assertions/assert_dq_remains_invalid_read20 /ddr4_top/assertions/assert_dq_remains_invalid_read21 /ddr4_top/assertions/assert_dq_remains_invalid_read22 /ddr4_top/assertions/assert_dq_remains_invalid_read23 /ddr4_top/assertions/assert_dq_remains_invalid_read24 /ddr4_top/assertions/assert_dq_remains_invalid_write /ddr4_top/assertions/assert_invalid_cas /ddr4_top/assertions/assert_ready_precharge /ddr4_top/assertions/assert_ready_after_precharge


