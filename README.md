# RISC-V Multi-Cycle Processor

An educational Verilog implementation of a classic multi-cycle RISC-V CPU. This design walks through the classic five-stage execution pipeline—fetch, decode, execute, memory access, write-back—using shared datapath components and a finite-state control unit.

---

##  Overview

This processor model emphasizes:

- **Efficient Hardware Reuse** — unlike single-cycle designs, this multi-cycle architecture reuses ALUs, memory, and control logic across instruction stages.
- **Modular Structure** — clear separation between the datapath and control logic, making it easier to understand and extend.
- **Instruction-Level Clarity** — step-by-step execution is great for educational traceability.

---

##  Project Structure

| File Name                      | Description                                     |
|-------------------------------|--------------------------------------------------|
| `PC.v`, `PC_adder.v`          | Program counter and increment logic              |
| `Instruction_memory.v`        | Instruction storage module                       |
| `register_files.v`            | Multi-ported register file                       |
| `Sign_Extend.v`               | Immediate value extension logic                  |
| `alu.v`, `alu_decoder.v`      | Arithmetic logic unit and operation decoder      |
| `data_memory.v`               | Load/store data memory module                    |
| `main_decoder.v`, `Control_Unit_Top.v` | Control logic for instruction execution     |
| `riscv_multicycle_Top.v`      | Top-level module integrating datapath and control|
| `riscv_multicycle_Top_tb.v`   | Testbench to simulate and verify execution       |

---

##  Quick Start

### Requirements

- Verilog simulator (e.g. Icarus Verilog, ModelSim)
- Waveform viewer (e.g. GTKWave)

### Run Instructions

1. Clone this repository:
      ```bash
   git clone https://github.com/7yns7/Riscv_multicycle_processor.git
   cd Riscv_multicycle_processor
2.Compile the top-level testbench and run the simulation: 
  ```bash
  iverilog -o out.vvp .\riscv_multicycle_Top_tb.v .\riscv_multicycle_Top.v
  vvp out.vvp
  gtkwave

