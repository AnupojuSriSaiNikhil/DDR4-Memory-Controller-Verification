
package ddr4_package;

    `include "uvm_macros.svh"
    import uvm_pkg::*;

    // Include sequence items and sequences
    `include "ddr4_seq_item.sv"
    `include "ddr4_write_seq.sv"
    `include "ddr4_read_seq.sv"

    // Include UVM components
    `include "ddr4_sequencer.sv"
    `include "ddr4_driver.sv"
    `include "ddr4_monitor.sv"
    `include "ddr4_agent.sv"
    `include "ddr4_environment.sv"

    // Include testbench
    `include "ddr4_test.sv"

endpackage

