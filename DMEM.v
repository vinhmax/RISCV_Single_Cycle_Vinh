module DMEM(
    input         clk,
    input  [31:0] addr,
    input  [31:0] wdata,
    input         we,
    output [31:0] rdata
);
    reg [31:0] memory [0:255];  // <-- Tên phải là memory

    always @(posedge clk) begin
        if (we)
            memory[addr[9:2]] <= wdata;
    end
    assign rdata = memory[addr[9:2]];
endmodule
