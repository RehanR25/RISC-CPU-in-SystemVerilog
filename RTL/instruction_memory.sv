module instruction_memory(
    input wire [3:0] address , 
    output reg [15:0] instruction 
);
    reg [15:0] instructions[0:9] ;  // array of 16-bit instruction
    // increase the length of instruction array as needed 

    always @(*) begin 
        instruction = instructions[address] ;
    end 

    initial begin 
        // hardcode some test values directly into instruction memory 
        instructions[0] = 16'b0000011000010000 ; 
        instructions[1] = 16'b0000101000010000 ;
        instructions[2] = 16'b0001001000010000 ; 
        instructions[3] = 16'b0000111000010000 ;
        instructions[4] = 16'b0001011000010000 ;
        instructions[5] = 16'b0011100000000010 ; 
        instructions[6] = 16'b0101001000000011 ; 
        instructions[7] = 16'b0110001000000001 ;
        instructions[8] = 16'b0110000000000011 ;
        instructions[9] = 16'b1000000000000011 ;
    end


endmodule