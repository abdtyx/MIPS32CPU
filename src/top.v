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
        .R_Reg1(2),
        .R_Reg2(4),
        .R_Data1(w1),
        .R_Data2(w2)
    );
    reg[W-1:0] nin = 0;
    wire[W-1:0] nout;
    pc _pc(
        .clk(clk),
        .NextAddr(nin),
        .Addr(nout)
    );

    always @(posedge clk) begin
        nin += 4;
    end

endmodule