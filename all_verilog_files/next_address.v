module next_address(
input j,
input beq,
input bne,
input call,
input ret,
input [18:0]r1_data,
input [18:0]r3_data,
input [7:0]addr,
output reg [7:0]addrF
);

always @(*)
begin
     if((j==1'b1) & (beq==1'b0) & (bne==1'b0) & (call==1'b0) & (ret==1'b0))
      addrF = addr;
	  else if ((j==1'b0) & (beq==1'b1) & (bne==1'b0) & (call==1'b0) & (ret==1'b0) & (r1_data==r3_data))
      addrF = addr; 
     else if ((j==1'b0) & (beq==1'b0) & (bne==1'b1) & (call==1'b0) & (ret==1'b0) & (r1_data!=r3_data))
	   addrF = addr;
	  else if ((j==1'b0) & (beq==1'b0) & (bne==1'b0) & (call==1'b1) & (ret==1'b0))	
	   addrF = addr;
	  else if ((j==1'b0) & (beq==1'b0) & (bne==1'b0) & (call==1'b0) & (ret==1'b1))
	   addrF = addr;
	  else 
	   addrF = 8'b00000000;
		
end
endmodule
