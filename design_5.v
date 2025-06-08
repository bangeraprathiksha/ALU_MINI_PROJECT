module design_5 #(parameter width = 8, parameter cwidth =4)(
  input [width-1:0] OPA, OPB,
  input CLK, RST, CE, MODE, CIN,
  input [1:0] INP_VALID,
  input [cwidth-1:0] CMD,
  output reg [2*width:0] RES,
  output reg OFLOW,
  output reg COUT,
  output reg G,
  output reg L,
  output reg E,
  output reg ERR
);

reg [2*width:0] temp;

//using temporary registers to store to cause a delay of 1 clock cycle
reg [2*width:0] next_RES;
reg next_COUT, next_OFLOW, next_G, next_L, next_E, next_ERR;

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

wire [2:0] amount;

assign amount = OPB[2:0];

always@(posedge CLK or posedge RST)
begin
    if(RST)begin
        next_RES <= 'b0;
        next_COUT <= 1'b0;
        next_OFLOW <= 1'b0;
        next_G <= 1'b0;
        next_E <= 1'b0;
        next_L <= 1'b0;
        next_ERR <= 1'b0;
    end
    else if(CE)
    begin
        if(INP_VALID == 2'b00)
        begin
            next_RES <= 'b0;
            next_COUT <= 1'b0;
            next_OFLOW <= 1'b0;
            next_G <= 1'b0;
            next_E <= 1'b0;
            next_L <= 1'b0;
            next_ERR <= 1'b0;
        end
        else if(INP_VALID ==2'b11)
        begin
            next_RES <= 'b0;
            next_COUT <= 1'b0;
            next_OFLOW <= 1'b0;
            next_G <= 1'b0;
            next_E <= 1'b0;
            next_L <= 1'b0;
            next_ERR <= 1'b0;
            if(MODE)begin
                case(CMD)
                    CMD_ADD:
                    begin
                        temp = OPA + OPB;
                        next_RES <= temp;
                        next_COUT <= temp[width];
                    end
                    CMD_SUB:
                    begin
                        next_OFLOW <= (OPA<OPB)?1'b1:1'b0;
                        next_RES <= OPA-OPB;
                    end
                    CMD_ADD_CIN:
                    begin
                        temp = OPA + OPB + CIN;
                        next_RES <= temp;
                        next_COUT <= temp[width];
                    end
                    CMD_SUB_CIN:
                    begin
                        next_OFLOW <= (OPA<OPB)?1'b1:1'b0;
                        next_RES <= OPA-OPB-CIN;
                    end
                    CMD_EGL:
                    begin
                        next_RES <= 'b0;
                        if(OPA==OPB)
                        begin
                            next_E <= 1'b1;
                            next_G <= 1'b0;
                            next_L <= 1'b0;
                        end
                        else if(OPA>OPB)
                        begin
                            next_E <= 1'b0;
                            next_G <= 1'b1;
                            next_L <= 1'b0;
                        end
                        else
                        begin
                            next_E <= 1'b0;
                            next_G <= 1'b0;
                            next_L <= 1'b1;
                        end
                    end
                    CMD_INC_MUL:
                    begin
                        temp = (OPA+1) * (OPB+1);
                        next_RES <= temp;
                        next_COUT <= temp[2*width];
                    end
                    CMD_SHIFT_MUL:
                    begin
                        temp =(OPA<<1)*OPB;
                        next_RES <= temp;
                        next_COUT <= temp[2*width];
                    end

                    CMD_SI_UNSI_ADD:
                    begin
                        temp = $signed(OPA) + $signed(OPB);
                        next_RES <= temp;
                        next_COUT <= temp[width];
                        next_OFLOW <= ((OPA[width-1] == OPB[width-1]) && (temp[width-1] != OPA[width-1])) ? 1'b1 : 1'b0;
                        if($signed(OPA)==$signed(OPB))
                        begin
                            next_E <= 1'b1;
                            next_G <= 1'b0;
                            next_L <= 1'b0;
                        end
                        else if($signed(OPA)>$signed(OPB))
                        begin
                            next_E <= 1'b0;
                            next_G <= 1'b1;
                            next_L <= 1'b0;
                        end
                        else
                        begin
                            next_E <= 1'b0;
                            next_G <= 1'b0;
                            next_L <= 1'b1;
                        end
                    end
                    CMD_SI_UNSI_SUB:
                    begin

                        temp = $signed(OPA) - $signed(OPB);
                        next_RES<= temp;
                        next_COUT <= temp[width];
                       next_OFLOW <= ((OPA[width-1] != OPB[width-1]) && (temp[width-1] != OPA[width-1])) ? 1'b1 : 1'b0;
                        if($signed(OPA) == $signed(OPB))
                        begin
                            next_E <= 1'b1;
                            next_G <= 1'b0;
                            next_L <= 1'b0;
                        end
                        else if($signed(OPA) > $signed(OPB))
                        begin
                            next_E <= 1'b0;
                            next_G <= 1'b1;
                            next_L <= 1'b0;
                        end
                        else
                        begin
                            next_E <= 1'b0;
                            next_G <= 1'b0;
                            next_L <= 1'b1;
                        end
                    end
                    default:
                    begin
                        next_RES <= 'b0;
                        next_COUT <= 1'b0;
                        next_OFLOW <= 1'b0;
                        next_G <= 1'b0;
                        next_E <= 1'b0;
                        next_L <= 1'b0;
                        next_ERR <= 1'b0;
                    end
                endcase
            end
            else begin
                case(CMD)
                    CMD_AND:next_RES <= {{width*2-(width-1){1'b0}},OPA&OPB};
                    CMD_NAND:next_RES <= {{width*2-(width-1){1'b0}},~(OPA&OPB)};
                    CMD_OR:next_RES <= {{width*2-(width-1){1'b0}},OPA|OPB};
                    CMD_NOR:next_RES <= {{width*2-(width-1){1'b0}},~(OPA|OPB)};
                    CMD_XOR:next_RES <= {{width*2-(width-1){1'b0}},OPA^OPB};
                    CMD_XNOR:next_RES <= {{width*2-(width-1){1'b0}},~(OPA^OPB)};
                    CMD_ROL_A_B:
                    begin
                        if (amount == 0)
                            next_RES <= {{width*2-(width-1){1'b0}}, OPA};
                        else
                            next_RES <= {{width*2-(width){1'b0}}, (OPA << amount) | (OPA >> (width - amount))};
                        next_ERR <= (width > 3 && |OPB[width-1:3]) ? 1'b1 : 1'b0;
                    end
                    CMD_ROR_A_B:
                    begin
                        if (amount == 0)
                            next_RES <= {{width*2-(width-1){1'b0}}, OPA};
                        else
                            next_RES <= {{width*2-(width-1){1'b0}}, (OPA >> amount) | (OPA << (width - amount))};
                        next_ERR <= (width > 3 && |OPB[width-1:3]) ? 1'b1 : 1'b0;
                    end
                    default:
                    begin
                        next_RES <='b0;
                        next_COUT <= 1'b0;
                        next_OFLOW <= 1'b0;
                        next_G <= 1'b0;
                        next_E <= 1'b0;
                        next_L <= 1'b0;
                        next_ERR <= 1'b0;
                    end
                endcase
            end
        end
        else if(INP_VALID == 2'b01)
        begin
            next_RES <=  'b0;
            next_COUT <= 1'b0;
            next_OFLOW <= 1'b0;
            next_G <= 1'b0;
            next_E <= 1'b0;
            next_L <= 1'b0;
            next_ERR <= 1'b0;
            if(MODE)begin
                case(CMD)
                    CMD_INC_A:next_RES <= OPA+1;
                    CMD_DEC_A:next_RES <= OPA-1;
                    default:
                    begin
                        next_RES <= 'b0;
                        next_COUT <= 1'b0;
                        next_OFLOW <= 1'b0;
                        next_G <= 1'b0;
                        next_E <= 1'b0;
                        next_L <= 1'b0;
                        next_ERR <= 1'b0;
                    end
                endcase
            end
            else begin
                case(CMD)
                    CMD_NOT_A:next_RES <= {{width*2-(width-1){1'b0}},~OPA};
                    CMD_SHR1_A:next_RES <= {{width*2-(width-1){1'b0}},OPA>>1};
                    CMD_SHLI_A:next_RES <= {{width*2-(width-1){1'b0}},OPA<<1};
                    default:
                    begin
                        next_RES <= 'b0;
                        next_COUT <= 1'b0;
                        next_OFLOW <= 1'b0;
                        next_G <= 1'b0;
                        next_E <= 1'b0;
                        next_L <= 1'b0;
                        next_ERR <= 1'b0;
                    end
                endcase
            end
        end
        else if(INP_VALID == 2'b10)
            begin
                next_RES <= 'b0;
                next_COUT <= 1'b0;
                next_OFLOW <= 1'b0;
                next_G <= 1'b0;
                next_E <= 1'b0;
                next_L <= 1'b0;
                next_ERR <= 1'b0;
                if(MODE) begin
                    case(CMD)
                        CMD_INC_B: next_RES <= OPB + 1;
                        CMD_DEC_B: next_RES <= OPB - 1;
                        default:
                        begin
                            next_RES <= 'b0;
                            next_COUT <= 1'b0;
                            next_OFLOW <= 1'b0;
                            next_G <= 1'b0;
                            next_E <= 1'b0;
                            next_L <= 1'b0;
                            next_ERR <= 1'b0;
                        end
                    endcase
                end
                else begin
                    case(CMD)
                        CMD_NOT_B:next_RES <= {{width*2-(width-1){1'b0}},~OPB};
                        CMD_SHR1_B:next_RES <= {{width*2-(width-1){1'b0}},OPB>>1};
                        CMD_SHL1_B:next_RES <= {{width*2-(width-1){1'b0}},OPB<<1};
                        default:
                        begin
                            next_RES <= 'b0;
                            next_COUT <= 1'b0;
                            next_OFLOW <= 1'b0;
                            next_G <= 1'b0;
                            next_E <= 1'b0;
                            next_L <= 1'b0;
                            next_ERR <= 1'b0;
                        end
                    endcase
                end
        end

    end
end

always @(posedge CLK or posedge RST) begin
    if(RST) begin
        RES <= 'b0;
        COUT <= 1'b0;
        OFLOW <= 1'b0;
        G <= 1'b0;
        E <= 1'b0;
        L <= 1'b0;
        ERR <= 1'b0;
    end else if (CE) begin
        RES <= next_RES;
        COUT <= next_COUT;
        OFLOW <= next_OFLOW;
        G <= next_G;
        L <= next_L;
        E <= next_E;
        ERR <= next_ERR;
    end
end
endmodule
