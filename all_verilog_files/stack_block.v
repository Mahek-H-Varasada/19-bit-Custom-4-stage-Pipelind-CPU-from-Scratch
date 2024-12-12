module stack_block(
input clk,
input call_ret,
input [7:0]pcp1,
output [7:0]StackAddress);

reg [3:0] StackPointer;
reg [3:0]wire_address_call_ret;

initial 
begin
StackPointer = 4'b1110;
end
stack_memory sm1(.clk(clk),
                 .a(wire_address_call_ret),
                 .wd(pcp1),
					  .we(call_ret),
					  .rd(StackAddress));

always@(posedge clk)
begin
     if(call_ret == 1'b1)
	   begin
      wire_address_call_ret = StackPointer;
      StackPointer = StackPointer - 4'b0001 ; 	
		end
	  else 
	   begin
	   StackPointer = StackPointer + 4'b0001;	
		wire_address_call_ret = StackPointer;
		end
		
end

endmodule					  
					  