module register_file(
    input wire [3:0] reg ; 
    input wire [0:3] regs ; 
    input wire [2:0] read_address1, read_address2 ; 
    input wire write_enable ; 
    input wire [3:0] write_data ; 
    input 
    output wire [3:0] register1, register2 ; 
    

);