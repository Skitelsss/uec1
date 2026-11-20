/* Copyright (C) 2025  AGH University of Krakow */

module counter #(
    parameter int WIDTH = 4,
    parameter logic [WIDTH-1:0] MAX_COUNT = 15
) (
    input  logic                clk,
    input  logic                rst_n,
    input  logic                enabled,
    output logic  [WIDTH-1:0]   value
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
        if (value == MAX_COUNT) begin
            value_nxt = 4'b0;
        end else begin
            value_nxt = value + 1'b1;
        end
    end
end

endmodule