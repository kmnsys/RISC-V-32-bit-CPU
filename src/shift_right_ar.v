module shift_right_ar(
    input [31:0] A, B,
    output reg [31:0] SRA
    );
    
    always @(*)
    begin
        case(B)
            0 : SRA = A;
            1 : begin SRA = {A[31] ? 1'b1 : 1'b0, A[31:1]}; end
            2 : begin SRA = {A[31] ? {2{1'b1}} : 2'b0, A[31:2]}; end
            3 : begin SRA = {A[31] ? {3{1'b1}} : 3'b0, A[31:3]}; end
            4 : begin SRA = {A[31] ? {4{1'b1}} : 4'b0, A[31:4]}; end
            5 : begin SRA = {A[31] ? {5{1'b1}} : 5'b0, A[31:5]}; end
            6 : begin SRA = {A[31] ? {6{1'b1}} : 6'b0, A[31:6]}; end
            7 : begin SRA = {A[31] ? {7{1'b1}} : 7'b0, A[31:7]}; end
            8 : begin SRA = {A[31] ? {8{1'b1}} : 8'b0, A[31:8]}; end
            9 : begin SRA = {A[31] ? {9{1'b1}} : 9'b0, A[31:9]}; end
            10 : begin SRA = {A[31] ? {10{1'b1}} : 10'b0, A[31:10]}; end
            11 : begin SRA = {A[31] ? {11{1'b1}} : 11'b0, A[31:11]}; end
            12 : begin SRA = {A[31] ? {12{1'b1}} : 12'b0, A[31:12]}; end
            13 : begin SRA = {A[31] ? {13{1'b1}} : 13'b0, A[31:13]}; end
            14 : begin SRA = {A[31] ? {14{1'b1}} : 14'b0, A[31:14]}; end
            15 : begin SRA = {A[31] ? {15{1'b1}} : 15'b0, A[31:15]}; end
            16 : begin SRA = {A[31] ? {16{1'b1}} : 16'b0, A[31:16]}; end
            17 : begin SRA = {A[31] ? {17{1'b1}} : 17'b0, A[31:17]}; end
            18 : begin SRA = {A[31] ? {18{1'b1}} : 18'b0, A[31:18]}; end
            19 : begin SRA = {A[31] ? {19{1'b1}} : 19'b0, A[31:19]}; end
            20 : begin SRA = {A[31] ? {20{1'b1}} : 20'b0, A[31:20]}; end
            21 : begin SRA = {A[31] ? {21{1'b1}} : 21'b0, A[31:21]}; end
            22 : begin SRA = {A[31] ? {22{1'b1}} : 22'b0, A[31:22]}; end
            23 : begin SRA = {A[31] ? {23{1'b1}} : 23'b0, A[31:23]}; end
            24 : begin SRA = {A[31] ? {24{1'b1}} : 24'b0, A[31:24]}; end
            25 : begin SRA = {A[31] ? {25{1'b1}} : 25'b0, A[31:25]}; end
            26 : begin SRA = {A[31] ? {26{1'b1}} : 26'b0, A[31:26]}; end
            27 : begin SRA = {A[31] ? {27{1'b1}} : 27'b0, A[31:27]}; end
            28 : begin SRA = {A[31] ? {28{1'b1}} : 28'b0, A[31:28]}; end
            29 : begin SRA = {A[31] ? {29{1'b1}} : 29'b0, A[31:29]}; end
            30 : begin SRA = {A[31] ? {30{1'b1}} : 30'b0, A[31:30]}; end
            31 : begin SRA = {A[31] ? {31{1'b1}} : 31'b0, A[31]}; end
            default : SRA = 32'b0;
       endcase
    end  
endmodule
