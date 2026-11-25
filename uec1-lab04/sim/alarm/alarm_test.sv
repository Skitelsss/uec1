module alarm_test;
    bit a, b, c, d, e;
    logic y;
    logic y_exp;

    alarm u_alarm (.a, .b, .c, .d, .e, .y);

    initial begin
        $monitor ("%b %b %b %b %b %b",a, b, c, d, e, y);
        a = 1; b = 1; c = 1; d = 1; e = 1;


        for (int i = 0; i < 32; i++) begin

            {a, b, c, d, e} = i[4:0];

            y_exp = ~(a & b & c & d & e);

            #10;
            assert (y == y_exp) else
                $error("y: exp: 0b%b, rcv: 0b%b, inputs: 0b%b 0b%b 0b%b 0b%b 0b%b ,at sim time: %t", y_exp, y, a, b, c, d, e, $time);
        end
        $finish;
    end

endmodule
