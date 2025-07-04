module RegisterFile(
    input         clk,
    input         we,
    input  [4:0]  rs1,
    input  [4:0]  rs2,
    input  [4:0]  rd,
    input  [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2
);
    reg [31:0] regfile [0:31];
    always @(posedge clk) begin
        if (we && rd != 0)
            regfile[rd] <= wdata;
    end
    assign rdata1 = (rs1 == 0) ? 0 : regfile[rs1];
    assign rdata2 = (rs2 == 0) ? 0 : regfile[rs2];
endmodule
