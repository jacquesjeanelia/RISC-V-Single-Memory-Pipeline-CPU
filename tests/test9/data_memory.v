`include "defines.v"

module DataMem(
    input clk, MemRead, MemWrite,
    input [2:0] function3,
    input [5:0] addr, 
    input [31:0] data_in, 
    output reg [31:0] data_out
);

    wire [31:0] mem_access_out;
    
    Memory_Access_Unit memory_access_unit(
        .data_in(MemWrite ? data_in : mem[addr]),
        .function3(function3),
        .data_out(mem_access_out)
    );

    reg [31:0] mem [0:63];

    always @(posedge clk) begin
        if (MemWrite) begin
            mem[addr] <= mem_access_out;
        end
    end

    always @(*) begin
        if (MemRead) begin
            data_out = mem_access_out;
        end
    end

    initial begin
        // Initialize memory used by the jal/jalr test program
        // This test program does not require specific data values to start,
        // but you can initialize key memory locations here if needed.

        // Just zero the first few entries for safety
        mem[0] = 32'h00000000;
        mem[1] = 32'h00000000;
        mem[2] = 32'h00000000;
        mem[3] = 32'h00000000;
        // Initialize rest to zero
        integer i;
        for(i = 4; i < 64; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end
    
endmodule
