module ALU_tb ; 
    reg [3:0] num1, num2 ;
    reg [2:0] opcode ;
    wire [3:0] sum ; 
    wire zero ; 

    ALU uut (.num1(num1), .num2(num2), .opcode(opcode), .sum(sum), .zero(zero)) ;

    initial begin 

        // set num1, num2, opcode to a combination
        // wait 
        // check if zero and sum are equal to expected values 
        // repeat for 7 combinations

        // 1 - ADD 
        num1 = 4'b0111; num2 = 4'b0101; opcode = 3'b001;
        #10 ; 
        if (sum != 4'b1100 && zero != 4'b0000) $display ("FAIL");
        else $display ("PASS");

        // 2 - SUB
        num1 = 4'b0111; num2 = 4'b0101; opcode = 3'b010;
        #10 ; 
        if (sum != 4'b0010 && zero != 4'b0000) $display ("FAIL") ;
        else $display ("PASS") ; 

        // 3 - AND
        num1 = 4'b0111; num2 = 4'b0101; opcode = 3'b100 ; 
        #10 ; 
        if (sum != 4'b0101 && zero != 4'b0000) $display ("FAIL") ;
        else $display ("PASS") ; 

        // 4 - XOR
        num1 = 4'b0111; num2 = 4'b0101; opcode = 3'b011 ;
        #10 ; 
        if (sum != 4'b0010 && zero != 4'b0000) $display ("FAIL") ;
        else $display ("PASS") ;

        // 5 - OR 
        num1 = 4'b0111; num2 = 4'b0101; opcode = 3'b101 ;
        #10 ; 
        if (sum != 4'b0111 && zero != 4'b0000) $display ("FAIL") ;
        else $display ("PASS") ; 

        // 6 - ZERO with SUB
        num1 = 4'b0111; num2 = 4'b0111; opcode = 3'b010 ; 
        #10 ; 
        if (sum != 4'b0000 && zero != 4'b0001) $display ("FAIL") ; 
        else $display ("PASS") ; 

        // 7 - ZERO with AND 
        num1 = 4'b0000; num2 = 4'b0000; opcode = 3'b100 ; 
        #10 ; 
        if (sum != 4'b0000 && zero != 4'b0001) $display ("FAIL") ; 
        else $display ("PASS") ;

    end 
endmodule