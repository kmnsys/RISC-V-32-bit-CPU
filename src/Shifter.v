module Shifter(
    input [31:0] A, B,
    input [1:0] H,//H select:s1, s0
    output [31:0] Result
    );
    
    wire [31:0] SLL, SRL, SRA;
    
    shift_left_log sll0(
    .A(A), .B(B), .SLL(SLL)
    );
    
    shift_right_log srl0(
    .A(A), .B(B), .SRL(SRL)
    );
    
    shift_right_ar sra0(
    .A(A), .B(B), .SRA(SRA)
    );
    
    assign Result = ~H[1] ? (~H[0] ? SLL : SRL) : SRA; 
        
endmodule
