module Imm_Gen(
    input  [31:0] instr,
    output reg [31:0] imm_out
);
    always @(*) begin
        case(instr[6:0])
            7'b0010011, // I-type
            7'b0000011,
            7'b1100111: imm_out = {{20{instr[31]}}, instr[31:20]};
            7'b0100011: imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
            7'b1100011: imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
            7'b1101111: imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type
            7'b0110111,
            7'b0010111: imm_out = {instr[31:12], 12'b0}; // U-type
            default: imm_out = 0;
        endcase
    end
endmodule
