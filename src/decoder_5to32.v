module decoder_5to32(
    input [4:0] in,
    input we,
    output [31:0] out
    );
    
    assign out = we << in;
    /*
    integer i;
    always @(in) begin
        for(i= 0; i<31; i=i+1)
            out[i] = (in==i)? 1'b1:1'b0;
    end
    */
endmodule
