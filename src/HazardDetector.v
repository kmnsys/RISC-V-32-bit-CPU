module HazardDetector(
    input ID_EX_MR, ID_EX_BR,
    input [4:0] IF_ID_AA, IF_ID_BA,
    input [4:0] ID_EX_DA,
    output reg PC_Write, IF_ID_Write, M_Stall
    );
    
    always @(*)
    begin
        if((ID_EX_MR == 1) && ((ID_EX_DA == IF_ID_AA) || (ID_EX_DA == IF_ID_BA)))
        begin
            M_Stall = 1;
            PC_Write = 0;
            IF_ID_Write = 0;    
        end
        
        else
        begin
            M_Stall = 0;
            PC_Write = 1;
            IF_ID_Write = 1; 
        end
    end
endmodule
