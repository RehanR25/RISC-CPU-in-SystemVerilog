module data_memory_tb; 
    reg clock, write_enable ; 
    reg [3:0] address, write_data ; 
    wire [3:0] read_data ; 

    data_memory uut (.clock(clock), .write_enable(write_enable), .address(address), 
                    .write_data(write_data), .read_data(read_data)) ; 

    initial clock = 0 ; 
    always #5 clock = ~clock ; 

    initial begin 


        // 1 - Checking write_enable 

        write_enable=1 ; address = 4'b0001 ; write_data = 4'b1010 ;
        @(posedge clock) ; 
        # 1 ;
        # 10 ; 
        write_enable=0; address = 4'b0001 ; write_data = 4'b0000 ;
        @(posedge clock) ;
        # 1 ;
        if (read_data == 4'b1010) $display("PASS") ; 
        else $display("FAIL") ; 

        // 2 - Checking if write_data and read data are the same or not 

        write_enable = 1; address = 4'b0011 ; write_data = 4'b1000 ; 
        @(posedge clock) ; 
        # 1 ; 
        if (read_data != 4'b1000) $display("FAIL"); 
        else $display("PASS"); 

        $finish ; 
    end 
endmodule