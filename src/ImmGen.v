module ImmGen(
    input  wire [31:0]  IR,
    output reg  [31:0]  Imm
);

wire [4:0] opcode = IR[6:2];

always @(*) begin
    case (opcode)
        5'b01101:     //LUI
		      Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
		5'b00101:     //AUIPC
		      Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
		5'b11011 :    //JAL
		      Imm = { {12{IR[31]}}, IR[19:12], IR[20], IR[30:21], 1'b0 };
		5'b11001 :    //JALR
		      Imm = { {20{IR[31]}}, IR[31:20]};
		5'b11000 :   //BRANCH
	          Imm = { {20{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};
	    5'b00000 :   //LOAD
	          Imm = { {20{IR[31]}}, IR[31:20]};
	    5'b01000 :   //STORE
              Imm = { {20{IR[31]}}, IR[31:25], IR[11:7]};
        5'b00100 :   //FU IMM 
	       if(IR[30])
		      Imm = { {27{IR[31]}}, IR[24:20]};
		   else
		      Imm = { {20{IR[31]}}, IR[31:20]};		      
		default : Imm = 32'b0; // FU IMM
	endcase 
end

endmodule