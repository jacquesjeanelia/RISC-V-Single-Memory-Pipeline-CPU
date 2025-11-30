`include "defines.v"

module InstrMem (
    input [5:0] address,
    output [31:0] data_out
);

    // 64-entry memory for instructions
    reg [31:0] mem [0:63];

    // Combinational read port
    assign data_out = mem[address];

    // Initialize memory with the assembled program
    initial begin
        mem[0]  = 32'h0c819c83;
        mem[1]  = 32'h09cb2c83;
        mem[2]  = 32'h006cffb3;
        mem[3]  = 32'h2defea93;
        mem[4]  = 32'h0a8a8a83;
        mem[5]  = 32'h02ba9423;
        mem[6]  = 32'h010a7433;
        mem[7]  = 32'h005426b3;
        mem[8]  = 32'hcf768893;
        mem[9]  = 32'hfffc8f13;
        mem[10] = 32'h03bf1263;
        mem[11] = 32'h0172f263;
        mem[12] = 32'h026cccb7;
        mem[13] = 32'h02c14f83;
        mem[14] = 32'h024fa303;
        mem[15] = 32'h01937663;
        mem[16] = 32'hff129ee3;
        mem[17] = 32'h05012d83;
        mem[18] = 32'h09edae23;
        mem[19] = 32'h00529063;
    end
endmodule
