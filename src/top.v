`include "define.v"
module top #(
    parameter W = `WORD_LEN
) (
    input clk, rst
);
    wire[W-1:0] w1, w2;

    regfile r(
        .clk(clk),
        .rst(rst),
        .w(1),
        .W_Data(123),
        .W_Reg(2),
        .R_Reg1(3),
        .R_Reg2(4),
        .R_Data1(w1),
        .R_Data2(w2)
    );

endmodule