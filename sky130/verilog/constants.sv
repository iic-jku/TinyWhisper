// Define operation constants
localparam logic [6:0] OP_RTYPE = 7'b0110011;
localparam logic [6:0] OP_ITYPE = 7'b0010011;
localparam logic [6:0] OP_LUI = 7'b0110111;
localparam logic [6:0] OP_AUIPC = 7'b0010111;
localparam logic [6:0] OP_LW = 7'b0000011;
localparam logic [6:0] OP_SW = 7'b0100011;
localparam logic [6:0] OP_JALR = 7'b1100111;
localparam logic [6:0] OP_JAL = 7'b1101111;
localparam logic [6:0] OP_BRANCH = 7'b1100011;
localparam logic [6:0] OP_MRET = 7'b1110011;
localparam logic [6:0] OP_CSR = 7'b1110011;

// Funct7 and funct3 fields for R-Type
localparam logic [6:0] FUNCT7_ADD = 7'b0000000;
localparam logic [2:0] FUNCT3_ADD = 3'b000;

localparam logic [6:0] FUNCT7_SUB = 7'b0100000;
localparam logic [2:0] FUNCT3_SUB = 3'b000;

localparam logic [6:0] FUNCT7_AND = 7'b0000000;
localparam logic [2:0] FUNCT3_AND = 3'b111;

localparam logic [6:0] FUNCT7_OR = 7'b0000000;
localparam logic [2:0] FUNCT3_OR = 3'b110;

localparam logic [6:0] FUNCT7_XOR = 7'b0000000;
localparam logic [2:0] FUNCT3_XOR = 3'b100;

localparam logic [6:0] FUNCT7_SLT = 7'b0000000;
localparam logic [2:0] FUNCT3_SLT = 3'b010;

localparam logic [6:0] FUNCT7_SLTU = 7'b0000000;
localparam logic [2:0] FUNCT3_SLTU = 3'b011;

localparam logic [6:0] FUNCT7_SRA = 7'b0100000;
localparam logic [2:0] FUNCT3_SRA = 3'b101;

localparam logic [6:0] FUNCT7_SRL = 7'b0000000;
localparam logic [2:0] FUNCT3_SRL = 3'b101;

localparam logic [6:0] FUNCT7_SLL = 7'b0000000;
localparam logic [2:0] FUNCT3_SLL = 3'b001;

// Funct3 for most immediate instructions
localparam logic [2:0] FUNCT3_ADDI = 3'b000;
localparam logic [2:0] FUNCT3_ANDI = 3'b111;
localparam logic [2:0] FUNCT3_ORI = 3'b110;
localparam logic [2:0] FUNCT3_XORI = 3'b100;
localparam logic [2:0] FUNCT3_SLTI = 3'b010;
localparam logic [2:0] FUNCT3_SLTIU = 3'b011;

localparam logic [6:0] FUNCT7_SRAI = 7'b0100000;
localparam logic [2:0] FUNCT3_SRAI = 3'b101;

localparam logic [6:0] FUNCT7_SRLI = 7'b0000000;
localparam logic [2:0] FUNCT3_SRLI = 3'b101;

localparam logic [6:0] FUNCT7_SLLI = 7'b0000000;
localparam logic [2:0] FUNCT3_SLLI = 3'b001;

// Funct3 for memory instructions
// localparam logic [2:0] FUNCT3_MEMORY = 3'b010;
localparam logic [2:0] FUNCT3_MEM_B = 3'b000;
localparam logic [2:0] FUNCT3_MEM_H = 3'b001;
localparam logic [2:0] FUNCT3_MEM_W = 3'b010;
localparam logic [2:0] FUNCT3_LBU = 3'b100;
localparam logic [2:0] FUNCT3_LHU = 3'b101;

// Funct3 for branches
localparam logic [2:0] FUNCT3_BEQ = 3'b000;
localparam logic [2:0] FUNCT3_BNE = 3'b001;
localparam logic [2:0] FUNCT3_BLT = 3'b100;
localparam logic [2:0] FUNCT3_BGE = 3'b101;
localparam logic [2:0] FUNCT3_BLTU = 3'b110;
localparam logic [2:0] FUNCT3_BGEU = 3'b111;

localparam logic [6:0] FUNCT7_MRET = 7'b0011000;
localparam logic [2:0] FUNCT3_MRET = 3'b000;

localparam logic [2:0] FUNCT3_CSRW = 3'b001;
localparam logic [2:0] FUNCT3_CSRR = 3'b010;

localparam logic [6:0] DONT_CARES = 7'b???????;

