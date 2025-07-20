# 🧠 Five-Cycle Non-Pipelined RISC Processor (Verilog HDL)

This project is a structural and behavioral Verilog implementation of a **non-pipelined RISC processor** that executes each instruction in **five clock cycles**. It is designed as part of the course **CSE302: Computer Organization and Architecture**.

---

## 📌 Features

- 5-stage non-pipelined execution:
  1. **Instruction Fetch**
  2. **Instruction Decode**
  3. **Execute**
  4. **Memory Access**
  5. **Write Back**
  
- Structural integration of all components
- Behavioral and structural Verilog mix
- Simple instruction set (ADD, LOAD, STORE,SHIFT)
- Supports `instmemory`, `register file`, `ALU`, `SRAM` and `control logic`

---

## 🏗️ Project Structure

├── processor.v          # Top-level module (RISCprocessor)
├── subcomponents.v      # All submodules (ALU, SRAM, TimingGen, etc.)
├── tb_RISCprocessor.v   # Testbench to simulate processor behavior
├── instructions.bin     # Binary machine code input for testing
├── README.md            # This file


🚀 How to Run
Make sure all the files (processor.v, subcomponents.v, tb_RISCprocessor.v, instructions.bin) are in the same folder.

Run the testbench using a Verilog simulator like Icarus Verilog:

iverilog -o testbench tb_RISCprocessor.v processor.v subcomponents.v
vvp testbench
View results in the terminal or with a waveform viewer (GTKWave if using Icarus).

💡 Sample Program (instructions.bin)
This binary file includes a sample program that:

Loads values into registers R1 and R2

Adds them and stores the result in R3

Writes R3 to memory

Halts the program

Example:

LOAD R1, #5
LOAD R2, #3
ADD R3, R1, R2
STORE R3, 10


✅ PowerPoint Presentation (to be submitted separately)

✅ Handwritten assembly code

 
