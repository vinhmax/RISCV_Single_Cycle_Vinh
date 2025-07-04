module RISCV_Single_Cycle (
    input clk,
    input rst_n,
    output [31:0] Instruction_out_top
);

    // Program Counter
    reg [31:0] pc;
    wire [31:0] pc_next;

    // Instruction Memory
    wire [31:0] instruction;
    IMEM IMEM_inst (
        .addr(pc),
        .inst(instruction)
    );

    // Instruction output for testbench
    assign Instruction_out_top = instruction;

    // Data Memory
    wire [31:0] alu_result;
    wire [31:0] write_data;
    wire [31:0] read_data;
    wire mem_write;

    DMEM DMEM_inst (
        .clk(clk),
        .addr(alu_result),
        .wdata(write_data),
        .we(mem_write),
        .rdata(read_data)
    );

    // ImmGen
    wire [31:0] imm_ext;
    Imm_Gen Imm_Gen_inst (
        .instr(instruction),
        .imm_out(imm_ext)
    );

    // Register File
    wire reg_write;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] reg_rdata1, reg_rdata2;

    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];

    RegisterFile RegisterFile_inst (
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wdata( /* Dữ liệu ghi vào thanh ghi, tự logic */ ),
        .rdata1(reg_rdata1),
        .rdata2(reg_rdata2)
    );

    // ALU control & ALU
    wire [3:0] alu_op;
    wire [31:0] alu_in_2;
    wire alu_zero;

    ALU_decoder ALU_decoder_inst (
        .funct7(instruction[31:25]),
        .funct3(instruction[14:12]),
        .ALUSrc( /* Kết nối theo thiết kế */ ),
        .ALUOp(alu_op)
    );

    assign alu_in_2 = alu_src ? imm_ext : reg_rdata2;
    ALU ALU_inst (
        .A(reg_rdata1),
        .B(alu_in_2),
        .ALUOp(alu_op),
        .Result(alu_result),
        .Zero(alu_zero)
    );

    // Control unit
    wire mem_read, alu_src, branch;
    wire [1:0] result_src;
    control_unit control_unit_inst (
        .opcode(instruction[6:0]),
        .RegWrite(reg_write),
        .MemWrite(mem_write),
        .MemRead(mem_read),
        .Branch(branch),
        .ALUSrc(alu_src),
        .ResultSrc(result_src)
    );

    // PC logic
    assign pc_next = pc + 4;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc <= 0;
        else
            pc <= pc_next;
    end

    // *** CHÚ Ý ***
    // Các tín hiệu như: write_data, alu_in_2, wdata, pc_next cần bạn tự hoàn chỉnh logic theo pipeline của bạn
    // Đây là khung chuẩn testbench, bạn chỉ cần điền đúng "đường đi" tín hiệu và bổ sung logic còn thiếu

endmodule