// Instruction definitions
// R-TYPE
// localparam logic [16:0] INST_ADD = {FUNCT7_ADD, FUNCT3_ADD, OP_RTYPE};
// localparam logic [16:0] INST_SUB = {FUNCT7_SUB, FUNCT3_SUB, OP_RTYPE};
// localparam logic [16:0] INST_MUL = {FUNCT7_MUL, FUNCT3_MUL, OP_RTYPE};
// localparam logic [16:0] INST_AND = {FUNCT7_AND, FUNCT3_AND, OP_RTYPE};
// localparam logic [16:0] INST_XOR = {FUNCT7_XOR, FUNCT3_XOR, OP_RTYPE};
// localparam logic [16:0] INST_OR = {FUNCT7_OR, FUNCT3_OR, OP_RTYPE};
// localparam logic [16:0] INST_SLTU = {FUNCT7_SLTU, FUNCT3_SLTU, OP_RTYPE};
// localparam logic [16:0] INST_SLT = {FUNCT7_SLT, FUNCT3_SLT, OP_RTYPE};
// localparam logic [16:0] INST_SRA = {FUNCT7_SRA, FUNCT3_SRA, OP_RTYPE};
// localparam logic [16:0] INST_SRL = {FUNCT7_SRL, FUNCT3_SRL, OP_RTYPE};
// localparam logic [16:0] INST_SLL = {FUNCT7_SLL, FUNCT3_SLL, OP_RTYPE};

// // I-TYPE
// localparam logic [16:0] INST_ADDI = {Dont_Cares, FUNCT3_ADDI, OP_ITYPE};
// localparam logic [16:0] INST_ANDI = {Dont_Cares, FUNCT3_ANDI, OP_ITYPE};
// localparam logic [16:0] INST_ORI = {Dont_Cares, FUNCT3_ORI, OP_ITYPE};
// localparam logic [16:0] INST_XORI = {Dont_Cares, FUNCT3_XORI, OP_ITYPE};
// localparam logic [16:0] INST_SLTI = {Dont_Cares, FUNCT3_SLTI, OP_ITYPE};
// localparam logic [16:0] INST_SLTIU = {Dont_Cares, FUNCT3_SLTIU, OP_ITYPE};
// localparam logic [16:0] INST_SRAI = {FUNCT7_SRAI, FUNCT3_SRAI, OP_ITYPE};
// localparam logic [16:0] INST_SRLI = {FUNCT7_SRLI, FUNCT3_SRLI, OP_ITYPE};
// localparam logic [16:0] INST_SLLI = {FUNCT7_SLLI, FUNCT3_SLLI, OP_ITYPE};

// // BRANCHES
// localparam logic [16:0] INST_BEQ = {Dont_Cares, FUNCT3_BEQ, OP_BRANCH};
// localparam logic [16:0] INST_BNE = {Dont_Cares, FUNCT3_BNE, OP_BRANCH};
// localparam logic [16:0] INST_BLT = {Dont_Cares, FUNCT3_BLT, OP_BRANCH};
// localparam logic [16:0] INST_BGE = {Dont_Cares, FUNCT3_BGE, OP_BRANCH};
// localparam logic [16:0] INST_BLTU = {Dont_Cares, FUNCT3_BLTU, OP_BRANCH};
// localparam logic [16:0] INST_BGEU = {Dont_Cares, FUNCT3_BGEU, OP_BRANCH};

// // SPECIAL
// localparam logic [16:0] INST_LUI = {Dont_Cares, 3'bxxx, OP_LUI};
// localparam logic [16:0] INST_AUIPC = {Dont_Cares, 3'bxxx, OP_AUIPC};

// // MEMORY
// localparam logic [16:0] INST_LW = {Dont_Cares, FUNCT3_MEM_W, OP_LW};
// localparam logic [16:0] INST_SW = {Dont_Cares, FUNCT3_MEM_W, OP_SW};

// // JUMP
// localparam logic [16:0] INST_JAL = {Dont_Cares, 3'bxxx, OP_JAL};
// localparam logic [16:0] INST_JALR = {Dont_Cares, 3'bxxx, OP_JALR};

// // MRET
// localparam logic [16:0] INST_MRET = {FUNCT7_MRET, FUNCT3_MRET, OP_MRET};

// // CSRR/W
// localparam logic [16:0] INST_CSRR = {Dont_Cares, FUNCT3_CSRR, OP_CSR};
// localparam logic [16:0] INST_CSRW = {Dont_Cares, FUNCT3_CSRW, OP_CSR};
