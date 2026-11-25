module counters #(
    parameter int MAX_COUNT_INNER = 5,
    parameter int WIDTH_INNER = 4,

    parameter int MAX_COUNT_OUTER = 3,
    parameter int WIDTH_OUTER = 4
) (
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic overflow,
    output logic [WIDTH_INNER-1:0] value_inner,
    output logic [WIDTH_OUTER-1:0] value_outer
);
    wire overflow_inner;
    counter #(
        .MAX_COUNT (MAX_COUNT_INNER),
        .WIDTH (WIDTH_INNER)
    ) innerctr (
        .clk,
        .rst_n,
        .enabled,
        .overflow (overflow_inner),
        .value (value_inner)
    );

    counter #(
        .MAX_COUNT (MAX_COUNT_OUTER),
        .WIDTH (WIDTH_OUTER)
    ) outerctr (
        .clk,
        .rst_n,
        .enabled (overflow_inner),
        .overflow,
        .value (value_outer)
    );

endmodule
