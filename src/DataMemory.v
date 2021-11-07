module DataMemory
#(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 128
)

(
    input clk, MW, MR,
    input [2:0] BMC,
    input [ADDR_WIDTH-1:0] Address,    
    input [DATA_WIDTH-1:0] Data_in,
    output reg [DATA_WIDTH-1:0] Data_out
);

    reg [7:0] mem[DEPTH-1:0];
    wire sign;
    assign sign = mem[Address][7];
    
    integer i;
    always @(posedge clk) 
    begin
        if(MW)
        begin
            case(BMC)
                3'b000: mem[Address] <= Data_in[7:0];  //SB                          
                3'b001: {mem[Address+1], mem[Address]} <= Data_in[16:0];  //SH
                3'b010: {mem[Address+ 3], mem[Address+2], mem[Address+1], mem[Address]} <= Data_in;  //SH
            endcase
        end
    end
    
    always @(*) 
    begin
        if(MR)
        begin
            case(BMC) 
                3'b000: Data_out = {{24{sign}}, mem[Address]};//LB
                3'b001: Data_out = {{16{sign}}, mem[Address +1], mem[Address]};//LH
                3'b010: Data_out = {mem[Address+3], mem[Address+2], mem[Address+1], mem[Address]};//LW
                3'b100: Data_out = {24'b0, mem[Address]};//LBU
                3'b101: Data_out = {16'b0, mem[Address +1], mem[Address]};//LHU
                default: Data_out = 32'b0;
            endcase
        end
        
        else
           Data_out = 0;
    end 
endmodule