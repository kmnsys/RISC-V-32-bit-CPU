module cla_4bit_adder(
    input [3:0] a, b, 
    input cin,
    output P, G,
    output [3:0] sum
    );
    
    wire [3:0] c;
    wire [3:0] p, g; 
    
    full_adder f0(.a(a[0]), .b(b[0]), .cin(c[0]), .sum(sum[0]),  .p(p[0]), .g(g[0]));
    full_adder f1(.a(a[1]), .b(b[1]), .cin(c[1]), .sum(sum[1]),  .p(p[1]), .g(g[1]));
    full_adder f2(.a(a[2]), .b(b[2]), .cin(c[2]), .sum(sum[2]),  .p(p[2]), .g(g[2]));
    full_adder f3(.a(a[3]), .b(b[3]), .cin(c[3]), .sum(sum[3]),  .p(p[3]), .g(g[3]));
    
    assign P = p[3]&p[2]&p[1]&p[0];
    assign G = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]);
    
    assign c[0]= cin;
    assign c[1]= g[0]|(p[0]&c[0]);
    assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
    assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
    
    
endmodule