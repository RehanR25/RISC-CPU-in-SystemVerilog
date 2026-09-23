module CPU_tb_edgecases ; 
    reg clock, reset ;
    wire [3:0] result, pc_out ;

    initial clock = 0 ; 
    always #5 clock = ~clock ; 

    cpu uut (.clock(clock), .reset(reset), .result(result), .pc_out(pc_out)) ; 

    initial begin 

        $display("Edge Case Testbench Started") ; 

        // Program counter module's logic is if (reset == 1) pc<= 0 ...
        // If reset is never explicitly set to 1 then 0 in testbench, it stays at default simulation value, undefined
        reset = 1 ; 
        @(posedge clock) 
        # 1 ; 
 
        // Edge 1 -  Register 0 was used as both source and destinaton in the same instruction
        reset = 0 ;
        # 1 ; 
        if (result != 4'b0110) $display("FAIL - EDGE Case 2") ; 
        else $display("PASS - EDGE Case") ; 
        $display("Result is %b since reg1 was %b and reg2 was %b", result, uut.operand1, uut.operand2) ; 
    
        // Edge 2 - ALU overflow
        @(posedge clock) ;
        # 1 ;
        @(posedge clock) ; 
        # 1 ; 
        if (result == 4'b0001) $display("PASS - EDGE Case 2") ;  
        else $display("FAIL - EDGE Case 2") ; 

        $display("Result is %b since reg1 was %b and reg2 was %b", result, uut.operand1, uut.operand2) ; 

        // Edge 3 - Memory Bound tests

        $display("EDGE CASE 3") ; 

        @(posedge clock) ; 
        # 1 ; 
        $display("DEBUG: regs[0] = %b", uut.reg_file.regs[0]);
        $display("Instruction is %b" , uut.instruction) ;
        $display("PC OUT is %b", pc_out) ; 

        if (result != 4'b0000) $display("FAIL - Zeroing") ; 
        else $display("PASS - Zeroing") ; 

        @(posedge clock) ; 
        # 1 ; // PC = 3 (STORE current, zeroing's write know committed)

        @(posedge clock) ; 
        # 1 ; // PC = 4 (LOAD current, STORE's write now commited)
        if (uut.dm.memory[0] != 4'b0110)$display("FAIL - STORE addr 0") ; 
        else $display("PASS - STORE addr 0") ;        

        if (result != 4'b0110) $display("FAIL - LOAD addr 0") ; 
        else $display("PASS - LOAD add 0 ") ; 

        @(posedge clock) ; 
        # 1 ; // PC = 5 (STORE)
        @(posedge clock) ; 
        # 1 ; // PC = 6 (LOAD)
        if (uut.dm.memory[15] == 4'b0110) $display("PASS - STORE addr 15") ; 
        else $display("FAIL - STORE addr 15") ; 

        if (result == 4'b0110) $display("PASS - LOAD addr 15") ; 
        else $display("FAIL - LOAD addr 15") ; 

        $finish ;


    end 




endmodule 
