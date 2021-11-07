`timescale 1ns / 1ps

module RegisterFile_tb();
    reg clk;
    reg [31:0] D;         //write data
    reg [4:0] DA, AA, BA; //read/write address
    reg RW;               //write enable
    wire [31:0] A, B;      //read data
    
    RegisterFile UUT(
        .clk(clk), .RW(RW),
        .DA(DA), .AA(AA), .BA(BA),
        .D(D), .A(A), .B(B)
    );
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0; RW = 0;
        #20
        RW = 1; D = 32'd15; DA = 5'd1; AA = 5'd0; BA = 5'd1;
        #20     
        RW = 1; D = 32'd25; DA = 5'd2; AA = 5'd1; BA = 5'd2;
        #20     
        RW = 1; D = 32'd35; DA = 5'd3; AA = 5'd2; BA = 5'd3;
        #20     
        RW = 1; D = 32'd55; DA = 5'd4; AA = 5'd3; BA = 5'd4;
        #20     
        RW = 1; D = 32'd45; DA = 5'd5; AA = 5'd4; BA = 5'd5;
        $finish;
    end
endmodule
