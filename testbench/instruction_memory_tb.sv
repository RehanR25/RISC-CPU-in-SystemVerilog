module instruction_memory_tb;
    reg [3:0] address ; 
    wire [15:0] instruction ; 

    instruction_memory uut(.address(address), .instruction(instruction)) ; 

    initial begin 
        // use the hardcoded test values from memory 
        // and write address so that the index matches with address

        // 1 
        address = 4'b0000 ; 
        # 1 ; 
        if (instruction != 16'b1111111111111111) $display("FAIL") ; 
        else $display ("PASS") ; 

        // 2 
        address = 4'b0001 ; 
        # 1 ; 
        if (instruction != 16'b1111111111111110) $display("FAIL") ; 
        else $display("PASS") ; 

        // 3 
        address = 4'b0010 ;
        # 1 ; 
        if (instruction != 16'b1111111111111100) $display("FAIL") ; 
        else $display("PASS") ; 

        // 4 
        address = 4'b0111 ; 
        # 1 ; 
        if (instruction != 16'b1111111111111000) $display("FAIL") ; 
        else $display("PASS") ;  
        
    end

endmodule