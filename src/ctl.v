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

    reg[`ALUCTRL_LEN-1:0] sig;

    always @(*) begin
        casex (ALUOp)
            `ALUOP_LEN'b00:
                sig = `ADD;
            `ALUOP_LEN'b01:
                sig = `SUB;
            `ALUOP_LEN'b1x:
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
        endcase
    end

    assign ALUCtrl = sig;

endmodule