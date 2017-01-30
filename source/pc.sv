/*
  Yiheng Chi
  chi14@purdue.edu

  program counter source code
*/

// import necessary files
`include "pc_if.vh"
`include "cpu_types_pkg.vh"

// pc module
module pc(
  input logic CLK, nRST,
  pc_if.pc pcif
);

// import types
import cpu_types_pkg::*;

// pc's update logic
always_ff @ (posedge CLK, negedge nRST) begin
  if (nRST == 0) begin
    pcif.pco <= 32'b0;
  end else begin
    if (pcif.WEN == 1'b1 && pcif.halt == 1'b0) begin
      pcif.pco <= pcif.pci;
    end
  end
end

endmodule
