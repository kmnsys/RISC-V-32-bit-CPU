module ALU(
    input [31:0] A, B,
    input [3:0] G, //G select: s2, s1, s0, Bneg
    output C, V, Z,
    output [31:0] Result
    );
    
    wire [31:0] au_res, lu_res;
    
    arithmetic_unit au0(.A(A), .B(B), .s1(G[2]), .s0(G[1]), .Bneg(G[0]), .C(C), .V(V), .arith_out(au_res));
    logic_unit log0(.A(A), .B(B), .s1(G[2]), .s0(G[1]), .logic_out(lu_res));
    
    assign Result = G[3] ? lu_res: au_res;
    
    zero_detector z0(.Result(Result), .Z(Z));
    
endmodule
