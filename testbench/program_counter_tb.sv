module program_counter_tb ; 
    reg clock, reset ; 
    wire [3:0] pc_out ;

    program_counter uut (.clock(clock), .reset(reset), .pc_out(pc_out)) ; 

    initial clock = 0;   // start clock at 0 
    always #5 clock = ~clock ; // every 5 unit times, flip it 

    integer i;

    initial begin 

        // 1 - Checking if reset affects pc_out 
        reset = 1; 
        @(posedge clock) ; 
        # 1 ; 
        if (pc_out == 0) $display("PASS") ; 
        else $display("FAIL") ; 

        // 2 - Ensuring that pc_out works and checking edge case 
        reset = 0; 

        for (i = 1; i<= 15; i = i + 1) begin 
            @(posedge clock) ; 
            # 1 ; 
            if (pc_out != i) $display("FAIL - increment at %d", i) ; 
            else $display("PASS - increment at %d", i) ; 
        end 

        // now pc_out should be at 15, one more edge should wrap it 
        @(posedge clock) ; 
        # 1 ; 

        if (pc_out != 0 ) $display("FAIL - wraparound") ; 
        else $display("PASS - wraparound") ; 

        $finish ; 
    end 
endmodule  