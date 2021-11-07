module logic_unit(
    input [31:0] A, B,
    input s1, s0,
    output [31:0] logic_out
    );
    
    wire [31:0] inp_and, inp_or, inp_xor;
    
    assign inp_and = A&B;
    assign inp_or = A|B;
    assign inp_xor = A^B;
    
    assign logic_out = ~s1 ? (~s0 ? inp_and : inp_or) : inp_xor ;
    
endmodule
