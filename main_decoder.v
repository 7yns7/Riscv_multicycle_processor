module main_decoder(operation, Zero, PC_Src, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite, ALUOP );

        input [6:0] operation;
        input Zero;
        output  PC_Src, ResultSrc, MemWrite, ALUSrc, RegWrite;
        output  [1:0] ImmSrc, ALUOP;

        wire Branch ; 

        assign RegWrite  = (operation == 7'b0000011) ? 1'b1 :
                   (operation == 7'b0110011) ? 1'b1 : 1'b0;

        assign ImmSrc    = (operation == 7'b0000011) ? 2'b00 :
                        (operation == 7'b0100011) ? 2'b01 :
                        (operation == 7'b1100011) ? 2'b10 : 2'b00;

        assign ALUSrc    = (operation == 7'b0000011) ? 1'b1 :
                        (operation == 7'b0100011) ? 1'b1 : 1'b0;

        assign ResultSrc = 1'b0; 

        assign MemWrite  = (operation == 7'b0100011) ? 1'b1 : 1'b0;

        assign Branch    = (operation == 7'b1100011) ? 1'b1 : 1'b0;

        assign ALUOP     = (operation == 7'b1100011) ? 2'b01 :
                        (operation == 7'b0110011) ? 2'b10 : 2'b00;

        assign PC_Src    = Branch & Zero;

        
endmodule



