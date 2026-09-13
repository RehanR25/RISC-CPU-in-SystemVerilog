module decoder(
    input wire [15:0] instruction, 
    output reg [2:0] opcode, funct, 
    output reg [1:0] reg1, reg2, regd, 
    output reg [12:0] immediate
); 

    always @(*) begin
        opcode = instruction[15:13] ; // this is the opcode 

        case (opcode)
            3'b000: begin // R-type
                funct = instruction[12:10] ; 
                regd  = instruction[9:8] ; 
                reg1  = instruction[7:6] ; 
                reg2  = instruction[5:4] ; 
                immediate = 13'b0;
            end 

            3'b001: begin // I-type
                funct = 3'b000; 
                regd  = instruction[12:11] ; 
                reg1  = instruction[10:9] ;
                reg2  = 2'b00;  
                immediate = {{4{instruction[8]}},instruction[8:0]};
            end 

            3'b010: begin // S-type
                funct = 3'b000;
                regd  = 2'b00;
                reg1  = instruction[12:11] ; 
                reg2  = instruction[10:9] ; 
                immediate = {{4{instruction[8]}},instruction[8:0]} ;
            end 

            3'b011: begin // B-type
                funct = 3'b010; // it tells the ALU to compute rs1 - rs2 otherwise its always zero
                regd  = 2'b00;
                reg1  = instruction[12:11] ; 
                reg2  = instruction[10:9] ; 
                immediate = {{4{instruction[8]}},instruction[8:0]} ;
            end 

            3'b100: begin // J-type
                funct = 3'b000;
                regd  = 2'b00;
                reg1  = 2'b00;
                reg2  = 2'b00;
                immediate = instruction[12:0] ;
            end 

            default: begin  // Default risks creating unintended latches 
                            // for unused opcode values (101,110,111)
                funct = 3'b000;
                regd  = 2'b00;
                reg1  = 2'b00;
                reg2  = 2'b00; 
                immediate = 13'b0;
            end
        endcase

    end 

endmodule