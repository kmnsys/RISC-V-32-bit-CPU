module MEM_WB(
    input clk,
    input [31:0] MEM_Fout,
    input [31:0] MEM_Data_In,
    input [31:0] MEM_Pc4,
    input [4:0] MEM_DA,
    input MEM_RW, MEM_MW, MEM_MD, 
    input MEM_JL, MEM_JLR,
    
    output reg [31:0] WB_Fout,
    output reg [31:0] WB_Data_In,
    output reg [31:0] WB_Pc4,
    output reg [4:0] WB_DA,
    output reg WB_RW, WB_MW, WB_MD, 
    output reg WB_JL, WB_JLR
    );
     
    always @(posedge clk)
    begin
        WB_Fout <= MEM_Fout;
        WB_Data_In <= MEM_Data_In;
        WB_Pc4 <= MEM_Pc4;
        WB_DA <= MEM_DA;
        
        WB_RW <= MEM_RW;
        WB_MW <= MEM_MW;
        WB_MD <= MEM_MD; 
        
        WB_JL <= MEM_JL;
        WB_JLR <= MEM_JLR;
    end
     
endmodule
