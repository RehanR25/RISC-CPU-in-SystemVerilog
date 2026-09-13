module cpu(
    input wire clock, reset, 
    output wire [3:0] result, pc_out 
); 
    //wire [3:0] pc_out ; // Memory address of next instruction that CPU needs to fetch and execute 
    wire [15:0] instruction ; // Instruction that CPU needs to fetch and execute
    // Decodes the instruction 
    wire [2:0] opcode, funct ;  
    wire [1:0] reg1, reg2, regd ; 
    wire [12:0] immediate; 
    // Execute instruction into ALU
    wire [3:0] operand1, operand2, alu_result ; 
    wire zero ;     
    wire reg_write_enable ;  // controls whether register gets written this cycle
    assign reg_write_enable = (opcode == 3'b001 || opcode == 3'b000) ; // for R-type and I-type
    
    //  Address calculation for LOAD and STORE (rs1 + immediate)
    wire [3:0] load_address;
    wire load_cout ; 
   
    // Data memory signals for LOAD and STORE
    wire [3:0] read_data ;
    wire memory_write_enable; // controls whether memory gets written this cycle
    assign memory_write_enable = (opcode == 3'b010) ; 

    // Signal for BEQ (Branch if equal)
    wire [3:0] pc_in ;
    wire branch_jump ; 
    assign branch_jump = (opcode == 3'b011 && zero == 1) || (opcode == 3'b100) ; 

    // Final write-back selection
    wire [3:0] write_data ;
     
    decoder dec (.instruction(instruction), .opcode(opcode), .funct(funct), .reg1(reg1), .reg2(reg2), .regd(regd), .immediate(immediate)) ; 
    register_file reg_file (.clock(clock), .write_enable(reg_write_enable), .read_address1(reg1), .read_address2(reg2), 
        .write_address(regd), .write_data(result), .register1(operand1), .register2(operand2)) ; 

    ripple_carry_adder addr_calc (.num1(operand1), .num2(immediate[3:0]), .cin(1'b0), .sum(load_address), .cout(load_cout)) ;

    program_counter pc (.clock(clock), .reset(reset), .jmp(branch_jump), .pc_in(pc_in), .pc_out(pc_out)) ;
    
    // for R-type and B-type
    ALU alu (.num1(operand1), .num2(operand2), .opcode(funct), .sum(alu_result), .zero(zero)) ; 

    // R-type
    instruction_memory inst_mem (.address(pc_out), .instruction(instruction)) ; 
    
    // I-type and S-type
    data_memory dm (.clock(clock), .write_enable(memory_write_enable), .address(load_address), .write_data(operand2), .read_data(read_data)) ; 
    // There is not conflict for write_data nad read_data since write_enable prevents anything from being written, 
    // and read_data is only being used for the mux which is selected by the operand so its harmless 

    // for S-type, no multiplexer needed since value is stored in

    // B-type and J-type
    ripple_carry_adder j_b_addr_calc (.num1(pc_out), .num2(immediate[3:0]), .cin(1'b0), .sum(pc_in), .cout(load_cout)) ;
    
    // Multiplexer 
    multiplexer mx0 (.in0(alu_result[0]), .in1(read_data[0]), .in2(1'b0), .in3(1'b0), .in4(1'b0), .in5(1'b0), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(write_data[0])) ;
    multiplexer mx1 (.in0(alu_result[1]), .in1(read_data[1]), .in2(1'b0), .in3(1'b0), .in4(1'b0), .in5(1'b0), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(write_data[1])) ;
    multiplexer mx2 (.in0(alu_result[2]), .in1(read_data[2]), .in2(1'b0), .in3(1'b0), .in4(1'b0), .in5(1'b0), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(write_data[2])) ;
    multiplexer mx3 (.in0(alu_result[3]), .in1(read_data[3]), .in2(1'b0), .in3(1'b0), .in4(1'b0), .in5(1'b0), .in6(1'b0), .in7(1'b0), .sel(opcode), .out(write_data[3])) ;

    assign result = write_data ; // expose final write-back value for testing


endmodule 