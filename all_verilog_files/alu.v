module alu(
input [18:0]A, //r1_2
input [18:0]B, //r3
input [19:0]ALUControl,
output [18:0]Result
);
// {ADD,SUB,MUL,DIV,INC,DEC,AND,OR,XOR,NOT,JUMP,BEQ,BNE,CALL,RET,LD,ST,ENC,DENC,FFT}
//wire cout;
assign Result = (ALUControl==20'b10000000000000000000)?(A+B):                                //sum                          
                (ALUControl==20'b01000000000000000000)?(A + (~B) + 19'b0000000000000000001):  //sub
					 (ALUControl==20'b00100000000000000000)?(A*B):                                //mul
					 (ALUControl==20'b00010000000000000000)?(A/B):                                //div
					 (ALUControl==20'b00001000000000000000)?(A + 19'b0000000000000000001):         //inc
					 (ALUControl==20'b00000100000000000000)?(A - 19'b0000000000000000001):         //dec
					 (ALUControl==20'b00000010000000000000)?(A&B):                                //and
					 (ALUControl==20'b00000001000000000000)?(A|B):                                //or
					 (ALUControl==20'b00000000100000000000)?(A^B):                                //xor
					 (ALUControl==20'b00000000010000000000)?(~A):                                 //not
					 {19{1'b0}};
					 

endmodule
