`include "define.v"
module mcu (
    input wire[`OPCODE_LEN-1:0] OpCode,
    output wire RegDst,
    output wire Jump,
    output wire RegWr,
    output wire Branch,
    output wire MemtoReg,
    output wire[`ALUOP_LEN-1:0] ALUOp,
    output wire MemWr,
    output wire MemRd,
    output wire ALUSrc
);

    reg[`ALUOP_LEN-1:0] aluop;
    reg regdst, jump, regwr, branch, memtoreg, memwr, memrd, alusrc;

    always @(OpCode) begin
        case (OpCode)
            `R: begin
                regdst = 1;
                regwr = 1;
                alusrc = 0;
                memrd = 0;
                memwr = 0;
                memtoreg = 0;
                branch = 0;
                jump = 0;
                aluop = `ALUOP_LEN'b10;
            end
            `LW: begin
                regdst = 0;
                regwr = 1;
                alusrc = 1;
                memrd = 1;
                memwr = 0;
                memtoreg = 1;
                branch = 0;
                jump = 0;
                aluop = `ALUOP_LEN'b00;
            end
            `SW: begin
                regdst = 0;
                regwr = 0;
                alusrc = 1;
                memrd = 0;
                memwr = 1;
                memtoreg = 0;
                branch = 0;
                jump = 0;
                aluop = `ALUOP_LEN'b00;
            end
            `BEQ: begin
                regdst = 0;
                regwr = 0;
                alusrc = 0;
                memrd = 0;
                memwr = 0;
                memtoreg = 0;
                branch = 1;
                jump = 0;
                aluop = `ALUOP_LEN'b01;
            end
            `J: begin
                regdst = 0;
                regwr = 0;
                alusrc = 0;
                memrd = 0;
                memwr = 0;
                memtoreg = 0;
                branch = 0;
                jump = 1;
                aluop = `ALUOP_LEN'b00;
            end
        endcase
    end

    assign RegDst = regdst;
    assign Jump = jump;
    assign RegWr = regwr;
    assign Branch = branch;
    assign MemtoReg = memtoreg;
    assign ALUOp = aluop;
    assign MemWr = memwr;
    assign MemRd = memrd;
    assign ALUSrc = alusrc;

endmodule

module alucu (
    input wire[`ALUOP_LEN-1:0] ALUOp,
    input wire[`FUNCT_LEN-1:0] Funct,
    output wire[`ALUCTRL_LEN-1:0] ALUCtrl
);

    reg[`ALUCTRL_LEN-1:0] sig;

    always @(*) begin
        casex (ALUOp)
            `ALUOP_LEN'b00:
                sig = `ADD;
            `ALUOP_LEN'b01:
                sig = `SUB;
            `ALUOP_LEN'b1x: begin
                case (Funct)
                    `FUNCT_LEN'b100000:
                        sig = `ADD;
                    `FUNCT_LEN'b100001:
                        sig = `ADDU;
                    `FUNCT_LEN'b100010:
                        sig = `SUB;
                    `FUNCT_LEN'b100100:
                        sig = `AND;
                    `FUNCT_LEN'b100101:
                        sig = `OR;
                    `FUNCT_LEN'b101010:
                        sig = `SLT;
                endcase
            end
        endcase
    end

    assign ALUCtrl = sig;

endmodule

module mux #(
    parameter LEN = `WORD_LEN
) (
    input wire[LEN-1:0] Data0,
    input wire[LEN-1:0] Data1,
    input wire sig,
    output reg[LEN-1:0] Data
);

    always @(*) begin
        Data <= sig ? Data1 : Data0;
    end

endmodule