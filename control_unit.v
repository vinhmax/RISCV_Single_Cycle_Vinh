module control_unit(
    input  [6:0] opcode,
    output reg RegWrite,
    output reg MemWrite,
    output reg MemRead,
    output reg Branch,
    output reg ALUSrc,
    output reg [1:0] ResultSrc
);
    always @(*) begin
        // Default values
        RegWrite  = 0;
        MemWrite  = 0;
        MemRead   = 0;
        Branch    = 0;
        ALUSrc    = 0;
        ResultSrc = 2'b00;

        case(opcode)
            7'b0110011: RegWrite = 1; // R-type
            7'b0010011: begin RegWrite = 1; ALUSrc = 1; end // I-type ALU
            7'b0000011: begin RegWrite = 1; MemRead = 1; ALUSrc = 1; ResultSrc = 2'b01; end // Load
            7'b0100011: begin MemWrite = 1; ALUSrc = 1; end // Store
            7'b1100011: Branch = 1; // Branch
            7'b1101111: begin RegWrite = 1; ResultSrc = 2'b10; end // JAL
            7'b1100111: begin RegWrite = 1; ALUSrc = 1; ResultSrc = 2'b10; end // JALR
            7'b0110111, 7'b0010111: begin RegWrite = 1; ResultSrc = 2'b11; end // LUI, AUIPC
        endcase
    end
endmodule
