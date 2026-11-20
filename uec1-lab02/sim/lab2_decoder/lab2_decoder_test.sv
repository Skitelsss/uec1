module lab2_decoder_test;

    logic [3:0] dec;
    logic [6:0] result;

    logic [6:0] result_exp;

    lab2_decoder duc (
        .dec,
        .result
    );

    initial begin
        $monitor("t = %0t, dec = %b, result = %b", $time, dec, result);
        for (int i = 0; i < 10; i++) begin
            
            dec = i[3:0];

            case (dec)
                4'd0: result_exp = 7'b1000000;
                4'd1: result_exp = 7'b1111001;
                4'd2: result_exp = 7'b0100100;
                4'd3: result_exp = 7'b0110000;
                4'd4: result_exp = 7'b0011001;
                4'd5: result_exp = 7'b0010010;
                4'd6: result_exp = 7'b0000010;
                4'd7: result_exp = 7'b1111000;
                4'd8: result_exp = 7'b0000000;
                4'd9: result_exp = 7'b0000000;
                default: result_exp = 7'bx;
            endcase
            
            #10;

            assert (result === result_exp) else
                $error("Error result: %b, result_exp: %b, dec: %b, at time: %0t ", result, result_exp, dec, $time);

        end

        $finish;

    end

endmodule