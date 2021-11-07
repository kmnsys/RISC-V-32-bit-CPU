module cla_16bit_adder(
    input [15:0] a, b, 
    input cin,
    output PO, GO,
    output [15:0] sum 
    );
    
    wire [4:0] C;
    wire [3:0] P, G;
    //wire PO, GO;

    cla_4bit_adder cla0(.a(a[3:0]), .b(b[3:0]), .cin(C[0]), .sum(sum[3:0]), .P(P[0]), .G(G[0]));
    cla_4bit_adder cla1(.a(a[7:4]), .b(b[7:4]), .cin(C[1]),  .sum(sum[7:4]), .P(P[1]), .G(G[1]));
    cla_4bit_adder cla2(.a(a[11:8]), .b(b[11:8]), .cin(C[2]),  .sum(sum[11:8]), .P(P[2]), .G(G[2]));
    cla_4bit_adder cla3(.a(a[15:12]), .b(b[15:12]), .cin(C[3]), .sum(sum[15:12]), .P(P[3]), .G(G[3]));
    
    assign PO = P[3]&P[2]&P[1]&P[0];
    assign GO = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]);
    
    assign C[0] = cin;
    assign C[1] = G[0] | (P[0]&C[0]);
    assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&C[0]);
    assign C[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&C[0]);
    assign C[4] = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&C[0]);
    
endmodule