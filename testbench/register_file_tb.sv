/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

  task init;
    begin
      rfif.rdat2 = 32'b0;
      rfif.rdat1 = 32'b0;
      rfif.wdat = 32'b0;
      rfif.rsel2 = 5'b0;
      rfif.rsel1 = 5'b0;
      rfif.wsel = 5'b0;
      rfif.WEN = 1'b0;
      nRST = 1'b0;
      @(posedge CLK);
      @(negedge CLK);
      nRST = 1'b1;
    end
  endtask

  task rst;
    begin
      @(negedge CLK);
      nRST = 1'b0;
      @(negedge CLK);
      nRST = 1'b1;
    end
  endtask

  task write;
    input logic [31:0] wdat;
    input logic [4:0] wsel;
    begin
      rfif.wdat = wdat;
      rfif.wsel = wsel;
      rfif.WEN = 1'b1;
      @(posedge CLK);
      rfif.WEN = 1'b0;
      @(posedge CLK);
    end
  endtask

  task read1;
    input logic [4:0] rsel;
    begin
      rfif.rsel1 = rsel;
      #(1*PERIOD);
    end
  endtask

  task read2;
    input logic [4:0] rsel;
    begin
      rfif.rsel2 = rsel;
      #(1*PERIOD);
    end
  endtask

endmodule

program test(
  input logic CLK, nRST,
  register_file_if.tb rfif
);

initial
begin
  init;

  write(32'hAAAAAAAA, 5'b00001);
  write(32'hAAAAAAAA, 5'b00010);
  write(32'hAAAAAAAA, 5'b00011);

  read1(5'b00001);
  read2(5'b00011);
  read1(5'b00010);

  rst;

  write(32'hFFFFFFFF, 5'b00000);

  read2(5'b00000);

  rst;

end

endprogram
