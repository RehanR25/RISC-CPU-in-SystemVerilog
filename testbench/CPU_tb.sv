module CPU_tb ; 
    reg clock, reset;
    wire [3:0] result, pc_out ;

    initial clock = 0 ; 
    always #5 clock = ~clock ; 

    cpu uut (.clock(clock), .reset(reset), .result(result), .pc_out(pc_out)) ; 
    
    initial begin 

        $display("TESTBENCH STARTED") ;

        // 1 - Reset 
        reset = 1 ; 
        @(posedge clock) ; 
        # 1 ; 
        if (pc_out != 0) $display("FAIL - reset") ; 
        else $display("PASS - reset") ;

        // 2 - Instruction cycle (R-type)
        
        reset = 0 ; 
        // Since pc_out is already at address 0, no need for (posedge clock)
        # 1 ; 
        if (result != 4'b1000) $display("FAIL - ADD result") ; 
        else $display("PASS - ADD result") ; 
        
        @(posedge clock) ; 
        # 1 ; 
        if (result != 4'b1110) $display("FAIL - SUB result") ;
        else $display("PASS - SUB result") ; 

        @(posedge clock) ; 
        # 1 ; 
        if (result != 4'b0001) $display("FAIL - AND result") ; 
        else $display("PASS - AND result") ; 

        @(posedge clock) ; 
        # 1 ; 
        if (result != 4'b0110) $display("FAIL - XOR result") ; 
        else $display("PASS - XOR result") ; 

        @(posedge clock) ; 
        # 1 ; 
        if (result != 4'b0111) $display("FAIL - OR result") ; 
        else $display("PASS - OR result") ; 

        // 3 - Instruction cycle (I-type) - Instruction[5]
        @(posedge clock) ; 
        # 1 ;   
        if (result != 4'b1010) $display("FAIL - LOAD") ; 
        else $display("PASS - LOAD") ;

        // 4 - Instruction cycle (S-type) - Instruction[6]
        @(posedge clock) ; 
        # 1 ; 
        if (uut.dm.memory[6] != 4'b0101) $display("FAIL - STORE") ; 
        else $display("PASS - STORE") ; 

        @(posedge clock) ; // BEQ effect on PC isnt visible until one clock edge after BEQ itself has been fetched

        // 5 - Instruction cycle (B-type) - Instruction[7]
        @(posedge clock) ;
        # 1 ;
        if (pc_out != 4'b1000) $display("FAIL - BEQ Branch") ; 
        else $display("PASS - BEQ Branch") ;
 
        @(posedge clock) ;
        # 1 ;
        if (pc_out != 4'b1011) $display("FAIL - BEQ") ; 
        else $display("PASS - BEQ") ;
        
        // 6 - Instruction cycle (J-type) - Instruction 
        @(posedge clock); 
        # 1 ;
        if (pc_out != 4'b1100) $display("FAIL - JUMP") ; 
        else $display("PASS - JUMP") ;

        $finish ;
    end 

endmodule