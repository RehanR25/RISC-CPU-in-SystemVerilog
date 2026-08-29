module register_tb; 
    reg clock, reset; 
    reg [3:0] data ;
    wire [3:0] stored_val ; 

    register uut (.clock(clock), .reset(reset), .data(data), .stored_val(stored_val)); 

    initial clock = 0 ; // start clock at 0 
    always #5 clock = ~clock ; // every 5 time units, flip it 

    initial begin 
        // set data and reset
        // wait for set amount of time units 
        // check if stored value match what you expect
        // repeat for 3 combinations 

        // The clock needs to keep toggling continuously and indenpendently, 
        // in parallel with whatever the initial value block is doing 
        // If the clock toggle is in the initial block, it would only run once and stop
        // not keep going for whole simulation

        // For this testbench since we are using a real clock, you should wait for actual clock 
        // edges instead of just an arbitrary #10 
        // @(posedge clock); explicityly wait for next rising edge, rather than guessing a delay number 

        // 1 - RESET
        reset=1; data = 4'b1111; 
        @(posedge clock);  // wait for edge that actually loads/resets 
        #1 ;               // tiny extra delay so stored_val has settled after the edge, may avoid race conditions in some simulators  
        if (stored_val != 4'b0000) $display("FAIL") ; 
        else $display("PASS") ; 

        // 2 - Memory 
        reset = 0; data = 4'b1010; 
        @(posedge clock); // wait for edge that actually loads/resets
        # 1 ;             // tiny extra delay so stored_val has settled after the edge, may avoid race conditions in some simulators
        if (stored_val != 4'b1010) $display("FAIL"); 
        else $display("PASS"); 

        // 3 - Edge 
        // This proves register only updates on edges, not continuously

        reset = 0; data = 4'b1010; 
        @(posedge clock); // wait for edge that actually loads/resets
        #1 ;              // tiny extra delay so stored_val has settled after the edge, may avoid race conditions in some simulators
        data = 4'b1011; 
        # 7 ;             // clock edge has not passed 
        if (stored_val != 4'b1010) $display ("FAIL") ; 
        else $display ("PASS") ; 

        $finish ; // explicitly tells the simulator to end simulation once tests are done 
    
    end 
endmodule 

