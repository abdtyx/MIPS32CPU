`include "define.v"
module instmem #(
    parameter W = `WORD_LEN,
    parameter S = `INST_MEM_SIZE
) (
    input wire[W-1:0] Addr,
    output reg[W-1:0] Inst
);

    reg[W-1:0] mem[S-1:0];

    initial begin
        $readmemh(`INST_MEM, mem);
        /*
        for (integer i = 0; i < 19; i++) begin
            $display("%h", mem[i]);
        end
        */
    end

    always @(Addr) begin
        Inst <= mem[Addr[11:2]];
    end

endmodule

module datamem #(
    parameter W = `WORD_LEN,
    parameter S = `DATA_MEM_SIZE
) (
    input wire clk, rst,
    input wire[W-1:0] Addr,
    input wire[W-1:0] W_Data,
    input wire[W-1:0] W_Enable,
    input wire[W-1:0] R_Enable,
    output reg[W-1:0] R_Data
);

    reg[W-1:0] mem[S-1:0];
    initial begin
        $readmemh(`DATA_MEM, mem);
        /*
        for (integer i = 0; i < 21; i++) begin
            $display("%h", mem[i]);
        end
        */
    end

    always @(Addr) begin
        if (R_Enable) begin
            R_Data <= mem[Addr[17:2]];
        end
    end

    always @(posedge clk) begin
        if (W_Enable) begin
            mem[Addr[17:2]] <= W_Data;
        end
    end

endmodule