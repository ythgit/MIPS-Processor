/*
  Yiheng Chi
  chi14@purdue.edu

  program counter interface
*/
`ifndef PC_IF_VH
`define PC_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface pc_if;
  // import types
  import cpu_types_pkg::*;

  logic  WEN, halt;
  word_t pci, pco;

  // program counter ports
  modport pc (
    input WEN, halt, pci,
    output pco
  );
  //register file tb
  modport tb (
    input pco,
    output WEN, halt, pci
  );
endinterface

`endif //PC_IF_VH
