module flow_control(
input clk,
input [18:0]r1_DATA,
input [18:0]r3_DATA,
input [7:0]addri,
input [7:0]pcp1,
input j,
input beq,
input bne,
input call,
input ret,
output[7:0]addrF
);
wire [7:0]muxaddr;
wire [7:0]STAddr;
wire [1:0]muxsel = {call,ret};

mux4x1_1 m4x1(
         .d0(addri),
			.d1(STAddr),
			.d2(addri),
			.d3(addri),
			.s(muxsel),
			.y(muxaddr)
);



next_address na1(
                  .j(j),
						.beq(beq),
						.bne(bne),
						.call(call),
						.ret(ret),
						.r1_data(r1_DATA),
						.r3_data(r3_DATA),
						.addr(muxaddr),
						.addrF(addrF)
);

stack_block sb1(
                .clk(clk),
					 .call_ret(call),
					 .pcp1(pcp1),
					 .StackAddress(STAddr)

);

endmodule
