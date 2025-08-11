module alu_decoder(op5, ALUOP, funct3, funct7_5, ALUControl);
        input op5, funct7_5;
        input [2:0] funct3;
        output [2:0] ALUControl;
        input [1:0] ALUOP;


        assign ALUControl = (ALUOP == 2'b00) ? 3'b000 : // lw,sw
                            (ALUOP == 2'b01) ? 3'b001 : // beq
                            ((ALUOP == 2'b10) & (funct3 == 3'b000) & (funct7_5 == 1'b0) & (op5 == 1'b0)) ? 3'b000 : // ADD
                            ((ALUOP == 2'b10) & (funct3 == 3'b000) & (funct7_5 == 1'b1) & (op5 == 1'b0)) ? 3'b000 : // ADD
                            ((ALUOP == 2'b10) & (funct3 == 3'b000) & (funct7_5 == 1'b0) & (op5 == 1'b1)) ? 3'b000 : // ADD
                            ((ALUOP == 2'b10) & (funct3 == 3'b000) & (funct7_5 == 1'b1) & (op5 == 1'b1)) ? 3'b001 : // SUB
                            ((ALUOP == 2'b10) & (funct3 == 3'b010) & (funct7_5 == 1'b0) & (op5 == 1'b0)) ? 3'b101 : // slt
                            ((ALUOP == 2'b10) & (funct3 == 3'b110) & (funct7_5 == 1'b0) & (op5 == 1'b0)) ? 3'b011 : // OR
                            ((ALUOP == 2'b10) & (funct3 == 3'b111) & (funct7_5 == 1'b0) & (op5 == 1'b0)) ? 3'b010 :3'b000; // AND
                     
                      
endmodule