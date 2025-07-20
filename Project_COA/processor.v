
`include "subcomponents.v"

module RISCprocessor(
    input clk,  
    input Reset, 
    input [7:0] InpExtWorld1, InpExtWorld2, InpExtWorld3, InpExtWorld4,
    output [7:0] OutExtWorld1, OutExtWorld2, OutExtWorld3, OutExtWorld4
);

    wire [7:0] RegDataout1, RegDataout2, RegDatain;
    wire [4:0] Opcode;
    wire [3:0] Source1, Source2, Destin;
    wire [7:0] Imm, MemoryAddress;
    wire [24:0] currentInstruction;
    wire [7:0] SRAMAddress, SRAMDatain, SRAMDataout;
    wire [7:0] StackAddress, StackDatain, StackDataout;
    wire [7:0] Operand1, Operand2, ALUout;
    wire T0, T1, T2, T3, T4;
    wire PCupdate;
    wire [7:0] PCAddress, PC, PC_D2;
    wire [7:0] InAddress, InDataout;   
    wire [7:0] OutAddress, OutDatain;
    wire ALUSave, ZflagSave, CflagSave;
    wire SRAMRead, SRAMWrite, StackRead, StackWrite, INportRead, OUTportWrite, RegFileRead, RegFileWrite;
    wire Zflag, Cflag;

    TimingGen TimingGenInst(clk,Reset,T0,T1,T2,T3,T4);
    ControlLogic ControlLogicInst(clk, Reset,T1, T2, T3, T4, Zflag, Cflag, Opcode, PCupdate,SRAMRead,SRAMWrite,StackRead,StackWrite,ALUSave,ZflagSave,CflagSave,INportRead,OUTportWrite,RegFileRead,RegFileWrite);

    Mux32to1_8bit Mux32to1_8bit_PCInst(
        .S(Opcode),
        .I0(PC), .I1(PC), .I2(PC), .I3(ALUout), .I4(ALUout), .I5(PC), .I6(PC), .I7(PC),
        .I8(PC), .I9(PC), .I10(PC), .I11(PC), .I12(PC), .I13(PC), .I14(Imm), .I15(Imm), 
        .I16(Imm), .I17(Imm), .I18(Imm), .I19(PC), .I20(PC), .I21(PC), .I22(PC), .I23(PC), 
        .I24(PC), .I25(PC), .I26(PC), .I27(PC), .I28(PC), .I29(PC), .I30(PC), .I31(PC),  
        .Y(PCAddress)
    );

    ProgCounter  ProgCounterInst(clk,Reset,T0,PCupdate,PCAddress,PC,PC_D2);
    InstMEM InstMEMInst(clk,Reset,T0,PC,currentInstruction,Opcode,Destin,Source1,Source2,Imm);
    Mux32to1_8bit Mux32to1_8bit_RegInst(
        .S(Opcode),
        .I0(RegDatain), .I1(ALUout), .I2(ALUout), .I3(ALUout), .I4(ALUout), .I5(ALUout), .I6(ALUout), .I7(ALUout),
        .I8(ALUout), .I9(ALUout), .I10(ALUout), .I11(SRAMDataout), .I12(RegDatain), .I13(RegDatain), .I14(RegDatain), .I15(RegDatain), 
        .I16(RegDatain), .I17(RegDatain), .I18(RegDatain), .I19(StackDataout), .I20(InDataout), .I21(RegDatain), .I22(SRAMDataout), .I23(RegDatain), 
        .I24(ALUout), .I25(ALUout), .I26(ALUout), .I27(RegDatain), .I28(RegDatain), .I29(RegDatain), .I30(RegDatain), .I31(RegDatain),  
        .Y(RegDatain)
    );

    RegisterFile RegisterFileInst(clk,Reset,RegFileRead,RegFileWrite,RegDatain,Source1,Source2,Destin,RegDataout1,RegDataout2);
    Mux32to1_8bit Mux32to1_8bit_op1(Opcode,8'b0, RegDataout1, RegDataout1, RegDataout1, RegDataout1, RegDataout1, RegDataout1, RegDataout1, RegDataout1, RegDataout1, 8'b0, 8'b0, RegDataout1,  8'b0, 8'b0, 8'b0, 8'b0, 8'b0, RegDataout1, 8'b0, 8'b0, RegDataout1, 8'b0, 8'b0, RegDataout1, RegDataout1, RegDataout1, PC_D2, PC_D2, 8'b0, 8'b0,8'b0,Operand1);
    Mux32to1_8bit Mux32to1_8bit_op2(Opcode,8'b0, RegDataout2, RegDataout2, RegDataout2, RegDataout2, Imm, Imm, Imm, Imm, 8'b0, Imm, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0,8'b0, RegDataout2, RegDataout2, RegDataout2, RegDataout2, {1'b0, Imm[6:0]}, {1'b0, Imm[6:0]}, 8'b0, 8'b0, 8'b0,Operand2);
   

    ALU ALU_Inst(clk,Reset,Imm[7],Operand1,Operand2,Opcode,ALUSave,ZflagSave,CflagSave,Zflag,Cflag,ALUout);
    Mux32to1_8bit Mux32to1_8bit_sram(Opcode,SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, Imm, Imm, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, RegDataout1, RegDataout1, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress, SRAMAddress,SRAMAddress);

    SRAM SRAM_Inst(clk,Reset,SRAMAddress,SRAMRead,SRAMWrite,ALUout,SRAMDataout);

    INport INport_Inst(clk,Reset,INportRead,InpExtWorld1,InpExtWorld2,InpExtWorld3,InpExtWorld4,Imm,InDataout);

    OUTport OUTport_Inst(clk,Reset,Imm,ALUout,OUTportWrite,OutExtWorld1,OutExtWorld2,OutExtWorld3,OutExtWorld4);

    Stack Stack(clk,Reset,StackRead,StackWrite,ALUout,StackDataout);
    

    

endmodule