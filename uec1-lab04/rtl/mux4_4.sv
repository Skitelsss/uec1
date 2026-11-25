module mux4_4 (
    input logic [3:0] input0,
    input logic [3:0] input1,
    input logic [3:0] input2,
    input logic [3:0] input3,
    input logic [3:0] sel,
    output logic [3:0] input_selected
);

    always_comb begin
        case (sel)
          4'b1110: input_selected = input0;
          4'b1101: input_selected = input1;
          4'b1011: input_selected = input2;
          4'b0111: input_selected = input3;
          default: input_selected = 4'bx; 
        endcase
    end

endmodule