module FunctionUnit(
    input [31:0] A, B,
    input [3:0] FS,  
    output [31:0] Result,
    output Z, C, V
    );
    
    wire [3:0] G;   //alu controls
    wire [1:0] H;   //shifter controls
    wire MF;        //alu-shifter select
    wire [31:0] alu_res, shift_res;
    
    assign MF = ~FS[1]&FS[0];
    assign G[3] = FS[2];
    assign G[2] = (~FS[2]&FS[0]) | (FS[2]&~FS[1]);
    assign G[1] = (FS[1]&~FS[0]);
    assign G[0] = FS[1]|FS[3];
    assign H[1] = FS[3];
    assign H[0] = FS[2];
    /*
    assign MF = FS[3] | (FS[2]&FS[1]&FS[0]);
    assign G[3] = FS[2];
    assign G[2] = (FS[1]&FS[0]) | (FS[2]&FS[1]);
    assign G[1] = (FS[1]&~FS[0]) | (FS[2]&FS[1]);
    assign G[0] = FS[1]|FS[0];
    assign H[1] = ~FS[2]&FS[0];
    assign H[0] = ~FS[2];
    */
    ALU alu0(
        .A(A), .B(B),
        .G(G), 
        .C(C), .V(V), .Z(Z),
        .Result(alu_res)
    );
    
    Shifter shift0(
        .A(A), .B(B),
        .H(H),
        .Result(shift_res)
    );
    
    assign Result = MF ? shift_res : alu_res; 
  
endmodule
