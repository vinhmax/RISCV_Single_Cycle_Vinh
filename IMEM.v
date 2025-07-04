module IMEM(
    input  [31:0] addr,
    output [31:0] inst
);
    reg [31:0] mem [0:255];
    initial $readmemh("imem.txt", mem);
    assign inst = mem[addr[9:2]];
endmodule
