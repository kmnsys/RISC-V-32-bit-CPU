module full_adder(
    input a, b, cin,
    output sum,
    output p, g
    );
    
    assign sum = a^b^cin;
    //assign cout = (b&cin)|(a&cin)|(a&b);
    
    assign p = a|b;
    assign g = a&b;
    
endmodule
