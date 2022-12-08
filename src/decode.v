`include "define.v"
module decode #(
    parameter W = `WORD_LEN
) (
    input wire[W-1:0] Inst,
    output wire[`OPCODE_LEN-1:0] OpCode,    // 31-26
    output wire[25:0] Addr,                 // 25-0
    output wire[`REGADDR_LEN-1:0] Rs,       // 25-21
    output wire[`REGADDR_LEN-1:0] Rt,       // 20-16
    output wire[`REGADDR_LEN-1:0] Rd,       // 15-11
    output wire[15:0] Imm,                  // 15-0
    output wire[5:0] Funct                  // 5-0
);
    assign OpCode = Inst[31:26];
    assign Addr = Inst[25:0];
    assign Rs = Inst[25:21];
    assign Rt = Inst[20:16];
    assign Rd = Inst[15:11];
    assign Imm = Inst[15:0];
    assign Funct = Inst[5:0];

endmodule