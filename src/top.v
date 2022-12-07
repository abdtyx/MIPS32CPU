`include "define.v"
module top #(
    parameter W = `WORD_LEN
) (
    input clk, rst
);
    wire[W-1:0] w;
    alu a(
        .Op1(1),
        .Op2(1),
        .ALUCtrl(3'b100),
        .Res(w)
    );

endmodule