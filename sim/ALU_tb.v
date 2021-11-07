`timescale 1ns / 1ps

module ALU_tb();
    reg [31:0] A, B;
    reg [3:0] G;
    wire [31:0] Result;
    wire C, V, Z;
    
    ALU UUT(
        .A(A), .B(B),
        .G(G),
        .C(C), .V(V), .Z(Z),
        .Result(Result)
    );
    
    initial begin
        A=0; B=0; G = 4'b0011; // SLT
        #10
        
        A=0; B=0; G = 4'b0101; // SLTU
        #10
        
        // Positive numbers, A>B
        A=40; B=20; G = 4'b0000; // ADD 
        #10
        A=40; B=20; G = 4'b0001; // SUB
        #10
        A=40; B=20; G = 4'b0011; // SLT
        #10
        A=40; B=20; G = 4'b0101; // SLTU
        #10
        
        A=40; B=20; G = 4'b1000; // AND
        #10                      
        A=40; B=20; G = 4'b1010; // OR
        #10                       
        A=40; B=20; G = 4'b1100; // XOR
        #10                      
                                  
        // Positive numbers, A<B // 
        A=40; B=70; G = 4'b0000; // ADD
        #10                       
        A=40; B=70; G = 4'b0001; // SUB
        #10                        
        A=40; B=70; G = 4'b0011; // SLT 
        #10                       
        A=40; B=70; G = 4'b0101; //  SLTU
        #10                       
                                 
        A=40; B=70; G = 4'b1000; // AND
        #10                        
        A=40; B=70; G = 4'b1010; // OR 
        #10                       
        A=40; B=70; G = 4'b1100; // XOR
        #10
        
        // Negative Numbers ADD/SUB/SLT Instructions
        A=-40; B=-30; G = 4'b0000; //  ADD
        #10
        A=-40; B=-30; G = 4'b0001; //  SUB
        #10
        A=-40; B=-30; G = 4'b0011; //  SLT
        #10
        
        $finish; 
    end  
     
endmodule