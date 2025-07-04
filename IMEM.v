module IMEM(
    input  [31:0] addr,
    output [31:0] inst
);
    reg [31:0] memory [0:255];  // <-- Tên phải là memory

    initial $readmemh("imem.txt", memory);

    assign inst = memory[addr[9:2]];
endmodule
