/* Copyright (C) 2025  AGH University of Krakow */

module counters_test;

localparam WIDTH = 4;
/* Local variables and signals */

logic clk, rst_n;

logic [WIDTH-1:0] value_inner;
logic [WIDTH-1:0] value_outer;

logic enabled;

logic overflow;

/* Submodules placement */

counters #(
    .MAX_COUNT_INNER(5),
    .WIDTH_INNER(WIDTH),
    .MAX_COUNT_OUTER(3),
    .WIDTH_OUTER(WIDTH)

) tcounters (
    .clk,
    .rst_n,
    .enabled,
    .overflow,
    .value_inner,
    .value_outer
);


/* Tasks and functions definitions */

task reset();
    for (int i = 0; i < 2; ++i) begin
        @(negedge clk);
        rst_n = i[0];
    end
endtask

task test_disabled_counters();
    enabled = 1'b0;

    reset();

    for (int outer = 0; outer <= 3; ++outer) begin
        for (int inner = 0; inner <= 5; ++inner) begin
            assert (value_inner == 4'b0) else begin
                $error("value_inner: exp: %1d, rcv: %1d", 4'b0, value_inner);
            end
            assert (value_outer == 4'b0) else begin
                $error("value_outer: exp: %1d, rcv: %1d", 4'b0, value_outer);
            end
            @(negedge clk);
        end
    end
endtask

task test_enabled_counters();
    enabled = 1'b1;

    reset();

    for (int outer = 0; outer <= 3; ++outer) begin
        for (int inner = 0; inner <= 5; ++inner) begin
            assert (value_inner == inner) else begin
                $error("value_inner: exp: %1d, rcv: %1d", 4'b0, value_inner);
            end
            assert (value_outer == outer) else begin
                $error("value_outer: exp: %1d, rcv: %1d", 4'b0, value_outer);
            end
            @(negedge clk);
        end
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

    test_disabled_counters();
    test_enabled_counters();

    $finish;
end

endmodule
