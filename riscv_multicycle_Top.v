`include "PC.v"
`include "Instruction_memory.v "
`include "register_files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "data_memory.v"
`include "PC_adder.v"

module riscv_multicycle_Top(clk, reset);

    input clk, reset;

    wire [31:0] PC_Top, ReadData_Top, ReadData1_Top, ReadData2_Top, Immediate_Top,ALUResult_Top,Read_Data_Memory_Top,PC_plus4_Top;
    wire [2:0] ALUControl_Top;
    wire RegWrite_Top, Mem_write_Top,
         ALUSrc_Top, ResultSrc_Top;
    wire [1:0] ImmSrc_Top;

    PC PC(
        .PC_Next(PC_plus4_Top),
        .clk(clk),
        .reset(reset),
        .PC(PC_Top)
    );
    PC_adder PC_Adder(
        .a(PC_Top),
        .b(32'h00000004), // Increment PC by 4
        .c(PC_plus4_Top)
    );
    Instruction_memory Instruction_memory(
        .Address(PC_Top),
        .reset(reset),
        .ReadData(ReadData_Top)
    );
    register_files Register_File(
        .A1(ReadData_Top[19:15]), // rs1
        .A2(ReadData_Top[24:20]), // rs2
        .A3(ReadData_Top[11:7]), // rd
        .Write_Data3((ResultSrc_Top)?Read_Data_Memory_Top: ALUResult_Top), // Data to write
        .Write_Enable3(RegWrite_Top),
        .clk(clk),
        .reset(reset),
        .Read_Data1(ReadData1_Top),
        .Read_Data2(ReadData2_Top)
    );
    Sign_Extend Sign_Extend(
        .In(ReadData_Top),
        .Imm_Ext(Immediate_Top),
        .ImmSrc(ImmSrc_Top[0])
    );
    alu alu(
        .A(ReadData1_Top),
        .B((ALUSrc_Top)?Immediate_Top:ReadData2_Top), // Use immediate if ALUSrc is set
        .ALUControl(ALUControl_Top),
        .Result(ALUResult_Top),
        .Zero(),
        .Overflow(),
        .Negative(),
        .CarryOUT()
    );
    Control_Unit_Top Control_Unit(
        .Op(ReadData_Top[6:0]),
        .RegWrite(RegWrite_Top),
        .ImmSrc(ImmSrc_Top),
        .ALUSrc(ALUSrc_Top),
        .MemWrite(Mem_write_Top),
        .ResultSrc(),
        .Branch(),
        .funct3(ReadData_Top[14:12]),
        .funct7(ReadData_Top[31:25]),
        .ALUControl(ALUControl_Top)
    );
    data_memory Data_Memory(
        .Write_Enable(Mem_write_Top),
        .Write_Data(ReadData2_Top),
        .A(ALUResult_Top),
        .Read_Data(Read_Data_Memory_Top),
        .clk(clk),
        .reset(reset)
    );

endmodule