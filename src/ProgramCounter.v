module ProgramCounter(
    input clk, rst, PC_Write,
    input [31:0] prev_pc, 
    output reg [31:0] next_pc
    );
       
    always @(posedge clk)
    begin
        if (rst)
            next_pc <= 32'b0;
        else
            if(PC_Write)
                next_pc <= prev_pc;
    end
    
endmodule
