/*
  Yiheng Chi
  chi14@purdue.edu

  control unit interface
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"
`include "control_unit_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;
  import control_unit_types_pkg::*;

  // input signal for control unit
  word_t instr;
  // output signals for control unit
  opfunc_t opfunc;
  regdst_t RegDst;
  memtoreg_t MemtoReg;
  logic ALUSrc;
  logic RegWEN, dWENi, dRENi;
  extop_t ExtOp;
  aluop_t ALUOp;
  logic halt;

  modport cu (
    input instr,
    output opfunc, RegDst, ALUSrc, MemtoReg, RegWEN, dWENi, dRENi,
           ALUOp, ExtOp, halt
  );

  modport tb (
    input opfunc, RegDst, ALUSrc, MemtoReg, RegWEN, dWENi, dRENi,
          ALUOp, ExtOp, halt,
    output instr
  );

endinterface

`endif //CONTROL_UNIT_IF_VH