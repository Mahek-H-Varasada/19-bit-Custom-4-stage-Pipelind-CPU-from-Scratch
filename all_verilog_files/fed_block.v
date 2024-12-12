module fed_block(
input clk,
input rst,
input [18:0]rdout,
input [2:0]f_e_d,
output [18:0]f_e_d_data
);
// {ADD,SUB,MUL,DIV,INC,DEC,AND,OR,XOR,NOT,JUMP,BEQ,BNE,CALL,RET,LD,ST,ENC,DENC,FFT}
wire [15:0] fft_data;
fft f1(
        .clk(clk),
		  .rst(rst),
		  .in(rdout[15:0]),
		  .out(fft_data)
);

assign f_e_d_data = (f_e_d==3'b001)? {1'b0,1'b0,1'b0,fft_data} : 
                    (f_e_d==3'b100)? (rdout^(19'b0000000001111111111)) :         //encrypt
						  (f_e_d==3'b010)? (rdout^(19'b0000000001111111111)) : 19'b0;  //decrpyt
						  
endmodule
