/* Copyright (C) 2025  AGH University of Krakow */

module fsm #(
    parameter logic [6:0] MAX_COUNT = 6'd20,
    parameter logic [6:0] DONE_COUNT = 6'd5,
    parameter logic [6:0] LED_DELAY = 6'd12,
    parameter logic [6:0] LED_BLINKING = 6'd40
) (
    input logic clk,
    input logic rst_n,
    output logic done,
    input logic trigger,

    output bit led
);


/* User defined types and constants */

typedef enum logic [1:0] {
    IDLE,
    ACTIVE,
    DONE,
    LED
} state_t;


/* Local variables and signals */

state_t state, state_nxt;
logic [5:0] counter, counter_nxt;


/* Module internal logic */

/* State Sequencer Logic */
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        counter <= 6'd0;
    end else begin
        state <= state_nxt;
        counter <= counter_nxt;
    end
end

/* Next State Decode Logic */
always_comb begin
    state_nxt = state;
    counter_nxt = counter;

    case (state)
        IDLE: begin
            if (trigger) begin
                state_nxt = ACTIVE;
                counter_nxt = 6'd0;
            end
        end
        ACTIVE: begin
            if (counter == (MAX_COUNT - 6'd1)) begin
                state_nxt = DONE;
                counter_nxt = 6'd0;
            end else begin
                counter_nxt = counter + 6'd1;
            end
        end
        DONE: begin
            if (counter == (DONE_COUNT - 6'd1)) begin
                state_nxt = IDLE;
                counter_nxt = 6'd0;
            end else begin
                counter_nxt = counter + 6'd1;
            end
        end
        LED: begin
            if (counter == (LED_DELAY + LED_BLINKING - 6'd1)) begin
                state_nxt = IDLE;
                counter_nxt = 6'd0;
            end else begin
                counter_nxt = counter + 6'd1;
            end
        end
    endcase
end

/* Output Decode Logic */
always_comb begin
    done = 1'b0;
    led = 1'b0;

    case (state)
        IDLE: ;
        ACTIVE: ;
        DONE: begin
            done = 1'b1;
        end

        LED: begin
            led = counter[2];
        end
    
    endcase
end

endmodule