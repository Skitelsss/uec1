module mux4_4_test;
    
    logic [3:0] input0, input1, input2, input3;
    logic [3:0] sel;
    logic [3:0] input_selected, input_selected_exp;

    mux4_4 tmux (
        .input0,
        .input1,
        .input2,
        .input3,
        .sel,
        .input_selected
    );

    
    initial begin
        $monitor("t=%0t, sel=%b, input0=%b, input1=%b, input2=%b, input3=%b, input_sel=%b", $time, sel, input0, input1, input2, input3, input_selected);
        
        input0 = 4'b1010;
        input1 = 4'b1011;
        input2 = 4'b1100;
        input3 = 4'b1101;

        sel = 4'b1110;
        #10;
        input_selected_exp = input0;
        assert (input_selected == input_selected_exp) else
            $error("Error sel: %b, out: %b, exp input0 = %b, at time: %0t", sel, input_selected, input0, $time);
        sel = 4'b1101;
        #10;
        input_selected_exp = input1;
        assert (input_selected == input_selected_exp) else
            $error("Error sel: %b, out: %b, exp input1 = %b, at time: %0t", sel, input_selected, input1, $time);    
        sel = 4'b1011;
        #10;
        input_selected_exp = input2;
        assert (input_selected == input_selected_exp) else
            $error("Error sel: %b, out: %b, exp input2 = %b, at time: %0t", sel, input_selected, input2, $time);
        sel = 4'b0111;
        #10;
        input_selected_exp = input3;
        assert (input_selected == input_selected_exp) else
            $error("Error sel: %b, out: %b, exp input3 = %b, at time: %0t", sel, input_selected, input3, $time);

        $finish;
    end

endmodule