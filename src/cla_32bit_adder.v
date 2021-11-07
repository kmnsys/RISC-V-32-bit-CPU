module cla_32bit_adder(
    input [31:0] a, b, 
    input cin,
    output cout,
    output [31:0] sum 
    );
    
    wire [1:0] P, G;
    wire [2:0] C;
    
    cla_16bit_adder cla16_0(.a(a[15:0]), .b(b[15:0]), .cin(C[0]), .sum(sum[15:0]), .PO(P[0]), .GO(G[0]));
    cla_16bit_adder cla16_1(.a(a[31:16]), .b(b[31:16]), .cin(C[1]), .sum(sum[31:16]), .PO(P[1]), .GO(G[1]));
    
    assign C[0] = cin;
    assign C[1] = G[0] | (P[0]&C[0]);
    assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&C[0]);
    
    assign cout  = C[2];
    
endmodule