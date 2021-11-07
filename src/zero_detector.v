module zero_detector(
    input [31:0] Result,
    output Z
    );
    
    assign Z = Result==32'b0;  
    
endmodule
