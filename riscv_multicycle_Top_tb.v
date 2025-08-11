module riscv_multicycle_Top_tb ();
    
    reg clk=1'b0,rst;

    riscv_multicycle_Top riscv_multicycle_Top(
                                .clk(clk),
                                .reset(rst)
    );

    initial begin
        $dumpfile("multicycle.vcd");
        $dumpvars(0);
    end

    always 
    begin
        clk = ~ clk;
        #50;  
        
    end
    
    initial
    begin
        rst <= 1'b0;
        #100;

        rst <=1'b1;
        #500;
        $finish;
    end
endmodule