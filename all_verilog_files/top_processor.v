module top_processor(input clk,
input rst,
output  ResultRegisterValue);          //sample output flag 

//IF Stage Wires
wire BranchD_ID_IF;
wire [7:0] PCBranch_Addr_ID_IF;
wire [18:0]InstrD_IF_ID;
wire [7:0]PCPlus1_IF_ID;


//ID Stage Wires 
wire RegWriteE_wire;
wire memtoRegE_wire;
wire memwriteE_wire;
wire[19:0]AluControlE_wire;
wire AluSrcE_wire;
wire[18:0]RD1_2_dataE_wire;
wire[18:0]RD3_dataE_wire;
wire[7:0]addrE_wire;
wire[1:0]r1E_addr_wire;


//exe stage wires
wire memtoregW_wire;
wire[18:0]RdOutW_wire;
wire [18:0]AluOutW_wire;


//wb stage wires
wire RegWriteW_wire;
wire [1:0]r1W_addr_wire;
wire [18:0]ResultW_wire; 

IF_ID_Stage IIS1(
                 .clk(clk),
					  .BranchD(BranchD_ID_IF), 
                 .PCBranch_Addr(PCBranch_Addr_ID_IF),
                 .InstrD(InstrD_IF_ID),
					  .PCPlus1(PCPlus1_IF_ID)
                  );
ID_EXE_Stage IES1(
                  .clk(clk),
						.RegRst(rst),
						.InstrD(InstrD_IF_ID),
						.pcp1(PCPlus1_IF_ID),
						.RegWriteW(RegWriteW_wire),
						.a3W(r1W_addr_wire),
						.wd3(ResultW_wire),
						.BranchD(BranchD_ID_IF),
						.addrfetch(PCBranch_Addr_ID_IF),
						.RegWriteE(RegWriteE_wire),
						.memtoRegE(memtoRegE_wire),
						.memwriteE(memwriteE_wire),
						.AluControlE(AluControlE_wire),
						.AluSrcE(AluSrcE_wire),
						.RD1_2_dataE(RD1_2_dataE_wire),
						.RD3_dataE(RD3_dataE_wire),
						.addrE(addrE_wire),
						.r1E_addr(r1E_addr_wire)
						
);

EXE_WB_Stage EWS1(
             .clk(clk),
				 .rst(rst),
				 .RegWriteE(RegWriteE_wire),
				 .memtoRegE(memtoRegE_wire),
				 .memwriteE(memwriteE_wire),
				 .AluControlE(AluControlE_wire),
				 .AluSrcE(AluSrcE_wire),
				 .RD1_2_dataE(RD1_2_dataE_wire),
				 .RD3_dataE(RD3_dataE_wire),
				 .addrE(addrE_wire),
				 .r1E_addr(r1E_addr_wire),
				 .RegWriteW(RegWriteW_wire),
				 .memtoregW(memtoregW_wire),
				 .RdOutW(RdOutW_wire),
				 .AluOutW(AluOutW_wire),
				 .r1W_addr(r1W_addr_wire)
				 
             );

WB_Stage WS1(
             .RdoutW(RdOutW_wire),
				 .AluOutW(AluOutW_wire),
				 .memtoregW(memtoregW_wire),
				 .ResultW(ResultW_wire)
);

assign ResultRegisterValue = ResultW_wire[0];
endmodule