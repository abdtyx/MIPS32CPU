// universal
`define WORD_LEN 32
`define OP_LEN 6

// R type
`define R 6'b000000

// I type
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100

// J type
`define J 6'b000010

// ALU op
`define ADD 6'b100000
`define ADDU 6'b100001
`define SUB 6'b100010
`define AND 6'b100100
`define OR 6'b100101
`define SLT 6'b101010