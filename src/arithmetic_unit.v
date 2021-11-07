module arithmetic_unit(
    input [31:0] A, B,
    input s1, s0, Bneg, 
    output C, V, 
    output [31:0] arith_out
    );
    
    wire [31:0] Binp, add_sub, slt, sltu;
    wire zero;
    wire Amsb, Bmsb, Rmsb;
    
    assign Binp = Bneg ? ~B : B;
    //assign Ainp = Azero ? 0 : A;

    
    cla_32bit_adder cla32(.a(A), .b(Binp), .cin(Bneg), .cout(C), .sum(add_sub));
    overflow_detector overflow0(.a(A[31]), .b(B[31]), .result(add_sub[31]), .V(V));
    
    //assign slt = {31'b0, add_sub[31]};
    assign Amsb = A[31];
    assign Bmsb = B[31];
    assign Rmsb = add_sub[31];
    
    assign slt = {31'b0, (~Bmsb&Rmsb)|(Amsb&~Bmsb)|(Amsb&Rmsb)};
    assign sltu = {31'b0 ,~C};
    
    assign arith_out = ~s1 ? (~s0 ? add_sub : slt) : sltu ; 
    
endmodule
