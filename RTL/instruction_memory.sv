module instruction_memory(
    input wire [3:0] address , 
    output reg [15:0] instruction 
);
    reg [15:0] instructions[0:4] ;  // array of 16-biut instruction

    always @(*) begin 
        instruction = instructions[address] ;
    end 

    initial begin 
        // hardcode some test values directly into memory 
        instructions[0] = 16'b1111111111111111; 
        instructions[1] = 16'b1111111111111110;
        instructions[2] = 16'b1111111111111100; 
        instructions[3] = 16'b1111111111111000; 
    end


endmodule