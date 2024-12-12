module data_memory(
input [18:0]AD,
input [18:0]WD,
input WE,
input [18:0]AW,
output [18:0]RD,
input clk);

reg[18:0]data_mem[255:0];
assign RD = data_mem[AD[18:0]];

always@(posedge clk)
begin

   if(WE)
    begin 
      data_mem[AW[18:0]]<=WD;
	 end	
end	
endmodule