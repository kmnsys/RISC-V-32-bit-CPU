module BranchController(
    input [31:0] imm, rs1, rs2, prev_pc,
    input [2:0] BMC,
    input PL, JL, JLR, BR,
    output [31:0] jump_pc, 
    output PC_Src
    );
    
    wire equal, signed_less, unsigned_less;
    
    assign equal = (rs1 == rs2);
    assign signed_less = ($signed(rs1) < $signed(rs2));
    assign unsigned_less = (rs1 < rs2);
    
    reg BE;    // branch enable
    always @(*)
    begin
        if(BR)
        begin
            case (BMC)
            3'b000:
            begin
                if( equal )
                    BE = 1;
                else
                    BE = 0;
            end
            
            3'b001:
            begin
                if( ~equal )
                    BE = 1;
                else
                    BE = 0;
            end
            
            3'b100:
            begin
                if( signed_less )
                    BE = 1;
                else
                    BE = 0;
            end
            
            
            3'b101:
            begin
                if( ~signed_less )
                    BE = 1;
                else
                    BE = 0;
            end
            
            
            3'b110:
            begin
                if( unsigned_less )
                    BE = 1;
                else
                    BE = 0;
            end
            
            
            3'b111:
            begin
                if( ~unsigned_less )
                    BE = 1;
                else
                    BE = 0;
            end
            
            default:
                    BE = 0;
            endcase        
        end
        
        else
            BE = 0;
    end
   
    assign PC_Src = ~PL&(BE | JL | JLR); 
    
    wire MIJ;
    assign MIJ = ~BE&~JL&JLR;
    
    wire [31:0] sum_imm, imm_rs1;
    
    
    cla_32bit_adder adder_imm(
        .a(imm), .b(prev_pc),
        .cin(0), .cout(), .sum(sum_imm)
    );
    
    cla_32bit_adder adder_jalr(
        .a(imm), .b(rs1),
        .cin(0), .cout(), .sum(imm_rs1)
    );
    
     mux_2to1 mux_ij(
        .in0(sum_imm), .in1(imm_rs1),
        .s(MIJ),
        .out(jump_pc)
    );
    
    
endmodule
