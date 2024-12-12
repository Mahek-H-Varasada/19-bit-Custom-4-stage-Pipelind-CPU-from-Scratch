module WB_Stage(
input [18:0]RdoutW,
input [18:0]AluOutW,
input memtoregW,
output [18:0] ResultW
);

mux2x1_6 m6( .d0(AluOutW),
             .d1(RdoutW),
				 .s(memtoregW),
				 .y(ResultW)
				 );
endmodule
				 