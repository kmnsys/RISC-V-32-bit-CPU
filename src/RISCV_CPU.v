module RISCV_CPU(
    input clk, rst, IM_we,
    input [31:0] IM_addr, IM_data
    
);
    
    wire [31:0] jump_pc, prev_pc, next_pc, pc4;
    wire PC_Src;
    assign pc4 = next_pc + 4;
    
    mux_2to1 muxpc(
       .in0(pc4), .in1(jump_pc),
       .s(PC_Src), 
       .out(prev_pc)
    );
    
    wire PC_Write, IF_ID_Write, M_Stall;
    wire  EX_MR;
    wire [4:0] AA, BA, EX_DA;
    wire BR;
    
    HazardDetector HD(
        .ID_EX_MR(EX_MR),.ID_EX_BR(BR),
        .IF_ID_AA(AA), .IF_ID_BA(BA),
        .ID_EX_DA(EX_DA),
        .PC_Write(PC_Write), .IF_ID_Write(IF_ID_Write), .M_Stall(M_Stall)
    );
    
    ProgramCounter PC(
        .clk(clk), .rst(rst),
        .PC_Write(PC_Write),
        .prev_pc(prev_pc),
        .next_pc(next_pc)
    );
    
    wire [31:0] Check_Inst;
    wire [31:0] IF_Inst;

	 InsMem IM(
        .clk(clk), .rst(rst), .we(IM_we),
        .addr(next_pc),
        .IM_addr(IM_addr),  
        .data(IM_data),
        .out(Check_Inst)
    );
    
