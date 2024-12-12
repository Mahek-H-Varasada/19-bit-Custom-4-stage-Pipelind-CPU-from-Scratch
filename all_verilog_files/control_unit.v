module control_unit (
input [4:0] op,
output BranchD,
output regwriteD,
output memtoregD,
output memwriteD,
output [19:0] control_signal, // {ADD,SUB,MUL,DIV,INC,DEC,AND,OR,XOR,NOT,JUMP,BEQ,BNE,CALL,RET,LD,ST,ENC,DENC,FFT}
output alusrc
);


reg [24:0] controls;
always @ (*)
case(op)
//assign {BranchD,regwriteD,memtoregD,memwriteD,alucontrol,alusrc} = controls; 
5'b00000: controls <=  25'b0100100000000000000000000; //add r1,r2,r3
5'b00001: controls <=  25'b0100010000000000000000000; //SUB R1,R2,R3
5'b00010: controls <=  25'b0100001000000000000000000; //MUL R1,R2,R3
5'b00011: controls <=  25'b0100000100000000000000000; //DIV R1,R2,R3
5'b00100: controls <=  25'b0100000010000000000000000; //INC R1
5'b00101: controls <=  25'b0100000001000000000000000; //DEC R1
5'b00110: controls <=  25'b0100000000100000000000000; //AND R1,R2,R3
5'b00111: controls <=  25'b0100000000010000000000000; //OR  R1,R2,R3
5'b01000: controls <=  25'b0100000000001000000000000; //XOR R1,R2,R3
5'b01001: controls <=  25'b0100000000000100000000000; //NOT R1,R3
5'b01010: controls <=  25'b1000000000000010000000000; //JUMP ADDR
5'b01011: controls <=  25'b1000000000000001000000000; //BEQ R1,R2,ADDR
5'b01100: controls <=  25'b1000000000000000100000000; //BNE R1,R2,ADDR
5'b01101: controls <=  25'b1000000000000000010000000; //CALL ADDR
5'b01110: controls <=  25'b1000000000000000001000000; //RET 
5'b01111: controls <=  25'b0110000000000000000100001; //LD R1,ADDR
5'b10000: controls <=  25'b010100000000000000001000x; //ST ADDR,R1
5'b11101: controls <=  25'b0100000000000000000001000; //FFT R1,R3
5'b11110: controls <=  25'b0100000000000000000000100; //ENC R1,R3
5'b11111: controls <=  25'b0100000000000000000000010; //DENC R1,R3 (IT IS R3 NOT R2 ,CHANGE DUE TO ARCHITECTURE CONSTRAINTS)




default: controls <= 18'bx;   //unknown
endcase

assign {BranchD,regwriteD,memtoregD,memwriteD,control_signal,alusrc} = controls; 

endmodule


