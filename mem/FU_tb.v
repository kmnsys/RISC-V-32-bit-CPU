`timescale 1ns / 1ps
module FunctionUnit_tb();
    reg [31:0] A, B;
    reg [3:0] FS;
    wire [31:0] Result;
    wire Z, C, V;
    
    FunctionUnit UUT(
        .A(A), .B(B),
        .FS(FS),
        .C(C), .V(V), .Z(Z),
        .Result(Result)
    );
    
    initial begin
        // ARITHMETIC OPERATIONS FS[4] = 0, FS[3] = 0
        A = 60; B = 30; FS = 4'b0000; //ADD
        #10
        A = 60; B = 30; FS = 4'b1000; //SUB
        #10
        A = 30; B = 60; FS = 4'b1000; //SUB
        #10
        A = 60; B = 30; FS = 4'b0010; //SLT
        #10
        A = 30; B = 60; FS = 4'b0010; //SLT
        #10
        A = 60; B = 30; FS = 4'b0011; //SLTU
        #10
        A = 30; B = 60; FS = 4'b0011; //SLTU
        #10
        
        // LOGICAL OPERATIONS FS[4] = 0, FS[3] = 0
        A = 60; B = 30; FS = 4'b0111; //AND
        #10
        A = 60; B = 30; FS = 4'b0110; //OR
        #10
        A = 60; B = 30; FS = 4'b0100; //XOR
        #10
        
        // SHIFT OPERATIONS
        A = 64; B = 2; FS = 4'b0001; //SLL
        #10
        A = 64; B = 2; FS = 4'b0101; //SRL
        #10
        A = 64; B = 2; FS = 4'b1101; //SRA Positive 
        #10
        A = -64; B = 2; FS = 4'b1101; //SRA Negative 
        #10
        
        $finish;
    end
    
endmodule
