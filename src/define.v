// universal
`define WORD_LEN 32
`define ALUCTRL_LEN 3
`define OPCODE_LEN 6
`define ALUOP_LEN 2
`define FUNCT_LEN 6
`define REGADDR_LEN 5

// R type
`define R 6'b000000

// I type
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100

// J type
`define J 6'b000010

// ALU Ctrl
`define ADD 3'b100
`define SUB 3'b110
`define ADDU 3'b101
`define AND 3'b000
`define OR 3'b001
`define SLT 3'b011