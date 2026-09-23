module instruction_memory(
    input wire [3:0] address, 
    output reg [15:0] instruction 
) ; 
    reg [15:0] instructions[0:15] ; //array of 16-bit instruction 

    // since this is the testbench instruction memory, it can fit 16 different testbench
    // However for a 4 bit PC, it limits the program to max of 16 instructions 
    // This is a design constraint 

    always @(*) begin 
        instruction = instructions[address] ; 
    end 

    initial begin 
        // hardcore some test values directly into instruction memory 
        
        // Edge Case 1 
        instructions[0] = 16'b0000010000000000 ; // Register 0 was used as both source and destinaton in the same instruction

        // Edge Case 2 - ALU overflow

        instructions[1] = 16'b0000010111000000;  // Add value of rs1=11 (8) and rs2=00 (6) into addr 01 = 14  
        instructions[2] = 16'b0000010101100000; // Add value of rs1=01 (14) and rs2=10 (3) into addr 01 = 17

        // Edge Case 3 and 4  - Memory Bound tests and Back-to-back dependent instructions 
        instructions[3] = 16'b0000100101010000 ; // Zeroing out a register 
        instructions[4] = 16'b0100100000000000 ; // Storing at address 0
        instructions[5] = 16'b0011001000000000 ; // Loading from address 0 

        instructions[6] = 16'b0101100000000111 ; // Storing at address 15 
        instructions[7] = 16'b0010111000000111 ; // Loading form address 15

    end 
endmodule 