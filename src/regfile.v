`include "define.v"
module regfile #(
    parameter W = `WORD_LEN
) (
    input wire clk, rst, w,
    input wire[W-1:0] W_Data,
    input wire[`REGADDR_LEN-1:0] W_Reg,
    input wire[`REGADDR_LEN-1:0] R_Reg1,
    input wire[`REGADDR_LEN-1:0] R_Reg2,
    output reg[W-1:0] R_Data1,
    output reg[W-1:0] R_Data2
);
    reg[W-1:0] Regs[W-1:0];

    initial begin
        for (integer i = 0; i < W; i++) begin
            Regs[i] <= 0;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            R_Data1 <= 0;
            R_Data2 <= 0;
        end
        else if (w) begin
            Regs[W_Reg] <= W_Data;
        end
    end

    always @(R_Reg1) begin
        if (!rst)
            R_Data1 <= Regs[R_Reg1];
        else
            R_Data1 <= 0;
    end

    always @(R_Reg2) begin
        if (!rst)
            R_Data2 <= Regs[R_Reg2];
        else
            R_Data2 <= 0;
    end

endmodule