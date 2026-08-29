module register(
    input wire clock, reset , 
    input wire [3:0] data , 
    output reg [3:0] stored_val
);
// Register holds value and only changes that value
// at a specific moment in time (a clock edge)

    always @(posedge clock) begin
    // posedge triggers the block on the positive (rising) edge of a clock signal 
    // it ignores everything except the exact instant clock goes from 0 to 1 
    // At that instant, run this block 

        if (reset == 1) stored_val <= 4'b0000 ; 
        else stored_val <= data ; 

// <= is the non-blocking assignment 
// it schedules this update to happen, but let all other statements
// in this block (and other blocks triggered by the same clock edge)
// also read the old values first, then everything updates together 
// using = would update immediately. in-order, potentially causes one statement's new value 
// to be seen by the next statement in the same clock edge which causes real bugs in bigger circuits 

    end 
endmodule 
