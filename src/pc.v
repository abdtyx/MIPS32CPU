`include "define.v"
module pc #(
    parameter W = `WORD_LEN
) (
    input wire clk, rst,
    input wire[W-1:0] NextAddr,
    output reg[W-1:0] Addr
);
    reg[W-1:0] r;
    always @(NextAddr) begin
        r <= NextAddr;
    end

    always @(posedge clk) begin
        if (rst) begin
            r <= 0;
        end
        else begin
            Addr <= r;
        end
    end
endmodule