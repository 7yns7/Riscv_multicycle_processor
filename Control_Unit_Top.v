`include "alu_decoder.v"
`include "main_decoder.v"

module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

    input [6:0]Op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc;
    output [2:0]ALUControl;

    wire [1:0]ALUOp;

    main_decoder main_decoder(
        .operation(Op),
        .Zero(1'b0), // Assuming Zero is not used in this context
        .PC_Src(), // Not used in this module
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUOP(ALUOp)
    );
    alu_decoder alu_decoder(
        .op5(funct7[5]),
        .ALUOP(ALUOp),
        .funct3(funct3),
        .funct7_5(funct7[5]),
        .ALUControl(ALUControl)
    );


endmodule