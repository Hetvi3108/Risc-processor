`timescale 1ns/100ps
module decoder3to8_withoutE(A,D);
  input [2:0] A;
  output wire [7:0] D;
  
  assign D[0] = ~A[2]&~A[1]&~A[0];
  assign D[1] = ~A[2]&~A[1]&A[0];
  assign D[2] = ~A[2]&A[1]&~A[0];
  assign D[3] = ~A[2]&A[1]&A[0];
  assign D[4] = A[2]&~A[1]&~A[0];
  assign D[5] = A[2]&~A[1]&A[0];
  assign D[6] = A[2]&A[1]&~A[0];
  assign D[7] = A[2]&A[1]&A[0];
  
endmodule
module mux8to1_withoutE(I,S,Y);
  input [2:0] S;
  input [7:0] I;
  output wire Y;
  
  wire [7:0] Ytemp;
  
  assign Ytemp[0] = ~S[2]&~S[1]&~S[0]&I[0];
  assign Ytemp[1] = ~S[2]&~S[1]&S[0]&I[1];
  assign Ytemp[2] = ~S[2]&S[1]&~S[0]&I[2];
  assign Ytemp[3] = ~S[2]&S[1]&S[0]&I[3];
  assign Ytemp[4] = S[2]&~S[1]&~S[0]&I[4];
  assign Ytemp[5] = S[2]&~S[1]&S[0]&I[5];
  assign Ytemp[6] = S[2]&S[1]&~S[0]&I[6];
  assign Ytemp[7] = S[2]&S[1]&S[0]&I[7];
  
  assign Y = Ytemp[7] | Ytemp[6] | Ytemp[5] | Ytemp[4] | Ytemp[3] | 			 Ytemp[2] | Ytemp[1] | Ytemp[0];
  
endmodule
module full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output wire S, Cout;
  
  wire [7:0] tempOut1;
  wire [2:0] tempA;
  
  assign tempA[0] = Cin;
  assign tempA[1] = B;
  assign tempA[2] = A;
  
  decoder3to8_withoutE inst1(tempA, tempOut1);
 	
  assign S = tempOut1[1] | tempOut1[2] | tempOut1[4] | tempOut1[7];
  
  mux8to1_withoutE inst2(8'b11101000, tempA, Cout);
endmodule

// Structural modelling_04 //
module ripple_carry_adder(A, B, Cin, S, Cout, C7);
  input [7:0] A, B;
  input Cin;
  output wire [7:0] S;
  output wire Cout, C7;
  
  wire temp1, temp2, temp3, temp4, temp5, temp6;
  
  full_adder inst3(A[0], B[0], Cin, S[0], temp1);
  full_adder inst4(A[1], B[1], temp1, S[1], temp2);
  full_adder inst5(A[2], B[2], temp2, S[2], temp3);
  full_adder inst6(A[3], B[3], temp3, S[3], temp4);
  full_adder inst7(A[4], B[4], temp4, S[4], temp5);
  full_adder inst8(A[5], B[5], temp5, S[5], temp6);
  full_adder inst9(A[6], B[6], temp6, S[6], C7);
  full_adder inst10(A[7], B[7], C7, S[7], Cout);
  
endmodule
module Mux_2to1(I0,I1,Sel,Y);
    input [7:0] I1;
    input[7:0] I0; 
    input Sel;
    output reg[7:0] Y;
    always @(*)begin
        case(Sel)
        1'b1: Y=I1;
        1'b0: Y=I0;
        default: Y=8'b0;
        endcase
    end
endmodule

module Mux32to1_1bit(S, I, Y, E);
    input E;
    input [4:0] S;
    input [31:0] I;
    output wire Y;

    assign Y = (E == 1'b1) ? I[S] : 1'b0;
endmodule

module Mux32to1_1bit_withoutE(S, I, Y);
    input [4:0] S;
    input [31:0] I;
    output wire Y;

    assign Y = I[S];
endmodule


module Mux4to1_1bit_withoutE(S, I0, I1, I2, I3, Y);
    input [1:0] S;
    input [7:0] I0, I1, I2, I3; 
    output [7:0] Y;             

    assign Y = (S == 2'b00) ? I0 :
               (S == 2'b01) ? I1 :
               (S == 2'b10) ? I2 : I3;
endmodule

module Mux32to1_8bit(input [4:0] S,
    input [7:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15,
    input [7:0] I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31,
    output reg [7:0] Y
);
    always @(*) begin
        case(S)
            5'b00000: Y = I0;
            5'b00001: Y = I1;
            5'b00010: Y = I2;
            5'b00011: Y = I3;
            5'b00100: Y = I4;
            5'b00101: Y = I5;
            5'b00110: Y = I6;
            5'b00111: Y = I7;
            5'b01000: Y = I8;
            5'b01001: Y = I9;
            5'b01010: Y = I10;
            5'b01011: Y = I11;
            5'b01100: Y = I12;
            5'b01101: Y = I13;
            5'b01110: Y = I14;
            5'b01111: Y = I15;
            5'b10000: Y = I16;
            5'b10001: Y = I17;
            5'b10010: Y = I18;
            5'b10011: Y = I19;
            5'b10100: Y = I20;
            5'b10101: Y = I21;
            5'b10110: Y = I22;
            5'b10111: Y = I23;
            5'b11000: Y = I24;
            5'b11001: Y = I25;
            5'b11010: Y = I26;
            5'b11011: Y = I27;
            5'b11100: Y = I28;
            5'b11101: Y = I29;
            5'b11110: Y = I30;
            5'b11111: Y = I31;
            default: Y = 8'b0;
        endcase
    end
endmodule



module Mux16to1_8bit_withoutE(S, I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, Y);
    input [3:0] S;
    input [7:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
    output wire [7:0] Y;

    
   wire [127:0] inputs;  
   assign inputs = { I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 };
   assign Y = inputs[8*S +: 8]; 
 
endmodule




// Structural modelling_05 //
module adder_subtractor(A, B, M, S, Cout, Overflow);
  input [7:0] A, B;
  input M;
  output wire [7:0] S;
  output wire Cout, Overflow;
  
  wire [7:0] tempB;
  wire C7;
  
  xor inst11(tempB[0], B[0], M);
  xor inst12(tempB[1], B[1], M);
  xor inst13(tempB[2], B[2], M);
  xor inst14(tempB[3], B[3], M);
  xor inst15(tempB[4], B[4], M);
  xor inst16(tempB[5], B[5], M);
  xor inst17(tempB[6], B[6], M);
  xor inst18(tempB[7], B[7], M);
  
  ripple_carry_adder inst8(A, tempB, M, S, Cout, C7);
  xor inst19(Overflow, Cout, C7);
  
endmodule

module RegisterSynW (
    input clk,
    input Reset,
    input W,           // Write enable not properly used
    input [7:0] Datain,
    output reg [7:0] Dataout
);
    // Fix: Add write enable check
    always @(posedge clk) begin
        if (Reset)
            Dataout <= 8'b0000_0000;
        else if (W)  // Only update when write is enabled
            Dataout <= Datain;
    end
endmodule




module decoder3to8(A, D);
    input [2:0] A;
    output wire [7:0] D;
    assign D = 8'b1 << A;
endmodule


module Comparator_Unsigned (A, B, AgB, AlB, AeB);
    input [7:0] A, B;
    output wire AgB, AlB, AeB; 

    wire [7:0] Sum;
    wire Carryout, Overflow; 

   
    adder_subtractor inst1(A, B, 1'b1, Sum, Carryout, Overflow); 

    
    assign AlB = ~Carryout;         
    assign AeB = (Sum == 8'b0);     
    assign AgB = Carryout & ~AeB;   
endmodule





module decoder4to16_withE_method1(A, E, D);
  input [3:0]A;			
  input E;				
  output reg [15:0] D;	

  always @(*)
    begin
      if (E == 1'b0)
       	D = 16'b0000_0000_0000_0000;
      else
       	begin 
        	if (A == 4'b0000)
        		D = 16'b0000_0000_0000_0001;
      		else if (A == 4'b0001)
		        D = 16'b0000_0000_0000_0010;
          	else if (A == 4'b0010)
            	D = 16'b0000_0000_0000_0100;
          	else if (A == 4'b0011)
              	D = 16'b0000_0000_0000_1000;
          	else if (A == 4'b0100)
              	D = 16'b0000_0000_0001_0000;
          	else if (A == 4'b0101)
              	D = 16'b0000_0000_0010_0000;
          	else if (A == 4'b0110)
            	D = 16'b0000_0000_0100_0000;
          	else if (A == 4'b0111)
            	D = 16'b0000_0000_1000_0000;
          	else if (A == 4'b1000)
            	D = 16'b0000_0001_0000_0000;
          	else if (A == 4'b1001)
              	D = 16'b0000_0010_0000_0000;
          	else if (A == 4'b1010)
              	D = 16'b0000_0100_0000_0000;
          	else if (A == 4'b1011)
            	D = 16'b0000_1000_0000_0000;
          	else if (A == 4'b1100)
              	D = 16'b0001_0000_0000_0000;
          	else if (A == 4'b1101)
            	D = 16'b0010_0000_0000_0000;
            else if (A == 4'b1110)
            	D = 16'b0100_0000_0000_0000;
          	else if (A == 4'b1111)
              	D = 16'b1000_0000_0000_0000;
          	else 
              	D = 16'b0000_0000_0000_0000;
        end
    end
endmodule


module eightbitRegwithLoad(clk,Reset,load,Datain,Dataout);
    input clk, Reset, load; 
    input [7:0] Datain;
    output reg [7:0] Dataout;

    wire [7:0] Y;
    assign Y = (load == 1'b1) ? Datain : Dataout;

    always @(posedge clk) begin
        if (Reset)
            Dataout <= 8'b00000000;
        else
            Dataout <= Y;
    end
endmodule

module onebitRegwithLoad(
    input clk,
    input Reset,
    input load,
    input Datain,
    output reg Dataout
);
    always @(posedge clk) begin
        if (Reset)
            Dataout <= 1'b0;
        else if (load)
            Dataout <= Datain;
    end
endmodule

module RegisterFile(clk, Reset, RegFileRead, RegFileWrite, Datain, Source1, Source2, Destin, Dataout1, Dataout2);
    input clk, Reset, RegFileRead, RegFileWrite;
    input [7:0] Datain;
    input [3:0] Source1, Source2, Destin;
    output wire [7:0] Dataout1, Dataout2; 

    wire [15:0] writeSignals; 
    wire [7:0] selectedReadData1, selectedReadData2; 
    

    
    decoder4to16_withE_method1 inst1(Destin, RegFileWrite, writeSignals);
    reg [7:0] D [0:15];
    integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1)
            D[i] = 8'b0;
    end
    always @(posedge clk) begin
        if (Reset) begin
            for (i = 0; i < 16; i = i + 1)
                D[i] <= 8'b0;
        end
        else if (RegFileWrite)  // Only write when enabled
            if (writeSignals[Destin])
                D[Destin] <= Datain;
    end

    // Read multiplexers
    assign selectedReadData1 = (RegFileRead) ? D[Source1] : 8'b0;
    assign selectedReadData2 = (RegFileRead) ? D[Source2] : 8'b0;
    RegisterSynW inst2(
        .clk(clk),
        .Reset(Reset),
        .W(RegFileRead),
        .Datain(selectedReadData1),
        .Dataout(Dataout1)
    );

    RegisterSynW inst3(
        .clk(clk),
        .Reset(Reset),
        .W(RegFileRead),
        .Datain(selectedReadData2),
        .Dataout(Dataout2)
    );

    
    
endmodule
module ROM(
    input [7:0] Address,
    output reg [24:0] Dataout,
    output reg [4:0] Opcode,
    output reg [3:0] Destin,
    output reg [3:0] Source1,
    output reg [3:0] Source2,
    output reg [7:0] Imm
);
    reg [24:0] mem [0:255];
    
    initial begin
        $readmemb("instructions.txt", mem);
    end
    
    always @(Address) begin  // Changed from @* to @(Address)
        Dataout = mem[Address];
        Opcode  = Dataout[24:20];
        Destin  = Dataout[19:16];
        Source1 = Dataout[15:12];
        Source2 = Dataout[11:8];
        Imm     = Dataout[7:0];
    end
endmodule

module InstMEM(
    input clk, 
    input Reset, 
    input InstRead, 
    input [7:0] Address, 
    
    output reg [24:0] Dataout, 
    output reg [4:0] Opcode, 
    output reg [3:0] Destin, 
    output reg [3:0] Source1, 
    output reg [3:0] Source2, 
    output reg [7:0] Imm
);

    wire [24:0] rout;
    wire [4:0] ropcode;
    wire [3:0] rDestin, rSource1, rSource2;
    wire [7:0] rImm;
    
    ROM inst1(
        .Address(Address),
        .Dataout(rout),
        .Opcode(ropcode),
        .Destin(rDestin),
        .Source1(rSource1),
        .Source2(rSource2),
        .Imm(rImm)
    );

    always @(posedge clk or posedge Reset) begin
        if (Reset) begin
            Dataout <= 25'b0;
            Opcode  <= 5'b0;
            Destin  <= 4'b0;
            Source1 <= 4'b0;
            Source2 <= 4'b0;
            Imm     <= 9'b0;
        end else if (InstRead) begin
            Dataout <= rout;
            Opcode  <= ropcode;
            Destin  <= rDestin;
            Source1 <= rSource1;
            Source2 <= rSource2;
            Imm     <= rImm;
        end
    end
endmodule




module SRAM(clk, Reset, Address, SRAMRead, SRAMWrite, Datain, Dataout);
    input clk, Reset, SRAMRead, SRAMWrite;
    input [7:0] Address, Datain;
    output reg [7:0] Dataout; 

    reg [7:0] mem [0:255];
    integer i;

    // Synchronous reset and write
    always @(posedge clk) begin
        if (Reset) begin
            for (i = 0; i < 256; i = i + 1)
                mem[i] <= 8'b00000000; 
        end
        else if (SRAMWrite) begin
            mem[Address] <= Datain;
        end
    end

    // Combinational read
    always @(*) begin
        if (SRAMRead)
            Dataout = mem[Address];
        else
            Dataout = 8'b00000000;
    end

endmodule



module Stack(clk, Reset, StackRead, StackWrite, Datain, Dataout);
    input clk, Reset, StackRead, StackWrite; 
    input [7:0] Datain;                       
    output wire [7:0] Dataout;               

    wire [7:0] SPW;      
    wire [7:0] SPR;     
    wire [7:0] mux1;    
    wire [7:0] mux2;    
    wire [7:0] sram_dataout_internal; 

    
    assign SPR = SPW - 8'b0000_0001;

    
    Mux4to1_1bit_withoutE inst1({StackRead, StackWrite}, SPW, SPW + 8'b0000_0001, SPR, SPW, mux1);

   
    eightbitRegwithLoad inst2(
        .clk(clk),
        .Reset(Reset),
        .load(StackRead | StackWrite | Reset), 
        .Datain(Reset ? 8'b0 : mux1), 
        .Dataout(SPW)
    );

    
    Mux4to1_1bit_withoutE inst3({StackRead, StackWrite}, 8'b0, SPW, SPR, 8'b0, mux2);

    
    SRAM inst4(clk, Reset, mux2, StackRead, StackWrite, Datain, sram_dataout_internal);

    
    assign Dataout = sram_dataout_internal;

endmodule


module ALU(clk,Reset,Imm7,Operand1,Operand2,Opcode,ALUSave,ZflagSave,CflagSave,Zflag,Cflag,ALUout);
    input clk, Reset, Imm7; // Original names
    input ALUSave, ZflagSave, CflagSave; 
    input [4:0] Opcode;                 
    input [7:0] Operand1, Operand2;    
    output wire Zflag, Cflag;          
    output wire [7:0] ALUout;          

    
    wire M, Cout, temp, zeroFlag, carryFlag;
    wire [7:0] Sum, Or, And, Exor, LShift, RShift, Ans;    
     
    
    Mux32to1_1bit_withoutE inst1(Opcode, {24'b0, 1'b1, 2'b0, Imm7, Imm7, 3'b0}, M);
    adder_subtractor inst2(Operand1, Operand2, M, Sum, Cout, temp); 

   
    assign Or = Operand1 | Operand2;
    assign And = Operand1 & Operand2;
    assign Exor = Operand1 ^ Operand2;
    assign LShift = Operand1 << {Operand2[2], Operand2[1], Operand2[0]}; 
    assign RShift = Operand1 >> {Operand2[2], Operand2[1], Operand2[0]}; 

    
    Mux32to1_8bit inst3 (
    Opcode, Sum, And, Or, Exor, Sum, And, Or, Exor, Sum, Sum, Sum, 8'b0, Sum, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, Sum,8'b0, 8'b0, Sum, 8'b0, Sum, Sum, RShift, LShift, Sum, Sum, 8'b0, 8'b0, 8'b0, Ans
);


    
    assign zeroFlag = (Ans == 8'b0) ? 1'b1 : 1'b0;
    Mux32to1_1bit_withoutE inst4(Opcode, 
        {{4{1'b0}}, Cout, {3{1'b0}}, Cout, {15{1'b0}}, Cout, Operand1[0], Operand1[7], {5{1'b0}}}, 
        carryFlag);

    
    eightbitRegwithLoad inst5(.clk(clk), .Reset(Reset), .load(ALUSave),   .Datain(Ans),           .Dataout(ALUout));
    onebitRegwithLoad inst6(.clk(clk), .Reset(Reset), .load(ALUSave), .Datain(carryFlag), .Dataout(Cflag)); 
    onebitRegwithLoad inst7(clk, Reset, ALUSave, ~(Ans[7] | Ans[6] | Ans[5] | Ans[4] |Ans[3] | Ans[2] | Ans[1] | Ans[0]),Zflag); 
    

  

endmodule



module TimingGen(
    input clk, Reset,
    output reg T0, T1, T2, T3, T4
);
    reg [2:0] cycle;

    always @(posedge clk or posedge Reset) begin
        if (Reset)
            cycle <= 3'b000;
        else
            cycle <= cycle+ 1;
    end

    always @(*) begin
        T0 = (cycle == 3'b000);
        T1 = (cycle == 3'b001);
        T2 = (cycle == 3'b010);
        T3 = (cycle == 3'b011);
        T4 = (cycle == 3'b100);
    end
endmodule




module ProgCounter(clk,Reset,PCenable,PCupdate,CAddress,PC,PC_D2);
    input clk, Reset, PCenable, PCupdate; 
    input [7:0] CAddress;                 
    output [7:0] PC, PC_D2;          
    wire [7:0] PC_D1;                      

    wire [7:0] mux1_out;
    wire [7:0] adder_out;
    
    // First mux to select between 0 and 1 based on Enable_PC
    Mux_2to1 inst62(8'b00000000, 8'b00000001, PCenable, mux1_out);
    
    // Simple addition instead of ripple carry adder
    assign adder_out = PC + mux1_out;
    
    wire [7:0] mux2_out;
    // Second mux to select between incremented PC and new address
    Mux_2to1 inst64(adder_out, CAddress, PCupdate, mux2_out);
    
    // Program Counter Register
    RegisterSynW inst65(clk, Reset, 1'b1, mux2_out, PC);
    
    // Two stage delay for PC
   
    RegisterSynW inst66(clk, Reset, 1'b1, PC, PC_D1);
    RegisterSynW inst67(clk, Reset, 1'b1, PC_D1, PC_D2);
endmodule


module INport(clk, Reset, INportRead, InpExtWorld1, InpExtWorld2, InpExtWorld3, InpExtWorld4, Address, Dataout);
    input clk, Reset, INportRead; 
    input [7:0] InpExtWorld1, InpExtWorld2, InpExtWorld3, InpExtWorld4, Address; 
    output wire [7:0] Dataout; 

    
    
    wire [7:0] InpExtWorld1dout, InpExtWorld2dout, InpExtWorld3dout, InpExtWorld4dout, muxOut_wire;
    wire c1,c2,c3,c4;
    wire temp;
    reg [1:0] Select;
    

    
    RegisterSynW inst1(clk, 1'b0, 1'b1,InpExtWorld1, InpExtWorld1dout);
    RegisterSynW inst2(clk, 1'b0, 1'b1,InpExtWorld2, InpExtWorld2dout);
    RegisterSynW inst3(clk, 1'b0, 1'b1,InpExtWorld3, InpExtWorld3dout);
    RegisterSynW inst4(clk, 1'b0, 1'b1,InpExtWorld4, InpExtWorld4dout);

    
   
    
    Comparator_Unsigned inst5(Address, 8'b11110000, temp, temp, c1); 
    Comparator_Unsigned inst6(Address, 8'b11110001, temp, temp, c2);
    Comparator_Unsigned inst7(Address,8'b11110010, temp, temp, c3);
    Comparator_Unsigned inst8(Address, 8'b11110011, temp, temp, c4);
    always @(*) begin
    if (c4 == 1'b1) begin
        Select = 2'b11;
    end
    else if (c3 == 1'b1) begin
        Select = 2'b10;
    end
    else if (c2 == 1'b1) begin
        Select = 2'b01;
    end
    else if (c1 == 1'b1) begin
        Select = 2'b00;
    end
    else begin
        Select = 2'b00;
    end
end

    
    

    
    Mux4to1_1bit_withoutE inst10(Select, InpExtWorld1dout, InpExtWorld2dout, InpExtWorld3dout, InpExtWorld4dout, Dataout);

    
    

endmodule


module OUTport(clk, Reset, Address, Datain, OUTportWrite, OutExtWorld1, OutExtWorld2, OutExtWorld3, OutExtWorld4);
    input clk, Reset, OUTportWrite; 
    input [7:0] Address, Datain;    
    output wire [7:0] OutExtWorld1, OutExtWorld2, OutExtWorld3, OutExtWorld4; 

   
    wire comp_out1, comp_out2, comp_out3, comp_out4, temp_wire; 
    
     
    localparam PORT1_ADDR = 8'b11111000;
    localparam PORT2_ADDR = 8'b11111001;
    localparam PORT3_ADDR = 8'b11111010;
    localparam PORT4_ADDR = 8'b11111011;

    
    Comparator_Unsigned inst1(Address, PORT1_ADDR, temp_wire, temp_wire, comp_out1);
    Comparator_Unsigned inst2(Address, PORT2_ADDR, temp_wire, temp_wire, comp_out2);
    Comparator_Unsigned inst3(Address, PORT3_ADDR, temp_wire, temp_wire, comp_out3);
    Comparator_Unsigned inst4(Address, PORT4_ADDR, temp_wire, temp_wire, comp_out4);

    
    
    eightbitRegwithLoad inst5(.clk(clk), .Reset(Reset), .load(OUTportWrite & comp_out1), .Datain(Datain), .Dataout(OutExtWorld1));
    eightbitRegwithLoad inst6(.clk(clk), .Reset(Reset), .load(OUTportWrite & comp_out2), .Datain(Datain), .Dataout(OutExtWorld2));
    eightbitRegwithLoad inst7(.clk(clk), .Reset(Reset), .load(OUTportWrite & comp_out3), .Datain(Datain), .Dataout(OutExtWorld3));
    eightbitRegwithLoad inst8(.clk(clk), .Reset(Reset), .load(OUTportWrite & comp_out4), .Datain(Datain), .Dataout(OutExtWorld4));

    
    

endmodule


module ControlLogic(clk,Reset,T1,T2,T3,T4,Zflag,Cflag,Opcode,PCupdate,SRAMRead,SRAMWrite,StackRead,StackWrite,ALUSave,ZflagSave,CflagSave,INportRead,OUTportWrite,RegFileRead,RegFileWrite);
    input clk, Reset, T1, T2, T3, T4, Zflag, Cflag; 
    input [4:0] Opcode;                             
    
    output wire PCupdate, SRAMRead, SRAMWrite, StackRead, StackWrite, ALUSave, ZflagSave, CflagSave, INportRead, OUTportWrite, RegFileRead, RegFileWrite;

   
    
    
    

    
    Mux32to1_1bit inst1(Opcode, 32'h00801000, SRAMWrite, T3);
    Mux32to1_1bit inst3(Opcode, 32'h1fa417fe, ALUSave, T2);
    Mux32to1_1bit inst2(Opcode, 32'h00400800, SRAMRead, T3);
    Mux32to1_1bit inst4(Opcode, 32'h070001fe, ZflagSave, T2);
    Mux32to1_1bit inst5(Opcode, 32'h07e413fe, RegFileRead, T1);
    Mux32to1_1bit inst6(Opcode, 32'h07000110, CflagSave, T1);
    Mux32to1_1bit inst7(Opcode, 32'h07580ffe, RegFileWrite, T4);
    Mux32to1_1bit inst8(Opcode, 32'h00040000, StackWrite, T3);
    Mux32to1_1bit inst9(Opcode, 32'h00200000, OUTportWrite, T3);
    Mux32to1_1bit inst10(Opcode, 32'h00080000, StackRead, T3);
    Mux32to1_1bit inst11(Opcode, 32'h00100000, INportRead, T3);
    Mux32to1_1bit inst12(Opcode, {13'b0, 1'b1, Zflag, ~Zflag, Cflag, ~Cflag, 9'b0, Zflag, ~Zflag, 3'b0}, PCupdate, T4);
    

endmodule