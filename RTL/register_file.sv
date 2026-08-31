module register_file(
    input wire clock, write_enable ,
    input wire [1:0] read_address1, read_address2, write_address , 
    input wire [3:0] write_data ; 
    output wire [3:0] register1, register2 ; 
);
    reg [3:0] regs [0:3] ; // Internal storage : 4 registers, 4 bits each 

    assign register1 = regs[read_address1] ;  // Assign register 1 to have data of address 1
    assign register2 = regs[read_address2] ;  // Assign register 2 to have data of address 2

    always @(posedge clock) begin   
        if (write_enable) begin 
            regs[write_address] <= write_data ; // Writes write_data into write_address
        end
    end 
endmodule