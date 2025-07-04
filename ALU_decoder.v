module ALU_decoder(
    input      [6:0] funct7,
    input      [2:0] funct3,
    input            ALUSrc,
    output reg [3:0] ALUOp
);
    always @(*) begin
        case (funct3)
            3'b000: ALUOp = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB or ADD
            3'b111: ALUOp = 4'b0010; // AND
            3'b110: ALUOp = 4'b0011; // OR
            3'b100: ALUOp = 4'b0100; // XOR
            3'b001: ALUOp = 4'b0101; // SLL
            3'b101: ALUOp = (funct7 == 7'b0000000) ? 4'b0110 : 4'b0111; // SRL or SRA
            3'b010: ALUOp = 4'b1000; // SLT
            3'b011: ALUOp = 4'b1001; // SLTU
            default: ALUOp = 4'b0000;
        endcase
    end
endmodule
