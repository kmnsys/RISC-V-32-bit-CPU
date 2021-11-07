module overflow_detector(
    input a, b, result,
    output V
    );
    
    assign V = ~(~a)&(~b)&(~result) | a&b&result;  
    
endmodule
