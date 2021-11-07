module InsMem
#(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    //parameter DEPTH = 2**ADDR_WIDTH
    parameter DEPTH = 128
)

(
    input clk, rst, we,   
    input [ADDR_WIDTH-1:0] addr,    
    input [ADDR_WIDTH-1:0] IM_addr,    
    input [DATA_WIDTH-1:0] data,
    output [DATA_WIDTH-1:0] out
);

    reg [7:0] mem[DEPTH-1:0];
    wire [DATA_WIDTH-1:0] read_data;
    
    /*
    reg [31:0] mem_read[0:50];
    integer i;
    
    initial begin
             $readmemb("D:/CODE FILES/VLSI CIRCUIT II/HW8/Branch/Branch.srcs/memory/raw2.txt", mem_read);

    end
    */
    
    always @(posedge clk) begin
        /*
        for (i = 0; i<50; i = i+1)
        begin
            {mem[4*i+3] ,mem[4*i+2], mem[4*i+1], mem[4*i]} = mem_read[i];    //lui
        end
        */
        if(we)
            {mem[IM_addr +3], mem[IM_addr+2], mem[IM_addr+1], mem[IM_addr]} <= data;
    end
    
    assign read_data = {mem[addr +3], mem[addr+2], mem[addr+1], mem[addr]};
    assign out = !we ? read_data: 'hx;

endmodule
