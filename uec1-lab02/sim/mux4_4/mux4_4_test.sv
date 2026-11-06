module mux4_4_test;

    logic [3:0] input0, input1, input2, input3;
    logic [3:0] sel;
    logic [3:0] input_selected;
    logic [3:0] expected_selected;

    mux4_4 uut (
        .input0(input0),
        .input1(input1),
        .input2(input2),
        .input3(input3),
        .sel(sel),
        .input_selected(input_selected)
    );

    initial begin
        input0 = 4'b1010;
        input1 = 4'b1011;
        input2 = 4'b1100;
        input3 = 4'b1101;

        for (int i = 0; i < 16; i++) begin
            sel = i[3:0];

            case (sel)
                4'b1110: expected_selected = input0;
                4'b1101: expected_selected = input1;
                4'b1011: expected_selected = input2;
                4'b0111: expected_selected = input3;
                default: expected_selected = 4'bxxxx;
            endcase

            #10;

            $display("Czas = %0t ns | sel = %b | wyjscie = %h", $time, sel, input_selected);

            assert (input_selected === expected_selected) else
                $error("BŁĄD! Czas = %0t ns | sel = %b | Otrzymano: %h, OCZEKIWANO: %h", 
                       $time, sel, input_selected, expected_selected);
        end

        $stop;
    end

endmodule