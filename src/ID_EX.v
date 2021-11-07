module ID_EX(
    input clk, rst,
    
    input [31:0] ID_Pc4, ID_Next_Pc, ID_Imm,
    input [4:0] ID_DA, ID_AA, ID_BA,
    input ID_MA, ID_MB, ID_MD,
    input ID_RW, ID_MW, ID_MR, 
    input ID_PL, ID_JL, ID_JLR,
    input [3:0] ID_FS,
    input [2:0] ID_BMC,
    input [31:0] ID_RA, ID_RB,
    
    output reg [31:0] EX_Pc4, EX_Next_Pc, EX_Imm,
    output reg [4:0] EX_DA, EX_AA, EX_BA, 
    output reg EX_MA, EX_MB, EX_MD, 
    output reg EX_RW, EX_MW, EX_MR, 
    output reg EX_PL, EX_JL, EX_JLR,
    output reg [3:0] EX_FS,
    output reg [2:0] EX_BMC,
    output reg [31:0] EX_RA, EX_RB
    );
    /*
    reg [31:0] Next_Pc, Imm;
    reg MA, MB, MD;
    reg RW, MW; 
    reg PL, JL, JLR;
    reg [3:0] FS;
    reg [2:0] BMC;
    reg [31:0] RA, RB;
    */
    
    always @(posedge clk)
    begin
    /*
        Next_Pc <= ID_Next_Pc; Imm<=ID_Imm;
        MA<=ID_MA ; MB<=ID_MB; MD<=ID_MB;
        RW<=ID_RW; MW<=ID_MW; 
        PL<=ID_PL; JL<=ID_JL; JLR<=ID_JLR;
        FS<=ID_FS; BMC<=ID_BMC;
        RA<=ID_RA; RB<=ID_RB;
       
      */
        if(rst)
        begin
        
            EX_Next_Pc <= 0;
            EX_Imm <= 0;
            EX_Pc4 <= 0;
            
            EX_DA <= 0;
            EX_AA <= 0;
            EX_BA <= 0;
            
            EX_RA<=0;
            EX_RB<=0;
            
            EX_MA<=0;
            EX_MB<=0;
            EX_MD<=0;
            
            EX_RW<=0;
            EX_MW<=0; 
            EX_MR<=0; 
            
            EX_PL<=1; 
            EX_JL<=0;
            EX_JLR<=0;
            
            EX_FS<=0;
            EX_BMC<=0;
        end
        
        else 
        begin
            EX_Next_Pc <= ID_Next_Pc;
            EX_Imm <= ID_Imm;
            EX_Pc4 <= ID_Pc4;
            
            EX_DA <= ID_DA;
            EX_AA <= ID_AA;
            EX_BA <= ID_BA;
            
            EX_RA<=ID_RA;
            EX_RB<=ID_RB;
            
            EX_MA<=ID_MA;
            EX_MB<=ID_MB;
            EX_MD<=ID_MD;
            
            EX_RW<=ID_RW;
            EX_MW<=ID_MW; 
            EX_MR<=ID_MR; 
            
            EX_PL<=ID_PL; 
            EX_JL<=ID_JL;
            EX_JLR<=ID_JLR;
            
            EX_FS<=ID_FS;
            EX_BMC<=ID_BMC;
        end
        
        
    end
    
endmodule
