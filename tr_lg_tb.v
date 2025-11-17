module tr_lg_tb;
    reg clk_t, rst_t;
    wire [2:0] light_t;

    tr_lg dut (
        .clk(clk_t),
        .rst(rst_t),
        .light(light_t)
    );

    always #20 clk_t = ~clk_t;

    initial begin
        clk_t = 1'b1;
        rst_t = 1'b1;
        #100;
        rst_t = 1'b0;
        #200;
    end
endmodule
