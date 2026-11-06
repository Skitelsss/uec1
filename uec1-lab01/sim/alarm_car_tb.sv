module alarm_car_tb;
    logic d1, d2, d3, d4, d5;
    logic alarm;

    alarm_car moj_alarm (
        .door1(d1),
        .door2(d2),
        .door3(d3),
        .door4(d4),
        .door5(d5),
        .alarm(alarm)
    );

    initial begin
        $monitor("Czas = %0t ns | Drzwi (1-5) = %b%b%b%b%b | Alarm = %b",
           $time, d1, d2, d3, d4, d5, alarm);

    //scenariusz testowy 1 = zamkniete 0 = otwarte
        {d1, d2, d3, d4, d5} = 5'b11111; #10;
        {d1, d2, d3, d4, d5} = 5'b11110; #10;
        {d1, d2, d3, d4, d5} = 5'b11011; #10;
        {d1, d2, d3, d4, d5} = 5'b00000; #10;
        {d1, d2, d3, d4, d5} = 5'b11111; #10;

        $stop;
    end
endmodule