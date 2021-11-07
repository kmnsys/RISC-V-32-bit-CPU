module InsDec(
    input [31:0] IR,
    output reg MA, MB, MD, RW, MW, MR,
    output reg PL, JL, JLR, BR,
    output reg [3:0] FS,
    output reg [2:0] BMC,
    output reg [4:0] AA, BA, DA
    );
    
    
    wire [4:0] opcode;
    wire [3:0] func73;
    wire [2:0] func3;
    
    assign opcode = IR[6:2];
    assign func3 = IR[14:12];
    assign func73 = {IR[30], IR[14:12]};
    
    
    always @(*) begin
        if (opcode == 5'b01101)
            AA = 5'b0;
        else
            AA = IR[19:15];
            BA = IR[24:20];
            DA = IR[11:7];
            BMC = IR[14:12];   //Memory and Branch Control
        
        case(opcode)
            5'b01100 :   //FU Operations 
            begin
                FS = func73;
                MA = 1'b0;  
                MB = 1'b0;
                MD = 1'b0;  
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b1;
                JLR = 1'b0; //dont care
                JL = 1'b0;  //dont care
                BR = 1'b0;
            end    
            
            5'b00100 :   //ALU IMM Operations
            begin
                if (func3 == 3'b101)
                    FS = func73;
                else
                    FS = {1'b0, func3};
                MA = 1'b0;  
                MB = 1'b1;
                MD = 1'b0;  
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b1;
                JLR = 1'b0; //dont care
                JL = 1'b0;  //dont care
                BR = 1'b0;
            end
              
            5'b01000 :   //STORE
            begin
                FS = 4'b0000;
                MA = 1'b0;  
                MB = 1'b1;
                MD = 1'b0;  //dont care
                RW = 1'b0;
                MW = 1'b1;
                MR = 1'b0;
                PL = 1'b1;
                JLR = 1'b0; //dont care
                JL = 1'b0;  //dont care
                BR = 1'b0;
            end
            
            5'b00000 :   //LOAD
            begin
                FS = 4'b0000;
                MA = 1'b0;  
                MB = 1'b1;
                MD = 1'b1;  
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b1;
                PL = 1'b1;
                JLR = 1'b0; //dont care
                JL = 1'b0;  //dont care
                BR = 1'b0;
            end
            
            5'b11000 :   //BRANCH
            begin  
                if(BMC == 3'b000 | BMC == 3'b001)
                    FS = 4'b1000;
                else if(BMC == 3'b100 | BMC == 3'b101)
                    FS = 4'b0010;
                else if(BMC == 3'b110 | BMC == 3'b111)
                    FS = 4'b0011;
                else
                    FS = 4'b0001;
                MA = 1'b0;  //dont care
                MB = 1'b0;
                MD = 1'b0;  //dont care
                RW = 1'b0;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b0;
                JLR = 1'b0; 
                JL = 1'b0;
                BR = 1'b1;
            end
            
            5'b11001 :    //JALR
            begin
                FS = 4'b0000;   //dont care
                MA = 1'b0;  
                MB = 1'b1;  //dont care
                MD = 1'b0;  //dont care
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b0;
                JLR = 1'b1; 
                JL = 1'b0;
                BR = 1'b0;  
            end
            
            5'b11011 :    //JAL
            begin
                FS = 4'b0;   //dont care
                MA = 1'b0;  
                MB = 1'b0;  //dont care
                MD = 1'b0;  //dont care
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b0;
                JLR = 1'b0; 
                JL = 1'b1;
                BR = 1'b0;  
            end
            
            5'b00101 :    //AUIPC
            begin
                FS = 4'b0000;   //dont care
                MA = 1'b1;  
                MB = 1'b1;  //dont care
                MD = 1'b0;  //dont care
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b1;
                JLR = 1'b0; 
                JL = 1'b0;
                BR = 1'b0;  
            end
            
            5'b01101 :    //LUI
            begin
                FS = 4'b0000;   //dont care
                MA = 1'b0;  
                MB = 1'b1;  //dont care
                MD = 1'b0;  //dont care
                RW = 1'b1;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b1;
                JLR = 1'b0; 
                JL = 1'b0;
                BR = 1'b0;  
            end
            
            default:
            begin
                FS = 4'b0000;   //dont care
                MA = 1'b0;  
                MB = 1'b0;  //dont care
                MD = 1'b0;  //dont care
                RW = 1'b0;
                MW = 1'b0;
                MR = 1'b0;
                PL = 1'b1;
                JLR = 1'b0; 
                JL = 1'b0;
                BR = 1'b0;
            end   
        endcase
    
    end  
endmodule
