module register_file(
    input wire clock, write_enable ,
    input wire [1:0] read_address1, read_address2, write_address , 
    input wire [3:0] write_data,  
    output reg [3:0] register1, register2  // changed from wire to reg 

    // Continuous assign statemnets reading from an indexed memory 
    // array regs[read_address1] with a variable index can behave 
    // unreliably so more robost way to write memory reads is with an 
    // always @(*) block instead of assign 
);
    reg [3:0] regs [0:3] ; // Internal storage : 4 registers, 4 bits each 

    always @(*) begin 
        register1 = regs[read_address1] ; // Write data of address1 to register 1
        register2 = regs[read_address2] ; // Write data of address2 to register 2

        // $display("READ: addr1=%b regs[addr1]=%b" , read_address1, regs[read_address1]) ; this is an message to check if registers have data in them 
    end 

    always @(posedge clock) begin   
        if (write_enable) begin 
            regs[write_address] <= write_data ; // Writes write_data into write_address
            // $display("Write : addr=%b data=%b", write_address, write_data) ;  this is a message to check if data has been written
        end
    end 

    initial begin
        regs[0] = 4'b0011 ; // 3
        regs[1] = 4'b0101 ; // 5  
        regs[2] = 4'b0011 ; // 3
        regs[3] = 4'b1000 ; // 8 

    end 



endmodule