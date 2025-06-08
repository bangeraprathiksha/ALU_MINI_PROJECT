# 🚀 Parameterized Arithmetic Logic Unit (ALU) in Verilog

This project implements a **parameterized Arithmetic Logic Unit (ALU)** using Verilog HDL. It supports a wide range of arithmetic and logical operations, configurable data width, and command structure.

---

## 📘 Project Overview

The ALU is designed to perform:
- Arithmetic operations: ADD, SUB, MUL, INC, DEC, etc.
- Logical operations: AND, OR, XOR, NOT, etc.
- Shift and rotate operations
- Comparison and status flag generation

It includes support for:
- Signed and unsigned calculations
- Control signals: `MODE`, `INP_VALID`, `CE`, `CIN`
- Output flags: `COUT`, `OFLOW`, `G`, `L`, `E`, `ERR`

---

## 📐 Architecture

The design includes:
- **Input Validation Logic**
- **Arithmetic & Logical Units**
- **Control Unit** (decodes `CMD` and `MODE`)
- **Pipeline Registers** for delayed result updates
- **Flag Generation Logic**

Testbench architecture is also provided and includes:
- Stimulus Generator
- DUT
- Output Monitor
- Checker
- Scoreboard

![Testbench Architecture](testbench_architecture.png)

---

## 📂 Files

| File | Description |
|------|-------------|
| `design_5.v` | Verilog source code of the ALU |
| `alu_tb.v` | Testbench for simulation |
| `ALU_DOCUMENT.pdf` | Full documentation with design, working, and future improvements |
| `testbench_architecture.png` | Diagram of the testbench structure |
| `README.md` | Project description |

---

## 🛠️ Simulation & Verification

- Exhaustive testbench to validate all operations
- Simulated using [QuestaSim/ModelSim]
- Code coverage and waveform analysis confirm correctness
- Handles edge cases and invalid conditions

---

## ✅ Results

- All operations validated using simulation
- Flags (`OFLOW`, `COUT`, `G`, `L`, `E`, `ERR`) work as expected
- Output registers introduce one-cycle latency for stability

---

## 🔮 Future Improvements

- Multi-stage pipelining for higher throughput
- Add support for division, modulus, and barrel shifter
- Wider data widths: 16-bit, 32-bit
- Formal verification for exhaustive coverage

---

## 🧑‍💻 Author

**Prathiksha Bangera**  
Intern at Mirafra Technologies

---


