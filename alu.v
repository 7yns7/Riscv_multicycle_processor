module alu(A,B,ALUControl,Result,Zero,Overflow,Negative,CarryOUT);
       input [31:0] A,B;
       input [2:0] ALUControl;

       output [31:0] Result;
       output Zero, Overflow, Negative, CarryOUT;

       // je declare des signaux intermediaires (ca s'appelle des wires en verilog)
        wire [31:0] a_and_b;
        wire [31:0] a_or_b;
        wire [31:0] not_b;

        wire [31:0] b_muxed;

        wire [31:0] sum;
        wire [31:0] result_muxed;
        wire [31:0] slt; // set less than
        wire c_out;
        // logique 
        assign a_and_b = A & B;
        assign a_or_b = A | B;
        assign not_b = ~B;
         
        assign b_muxed = (ALUControl[0] == 1'b0) ? B : not_b;
        
        assign {sum,c_out} = A + b_muxed + ALUControl[0];   // ALUControl[0] c'est en gro c_in
        assign slt = { 31'b0,sum[31] }; // Set less than result, only the sign bit is used
        assign result_muxed = (ALUControl == 3'b000) ? sum :        // ADD
                (ALUControl == 3'b001) ? sum :        // SUB
                (ALUControl == 3'b010) ? a_and_b :    // AND
                (ALUControl == 3'b011) ? a_or_b :     // OR
                (ALUControl == 3'b101) ? slt :        // SLT
                32'b0;                               // Default

        assign Result = result_muxed;
        assign Zero = &(~result_muxed);
        assign Negative = result_muxed[31];
        assign CarryOUT = c_out &(~ALUControl[1]); // Carry out is only relevant for ADD/SUB
        assign Overflow = (~ALUControl[1]) & (~(A[31] ^ B[31] ^ ALUControl[0])) & (A[31] ^ sum[31]);



endmodule