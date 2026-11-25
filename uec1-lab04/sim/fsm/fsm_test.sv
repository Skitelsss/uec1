/* Copyright (C) 2025  AGH University of Krakow */

module fsm_test;


    /* Local variables and signals */
    
    localparam logic [6:0] MAX_COUNT = 6'd20;
    localparam logic [6:0] DONE_COUNT = 6'd5;
    localparam logic [6:0] LED_DELAY = 6'd12;
    localparam logic [6:0] LED_BLINKING = 6'd40;
    
    logic clk, rst_n;
    logic trigger, done;
    bit led;
    
    /* Submodules placement */
    
    fsm #(
        .MAX_COUNT(MAX_COUNT),
        .DONE_COUNT(DONE_COUNT),
        .LED_DELAY(LED_DELAY),
        .LED_BLINKING(LED_BLINKING)
    ) dut (
        .clk,
        .rst_n,
        .done,
        .trigger,
        .led
    );
    
    
    /* Tasks and functions definitions */
    
    task automatic reset();
        for (int i = 0; i < 2; ++i) begin
            @(negedge clk);
            rst_n = i[0];
        end
    endtask
    
    task automatic test_non_triggered_fsm();
        for (int i = 0; i < 52; ++i) begin
            assert (!done) else begin
                $error("done: exp: %b, rcv: %b", 1'b0, done);
            end
            assert (!led) else begin
                $error("done: exp: %b, rcv: %b", 1'b0, done);
            end
            @(negedge clk);
        end
    endtask
    
    task automatic test_triggered_fsm();
        @(negedge clk);
        trigger = 1'b1;
    
        fork
            begin
                @(negedge clk);
                trigger = 1'b0;
            end
            begin
                for (int i = 0; i < MAX_COUNT; ++i) begin
                    @(negedge clk);
                    assert (!done) else begin
                        $error("cycle %0d: done: exp: %b, rcv: %b", i, 1'b0, done);
                    end
                end
    
                for (int i = 0; i < DONE_COUNT; ++i) begin
                    @(negedge clk);
                    assert (done) else begin
                        $error("done cycle %0d: done: exp: %b, rcv: %b", i, 1'b1, done);
                    end
                end

                for (int i = 0; i < LED_DELAY + LED_BLINKING; ++i) begin
                    @(negedge clk);
                    assert (led) else begin
                        $error("led %0d: led: exp: %b, rcv: %b", i, 1'b1, led);
                    end
                end                
            end
        join
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
        trigger = 1'b0;
    
        reset();
    
        test_non_triggered_fsm();
        test_triggered_fsm();
    
        $finish();
    end
    
    endmodule