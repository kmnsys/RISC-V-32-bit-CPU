module ForwardUnit(
    input EX_MEM_RW, MEM_WB_RW,
    input [4:0] EX_MEM_DA, MEM_WB_DA, ID_EX_AA, ID_EX_BA,
    input [4:0] EX_MEM_BA,
    input [4:0] AA, BA,
    input EX_MEM_MW, BR,
    output reg ForwardC, ForwardD, ForwardM,
    output reg [1:0] ForwardA, ForwardB  
    );
    
    
    always @(*) begin
        // RAW Forward
        if((EX_MEM_RW == 1) && (EX_MEM_DA != 0) && (EX_MEM_DA == ID_EX_AA))
            ForwardA = 2'b01;
        else if((MEM_WB_RW == 1) && (MEM_WB_DA != 0) && (MEM_WB_DA == ID_EX_AA) && (EX_MEM_DA != ID_EX_AA))
            ForwardA = 2'b10;
        else
            ForwardA = 2'b00;
        
        // RAW Forward    
        if((EX_MEM_RW == 1) && (EX_MEM_DA != 0) && (EX_MEM_DA == ID_EX_BA))
            ForwardB = 2'b01;
        else if((MEM_WB_RW == 1) && (MEM_WB_DA != 0) && (MEM_WB_DA == ID_EX_BA) && (EX_MEM_DA != ID_EX_BA) )
            ForwardB = 2'b10; 
        else
            ForwardB = 2'b00;
        
        // Mem to Mem Forward
        if( EX_MEM_MW == 1 && MEM_WB_RW == 1 && EX_MEM_BA == MEM_WB_DA)
            ForwardM = 1;
        else
            ForwardM = 0;
        
        //Branch Forward
        if( (BR == 1) && (EX_MEM_DA != 0) && (EX_MEM_DA == AA))
            ForwardC = 1;
        else 
            ForwardC = 0;
        
        //Branch Forward
        if( (BR == 1) && (EX_MEM_DA != 0) && (EX_MEM_DA == BA))
            ForwardD = 1;
        else 
            ForwardD = 0;
            
    end
    
endmodule
