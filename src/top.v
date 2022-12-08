`include "define.v"
module top #(
    parameter W = `WORD_LEN
) (
    input clk, rst
);

    wire[W-1:0] NextAddr, Addr;

    pc _pc(
        .clk(clk),
        .rst(rst),
        .NextAddr(NextAddr),
        .Addr(Addr)
    );

    wire[W-1:0] Inst;

    instmem _instmem(
        .Addr(Addr),
        .Inst(Inst)
    );

    wire[`OPCODE_LEN-1:0] OpCode;
    wire[25:0] JAddr;
    wire[`REGADDR_LEN-1:0] Rs, Rt, Rd;
    wire[15:0] Imm;
    wire[5:0] Funct;

    decode _decode(
        .Inst(Inst),
        .OpCode(OpCode),
        .Addr(JAddr),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(Rd),
        .Imm(Imm),
        .Funct(Funct)
    );

    wire[`ALUOP_LEN-1:0] ALUOp;
    wire RegDst, Jump, RegWr, Branch, MemtoReg, MemWr, MemRd, ALUSrc;

    mcu _mcu(
        .OpCode(OpCode),
        .RegDst(RegDst),
        .Jump(Jump),
        .RegWr(RegWr),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWr(MemWr),
        .MemRd(MemRd),
        .ALUSrc(ALUSrc)
    );

    wire[`ALUCTRL_LEN-1:0] ALUCtrl;

    alucu _alucu(
        .ALUOp(ALUOp),
        .Funct(Funct),
        .ALUCtrl(ALUCtrl)
    );

    wire[W-1:0] W_Data, R_Data1, R_Data2;
    wire[`REGADDR_LEN-1:0] W_Reg;

    mux #(`REGADDR_LEN) _mux_W_Reg(
        .Data0(Rt),
        .Data1(Rd),
        .sig(RegDst),
        .Data(W_Reg)
    );

    regfile _regfile(
        .clk(clk),
        .rst(rst),
        .w(RegWr),
        .W_Data(W_Data),
        .W_Reg(W_Reg),
        .R_Reg1(Rs),
        .R_Reg2(Rt),
        .R_Data1(R_Data1),
        .R_Data2(R_Data2)
    );

    wire[W-1:0] ALUOp2;

    mux #(W) _mux_ALUOp2(
        .Data0(R_Data2),
        .Data1({{(16){Imm[15]}}, Imm}),
        .sig(ALUSrc),
        .Data(ALUOp2)
    );

    wire[W-1:0] ALURes;
    wire ALUResz;

    alu _alu(
        .Op1(R_Data1),
        .Op2(ALUOp2),
        .ALUCtrl(ALUCtrl),
        .Res(ALURes),
        .Resz(ALUResz)
    );

    wire[W-1:0] MemR_Data;

    datamem _datamem(
        .clk(clk),
        .rst(rst),
        .Addr(ALURes),
        .W_Data(R_Data2),
        .W_Enable(MemWr),
        .R_Enable(MemRd),
        .R_Data(MemR_Data)
    );

    mux #(W) _mux_W_Data(
        .Data0(ALURes),
        .Data1(MemR_Data),
        .sig(MemtoReg),
        .Data(W_Data)
    );

    wire[W-1:0] PCPlusFour;

    alu Add1(
        .Op1(4),
        .Op2(Addr),
        .ALUCtrl(`ADD),
        .Res(PCPlusFour),
        .Resz()
    );

    wire[W-1:0] Add2_C;

    alu Add2(
        .Op1(PCPlusFour),
        .Op2({{(16){Imm[15]}}, Imm} << 2),
        .ALUCtrl(`ADD),
        .Res(Add2_C),
        .Resz()
    );

    wire[W-1:0] BranchAddr;

    mux #(W) _mux_Branch(
        .Data0(PCPlusFour),
        .Data1(Add2_C),
        .sig(ALUResz & Branch),
        .Data(BranchAddr)
    );

    mux #(W) _mux_Jump(
        .Data0(BranchAddr),
        .Data1({PCPlusFour[31:28], {JAddr, {(2){1'b0}}}}),
        .sig(Jump),
        .Data(NextAddr)
    );

endmodule