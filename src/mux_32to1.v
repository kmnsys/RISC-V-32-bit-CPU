module mux_32to1 ( 
    input [31:0] in0, in1, in2, in3, in4, in5, in6, in7,
    input [31:0] in8, in9, in10, in11, in12, in13, in14, in15,
    input [31:0] in16, in17, in18, in19, in20, in21, in22, in23,
    input [31:0] in24, in25, in26, in27, in28, in29, in30, in31,
    input [4:0] select,
    output [31:0] out
);
    wire [31:0] mux[31:0];
    assign mux[0] = in0; assign mux[1] = in1; assign mux[2] = in2; assign mux[3] = in3;
    assign mux[4] = in4; assign mux[5] = in5; assign mux[6] = in6; assign mux[7] = in7;
    assign mux[8] = in8; assign mux[9] = in9; assign mux[10] = in10; assign mux[11] = in11;
    assign mux[12] = in12; assign mux[13] = in13; assign mux[14] = in14; assign mux[15] = in15;
    assign mux[16] = in16; assign mux[17] = in17; assign mux[18] = in18; assign mux[19] = in19;
    assign mux[20] = in20; assign mux[21] = in21; assign mux[22] = in22; assign mux[23] = in23;
    assign mux[24] = in24; assign mux[25] = in25; assign mux[26] = in26; assign mux[27] = in27;
    assign mux[28] = in28; assign mux[29] = in29; assign mux[30] = in30; assign mux[31] = in31;
    
    assign out = mux[select];
/*
    always @(*) begin
        case(select)
            5'd0: out=in0;   5'd1: out=in1; 5'd2:   out=in2; 5'd3: out=in3;
            5'd4: out=in4;   5'd5: out=in5; 5'd6:   out=in6; 5'd7: out=in7;
            5'd8: out=in8;   5'd9: out=in9; 5'd10:  out=in10; 5'd11: out<=in11;
            5'd12: out=in12; 5'd13: out=in13; 5'd14: out=in14; 5'd15: out=in15;
            5'd16: out=in16; 5'd17: out=in17; 5'd18: out=in18; 5'd19: out=in19;
            5'd20: out=in20; 5'd21: out=in21; 5'd22: out=in22; 5'd23: out=in23;
            5'd24: out=in24; 5'd25: out=in25; 5'd26: out=in26; 5'd27: out=in27;
            5'd28: out=in28; 5'd29: out=in29; 5'd30: out=in30; 5'd31: out=in31;
        endcase
    end  
 */       

endmodule