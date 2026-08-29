module multiplexer_tb;
    reg in0, in1, in2, in3, in4, in5, in6, in7;
    reg [2:0] sel ;
    wire out ;
    
    multiplexer uut (.in0(in0), .in1(in1), .in2(in2),
                    .in3(in3), .in4(in4), .in5(in5), 
                    .in6(in6), .in7(in7), .sel(sel), .out(out));
    
    initial begin 
        // set input to a combination 
        // wait for a moment 
        // check if output match what you expect 
        // repeat for all combinations 

        // 1 
        in0=1; in1=0; in2=0; in3=0; in4=0;
        in5=0; in6=0; in7=0; sel=3'b000;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 2
        in0=0; in1=1; in2=0; in3=0; in4=0;
        in5=0; in6=0; in7=0; sel=3'b001;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 3
        in0=0; in1=0; in2=1; in3=0; in4=0;
        in5=0; in6=0; in7=0; sel=3'b010;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 4
        in0=0; in1=0; in2=0; in3=1; in4=0;
        in5=0; in6=0; in7=0; sel=3'b100;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 5
        in0=0; in1=0; in2=0; in3=0; in4=1;
        in5=0; in6=0; in7=0; sel=3'b011;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 6
        in0=0; in1=0; in2=0; in3=0; in4=0;
        in5=1; in6=0; in7=0; sel=3'b101;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 7
        in0=0; in1=0; in2=0; in3=0; in4=0;
        in5=0; in6=1; in7=0; sel=3'b110;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // 8
        in0=0; in1=0; in2=0; in3=0; in4=0;
        in5=0; in6=0; in7=1; sel=3'b111;
        #10; 
        if (out != 1) $display("FAIL"); 
        else $display("PASS");

        // only 4 tested since checking 64 combinations is redundant 
        // since we are checking the selection logic only

        // number of tested increased since the sel was increased to 3 bits

    end
endmodule
