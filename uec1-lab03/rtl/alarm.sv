module alarm (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic y
);

assign y = ~(a & b & c & d & e);
endmodule 
