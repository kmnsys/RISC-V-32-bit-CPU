module mux_2to1
#(
    parameter SIZE = 32
)
(
    input [SIZE-1:0] in0, in1,
    input s,
    output [SIZE-1:0] out
    );
    
    assign out = s ? in1 : in0;
    
endmodule
