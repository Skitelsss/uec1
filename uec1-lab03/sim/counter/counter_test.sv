/* Copyright (C) 2025  AGH University of Krakow */

module counter_test;

localparam int WIDTH     = 4;
localparam int MAX_COUNT = 9;

/* Local variables and signals */

logic clk, rst_n;

logic [WIDTH-1:0] value;
logic enabled;

logic overflow;


/* Submodules placement */

counter #(
    .MAX_COUNT(MAX_COUNT),
    .WIDTH(WIDTH)
) dut (
    .clk,
    .rst_n,
    .enabled,
    .overflow,
    .value
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
            $error("value: exp: %1d, rcv: %1d", 0, value);
        end
        assert (overflow == 1'b0) else begin
            $error("overflow: exp: 0, rcv: %1b", overflow);
        end
        @(negedge clk);
    end
endtask

task test_enabled_counter();
    enabled = 1'b1;

    reset();

    for (int i = 0; i < 25; ++i) begin
        int exp_val = i % (MAX_COUNT + 1);
        logic exp_ovf = (i > 0) && (exp_val == 0);

        assert (value == exp_val[WIDTH-1:0]) else begin
            $error("value: exp: %1d, rcv: %1d", exp_val, value);
        end
        assert (overflow == exp_ovf) else begin
            $error("overflow: exp: %1b, rcv: %1b", exp_ovf, overflow);
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
