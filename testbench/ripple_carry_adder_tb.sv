module ripple_carry_adder_tb; 
     
    reg [3:0] num1 ,num2; 
    reg cin ; 
    wire [3:0] sum ; 
    wire cout ; 

    // UUT - Unit Under test 

    ripple_carry_adder uut (.num1(num1), .num2(num2), .cin(cin), .sum(sum), .cout(cout));

    initial begin 
        // Set num1, num2, and cin to a combination 
        // Wait for a moment 
        // Check if sum match what you expect
        // Repeat for different combinations

        // 1
        num1 = 4'b1111; num2 = 4'b1111; cin = 0;
        #10; 
        if ({cout,sum} != (num1 + num2 + cin)) $display("FAIL");
        else $display("PASS");

        // 2
        num1 = 4'b0000; num2 = 4'b1111; cin = 0;
        #10; 
        if ({cout,sum} != (num1 + num2 + cin)) $display("FAIL") ;
        else $display("PASS") ;

        // 3
        num1 = 4'b0000; num2 = 4'b0000; cin = 0;
        #10; 
        if ({cout,sum} != (num1 + num2 + cin)) $display("FAIL") ;
        else $display("PASS") ; 

        // 4
        num1 = 4'b0011; num2 = 4'b0011; cin = 0;
        #10; 
        if ({cout,sum} != (num1 + num2 + cin)) $display("FAIL") ;
        else $display("PASS") ; 

        // 5
        num1 = 4'b0001; num2 = 4'b0001; cin = 1;
        #10; 
        if ({cout,sum} != (num1 + num2 + cin)) $display("FAIL") ;
        else $display("PASS") ;
    end 
endmodule