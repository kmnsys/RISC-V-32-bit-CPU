module EX_MEM(
    input clk, rst,
    input [31:0] EX_Pc4, 
    input [31:0] EX_Fout, EX_Data_Out,
    input [4:0] EX_DA, EX_BA,
    input EX_MD,
    input EX_RW, EX_MW, EX_MR,
    input EX_JL, EX_JLR,
    input [2:0] EX_BMC,
    
    output reg [31:0] MEM_Pc4, 
    output reg [31:0] MEM_Fout, MEM_Data_Out,
    output reg [4:0] MEM_DA, MEM_BA,
    output reg  MEM_MD,
    output reg  MEM_RW, MEM_MW, MEM_MR,
    output reg  MEM_JL, MEM_JLR,
    output reg  [2:0] MEM_BMC
    );
    
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            MEM_Pc4 <= 0;
            MEM_Fout <= 0;
            MEM_Data_Out <= 0;
            
            MEM_DA <= 0;
            MEM_BA <= 0;
            MEM_MD <= 0;
            
            MEM_RW <= 0;
            MEM_MW <= 0; 
            MEM_MR <= 0; 
            
            MEM_JL <= 0;
            MEM_JLR <= 0;
            MEM_BMC <= 0;
        end
        
        else 
        begin 
            MEM_Pc4 <= EX_Pc4;
            MEM_Fout <= EX_Fout;
            MEM_Data_Out <= EX_Data_Out;
            
            MEM_DA <= EX_DA;
            MEM_BA <= EX_BA;
            MEM_MD <= EX_MD;
            
            MEM_RW <= EX_RW;
            MEM_MW <= EX_MW; 
            MEM_MR <= EX_MR; 
            
            MEM_JL <= EX_JL;
            MEM_JLR <= EX_JLR;
            MEM_BMC <= EX_BMC;
        end
        
    end
endmodule
