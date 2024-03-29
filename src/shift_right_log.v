module shift_right_log(
    input [31:0] A, B,
    output reg [31:0] SRL
    );
    
    always @(*)
    begin
        case(B)
            0 : SRL = A;
            1 : SRL = {1'b0, A[31:1]};
            2 : SRL = {2'b0, A[31:2]};
            3 : SRL = {3'b0, A[31:3]};
            4 : SRL = {4'b0, A[31:4]};
            5 : SRL = {5'b0, A[31:5]};
            6 : SRL = {6'b0, A[31:6]};
            7 : SRL = {7'b0, A[31:7]};
            8 : SRL = {8'b0, A[31:8]};
            9 : SRL = {9'b0, A[31:9]};
            10 : SRL = {10'b0, A[31:10]};
            11 : SRL = {11'b0, A[31:11]};
            12 : SRL = {12'b0, A[31:12]};
            13 : SRL = {13'b0, A[31:13]};
            14 : SRL = {14'b0, A[31:14]};
            15 : SRL = {15'b0, A[31:15]};
            
            16 : SRL = {16'b0, A[31:16]};
            17 : SRL = {17'b0, A[31:17]};
            18 : SRL = {18'b0, A[31:18]};
            19 : SRL = {19'b0, A[31:19]};
            20 : SRL = {20'b0, A[31:20]};
            21 : SRL = {21'b0, A[31:21]};
            22 : SRL = {22'b0, A[31:22]};
            23 : SRL = {23'b0, A[31:23]};
            24 : SRL = {24'b0, A[31:24]};
            25 : SRL = {25'b0, A[31:25]};
            26 : SRL = {26'b0, A[31:26]};
            27 : SRL = {27'b0, A[31:27]};
            28 : SRL = {28'b0, A[31:28]};
            29 : SRL = {29'b0, A[31:29]};
            30 : SRL = {30'b0, A[31:30]};
            31 : SRL = {31'b0, A[31]};
            default : SRL = 0;
       endcase
    end  
endmodule
