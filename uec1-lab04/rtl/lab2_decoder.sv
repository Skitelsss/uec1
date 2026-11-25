module lab2_decoder (
    input logic [3:0] dec,
    output logic [6:0] result
);

    always_comb begin
        case(dec)
            4'd0: result = 7'b1000000;
            4'd1: result = 7'b1111001;
            4'd2: result = 7'b0100100;
            4'd3: result = 7'b0110000;
            4'd4: result = 7'b0011001;
            4'd5: result = 7'b0010010;
            4'd6: result = 7'b0000010;
            4'd7: result = 7'b1111000;
            4'd8: result = 7'b0000000;
            4'd9: result = 7'b0000000;
            default: result = 7'bx;
        endcase
    end
endmodule