/*
    InsMem IM(
        .clk(clk), .rst(rst), .we(IM_we),
        .addr(next_pc),  
        .data(),
        .out(Check_Inst)
    );
*/  
    
    
    //wire MJ;
    //assign MJ = JL | JLR;
    
    mux_2to1 muxj(
        .in0(Check_Inst), .in1(32'd19),
        .s(PC_Src),
        .out(IF_Inst)
    );
    
    wire [31:0] ID_Inst;
    wire [31:0] ID_Next_Pc;
    wire [31:0] ID_Pc4;
    
    IF_ID IF_ID(
        .clk(clk), .rst(rst),
        .IF_ID_Write(IF_ID_Write),
        .IF_Inst(IF_Inst), .IF_Next_Pc(next_pc), .IF_Pc4(pc4), 
        .ID_Inst(ID_Inst), .ID_Next_Pc(ID_Next_Pc), .ID_Pc4(ID_Pc4)   
    );
    
    wire [31:0] ID_Imm;
    ImmGen IG(
        .IR(ID_Inst),
        .Imm(ID_Imm)
    );
    
    wire MA, MB, MD, RW, MW, MR, PL, JL, JLR;
    wire [3:0] FS;
    wire [2:0] BMC;
    wire [4:0] DA;
    
    InsDec ID(
        .IR(ID_Inst),
        .MA(MA), .MB(MB), .MD(MD),
        .RW(RW), .MW(MW), .MR(MR),
        .PL(PL), .JL(JL), .JLR(JLR), .BR(BR),
        .FS(FS), .BMC(BMC),
        .AA(AA), .BA(BA), .DA(DA)
    );
    
    wire [31:0] Adata, Bdata, Ddata;
    wire [31:0] BusA, BusB, BusD;
    wire WB_RW;
    wire [4:0] MEM_DA;
    wire [4:0] WB_DA;
    
    RegisterFile RF(
        .clk(clk), .RW(WB_RW),
        .AA(AA), .BA(BA), .DA(WB_DA),
        .D(BusD), .A(Adata), .B(Bdata) 
    );
    
    wire [31:0] new_Adata;
    wire [31:0] new_Bdata;
    wire [31:0] MEM_Fout;
    
    mux_2to1 forw_rfa (
        .in0(Adata), .in1(MEM_Fout),
        .s(ForwardC), .out(new_Adata)
    );
    
    mux_2to1 forw_rfb (
        .in0(Bdata), .in1(MEM_Fout),
        .s(ForwardD), .out(new_Bdata)
    );
    
    BranchController BC(
        .BMC(BMC), 
        .PL(PL), .JL(JL), .JLR(JLR), .BR(BR),
        .imm(ID_Imm), .rs1(new_Adata), .rs2(new_Bdata),
        .prev_pc(ID_Next_Pc),
        .jump_pc(jump_pc), 
        .PC_Src(PC_Src)
    );
    
    wire [31:0] EX_Pc4, EX_Next_Pc, EX_Imm;
    wire [4:0] EX_AA, EX_BA;
    wire EX_MA, EX_MB, EX_MD;
    wire EX_RW, EX_MW; 
    wire EX_PL, EX_JL, EX_JLR;
    wire [3:0] EX_FS;
    wire [2:0] EX_BMC;
    wire [31:0] EX_RA, EX_RB;
    
    wire [31:0] Control;
    wire [31:0] COUTS;
    
    assign Control = {16'b0, MA, MB, MD, RW, MW, MR, PL, JL, JLR, FS, BMC};
    
    mux_2to1 mux_idex(
        .in0(Control), .in1(0),
        .s(M_Stall),
        .out(COUTS)
    );
    
    ID_EX ID_EX(
        .clk(clk), .rst(rst),
        
        .ID_Next_Pc(ID_Next_Pc), 
        .ID_Imm(ID_Imm),
        .ID_DA(DA), .ID_AA(AA), .ID_BA(BA),
        .ID_Pc4(ID_Pc4),
        .ID_MA(COUTS[15]), .ID_MB(COUTS[14]), .ID_MD(COUTS[13]),
        .ID_RW(COUTS[12]), .ID_MW(COUTS[11]), .ID_MR(COUTS[10]),
        .ID_PL(COUTS[9]), .ID_JL(COUTS[8]), .ID_JLR(COUTS[7]),
        .ID_FS(COUTS[6:3]), .ID_BMC(COUTS[2:0]),
        .ID_RA(Adata), .ID_RB(Bdata),
        
        .EX_Next_Pc(EX_Next_Pc), 
        .EX_Imm(EX_Imm),
        .EX_DA(EX_DA), .EX_AA(EX_AA), .EX_BA(EX_BA), 
        .EX_Pc4(EX_Pc4),
        .EX_MA(EX_MA), .EX_MB(EX_MB), .EX_MD(EX_MD),
        .EX_RW(EX_RW), .EX_MW(EX_MW), .EX_MR(EX_MR),
        .EX_PL(EX_PL), .EX_JL(EX_JL), .EX_JLR(EX_JLR),
        .EX_FS(EX_FS), .EX_BMC(EX_BMC),
        .EX_RA(EX_RA), .EX_RB(EX_RB)
    );
    
    
    wire MEM_RW, MEM_MW;
    wire [4:0] MEM_BA;
    wire [1:0] ForwardA, ForwardB;
    wire ForwardM;
    
    ForwardUnit ForwardU(
        .EX_MEM_RW(MEM_RW), .MEM_WB_RW(WB_RW),
        .EX_MEM_DA(MEM_DA), .MEM_WB_DA(WB_DA), 
        .ID_EX_AA(EX_AA), .ID_EX_BA(EX_BA),
        .ForwardA(ForwardA), .ForwardB(ForwardB),
        
        .AA(AA), .BA(BA), .BR(BR),
        .ForwardC(ForwardC), .ForwardD(ForwardD),
        
        .EX_MEM_MW(MEM_MW),
        .EX_MEM_BA(MEM_BA), 
        .ForwardM(ForwardM)
         
    );
    
    wire [31:0] FA, FB;
    wire [31:0] WB_Fout;
    //wire [31:0] MEM_Fout;
    
    mux_4to1 mux_forwa(
        .in0(EX_RA), .in1(MEM_Fout),
        .in2(BusD), .in3(EX_RA),
        .sel(ForwardA), .out(FA)
    );
    
    mux_4to1 mux_forwb(
        .in0(EX_RB), .in1(MEM_Fout),
        .in2(BusD), .in3(EX_RB),
        .sel(ForwardB), .out(FB)
    );
   
    mux_2to1 mux_ma(
        .in0(FA), .in1(EX_Next_Pc),
        .s(EX_MA), 
        .out(BusA)
    );
    
    mux_2to1 mux_mb(
        .in0(FB), .in1(EX_Imm),
        .s(EX_MB), 
        .out(BusB)
    );
    
    wire [31:0] Fout;
    wire Z, C, V;
    
    FunctionUnit FunctionU(
        .A(BusA), .B(BusB),
        .FS(EX_FS),
        .Result(Fout),
        .Z(Z), .C(C), .V(V)
    );
    
    
    //wire MEM_Next_Pc;
    wire [31:0] MEM_Pc4; 
    wire [31:0] MEM_Data_Out;
    wire [2:0] MEM_BMC;
    wire MEM_MR, MEM_MD;
    //wire MEM_MW;
    wire MEM_JL, MEM_JLR;
    //wire [4:0] MEM_BA;
   
    EX_MEM EX_MEM(
        .clk(clk), .rst(rst),
        
        .EX_Pc4(EX_Pc4), 
        .EX_Fout(Fout), .EX_Data_Out(FB),
        .EX_DA(EX_DA), .EX_BA(EX_BA),
        .EX_MD(EX_MD), .EX_BMC(EX_BMC),
        .EX_RW(EX_RW), .EX_MW(EX_MW), .EX_MR(EX_MR),
        .EX_JL(EX_JL), .EX_JLR(EX_JLR),
        
        .MEM_Pc4(MEM_Pc4), 
        .MEM_Fout(MEM_Fout), .MEM_Data_Out(MEM_Data_Out),
        .MEM_DA(MEM_DA), .MEM_BA(MEM_BA), 
        .MEM_MD(MEM_MD), .MEM_BMC(MEM_BMC),
        .MEM_RW(MEM_RW), .MEM_MW(MEM_MW), .MEM_MR(MEM_MR),
        .MEM_JL(MEM_JL), .MEM_JLR(MEM_JLR)
        
    );
    
    wire WB_MW;
    
    wire [31:0] new_Data_Out;
    wire [31:0] WB_Data_In;
    
    mux_2to1  mux_fm(
        .in0(MEM_Data_Out), .in1(WB_Data_In),
        .s(ForwardM), .out(new_Data_Out)
    );
    
    wire [31:0] MEM_Data_In;
    DataMemory DM(
        .clk(clk), 
        .MW(MEM_MW), .MR(MEM_MR), .BMC(MEM_BMC),
        .Address(MEM_Fout),
        .Data_in(new_Data_Out),  
        .Data_out(MEM_Data_In)  
    );
    
    wire [31:0] WB_Pc4;
    wire  WB_MD; 
    wire  WB_JL, WB_JLR;
    
    MEM_WB MEM_WB( 
        .clk(clk),
        .MEM_Fout(MEM_Fout),
        .MEM_Data_In(MEM_Data_In),
        .MEM_DA(MEM_DA),
        .MEM_Pc4(MEM_Pc4),
        .MEM_MD(MEM_MD), .MEM_RW(MEM_RW), .MEM_MW(MEM_MW), 
        .MEM_JL(MEM_JL), .MEM_JLR(MEM_JLR),
        
        .WB_Fout(WB_Fout),
        .WB_Data_In(WB_Data_In),
        .WB_DA(WB_DA),
        .WB_Pc4(WB_Pc4),
        .WB_MD(WB_MD),.WB_RW(WB_RW), .WB_MW(WB_MW),
        .WB_JL(WB_JL), .WB_JLR(WB_JLR)
    );
    
    
    mux_2to1  mux_md(
        .in0(WB_Fout), .in1(WB_Data_In),
        .s(WB_MD), 
        .out(Ddata)
    );
    
    wire MP;
    assign MP = WB_JL | WB_JLR;
    
    mux_2to1 mux_mp(
        .in0(Ddata), .in1(WB_Pc4),
        .s(MP), 
        .out(BusD)
    );
    
endmodule
