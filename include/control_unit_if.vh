/*
  Yiheng Chi
  chi14@purdue.edu

  control unit interface
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  // input signal for control unit
  word_t instr;
  // output signals for control unit
  logic [1:0] RegDst, MemtoReg;
  logic ALUSrc;
  logic RegWEN, dWENi, dRENi;
  logic [1:0] ExtOp;
  aluop_t ALUOp;

  modport cu (
    input instr,
    output RegDst, ALUSrc, MemtoReg, RegWEN, dWENi, dRENi, ALUOp, ExtOp
  );

endinterface

`endif //CONTROL_UNIT_IF_VH
