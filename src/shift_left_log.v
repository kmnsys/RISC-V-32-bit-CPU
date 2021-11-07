module shift_left_log(
    input [31:0] A, B,
    output reg [31:0] SLL
    );
    
    
    always @(*)
    begin
        case(B)
            0 : SLL = A;
            1 : SLL = {A[30:0], 1'b0};
            2 : SLL = {A[29:0], 2'b0};
            3 : SLL = {A[28:0], 3'b0};
            4 : SLL = {A[27:0], 4'b0};
            5 : SLL = {A[26:0], 5'b0};
            6 : SLL = {A[25:0], 6'b0};
            7 : SLL = {A[24:0], 7'b0};
            8 : SLL = {A[23:0], 8'b0};
            9 : SLL = {A[22:0], 9'b0};
            10 : SLL = {A[21:0], 10'b0};
            11 : SLL = {A[20:0], 11'b0};
            12 : SLL = {A[19:0], 12'b0};
            13 : SLL = {A[18:0], 13'b0};
            14 : SLL = {A[17:0], 14'b0};
            15 : SLL = {A[16:0], 15'b0};
            
            16 : SLL = {A[15:0], 16'b0};
            17 : SLL = {A[14:0], 17'b0};
            18 : SLL = {A[13:0], 18'b0};
            19 : SLL = {A[12:0], 19'b0};
            20 : SLL = {A[11:0], 20'b0};
            21 : SLL = {A[10:0], 21'b0};
            22 : SLL = {A[9:0], 22'b0};
            23 : SLL = {A[8:0], 23'b0};
            24 : SLL = {A[7:0], 24'b0};
            25 : SLL = {A[6:0], 25'b0};
            26 : SLL = {A[5:0], 26'b0};
            27 : SLL = {A[4:0], 27'b0};
            28 : SLL = {A[3:0], 28'b0};
            29 : SLL = {A[2:0], 29'b0};
            30 : SLL = {A[1:0], 30'b0};
            31 : SLL = {A[0], 31'b0};
            default : SLL = 0;
       endcase
    end  
endmodule
