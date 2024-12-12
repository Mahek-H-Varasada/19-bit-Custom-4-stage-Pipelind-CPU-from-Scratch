module stack_memory(
input clk,
input [3:0]a,
input [7:0]wd,
input we,
output [7:0]rd
);

reg[7:0]data_mem[15:0];
assign rd = data_mem[a[3:0]];

always@(posedge clk)
 if(we)
   data_mem[a[3:0]]<=wd;
endmodule