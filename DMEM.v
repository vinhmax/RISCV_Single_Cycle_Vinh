module DMEM(
    input         clk,
    input  [31:0] addr,
    input  [31:0] wdata,
    input         we,
    output [31:0] rdata
);
    reg [31:0] mem [0:255];
    always @(posedge clk) begin
        if (we)
            mem[addr[9:2]] <= wdata;
    end
    assign rdata = mem[addr[9:2]];
endmodule
