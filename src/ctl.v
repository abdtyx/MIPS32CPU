`include "define.v"
module mcu (
    input wire[`OPCODE_LEN-1:0] OpCode,
    output wire RegDst,
    output wire Jump,
    output wire RegWr,
    output wire Branch,
    output wire MemtoReg,
    output wire ALUOp,
    output wire MemWr,
    output wire MemRd,
    output wire ALUSrc
);
endmodule

module alucu (
    input wire[`ALUOP_LEN-1:0] ALUOp,
    input wire[`FUNCT_LEN-1:0] Funct,
    output wire[`ALUCTRL_LEN-1:0] ALUCtrl
);
endmodule