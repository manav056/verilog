//Module Name   : pipe_MIPS32.v
//Description   : 5 stage pipelined implementation of MIPS32 Instruction Set 
//Version       : 1.0
//Last Modified : 05-02-2025
//Writer        : Manav Saini


//Timescale : Unit = 1 nanosecond, Precision = 1 pecosecond
`timescale 1ns / 1ps
module pipe_MIPS32(clk1, 
                   clk2,
                   o_addr);
                   //io_data);
    input clk1, clk2;         //Two-phase clock

    output reg [31:0] o_addr;
    
    reg [31:0] PC,            //Program Counter

    //Buffer Registers / Latch between Stage 1 and 2
               IF_ID_IR,      
               IF_ID_NPC;     

    //Buffer Registers / Latch between Stage 2 and 3
    reg [31:0] ID_EX_IR,      //IR
               ID_EX_NPC,     //NPC
               ID_EX_A,       //A
               ID_EX_B,       //B
               ID_EX_Imm;     //Immediate

    //Buffer registers that store opcode
    reg [5:0] ID_EX_type,     //between stage 2 and 3
              EX_MEM_type,    //between stage 3 and 4
              MEM_WB_type;    //between stage 4 and 5

    //Buffer registers between stage 3 and 4
    reg [31:0] EX_MEM_IR,     //IR
               EX_MEM_ALUOut, //ALU OUTPUT / EXECUTION OUTPUT
               EX_MEM_B;      //B

    reg        EX_MEM_cond;   //Buffer Register for BRANCH CONDITION between stage 3 and 4

    //Buffer registers between stage 4 and 5
    reg [31:0] MEM_WB_IR,     //IR
               MEM_WB_ALUOut, //ALU OUTPUT / EXECUTION OUTPUT
               MEM_WB_LMD;
    
    reg [31:0] Reg [0:31];       //Register Bank (32 x 32)

    reg [31:0] Mem [0:1023];     //1024 x 32 memory
    
    //Defining Opcodes for operations
    parameter ADD=6'b000000,
              ADDI=6'b000001,
              ADDIU=6'b000010,
              ADDIUPC=6'b000011,
              ADDU=6'b000100,
              ALIGN=6'b000101,
              ALUIPC=6'b000110,
              AND=6'b000111,
              ANDI=6'b001000,
              AUI=6'b001001,
              AUIPC=6'b001010,
              B=6'b001011,
              BAL=6'b001100,
              BNEQZ=6'b001101,
              BEQZ=6'b001110,
              SUB=6'b000001,
              OR=6'b000011,
              SLT=6'b000100,
              MUL=6'b000101,
              HLT=6'b111111,
              LW=6'b001000,
              SW=6'b001001,
              SUBI=6'b001011,
              SLTI=6'b001100; 
    
    //Defining Instruction
    parameter RR_ALU=6'b000000,            //Register - Register type instructions = Both operands are registers
              RM_ALU=6'b000001,            //Immediate type instructions           = One operand is register and other is Immediate Data
              LOAD=6'b000010,              //Load Data type instructions           = Loads data from memory
              STORE=6'b000011,             //Store data type instructions          = Stores data in memory
              BRANCH=6'b000100,            //Branching type instructions           = Used to perform branching 
              HALT=6'b000101,              //Halt Instruction                      = Stops the CPU operations
              PCREL=6'b111011;             //Program Counter relative instructions = One operand is PC and the other is register
    
    reg HALTED; //Set after HLT instruction is completed (in WB stage)

    reg TAKEN_BRANCH; //Required to disable instructions after branch
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Instruction Fetch Stage
    always @(posedge clk1)
        begin
            if(HALTED == 0)
                begin

                //Checking for branch condition
                    if(((EX_MEM_IR[31:26] == BEQZ) && (EX_MEM_cond == 1))||((EX_MEM_IR[31:26] == BNEQZ) && (EX_MEM_cond == 0))||(EX_MEM_IR[31:26] == B))

                    //Following values will be assigned if branch is taken
                        begin
                            IF_ID_IR     <=  Mem[EX_MEM_ALUOut];
                            //TAKEN_BRANCH <=  ((EX_MEM_IR[31:26] == BEQZ) && (EX_MEM_cond == 1))||((EX_MEM_IR[31:26] == BNEQZ) && (EX_MEM_cond == 0));
                            IF_ID_NPC    <=  EX_MEM_ALUOut + 1;
                            PC           <=  EX_MEM_ALUOut + 1;
                        end

                    //Following values will be assigned if branch is not taken i.e normal operation    
                    else
                        begin
                            IF_ID_IR     <=  Mem[PC];
                            IF_ID_NPC    <=  PC + 1;
                            PC           <=  PC + 1;
                            o_addr       <=  IF_ID_NPC;
                        end
                end
        end
        
     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     //Instruction Decode
     always @(posedge clk2)
        begin
            if(HALTED == 0)
                begin
                    if(IF_ID_IR[25:21] == 5'b00000) ID_EX_A <= 0;
                    else                            ID_EX_A <=  Reg[IF_ID_IR[25:21]];
                    
                    if(IF_ID_IR[20:16] == 5'b00000) ID_EX_B <= 0;
                    else                            ID_EX_B <=  Reg[IF_ID_IR[20:16]];

                    if(IF_ID_IR[20:16] == 5'b11111) ID_EX_B <= 1;
                    else                            ID_EX_B <=  Reg[IF_ID_IR[20:16]];

                    //if(IF_ID_IR[31:26] == 6'b011111) 
                    
                    //Following code defines the forwarding of values of NPC and IR to the next stage
                    ID_EX_NPC <=  IF_ID_NPC;
                    ID_EX_IR  <=  IF_ID_IR;

                    //Assigning immediate values to the immediate register
                    ID_EX_Imm <=  {{16{IF_ID_IR[15]}},{IF_ID_IR[15:0]}};
                end
            
            //Defining instruction type based on the instruction
            case(IF_ID_IR[31:26])
                ADD, SUB, AND, OR, SLT, MUL, ALIGN                    : ID_EX_type <=  RR_ALU;
                ADDI, SUBI, SLTI, ADDIU, ANDI, AUI                    : ID_EX_type <=  RM_ALU;
                ADDIUPC, ALUIPC                                       : ID_EX_type <=  PCREL;
                LW                                                    : ID_EX_type <=  LOAD;
                SW                                                    : ID_EX_type <=  STORE;
                BNEQZ, BEQZ, B                                        : ID_EX_type <=  BRANCH;
                HLT                                                   : ID_EX_type <=  HALT;
                default                                               : ID_EX_type <=  HALT;
            endcase
        end
        
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     //Execution Stage
     always @(posedge clk1)
        begin
            if(HALTED == 0)
                begin
                    EX_MEM_type <=  ID_EX_type;
                    EX_MEM_IR   <=  ID_EX_IR;
                    //TAKEN_BRANCH <=  ((EX_MEM_IR[31:26] == BEQZ) && (EX_MEM_cond == 1))||((EX_MEM_IR[31:26] == BNEQZ) && (EX_MEM_cond == 0));
                    
                    //Computing the value of EX_MEM_ALUOut based on the instruction
                    case(ID_EX_type)
                        RR_ALU: 
                            begin
                                case(ID_EX_IR[31:26]) //OPCODE
                                    ADD    : EX_MEM_ALUOut <=  ID_EX_A + ID_EX_B;
                                    SUB    : EX_MEM_ALUOut <=  ID_EX_A - ID_EX_B;
                                    AND    : EX_MEM_ALUOut <=  ID_EX_A & ID_EX_B;
                                    OR     : EX_MEM_ALUOut <=  ID_EX_A | ID_EX_B;
                                    SLT    : EX_MEM_ALUOut <=  ID_EX_A < ID_EX_B;
                                    MUL    : EX_MEM_ALUOut <=  ID_EX_A * ID_EX_B;
                                    ALIGN  : EX_MEM_ALUOut <=  ((ID_EX_B << (8*ID_EX_IR[7:6]))||(ID_EX_A >> (8*(4 - ID_EX_IR[7:6]))));
                                    default: EX_MEM_ALUOut <=  32'hxxxxxxxx;
                                endcase
                            end
                            
                        RM_ALU: 
                            begin
                                case(ID_EX_IR[31:26]) //OPCODE
                                    ADDI    : EX_MEM_ALUOut <=  ID_EX_A + ID_EX_Imm;
                                    SUBI    : EX_MEM_ALUOut <=  ID_EX_A - ID_EX_Imm;
                                    SLTI    : EX_MEM_ALUOut <=  ID_EX_A < ID_EX_Imm;
                                    ADDIU   : EX_MEM_ALUOut <=  ID_EX_A + ID_EX_Imm;
                                    ANDI    : EX_MEM_ALUOut <=  ID_EX_A & ID_EX_Imm;
                                    AUI     : EX_MEM_ALUOut <=  ID_EX_A + ID_EX_Imm;
                                    default : EX_MEM_ALUOut <=  32'hxxxxxxxx;
                                endcase
                            end
                            
                       LOAD, STORE:
                            begin
                                EX_MEM_ALUOut <=  ID_EX_A + ID_EX_Imm;
                                EX_MEM_B      <=  ID_EX_B;
                            end
                            
                       BRANCH:
                            begin
                                EX_MEM_ALUOut <=  ID_EX_NPC + ID_EX_Imm;
                                
                                case(IF_ID_IR[31:26])
                                    B   : EX_MEM_cond <=  1'b1;
                                    //BEQ : EX_MEM_cond <=  (ID_EX_A == ID_EX_B);
                                endcase
                                //EX_MEM_cond   <=  (ID_EX_A == 0);
                                TAKEN_BRANCH  <=  EX_MEM_cond;
                            end

                        PCREL:
                            begin
                                case(ID_EX_IR[31:26])
                                    ADDIUPC : EX_MEM_ALUOut <=  ID_EX_A + ID_EX_IR;
                                    ALUIPC  : EX_MEM_ALUOut <=  ~40'h0FFFF & (PC + ID_EX_Imm);
                                    AUIPC   : EX_MEM_ALUOut <=  PC + ID_EX_Imm;
                                endcase
                            end
                    endcase 
                end
        end
     
     /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     //Memory Stage   
     always @(posedge clk2)
        begin
            if(HALTED == 0)
                begin
                    MEM_WB_type <=  EX_MEM_type;
                    MEM_WB_IR   <=  EX_MEM_IR;
                    
                    case(EX_MEM_type)
                        RR_ALU, RM_ALU: MEM_WB_ALUOut <=  EX_MEM_ALUOut;
                        
                        LOAD          : MEM_WB_LMD    <=  Mem[EX_MEM_ALUOut];
                        
                        STORE         : if(TAKEN_BRANCH == 0)
                                           Mem[EX_MEM_ALUOut] <=  EX_MEM_B; 

                        PCREL         : MEM_WB_ALUOut <=  EX_MEM_ALUOut; 
                    endcase 
                end
        end 
        
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //Write Back Stage
      always @(posedge clk1)
        begin
            if(TAKEN_BRANCH == 0)
                case(MEM_WB_type)
                    RR_ALU       : Reg[MEM_WB_IR[15:11]] <=  MEM_WB_ALUOut;
                    
                    RM_ALU       : Reg[MEM_WB_IR[20:16]] <=  MEM_WB_ALUOut;
                    
                    LOAD         : Reg[MEM_WB_IR[20:16]] <=  MEM_WB_LMD;
                    
                    HALT         : HALTED                <=  1'b1;

                    PCREL        : Reg[MEM_WB_IR[25:21]] <=  MEM_WB_ALUOut;
                endcase
        end
endmodule