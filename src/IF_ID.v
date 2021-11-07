module IF_ID(
    input clk, rst, IF_ID_Write,
    input [31:0] IF_Inst, IF_Next_Pc, IF_Pc4,
    output reg [31:0] ID_Inst, ID_Next_Pc, ID_Pc4   
    );
    
    //reg [31:0] Inst, Next_Pc;
    
    
    always @(posedge clk)
    begin
        if(rst)
        begin
                ID_Inst <= 32'b00000000000000000000000000010011;
                ID_Next_Pc <= 0;
                ID_Pc4 <= 0;
        end
        
        else
        begin
            if(IF_ID_Write == 1)
            begin
                ID_Inst <= IF_Inst;
                ID_Next_Pc <= IF_Next_Pc;
                ID_Pc4 <= IF_Pc4;
            end
        end
    end
    
    //assign ID_Inst = Inst;
    //assign ID_Next_Pc = Next_Pc;
    
endmodule


    
      