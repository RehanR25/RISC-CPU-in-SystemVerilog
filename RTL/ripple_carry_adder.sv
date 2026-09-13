module ripple_carry_adder(
    input wire [3:0] num1, num2 ,
    input wire cin, 
    output wire [3:0] sum , 
    output wire cout
); 

    // since binary addition happens column by column
    // each column only needs to deal with one bit from each number, along with a carry 
    // So to add two 4-bit numbers, four full adders need to be connected together

    // Internal carries between stages
    wire c1, c2, c3 ;

    // Instantiation syntax 
    // .port name of the module being instantiated(signal from current module)

    full_adder fa0(.a(num1[0]), .b(num2[0]), .cin(cin), .sum(sum[0]), .cout(c1)) ; 
    full_adder fa1(.a(num1[1]), .b(num2[1]), .cin(c1), .sum(sum[1]), .cout(c2)) ;
    full_adder fa2(.a(num1[2]), .b(num2[2]), .cin(c2), .sum(sum[2]), .cout(c3)) ;
    full_adder fa3(.a(num1[3]), .b(num2[3]), .cin(c3), .sum(sum[3]), .cout(cout)) ;
endmodule

