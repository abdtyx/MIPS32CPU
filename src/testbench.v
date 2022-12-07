`timescale 1ns/1ns

module testbench;
    parameter CLK_FREQ = 100;  // 100MHz
    parameter CLK_CYCLE = 1e9 / (CLK_FREQ * 1e6);

    reg clk, rst;

    top t(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk <= 1'b0;
        rst = 1'b1;
        rst <= #20 1'b0;
    end
    always begin
        # (CLK_CYCLE / 2) clk = ~clk;
    end

    always begin 
        #10;
        if ($time >= 1000) begin 
            $finish;
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);
    end


endmodule