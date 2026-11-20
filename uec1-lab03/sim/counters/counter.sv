/* Copyright (C) 2025  AGH University of Krakow */

module counter #(
    parameter int MAX_COUNT = 4,
    parameter int WIDTH = 8
) (
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic overflow,
    output logic [WIDTH-1:0] value
);


/* Local variables and signals */

logic [WIDTH-1:0] value_nxt;


/* Module internal logic */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        value <= '0;
    end else begin
        value <= value_nxt;
    end
end

always_comb begin
    value_nxt = value;

    if (enabled) begin
        if (value_nxt < MAX_COUNT) begin
            value_nxt = value + 1;
            overflow = 0;
        end else begin
            value_nxt = '0;
            overflow = 1;
        end
    end
end

endmodule
