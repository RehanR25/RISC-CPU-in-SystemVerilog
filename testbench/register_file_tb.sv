module register_file_tb; 
    reg clock, write_enable ; 
    reg [1:0] read_address1, read_address2, write_address ; 
    reg [3:0] write_data ; 
    wire [3:0] register1, register2 ; 

    register_file uut(.clock(clock), .write_enable(write_enable), .read_address1(read_address1),
                         .read_address2(read_address2), .write_address(write_address), .write_data(write_data), .register1(register1), .register2(register2)) ; 
    
    initial clock = 0 ; // start clock at 0 
    always #5 clock = ~clock ; // Every 5 time units, flip it

    initial begin
        

        // 1 - Checking if data in the addresses is correct

        write_enable = 1; write_address=2'b01 ; read_address1 = 2'b01 ; write_data = 4'b1001 ; 
        @(posedge clock) ;  
        # 1 ; 
        if (register1 != 4'b1001) $display("FAIL") ; 
        else $display("PASS") ; 


        // 2 - Checking if write_enable affects write attempt 

        write_enable = 0; 
        @(posedge clock) ; 
        # 1 ; 
        if (register1 != 4'b1001) $display ("FAIL") ; 
        else $display ("PASS") ;  // it should be the previous register value

        // 3 -  Ensuring that 2 independent writes and reads are correct and independent

        write_enable = 1; write_address = 2'b10 ; write_data = 4'b1000 ; 
        @(posedge clock) ; 
        # 1 ; 
        # 10 ;  
        write_enable = 1; write_address = 2'b11 ; write_data = 4'b1111 ;
        @(posedge clock) ; 
        # 1 ; 
        read_address1 = 2'b10 ; read_address2 = 2'b11 ; 
        # 1 ; 

        // there is a delay before new address change flows through the update
        // Reading them in the exact same instant you change the address can catch them before that update completes

        if (register1 == 4'b1000 && register2 == 4'b1111) $display ("PASS") ; 
        else $display ("FAIL") ; 
        
        $finish ; // explicitly tells the simulator to end simulation once tests are done

    end



endmodule