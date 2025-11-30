`include "defines.v"

module InstrMem (
    input [5:0] address,
    output [31:0] data_out
);

    // 64-entry memory, where each entry is a 32-bit instruction
    reg [31:0] mem [0:63];

    // Combinational read port
    assign data_out = mem[address];

    // Initialize the instruction memory with the assembled program
    initial begin
        // jal x1, 12        (jump forward to label_jal, link)
        mem[0]  = 32'h00c000ef;
        // addi x10, x0, 0   (li a0, 0 - failure flag)
        mem[1]  = 32'h00000513;
        // jal x0, 16        (jump forward to print_result)
        mem[2]  = 32'h0100006f;
        // jalr x0, 0(x1)    (jump back to return address)
        mem[3]  = 32'h00008067;
        // addi x10, x0, 0   (li a0, 0 - failure flag)
        mem[4]  = 32'h00000513;
        // jal x0, 4         (jump forward to print_result)
        mem[5]  = 32'h0040006f;
        // addi x10, x0, 1   (li a0, 1 - success flag)
        mem[6]  = 32'h00100513;
        // bne x10, x0, 24   (bnez a0, print_success)
        mem[7]  = 32'h00051c63;
        // auipc x10, 64528  (la a0, fail_msg)
        mem[8]  = 32'h0fc10517;
        // addi x10, x10, -32
        mem[9]  = 32'hfe050513;
        // addi x10, x0, 4   (li a0, 4 - print string syscall)
        mem[10] = 32'h00400513;
        // ecall             (print fail_msg)
        mem[11] = 32'h00000073;
        // jal x0, 20        (jump to exit)
        mem[12] = 32'h0140006f;
        // auipc x10, 64528  (la a0, success_msg)
        mem[13] = 32'h0fc10517;
        // addi x10, x10, -52
        mem[14] = 32'hfcc50513;
        // addi x10, x0, 4   (li a0, 4 - print string syscall)
        mem[15] = 32'h00400513;
        // ecall             (print success_msg)
        mem[16] = 32'h00000073;
        // addi x10, x0, 10  (li a0, 10 - exit syscall)
        mem[17] = 32'h00a00513;
        // ecall             (exit)
        mem[18] = 32'h00000073;
    end
endmodule
