module full_adder_tb; 
    reg a, b, cin; 
    wire sum, cout; 

    full_adder uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)); 

    initial begin 
        // set a, b, cin to a combination 
        // wait for a moment 
        // check if sum and cout match what you expect 
        // repeat for all 8 combinations
        
        // 1 
        a=0; b=0; cin=0; 
        #10; 
        if (sum!==0 || cout!==0) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 2
        a=0; b=0; cin=1; 
        #10; 
        if (sum!==1 || cout!==0) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 3 
        a=0; b=1; cin=0; 
        #10; 
        if (sum!==1 || cout!==0) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 4
        a=0; b=1; cin=1; 
        #10; 
        if (sum!==0 || cout!==1) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 5 
        a=1; b=0; cin=0; 
        #10; 
        if (sum!==1 || cout!==0) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 6 
        a=1; b=0; cin=1; 
        #10; 
        if (sum!==0 || cout!==1) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 7 
        a=1; b=1; cin=0; 
        #10; 
        if (sum!==0 || cout!==1) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

        // 8 
        a=1; b=1; cin=1; 
        #10; 
        if (sum!==1 || cout!==1) $display("FAIL: a=%b b=%b cin=%b", a, b, cin);
        else $display("PASS: a=%b b=%b cin=%b", a, b, cin);

    end
endmodule
