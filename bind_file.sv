module ddr4_bind;
  bind ddr4_rtl 
    bind_block u_bind (
      .ddr4_command_interface(ddr4_top.ddr4_intf.ddr4_command),
      .ddr4_command_internal(ddr4_command)
    );
endmodule

module bind_block(
  output logic [71:0] ddr4_command_interface,
  input  logic [71:0] ddr4_command_internal
);
  assign ddr4_command_interface = ddr4_command_internal;
endmodule

