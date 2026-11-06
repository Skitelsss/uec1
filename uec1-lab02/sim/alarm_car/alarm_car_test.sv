module alarm_car_test;

    logic door1, door2, door3, door4, door5;
    logic alarm;
    logic expected_alarm; 

    alarm_car uut (
        .door1(door1),
        .door2(door2),
        .door3(door3),
        .door4(door4),
        .door5(door5),
        .alarm(alarm)
    );

    initial begin
        for (int i = 0; i < 32; i++) begin
            {door1, door2, door3, door4, door5} = i[4:0];
            
            expected_alarm = ~(door1 & door2 & door3 & door4 & door5);
            
            #10;

            //$display("Czas = %0t ns | Drzwi (1-5) = %b%b%b%b%b | Alarm = %b", 
                    // $time, door1, door2, door3, door4, door5, alarm);

            assert (alarm == expected_alarm) else
                $error("BŁĄD! Czas = %0t ns | Drzwi = %b%b%b%b%b | Otrzymano: %b, OCZEKIWANO: %b", 
                       $time, door1, door2, door3, door4, door5, alarm, expected_alarm);
        end

        $stop;
    end

endmodule