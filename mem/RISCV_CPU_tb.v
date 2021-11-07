`timescale 1ns / 1ps

module RISCV_CPU_tb();

    reg clk, rst, IM_we;
    reg [31:0] IM_addr, IM_data;
    
    RISCV_CPU UUT(
        .clk(clk),
        .rst(rst),
        .IM_we(IM_we),
        .IM_addr(IM_addr),
        .IM_data(IM_data)
    );
    
    always #20 clk = ~clk;
    
    reg [31:0] mem_read[0:50];
    integer i;
    initial begin
        clk = 0; IM_we = 1; IM_addr = 0;
        $readmemb("C:/Projects/Vivado/RISCV_CPU/RISCV_CPU.srcs/memory/mod_mul_branch.txt", mem_read);
        for (i = 0; i<50; i = i+1)
        begin
            IM_data = mem_read[i];    //lui
            #40;
            IM_addr = IM_addr + 4;
        end
        
        rst = 1;
        #40;
        rst = 0; IM_we = 0;
        #500;
	//$stop;
        
    end
     
endmodule