module EXE_WB_Stage(
input clk,
input rst,
input RegWriteE,
input memtoRegE,
input memwriteE,
input[19:0]AluControlE,
input AluSrcE,
input[18:0]RD1_2_dataE,
input[18:0]RD3_dataE,
input[7:0]addrE,
input[1:0]r1E_addr,
output RegWriteW,
output memtoregW,
output [18:0]RdOutW,
output [18:0]AluOutW,
output [1:0]r1W_addr
);

reg regWriteE_reg;
reg memtoRegE_reg;
reg [18:0]RdOutE_reg;
reg [18:0]AluOutE_reg;
reg [1:0]r1E_addr_reg;

wire[18:0] RdOutE_wire;
wire [18:0]AluOutE_wire;
wire [18:0] extend_addr;
wire [18:0]mux3_data;
wire [18:0]mux4_data;
wire [18:0]mux5_data;
wire [18:0]fft_data;



alu a1(.A(RD1_2_dataE),
       .B(RD3_dataE),
		 .ALUControl(AluControlE),
		 .Result(AluOutE_wire)
       );
		 
signextend se1(.a(addrE),
           .b(extend_addr)
			  );

mux2x1_3 m3(.d0(RD3_dataE),
         .d1(extend_addr),
			.s((memtoRegE==1)&(AluControlE[2:0]==3'b000)),
			.y(mux3_data)
			);			  
		 
mux2x1_4 m4(.d0(RD1_2_dataE),
         .d1(extend_addr),
			.s((memwriteE==1) & (AluControlE[2:0]==3'b000)),
			.y(mux4_data)
         );
mux2x1_5 m5(.d0(fft_data),
         .d1(RD1_2_dataE),
			.s((memwriteE==1) & (AluControlE[2:0]==3'b000)),
			.y(mux5_data)
         );

data_memory dm1(.AD(mux3_data),
            .WD(mux5_data),
				.WE(memwriteE),
				.AW(mux4_data),
				.RD(RdOutE_wire),
				.clk(clk)
				);
fed_block fed1(.clk(clk),
          .rst(rst),
			 .rdout(RdOutE_wire),
			 .f_e_d(AluControlE[2:0]),
			 .f_e_d_data(fft_data)
          );
			 
always@(posedge clk)
begin
   regWriteE_reg <= RegWriteE;
   memtoRegE_reg <= memtoRegE;
   RdOutE_reg    <= RdOutE_wire;
   AluOutE_reg   <= AluOutE_wire;
   r1E_addr_reg  <= r1E_addr;	
	
end
	
assign 	RegWriteW= regWriteE_reg;
assign   memtoregW= memtoRegE_reg;
assign   RdOutW   = RdOutE_reg;
assign   AluOutW  = AluOutE_reg;
assign   r1W_addr = r1E_addr_reg;

endmodule
