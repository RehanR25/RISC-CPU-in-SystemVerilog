module decoder_tb; 
    reg [15:0] instruction ;
    wire [2:0] opcode, funct ; 
    wire [1:0] reg1, reg2, regd ; 
    wire [12:0] immediate ; 

    decoder uut (.instruction(instruction), .opcode(opcode), .funct(funct), 
                .regd(regd), .reg1(reg1), .reg2(reg2), .immediate(immediate)) ; 

    initial begin 

        // 1 - R-type
        instruction = 16'b0001011011110000 ;
        # 1;
        if (funct == 3'b101 && regd == 2'b10 && reg1 == 2'b11 && reg2 == 2'b11) $display("PASS") ; 
        else $display("FAIL") ;  

        // 2 - I-type
        instruction = 16'b0011101011110010 ;
        # 1 ; 
        if (regd == 2'b11 && reg1 == 2'b01 && immediate == 13'b0000011110010) $display("PASS") ; 
        else $display("FAIL") ;

        // 3 - S-type
        instruction = 16'b0101101011110000 ; 
        # 1 ; 
        if (reg1 == 2'b11 && reg2 == 2'b01 && immediate == 13'b0000011110000) $display("PASS") ; 
        else $display("FAIL") ;

        // 4 - B-type
        instruction = 16'b0110010011110001 ;
        # 1 ;  
        if (reg1 == 2'b00 && reg2 == 2'b10 && immediate == 13'b0000011110001) $display("PASS") ; 
        else $display("FAIL") ;

        // 5 - J-type
        instruction = 16'b1001010101011110 ; 
        # 1 ;
        if (immediate == 13'b1010101011110) $display("PASS") ; 
        else $display("FAIL") ; 

        // 6 - Error 
        instruction = 16'b1111111111111111 ; 
        # 1 ; 
        if (funct != 3'b000 && regd != 2'b00 && reg1 != 2'b00 && reg2 != 2'b00 && immediate != 13'b0) $display("FAIL") ; 
        else $display("PASS") ; 
    
    end 

endmodule