module ID_EXE_Stage(
input clk,
input RegRst,
input [18:0] InstrD,
input [7:0]pcp1,
input RegWriteW,
input [1:0]a3W,
input [18:0]wd3,
output BranchD,
output[7:0] addrfetch,
output RegWriteE,
output memtoRegE,
output memwriteE,
output[19:0]AluControlE,
output AluSrcE,
output[18:0]RD1_2_dataE,
output[18:0]RD3_dataE,
output[7:0]addrE,
output[1:0]r1E_addr
);

reg RegWriteD_reg;
reg memtoRegD_reg;
reg memwriteD_reg;
reg [19:0]AluControlD_reg;
reg AluSrc_reg;
reg [18:0]RD1_2_dataD_reg;
reg [18:0]RD3_dataD_reg;
reg [7:0]addrD_reg;
reg [1:0]r1D_addr_reg;

wire RegWriteD_wire;
wire memtoRegD_wire;
wire memwriteD_wire;
wire [19:0]AluControlD_wire;
wire AluSrc_wire;
wire [18:0]RD1_2_dataD_wire;
wire [18:0]RD3_dataD_wire;
wire [7:0]addrD_wire = InstrD[7:0];
wire [1:0]r1D_addr_wire= InstrD[13:12];
wire [1:0]a1_addr; 

// [19:0]AluControlD_wire = {ADD,SUB,MUL,DIV,INC,DEC,AND,OR,XOR,NOT,JUMP,BEQ,BNE,CALL,RET,LD,ST,ENC,DENC,FFT}
control_unit cu1(
                 .op(InstrD[18:14]),
					  .BranchD(BranchD),
					  .regwriteD(RegWriteD_wire),
					  .memtoregD(memtoRegD_wire),
					  .memwriteD(memwriteD_wire),
					  .control_signal(AluControlD_wire),
					  .alusrc(AluSrc_wire)
                 );



flow_control fc1(
                 .clk(clk),
					  .r1_DATA(RD1_2_dataD_wire),
					  .r3_DATA(RD3_dataD_wire),
					  .addri(InstrD[7:0]),
					  .pcp1(pcp1),
					  .j(AluControlD_wire[9]),
					  .beq(AluControlD_wire[8]),
					  .bne(AluControlD_wire[7]),
					  .call(AluControlD_wire[6]),
					  .ret(AluControlD_wire[5]),
					  .addrF(addrfetch)
                 );




mux2x1_2 mx2( .d0(InstrD[11:10]),
              .d1(InstrD[13:12]),
				  .s(AluControlD_wire[15] | AluControlD_wire[14] | AluControlD_wire[8] |AluControlD_wire[7]),
				  .y(a1_addr)
				  );
				  
register_file rf1(
                  .clock(clk),
						.Regreset(RegRst),
						.WE3(RegWriteW),
						.A1(a1_addr), // MUXED SIGNAL ADDRESS OF R1 AND R2
						.A2(InstrD[9:8]),//R3 ADDRESS
						.A3(a3W),
						.WD3(wd3),
						.RD1(RD1_2_dataD_wire),
						.RD2(RD3_dataD_wire)
                  );
						
always@(posedge clk)
begin
     RegWriteD_reg <= RegWriteD_wire;
     memtoRegD_reg <= memtoRegD_wire;
     memwriteD_reg <= memwriteD_wire;
     AluControlD_reg <= AluControlD_wire;
	  AluSrc_reg<= AluSrc_wire;
     RD1_2_dataD_reg<=RD1_2_dataD_wire;
     RD3_dataD_reg <= RD3_dataD_wire;
     addrD_reg <= addrD_wire;
     r1D_addr_reg<=r1D_addr_wire;
	  
end

assign RegWriteE = RegWriteD_reg;
assign memtoRegE = memtoRegD_reg;
assign memwriteE = memwriteD_reg;
assign AluControlE =AluControlD_reg;
assign AluSrcE =  AluSrc_reg;
assign RD1_2_dataE= RD1_2_dataD_reg;
assign RD3_dataE= RD3_dataD_reg;
assign addrE= addrD_reg;
assign r1E_addr = r1D_addr_reg;

endmodule
