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
        // Test values for comprehensive load instruction testing
        // These values test: LB (signed byte), LBU (unsigned byte), 
        // LH (signed halfword), and LW (word)
        
        mem[0]  = 32'hDEADBEEF; // Tests sign extension and word load
        mem[1]  = 32'h12345678; // Tests byte/halfword at different positions
        mem[2]  = 32'h8ABCDEF0; // Tests negative sign extension (MSB=1)
        mem[3]  = 32'h7FFFFFFF; // Maximum positive signed 32-bit value
        mem[4]  = 32'h80000000; // Minimum negative signed 32-bit value
        mem[5]  = 32'hFF00FF00; // Alternating pattern for byte testing
        mem[6]  = 32'h00FF00FF; // Inverse alternating pattern
        mem[7]  = 32'hAAAA5555; // Alternating bits pattern
        mem[8]  = 32'h5555AAAA; // Inverse alternating bits
        mem[9]  = 32'hFEDCBA98; // Descending hex pattern
        mem[10] = 32'h01234567; // Ascending hex pattern
        mem[11] = 32'h00000080; // Tests LB sign extension (byte=-128)
        mem[12] = 32'h0000007F; // Maximum positive byte
        mem[13] = 32'h000000FF; // Tests LBU vs LB difference
        mem[14] = 32'h00008000; // Tests LH sign extension (halfword=-32768)
        mem[15] = 32'h00007FFF; // Maximum positive halfword
        mem[16] = 32'h0000FFFF; // Tests LHU vs LH difference
        mem[17] = 32'hCAFEBABE; // Classic test pattern
        mem[18] = 32'hBAADF00D; // Another classic pattern
        mem[19] = 32'h13579BDF; // Odd digits pattern
        mem[20] = 32'h2468ACE0; // Even digits pattern
        mem[21] = 32'hF0F0F0F0; // Nibble pattern
        mem[22] = 32'h0F0F0F0F; // Inverse nibble pattern
        mem[23] = 32'hFFFFFFFF; // All ones
        mem[24] = 32'h00000000; // All zeros
        mem[25] = 32'h00000001; // Minimal positive
        mem[26] = 32'hFFFFFFFE; // Near maximum negative
        mem[27] = 32'h00000000; // Reserved for store result
        mem[28] = 32'h00000000; // Reserved for store result
        mem[29] = 32'h00000000; // Reserved for store result
        mem[30] = 32'h00000000; // Reserved for store result
        mem[31] = 32'h00000000;
        mem[32] = 32'h00000000;
        mem[33] = 32'h00000000;
        mem[34] = 32'h00000000;
        mem[35] = 32'h00000000;
        mem[36] = 32'h00000000;
        mem[37] = 32'h00000000;
        mem[38] = 32'h00000000;
        mem[39] = 32'h00000000;
        mem[40] = 32'h00000000;
        mem[41] = 32'h00000000;
        mem[42] = 32'h00000000;
        mem[43] = 32'h00000000;
        mem[44] = 32'h00000000;
        mem[45] = 32'h00000000;
        mem[46] = 32'h00000000;
        mem[47] = 32'h00000000;
        mem[48] = 32'h00000000;
        mem[49] = 32'h00000000;
        mem[50] = 32'h00000000;
        mem[51] = 32'h00000000;
        mem[52] = 32'h00000000;
        mem[53] = 32'h00000000;
        mem[54] = 32'h00000000;
        mem[55] = 32'h00000000;
        mem[56] = 32'h00000000;
        mem[57] = 32'h00000000;
        mem[58] = 32'h00000000;
        mem[59] = 32'h00000000;
        mem[60] = 32'h00000000;
        mem[61] = 32'h00000000;
        mem[62] = 32'h00000000;
        mem[63] = 32'h00000000;
    end

    
endmodule
