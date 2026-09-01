module program_counter(
    input wire clock, reset, 
    output reg [3:0] pc_out 
); 
    always @(posedge clock) begin 
        if (reset == 1) pc_out <= 0 ; 
        else pc_out <= pc_out + 1 ;
    end 
endmodule 