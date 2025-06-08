
//MODE =1

//VALID_INP=2'b11
localparam CMD_ADD = 4'b0000;
localparam CMD_SUB = 4'b0001;
localparam CMD_ADD_CIN = 4'b0010;
localparam CMD_SUB_CIN = 4'b0011;
localparam CMD_EGL = 4'b1000;
localparam CMD_INC_MUL = 4'b1001;
localparam CMD_SHIFT_MUL = 4'b1010;
localparam CMD_SI_UNSI_ADD = 4'b1011;
localparam CMD_SI_UNSI_SUB = 4'b1100;


//VALID_INP=2'b01 (A is Valid)
localparam CMD_INC_A = 4'b0100;
localparam CMD_DEC_A = 4'b0101;

//VALID_INP =2'b10 (B is valid)
localparam CMD_INC_B = 4'b0110;
localparam CMD_DEC_B = 4'b0111;



///MODE =0

//VALID_INP=2'b11
localparam CMD_AND = 4'b0000;
localparam CMD_NAND = 4'b0001;
localparam CMD_OR = 4'b0010;
localparam CMD_NOR = 4'b0011;
localparam CMD_XOR = 4'b0100;
localparam CMD_XNOR = 4'b0101;
localparam CMD_ROL_A_B = 4'b1100;
localparam CMD_ROR_A_B = 4'b1101;

//VALID_INP =2'b01 (A is valid)
localparam CMD_NOT_A = 4'b0110;
localparam CMD_SHR1_A = 4'b1000;
localparam CMD_SHLI_A = 4'b1001;

//VALID_INP =2'b10 (B is valid)
localparam CMD_NOT_B = 4'b0111;
localparam CMD_SHR1_B = 4'b1010;
localparam CMD_SHL1_B = 4'b1011;
