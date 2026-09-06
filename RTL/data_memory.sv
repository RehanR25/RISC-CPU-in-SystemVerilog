module data_memory(
    input wire clock, write_enable,   
    input wire [3:0] address, write_data , 
    output reg [3:0] read_data
);
    reg [3:0] memory [0:15] ; // 16 locations, 4 bits each 

    always @(*) begin
        read_data = memory[address] ; // Reads data from address
    end 

    always @(posedge clock) begin 
        if (write_enable) begin 
            memory[address] <= write_data  ; // Writes data into address
        end 
    end

endmodule