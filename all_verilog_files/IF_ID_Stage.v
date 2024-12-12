module IF_ID_Stage(
input clk,
input BranchD,
input[7:0] PCBranch_Addr,
output[18:0]InstrD,
output [7:0]PCPlus1);

wire [7:0]PCI;
wire [7:0]PCF;
wire [7:0]PCPlus1_addr;
wire [18:0]inst_fetch_wire;

reg [18:0] Inst_Fetch_reg;
reg [7:0]PCPlus1_reg;
mux2x1_1 MUX1(
              .d0(PCPlus1_addr),
				  .d1(PCBranch_Addr),
				  .s(BranchD),
				  .y(PCI)
              );
				  
program_counter PC1(
                    .clk(clk),
						  .pc(PCI),
						  .pcf(PCF)
);

pcplus1_adder PCADD1(
              .a(PCF),
				  .c(PCPlus1_addr)
);

instruction_memory INSMEM1(
                   .address(PCF),
						 .data(inst_fetch_wire)
);

always@(posedge clk)
begin
     Inst_Fetch_reg <= inst_fetch_wire;
	  PCPlus1_reg  <= PCPlus1_addr;
end

assign InstrD = Inst_Fetch_reg;
assign PCPlus1= PCPlus1_reg;
endmodule
