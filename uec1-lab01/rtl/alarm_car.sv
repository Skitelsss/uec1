module alarm_car (
    input logic door1,
    input logic door2,
    input logic door3,
    input logic door4,
    input logic door5,
    output logic alarm
);

assign alarm = ~(door1&door2&door3&door4&door5);

endmodule