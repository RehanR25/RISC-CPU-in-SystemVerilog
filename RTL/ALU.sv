module ALU(
    input wire [3:0] num1, num2, 
    input wire [2:0] opcode, 
    output wire [3:0] sum, 
    output wire zero // for Branch if zero
);

    // since ALU computes different ADD, SUB, AND, OR, XOR
    // it uses both ripple carry to add num1 and num2 
    // and a case statement (multiplexer) to select the operation to be outputted

    // Compute ADD/SUB/AND/OR/XOR results as seperate wires
    wire [3:0] and_result = num1 & num2 ;
    wire [3:0] or_result = num1 | num2 ;
    wire [3:0] xor_result = num1 ^ num2 ;
    wire [3:0] add_sub_result ;

    // providing a 1-bit wire thats 1 only when opcode is SUB, O otherwise 

    wire sub_ctrl ;
    assign sub_ctrl = (opcode == 3'b010) ;

    // Instantiate ripple carry adder 
    wire cin, cout ;
    // since ik sub_ctrl i cant add it to cin since 
    // flipping all bits in num2 and adding 1 makes it to -num2
    // {4{sub_ctrl}} replicates sub_ctrl such that it becomes 4 bit
    ripple_carry_adder rca(.num1(num1), .num2((num2 ^ {4{sub_ctrl}} )), .cin(sub_ctrl), .sum(add_sub_result), .cout(cout)); 

    // Sum is 4 bits 
    // Since each mux instance produces only 1 output bit 
    // 4 seperate mux instances are needed, one per bit positiion of sum

    multiplexer mux0 (.in0(1'b0), .in1(add_sub_result[0]), .in2(add_sub_result[0]), .in3(and_result[0]),
    .in4(xor_result[0]), .in5(or_result[0]), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(sum[0])); 
    
    multiplexer mux1 (.in0(1'b0), .in1(add_sub_result[1]), .in2(add_sub_result[1]), .in3(and_result[1]),
    .in4(xor_result[1]), .in5(or_result[1]), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(sum[1])); 

    multiplexer mux2 (.in0(1'b0), .in1(add_sub_result[2]), .in2(add_sub_result[2]), .in3(and_result[2]),
    .in4(xor_result[2]), .in5(or_result[2]), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(sum[2]));

    multiplexer mux3 (.in0(1'b0), .in1(add_sub_result[3]), .in2(add_sub_result[3]), .in3(and_result[3]),
    .in4(xor_result[3]), .in5(or_result[3]), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(sum[3]));

    assign zero = (sum == 4'b0000) ;

endmodule

// for the SUB and ADD, a single bit can be used to distinguish between them 
// but that makes 3 opcodes redundant
// this is common practice but for this u need intentional opcode placing for such shortcuts 
