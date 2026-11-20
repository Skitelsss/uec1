/* Copyright (C) 2025  AGH University of Krakow */

module counter_test;


/* Local variables and signals */
localparam int WIDTH     = 4;
logic clk, rst_n;

logic [WIDTH-1:0] value;
logic enabled;


/* Submodules placement */

counter #(
    .WIDTH(WIDTH),
    .MAX_COUNT(12)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .enabled(enabled),
    .value(value)
);




/* Tasks and functions definitions */

task reset();
    for (int i = 0; i < 2; ++i) begin
        @(negedge clk);
        rst_n = i[0];
    end
endtask

task test_disabled_counter();
    enabled = 1'b0;

    reset();

    for (int i = 0; i < 10; ++i) begin
        assert (value == '0) else begin
            $error("value: exp: %1d, rcv: %1d", 4'b0, value);
        end
        @(negedge clk);
    end
endtask

task test_enabled_counter();
    enabled = 1'b1;

    reset();

    for (int i = 0; i < 20; ++i) begin 
        assert (value == i[WIDTH-1:0]) else begin
            $error("value: exp: %1d, rcv: %1d", i, value);
        end
        @(negedge clk);
    end
endtask


/* Clock generation */

initial begin
    clk = 1'b0;

    forever begin
        clk = #5ns ~clk;
    end
end


/* Test */

initial begin
    rst_n = 1'b1;
    enabled = 1'b0;

    test_disabled_counter();
    test_enabled_counter();

    $finish;
end

endmodule
