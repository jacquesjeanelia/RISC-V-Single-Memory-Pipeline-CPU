# RISC-V Pipelined CPU

A 5-stage pipelined RISC-V processor implementation in Verilog, supporting the RV32I base instruction set with data forwarding and hazard detection.

## Overview

This project implements a classic 5-stage pipelined RISC-V CPU architecture with the following pipeline stages:

- **IF** (Instruction Fetch)
- **ID** (Instruction Decode)
- **EX** (Execute)
- **MEM** (Memory Access)
- **WB** (Write Back)

The design includes advanced features such as data forwarding to minimize pipeline stalls and hazard detection for handling control and data dependencies.

## Features

### Supported Instructions

The CPU implements the RV32I base instruction set, including:

- **Arithmetic Operations**: ADD, SUB, ADDI
- **Logical Operations**: AND, OR, XOR, ANDI, ORI, XORI
- **Shift Operations**: SLL, SRL, SRA, SLLI, SRLI, SRAI
- **Comparison**: SLT, SLTU, SLTI, SLTIU
- **Memory Access**: LB, LH, LW, LBU, LHU, SB, SH, SW
- **Branches**: BEQ, BNE, BLT, BGE, BLTU, BGEU
- **Jumps**: JAL, JALR
- **Upper Immediate**: LUI, AUIPC

### Pipeline Features

- **Data Forwarding**: Implements EX-to-EX and MEM-to-EX forwarding to reduce data hazard stalls
- **Hazard Detection**: Automatic detection and handling of control and data hazards
- **Pipeline Stalling**: Intelligent stalling mechanism for load-use hazards
- **Branch Control**: Pipeline flush mechanism on branch misprediction
- **Optimized Memory Access**: Unified memory design enables instruction fetch every cycle (instead of every 2 cycles) by intelligently multiplexing instruction and data access

## Architecture

### Module Structure

```
verilog/
├── CPU_pipelined.v          # Top-level pipelined CPU module
├── ALU.v                    # Arithmetic Logic Unit
├── ALU_control.v            # ALU control unit
├── control.v                # Main control unit
├── register_file.v          # 32-register file
├── memory.v                 # Unified memory module
├── forwarding_unit.v        # Data forwarding logic
├── branch_control.v         # Branch decision logic
├── imm_gen.v                # Immediate value generator
└── [other supporting modules]
```

### Pipeline Registers

- **IF/ID**: Stores PC, instruction, and PC+4
- **ID/EX**: Stores control signals, register values, immediate, and metadata
- **EX/MEM**: Stores ALU result, memory data, control signals, and flags
- **MEM/WB**: Stores memory output, ALU result, and write-back control

## Getting Started

### Prerequisites

- Verilog simulator (ModelSim, Icarus Verilog, Vivado, etc.)
- Basic understanding of RISC-V ISA and pipelined processor architecture

### File Organization

```
RISC-V-CPU/
├── verilog/                 # Source files
├── sim/                     # Testbench files
├── tests/                   # Test programs and memory files
│   ├── test1/              # Individual test cases
│   ├── test2/
│   └── ...
└── README.md
```

### Running Simulations

1. **Set up your simulation environment** with your preferred Verilog simulator

2. **Load the testbench**:

   ```verilog
   sim/CPU_pipelined_tb.v
   ```

3. **Include necessary modules** from the `verilog/` directory

4. **Run simulation**:
   - The testbench initializes the CPU with reset
   - Clock period is 10ns (5ns high, 5ns low)
   - Monitor register file and memory contents to verify correctness

### Test Programs

The `tests/` directory contains multiple test cases (test1 through test10), each with:

- `instruction_memory.v`: Pre-loaded instruction memory
- `data_memory.v`: Initial data memory state
- `.asm` files: Assembly source code (where applicable)

## Design Highlights

### Data Forwarding

The forwarding unit handles three forwarding scenarios:

- **EX-to-EX forwarding**: Forward from EX/MEM to EX stage
- **MEM-to-EX forwarding**: Forward from MEM/WB to EX stage
- Prevents unnecessary stalls for back-to-back dependent instructions

**Design Optimization**: The write-back data selection mux (traditionally in the WB stage) has been moved to the EX stage. This architectural decision allows forwarding to provide the final result (including LUI, AUIPC, JAL, and JALR outputs) rather than just the ALU output, enabling proper forwarding support for all instruction types that write to registers.

### Hazard Detection

- **Load-use hazards**: Detected and resolved with pipeline stalls
- **Control hazards**: Resolved with pipeline flushes on branch/jump
- **Structural hazards**: Avoided through unified memory with proper timing

### Control Flow

The CPU supports:

- **Conditional branches** with flag-based comparison
- **Unconditional jumps** (JAL, JALR)
- **PC-relative addressing** for branches
- **Register-indirect jumps** for JALR

## Memory Architecture

- **Unified Memory**: Single memory module handles both instruction fetch and data access without requiring alternating cycles
  - Smart multiplexing based on memory operation signals (MemRead/MemWrite)
  - When no data memory access is needed, instruction fetch proceeds normally
  - Eliminates the traditional 2-cycle penalty of basic unified memory designs
- **Word-addressable**: 32-bit word access with byte/halfword support
- **Address space**: Configurable based on memory module implementation

## Performance Considerations

- **Pipeline efficiency**: Most instructions complete in 1 cycle (after pipeline fill)
- **Stall cycles**: Introduced only when necessary (load-use hazards)
- **Branch penalty**: 2-3 cycles on mispredicted branches
- **Maximum clock frequency**: Dependent on critical path through ALU and memory

## Future Enhancements

Planned improvements and extensions:

- [ ] **Branch prediction** (e.g., 2-bit saturating counter or branch target buffer)
- [ ] **Cache memory hierarchy** (separate I-cache and D-cache)
- [ ] **M Extension support** (multiplication and division instructions)
- [ ] **Exception and interrupt handling** (trap handling, CSR registers)
- [ ] **Performance counters** and profiling capabilities

## Resources

- [RISC-V ISA Specification](https://riscv.org/technical/specifications/)
- [RISC-V Instruction Set Manual](https://github.com/riscv/riscv-isa-manual)

## License

This project is available for educational and reference purposes.

## About

A personal project exploring advanced computer architecture concepts and RISC-V processor design.
