  org 0x0000
  ori $3,$0,0xD269
  ori $2,$0,0x37F1
  ori $7,$0,0x3FD2
  ori $21,$0,0x80
  add $1, $2, $3
  sub $2, $1, $3
  and $4, $2, $1
  xor $6, $1, $7
  sw  $1, 0($21)
  sw  $2, 4($21)
  sw  $4, 8($21)
  sw  $6, 12($21)
  halt
