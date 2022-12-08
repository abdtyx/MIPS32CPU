`include "define.v"

module alu #(
    parameter W = `WORD_LEN
) (
    input wire[W-1:0] Op1,
    input wire[W-1:0] Op2,
    input wire[`ALUCTRL_LEN-1:0] ALUCtrl,
    output wire[W-1:0] Res,
    output wire z
);
    reg [W-1:0] r;
    always @(*) begin
        case (ALUCtrl)
            `ADD: 
                r <= $signed(Op1) + $signed(Op2);
            `SUB:
                r <= $signed(Op1) - $signed(Op2);
            `ADDU:
                r <= Op1 + Op2;
            `AND:
                r <= Op1 & Op2;
            `OR:
                r <= Op1 | Op2;
            `SLT:
                r <= $signed(Op1) < $signed(Op2) ? 1 : 0;
        endcase
    end
    assign Res = r;
    assign z = (Op1 == Op2 ? 1 : 0);

endmodule