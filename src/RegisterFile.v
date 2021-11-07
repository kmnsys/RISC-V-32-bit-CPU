module RegisterFile(
    input clk,
    input [31:0] D,         //write data
    input [4:0] DA, AA, BA, //read/write address
    input RW,               //write enable
    output reg [31:0] A, B      //read data
    );
    
    reg [31:0] RF [31:0];   //32 registers each 32 bits long
    wire [31:0] decout;
    
    wire [31:0] rA, rB; // mux read a and b
    
    mux_32to1 muxA (
    .in0(RF[0]), .in1(RF[1]), .in2(RF[2]), .in3(RF[3]),
    .in4(RF[4]), .in5(RF[5]), .in6(RF[6]), .in7(RF[7]),
    .in8(RF[8]), .in9(RF[9]), .in10(RF[10]), .in11(RF[11]),
    .in12(RF[12]), .in13(RF[13]), .in14(RF[14]), .in15(RF[15]),
    .in16(RF[16]), .in17(RF[17]), .in18(RF[18]), .in19(RF[19]),
    .in20(RF[20]), .in21(RF[21]), .in22(RF[22]), .in23(RF[23]),
    .in24(RF[24]), .in25(RF[25]), .in26(RF[26]), .in27(RF[27]),
    .in28(RF[28]), .in29(RF[29]), .in30(RF[30]), .in31(RF[31]),
    .select(AA), .out(rA)
    );
    
    mux_32to1 muxB (
        .in0(RF[0]), .in1(RF[1]), .in2(RF[2]), .in3(RF[3]),
        .in4(RF[4]), .in5(RF[5]), .in6(RF[6]), .in7(RF[7]),
        .in8(RF[8]), .in9(RF[9]), .in10(RF[10]), .in11(RF[11]),
        .in12(RF[12]), .in13(RF[13]), .in14(RF[14]), .in15(RF[15]),
        .in16(RF[16]), .in17(RF[17]), .in18(RF[18]), .in19(RF[19]),
        .in20(RF[20]), .in21(RF[21]), .in22(RF[22]), .in23(RF[23]),
        .in24(RF[24]), .in25(RF[25]), .in26(RF[26]), .in27(RF[27]),
        .in28(RF[28]), .in29(RF[29]), .in30(RF[30]), .in31(RF[31]),
        .select(BA), .out(rB)
    );
    
    decoder_5to32 dec(
        .in(DA), .we(RW), .out(decout)
    );
    
    //assign A = RF[AA];
    //assign B = RF[BA];
    
    integer i;
    always @(posedge clk) begin
        RF[0] <= 0; 
        for(i= 1; i<32; i=i+1)
            if (decout[i]==1)
                RF[i]<= D;
    end
    
    always @(*)
    begin
        if(RW == 1 && AA == DA)
            A = D;
        else
            A = rA;
        
        if(RW == 1 && BA == DA)
            B = D;
        else
            B = rB;
        
    end
    //assign A = rA;
    //assign B = rB;
endmodule
