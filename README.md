# ALU_MINI_PROJECT
About ALU Project carried @Mirafra Technologies [Manipal] during Internship....

# BRIEF INTRODUCTION
This project focuses on designing and verifying a parameterized Arithmetic Logic Unit (ALU) in Verilog. The ALU performs a wide range of arithmetic and logical operations and supports configurable data width and command width. Though internally combinational, the design uses pipelined output registers (RES, OFLOW, COUT, G, L, E, ERR), introducing a one-cycle delay to support higher clock frequencies.

The ALU supports two modes—arithmetic and logical—controlled by the MODE signal. It handles operations like addition, subtraction (with/without carry), comparison, increment/decrement, multiplication, shifts, rotates, and basic logic functions. Input validation through INP_VALID allows selective operand usage.
Verification is a key part of the project, focusing on achieving high code coverage. This ensures all functional paths are tested, corner cases are identified, and the design is robust and reliable under all specified conditions.

# OBJECTIVES

To implement and design an Arithmetic Logic Unit(ALU) in Verilog HDL that can perforrm a wide range of arithmetic and logic functions.
To facilitate parameterization for data width and command structure to enable reusability and scalability.
To provide for proper handling of signed and unsigned operations, carry, overflow, and comparison flags.
To confirm the proper functioning and correctness of the ALU using exhaustive simulation testbenches in a Verilog simulation environment.
To exhibit the behavior of the ALU under various operating modes and input scenarios, such as edge cases and erroneous inputs.

# WORKING

Operands and opcode are processed combinationally to perform the selected operation and update status flags accordingly. The Arithmetic Logic Unit (ALU) uses control signals to determine the type of operation and processes inputs without waiting for clock edges during computation.

Operation Mode Selection – MODE Signal
MODE = 1 (Arithmetic Mode): Enables arithmetic operations like ADD, SUB, INC, DEC, MUL, and signed variants such as ADD_SIGN and SUB_SIGN.

MODE = 0 (Logical Mode): Enables logical operations including AND, OR, XOR, NOT, NAND, NOR, XNOR, SHL, SHR, and ROTATE operations.


Operand Validity – INP_VALID Signal

Operand usage is determined by the 2-bit INP_VALID signal:

2'b00: Both OPA and OPB are invalid → operation skipped; ERR is asserted.

2'b01: Only OPA is valid → single-operand operation performed on OPA.

2'b10: Only OPB is valid → single-operand operation performed on OPB.

2'b11: Both operands are valid → full binary operations enabled.

Combinational Operation and Result Handling
All supported ALU operations are computed in a purely combinational manner. Results are first stored in an intermediate register and then transferred to the output register RES at the next rising clock edge, introducing a 1-cycle latency for output updates. This ensures stability and synchronization without glitches.
Status Flag Updates

COUT: Set during unsigned operations with carry-out.

OFLOW: Set during signed arithmetic overflow.

G, E, L: Comparison flags indicating Greater, Equal, or Less.

ERR: Indicates invalid operand combinations or unsupported operation codes.
