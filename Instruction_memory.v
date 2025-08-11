module Instruction_memory(Address,reset, ReadData);
    input [31:0]Address;
    output [31:0] ReadData;
    input reset;


    reg [31:0] memory [1023:0]; // 1024 words of 32 bits each
    assign ReadData = (!reset)? {32{1'b0}} : memory[Address[31:2]];

    initial begin
        // Initialize the instruction memory with some instructions
        memory[0] = 32'hFFC4A303; 
        
        
    end
endmodule